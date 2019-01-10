require 'erb'

module Simpler
  class View
    VIEW_BASE_PATH = 'app/views'.freeze
    DEFAULT_RENDER = 'html'.freeze

    def self.render(env)
      Simpler::View.const_get("#{self.render_type(env).capitalize}Render")
    end

    def self.render_type(env)
      template = env.keys.grep(/simpler\.template\.(\w+)/){$1}
      template.any? ? template.first : DEFAULT_RENDER
    end
  end
end
