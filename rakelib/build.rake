desc "build the documentation"
task :build do
  sh('npm install')
  sh('npm run init-gitbook')
  sh('npm run build')
  sh('npm run minify')
end
