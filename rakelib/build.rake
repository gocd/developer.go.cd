desc "build the documentation"
task :build do
  sh('npm install')
  sh('npm run build')
end
