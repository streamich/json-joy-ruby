# frozen_string_literal: true

module Json
  class Pointer
    def self.unescape_component component
      component.index('~') ? component.gsub('~1', '/').gsub('~0', '~') : component
    end

    def self.escape_component component
      return component if !component.index('~') && !component.index('/')
      component.gsub('~', '~0').gsub('/', '~1')
    end

    def self.parse str
      return [] if str.empty?
      return [''] if str == '/'
      components = str[1..-1].split '/', -1
      components.map! { |component| unescape_component component }
    end
  end
end
