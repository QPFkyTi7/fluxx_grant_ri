# FLUXX Grant Reference Implementation

## Purpose

The FLUXX Grant Reference Implementation is a fully-featured grants management software application.
It depends on several gems: fluxx_engine, fluxx_crm and fluxx_grant.

## Highlights of the Fluxx Grants Management Software

Fluxx Grant is grants management software. This provides a mechanism for foundations to track the
grant making progress using a highly configurable workflow system. The system allows each member of
the foundation to view the data the way they need to see it. 

## Installation

If you have been developing in rails for a while, you probably have all the key ingredients to get
started with fluxx grant.  If not, this guide will walk you through how to get started. Check on the
[google group](http://groups.google.com/group/projectfluxx) for support and gem release announcements.

### Pre-requisites

* Some form of linux is assumed in these instructions. This project should be able to run on a windows
  server but has not been tested.
* A relational database. This project has been tested with mysql. It should work with other databases
  such as postgres as well.
* The [sphinx](http://sphinxsearch.com/downloads.html) search engine is integrated into the fluxx_grant
  gem. Other search engine options may be incorporated in the future.

### Quick Start: for rails experts

Pull latest version from git repo. We're using git submodules for development work on our engines, so
you need to initialize and update them after pull out the fresh version:

    $ git clone git@github.com:fluxxlabs/fluxx_ef.git
    $ git submodule init
    $ git submodule update
  
Run bundler in submodules and main app:

    $ git submodule foreach 'bundle install'
    $ bundle install
    
Provide your database credentials, setup and migrate databases:

    $ cp config/database.yml.sample config/database.yml
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed

Reindex sphinx data:

    $ rake ts:rebuild

Create first user:

    $ rails runner "User.create :first_name => 'John', :last_name => 'Smith', :email => 'johnsmith@some_domain_name.com', :password => 'pass', :login => 'johnsmith', :password_confirmation => 'pass'"
    $ rake fluxx_grant:add_all_program_roles user_id=1

Start the sever:

    $ rails s

Enjoy!

**NOTE**: If you want to pull the latest gems, you must run `bundle update`. Otherwise bundle install
will not automatically try to get more recent versions of the gems.

## Technical Details

### Generators and Migrations

* Generate a set of migration files. These files define how the database tables will be structured.
  Feel free to alter these tables to suit your needs. The audited_migration file tracks the history
  of changes to model objects.  The fluxx_engine, fluxx_crm and fluxx_grant migration generators generate
  migration files for utility tables and model tables for grants and CRM.
  * `rails generate audited_migration`
  * `rails generate delayed_job`
  * `rails generate fluxx_engine_migration`
  * `rails generate fluxx_crm_migration`
  * `rails generate fluxx_grant_migration`

* Generate a script to populate the grant tables with sample data for programs, initiatives and
  other model objects.
  * `rails generate fluxx_grant_seed`

* Generate a locale script with error and information messages.
  * `rails generate fluxx_engine_locale`

* Generate javascript, CSS and image files. These files should not be altered. As enhancements are
  made, you may need to re-run these scripts to get the latest code.
  * `rails generate fluxx_engine_public`
  * `rails generate fluxx_crm_public`
  * `rails generate fluxx_grant_public`
  * `rails generate devise:install`

### Background tasks

* Sphinx: `rake ts:start`
* Delayed job processor: `rake ts:dd`

### Fluxx Developers

Most of the code for fluxx grants lives in the 3 rails engine gems: fluxx_engine, fluxx_crm and fluxx_grant.
If you intend to contribute to the fluxx gems, use local development version as git submodules. If you want
to be able to push your changes you need to run following code in project root directory:

    $ git submodule foreach 'git checkout master'

Now when you want to push some changes eg. to fluxx_engine main repo you just have to go to its directory
and work like with normal git repo, eg:

    $ cd vendor/gems/fluxx_engine
    $ git add .
    $ git commit -m "my engine changes"
    $ git push origin master
    $ cd ../../..
    $ git add vendor/gems/fluxx_engine
    $ git commit -m "updated fluxx_engine"

To pull changes from main repo just run `git pull --rebase` in its directory. You can also update changes
in all submodules using foreach statement:

    $ git submodule update
    $ git submodule foreach 'git pull --rebase'
    $ git commit -am "updated engines"

By default engines are running in development mode, which means that application is using engines from
the `vendor/gems` directory.

## Support

The best way to reach us is to join the [google group](http://groups.google.com/group/projectfluxx).

### References

A series of tutorials on rails 3 engines:

* http://www.themodestrubyist.com/2010/03/01/rails-3-plugins---part-1---the-big-picture/
* http://www.themodestrubyist.com/2010/03/05/rails-3-plugins---part-2---writing-an-engine/
* http://www.themodestrubyist.com/2010/03/16/rails-3-plugins---part-3---rake-tasks-generators-initializers-oh-my/
* http://www.themodestrubyist.com/2010/03/22/rails-3-plugins---part-4---more-on-generators/

rails 3 engine info:

* https://gist.github.com/e139fa787aa882c0aa9c

Sample rails 3 rails engines:

* http://github.com/datamapper/dm-rails
* http://github.com/jrwest/authr3

Thor generators:

* http://caffeinedd.com/guides/331-making-generators-for-rails-3-with-thor
* http://blog.plataformatec.com.br/2010/01/discovering-rails-3-generators/
* http://rdoc.info/rdoc/wycats/thor/blob/f939a3e8a854616784cac1dcff04ef4f3ee5f7ff/Thor/Actions.html

How to load in extensions, making sure that ActiveRecord, ActiveController etc. is loaded first:

* http://weblog.rubyonrails.org/2010/2/9/plugin-authors-toward-a-better-future

Managing gem dependencies

* http://wiki.github.com/technicalpickles/jeweler/customizing-your-projects-gem-specification
* http://technicalpickles.com/posts/craft-the-perfect-gem-with-jeweler/
