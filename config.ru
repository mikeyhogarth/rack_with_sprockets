require 'sprockets'
project_root = File.expand_path(File.dirname(__FILE__))
assets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

assets.append_path(File.join(project_root, 'assets', 'javascripts'))
assets.append_path(File.join(project_root, 'assets', 'stylesheets'))

map "/assets" do
  run assets
end

map "/" do
  run lambda { |env|
    [
      200, 
      {
        'Content-Type'  => 'text/html', 
        'Cache-Control' => 'public, max-age=86400' 
      },
      File.open('public/index.html', File::RDONLY)
    ]
  }
end
