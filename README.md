CocoaPods Guides Site
==========

This is the repo for the CocoaPods Guides site.

### I'd like to contribute

Great! Head over to [CONTRIBUTING](CONTRIBUTING.md).

### I'd like to make a suggestion

Fantastic! Take a look at our [open issues](https://github.com/CocoaPods/guides.cocoapods.org/issues), and comment on one that seems relevant or open an issue. See our [CONTRIBUTING](CONTRIBUTING.md) guidelines for opening issues.

### I'd like to add my blog post or tutorial.

Delightful! Double check your link follows our [External Resource Guidelines](CONTRIBUTING.md), then make a pull request.

### I'd like to run guides.cocoapods.org locally

The guides site is built on [Middleman](http://middlemanapp.com), and runs on Ruby 2.1.3.

Steps to setup:

1. `$ git clone https://github.com/CocoaPods/guides.cocoapods.org.git`
2. `$ cd guides.cocoapods.org`
3. `$ rake bootstrap`
4. `$ bundle exec rake generate:all`
5. `$ foreman start`
6. Open [localhost:4567](http://localhost:4567) in your browser. Changes will be processed automatically

### Deploying the latest version to GitHub Pages

`$ bundle exec rake deploy`
