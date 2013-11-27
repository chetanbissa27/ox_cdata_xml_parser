
module XmlParsing
  require "ox"

  class Reader < ::Ox::Sax
    def initialize file_path, target, target_handler
      @target_handler = target_handler
      @target = target
      @file_path = file_path
      @elements = []
    end

    def count match=nil
      match ||= "<#{@target}>"
      @count = `grep "#{match}" #{@file_path} -o | wc -l`.to_s.strip.to_i
      @count
    end

    def parse
      xmlio = IO.new(IO.sysopen @file_path)
      Ox.sax_parse self, xmlio
    end

    def start_element(name)
      name = name.to_s.strip
      @elements.push({ name=>{} })
    end

    def cdata(value)
      return unless @elements.last
      value = value.to_s.strip
      @elements.last[:cdata] = value
    end

    def end_element(name)
      name = name.to_s.strip

      if @elements.last[name]
        @element = @elements.pop

        @element.delete name

        if @element.keys.count==1 and @element[:text]
          inject_into_last name, @element[:text]
        else
          inject_into_last name, @element
        end
      end

      @target_handler.next_element @element if @target==name
    end

    def inject_into_last name, value
      return unless @elements.last
      
      if @elements.last[name]
        @elements.last[name] = [ @elements.last[name] ] unless @elements.last[name].is_a? Array
        @elements.last[name].push value

      else
        @elements.last[name] = value
      end
    end

    def attr(name, value)
      return unless @elements.last

      name = name.to_s.strip
      value = value.to_s.strip

      @elements.last[:attrs] ||= {}
      @elements.last[:attrs][name] = value
    end

    def text(value)
      return unless @elements.last
      value = value.to_s.strip
      @elements.last[:text] = value
    end
  end

  class Dummy
    def next_element
      @count ||= 0
      @count += 1
    end

    def count
      @count
    end
  end
end
