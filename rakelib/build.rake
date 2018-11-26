desc "build the documentation"
task :build do
  sh('curl -sL https://rpm.nodesource.com/setup_6.x | sudo bash -')
  sh('sudo yum -y remove nodejs')
  sh('sudo yum -y install nodejs yarn')
  sh('yarn install')
  sh('yarn run init-gitbook')
  sh('yarn run build')
  sh('yarn run minify')
end
