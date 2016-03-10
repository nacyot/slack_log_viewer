lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'slack_log_viewer/version'

Gem::Specification.new do |spec|
  spec.name = 'slack_log_viewer'
  spec.version = SLACK_LOG_VIEWER_VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ['Daekwon Kim']
  spec.email = ['i-am-not-a-machine@nacyot.com']
  spec.homepage = 'https://github.com/nacyot/slack_log_viewer'
  spec.summary = 'Slack log viewer'
  spec.description = 'Slack log viewer'
  spec.license = 'MIT'

  spec.add_development_dependency 'bundler'

  spec.add_dependency 'sinatra', '~> 1.4'
  spec.add_dependency 'haml', '~> 4.0'
  spec.add_dependency 'twemoji', '~> 2.1'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w( lib )
end
