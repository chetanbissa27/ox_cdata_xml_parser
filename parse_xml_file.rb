require 'ox_xml'
require "awesome_print"

class ParseXmlFile
  def valid? hash_obj
#    return true or false
  end

  def run
    parser = XmlParsing::Reader.new(<filename>, <parent_tag>, self)
    @count = parser.count
    parser.parse
  end

  def next_element hash_obj
    return unless valid? hash_obj
    # write your code 
  end

end

