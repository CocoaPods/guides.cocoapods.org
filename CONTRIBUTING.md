##Overall Guidelines

- **This repo is for content for guides.cocoapods.org only.** If you are having an issue with CocoaPods, please ask on [StackOverflow](http://stackoverflow.com/search?q=CocoaPods) or our [mailing-list](http://groups.google.com/group/cocoapods).
- **This is high-level content only.** If you have an issue with the API documentation for one of the gems that make up CocoaPods, please file that issue in its own repo; API documentation is generated from source files.
- **This is not the repository for per-Pod documentation.** See [CocoaDocs](http://cocoadocs.org) for documentation on individual Pods.
- **Please do not add images hosted on 3rd party sites.** Image explanations are great, but we would like to keep this a self-contained site.
- **Take out any personally identifiable information.** This applies to images, code snippets, or any other content. Please keep all information anonymous.
- **Do not add promotional material.** This applies to both Guides content and linked resources.

##Style Guidelines

While we aren't terribly picky about writing style, there are a few things we'd like to make sure are standard across the content of the Guides site.

- All content must be in well written English. Use proper spelling and punctuation.
- All guides content is separated into 3 sections: Using, Making, and Contributing. For any new guides, please choose the appropriate section.
- All content is written in [Markdown](http://daringfireball.net/projects/markdown/).
- These are not tutorials, but rather explanations of the inner workings of CocoaPods.
- If you would like to see these in another language, please [open an issue](https://github.com/CocoaPods/guides.cocoapods.org/issues), or simply start translating. We'd love to see this content accessible to more users.
- Our code blocks are parsed by [Pygments](https://github.com/tmm1/pygments.rb), so please make sure your code additions are highlighted correctly. The best way to check this is to run your changes locally. Instructions can be found in the [README](README.md).
- We also enjoy the Oxford comma.

##Issue Submissions

We are always looking for the best way to present information about CocoaPods. If you would like to see something specific, or start a discussion, please follow these guidelines.

- Double check there is no open issue for a potential topic. If it is related, but not quite the same, make sure to mention the issue in your post.
- When opening a new issue, please reference the specific guide you would like to talk about. If it does not exist, make sure to say so.
- While discussing issues, links to external sites are welcome, but this site is for original content. If you'd like to add a link to a blog post or article, see the External Resource Submission guidelines below.
- There are some topics, e.g. whether or not to check in the Pods folder, that will be heavily debated. In these situations, we would like to present both sides and give the user the best information to make an informed decision. Please be courteous and resepectful to your fellow developers.
- UX suggestions are not only welcome, but encouraged. We want to make sure this content is easy to browse and easy to read.

##External Resource Submissions

We love including content from the greater community. When adding a new resource, please follow the following guidelines.

- External resources are to be placed at the bottom of the guide for reference.
- These should serve to enhance the content available on the Guides site, not duplicate it.
- Make sure to add a resource on the correct page. E.g. a blog post on creating a private cocoapod should not be on the Specs and Spec Repo guide.
- Links should lead to articles or blog posts. Please do not add links to StackOverflow, GitHub Issues, Gists, or our mailing list.
- Links should be active at the time of submission. Please do not link to a mirror site.
- Any external resource links should lead directly to the resource. Links with paywalls, adwalls, etc will not be accepted.
- External resources should not be promotions or trying to sell something. We are happy to link to technical posts on your company's blog, but posts solely for advertising purposes will not be accepted.
- All external resources should be submitted via pull request.