require 'nokogiri'
require 'open-uri'
require 'sqlite3'

PWD = Dir.pwd

#
# Create any of the default docset file structure that we may need
#
def reset_docs_dir
  if Dir.exist? './CocoaPodsGuides.docset'
    `rm -Rf ./CocoaPodsGuides.docset`
  end
  
  `mkdir -p ./CocoaPodsGuides.docset/Contents/Resources/Documents`

  # get icon.png file
  `wget https://cocoapods.org/favicons/apple-touch-icon.png -O ./CocoaPodsGuides.docset/icon.png`

  `cp ./docset-Info.plist ./CocoaPodsGuides.docset/Contents/Info.plist`
end

#
# create the sqlite index
#
def create_sqlite_db
  db_file = './CocoaPodsGuides.docset/Contents/Resources/docSet.dsidx'
  if File.exist? db_file
    File.delete db_file
  end
  db = SQLite3::Database.new db_file

  db.execute 'CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);'
  db.execute 'CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);'
  return db
end

#
# Given an html file path, open it, parse it, clean it up,
# and overwirte the existing file.
#
def cleanup_html(file)
  original = File.open(file)
  page = Nokogiri::HTML(original)
  original.close

  page.css('nav').each { |nav| nav.remove }  
  page.css('footer').each { |footer| footer.remove }
  page.css('.site_navigation').each { |nav| nav.remove }
  page.css('.info-row').each { |row| row.remove }
  
  page.css('.guide .container h5 a').each { |link| puts link.to_s }

  File.open(file, 'w') { |f| f.write(page.to_s) }
  puts "saved cleaned up #{file}"
end

def extract_main_nav(file)
  original = File.open(file)
  page = Nokogiri::HTML(original)
  original.close
  
  page.css('.guide .container h5 a').to_a
end

def generate_docset
  # delete the old dir and setup a new one
  reset_docs_dir
  
  db = create_sqlite_db
  
  docset_dir = './CocoaPodsGuides.docset/Contents/Resources/Documents'

  `mv build/** #{docset_dir}`
  
  Dir.chdir docset_dir

  # grab the list of search commands to be used as the default page for splunk docs
  cleanup_html("./index.html")
  
  links = extract_main_nav("./index.html")
  
  guide_pages = {}
  links.each do |l|
    guide_pages[l.text] = l.attributes["href"].value
  end
  
  guide_pages.each do |page, url|
    # cleanup the tail end of the URL using
    path = './' + url.split('//').last
    cleanup_html(path)
    
    # for each thing we want to link to, populate the sqlite index
    db.execute "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{page}', 'Guide', '#{path}');"
  end

  Dir.chdir PWD

  # # do any general cleanup inside the docset file structure
  #
  # f = File.open("list.html")
  # doc = Nokogiri::HTML(f)
  #
  # links = doc.xpath('//a')
  # sections = {}
  #
  # links.each do |l|
  #   sections[l.text] = l.attribute('href').value
  # end
end
