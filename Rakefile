require 'fileutils'

# Files
def entries
  @files ||= Dir.entries( File.expand_path( '~/.dotfiles' ) ) - $exclude
end

def post_external(path, repo)
  if File.directory?(path) &&  File.directory?(path + "/.git")
    system "cd #{path}; git pull"
  else
    system "rm -r #{path}; git clone #{repo} #{path}"
  end
end

# Files and folders which shouldn't be copied over
$exclude = [
  '.',
  '..',
  '.git',
  'bootstrap.sh',
  'Gemfile',
  'Gemfile.lock',
  'Rakefile',
  'README.md'
]

desc 'Backup previous dotfiles.'
task :backup do
  dir = FileUtils.mkdir_p( File.expand_path( File.join( '~' , '.dotfiles-backup', Time.now.to_s ) ) )
  entries.each do | file |
    orig = File.expand_path( "~/#{file}" )
    FileUtils.cp_r orig, "#{dir}/#{file}", :verbose => true if File.exists? orig
  end
end

desc 'Update dotfiles repository.'
task :update do
  system 'git pull'
end

desc 'Run all install tasks in order.'
task :install => [ 'install:deps', 'install:copy', 'install:post' ]

namespace :install do

  desc 'Check for and install required dependencies.'
  task :deps do
    puts 'Please install bundler and re-run installation. http://gembundler.com/' and exit 1 unless system 'which bundle'
    system 'bundle install'
  end

  desc 'Copy dotfiles over to home dir.'
  task :copy do
    entries.each do | file |
      FileUtils.cp_r file, File.expand_path( "~/#{file}" ), :verbose => true, :remove_destination => true
    end
  end

  desc 'Run post-install tasks.'
  task :post do
    # External repos
    ohmyzsh_path = File.expand_path("~/.oh-my-zsh")
    post_external(ohmyzsh_path, "git://github.com/robbyrussell/oh-my-zsh.git")
    rbenv_path = File.expand_path("~/.rbenv")
    post_external(rbenv_path, "git://github.com/sstephenson/rbenv.git")

    # Ruby-build
    rbuild_path = File.expand_path("~/.rbenv/plugins/ruby-build")
    post_external(rbuild_path, "git://github.com/sstephenson/ruby-build.git")

    puts "\n\n\n##################################################"
    puts "Now install your ruby using rbenv and after that, pow"
  end

end
