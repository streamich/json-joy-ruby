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

    def self.format components
      escaped = components.map { |component| escape_component component }
      pointer = escaped.join('/')
      pointer.empty? ? '' : '/' + pointer
    end

    def self.find val, path
      obj = nil
      key = nil
      return Reference.new val, obj, key if path.empty?
      path.each do |component|
        if val.class == Hash
          raise 'NOT_FOUND' unless val.key?(component)
          obj = val
          key = component
          val = val[component]
        elsif val.class == Array
          index = component.to_i
          raise 'INVALID_INDEX' if index.to_s != component
          raise 'INVALID_INDEX' if index >= val.length || index < 0
          obj = val
          key = index
          val = val[component.to_i]
        else
          raise 'NOT_FOUND'
        end
      end
      Reference.new val, obj, key
    end
  end

  class Reference
    attr_accessor :val, :obj, :key

    def initialize val, obj = nil, key = nil
      @val = val
      @obj = obj
      @key = key
    end
  end
end
