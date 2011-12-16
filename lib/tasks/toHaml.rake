@path = File.join('app', 'views')

class ToHaml
  def initialize(path)
    @path = path
  end
  
  def convert!
    Dir["#{@path}/**/*.erb"].each do |file|
      puts "html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}"
      %x[html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}]
    end
  end
end

namespace :erb do
  desc 'Convert ERB to HAML'
  task :toHaml do
    ToHaml.new(@path).convert!    
  end

  desc 'Remove all ERB files'
  task :remove do
    Dir["#{@path}/**/*.erb"].each do |file|
      puts "Remove #{file}"
      %x[ rm #{file}]
    end
  end
end
