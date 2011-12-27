desc "Run tests with SimpleCov"
task :test_cov do
  Spec::Rake::SpecTask.new('coverage') do |t|
    ENV['COVERAGE'] = "true"
    sh %{bundle exec rspec spec}
    sh %{bundle exec cucumber}
  end
end
