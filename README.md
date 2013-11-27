## ox_cdata_xml_parser ##
---------------------------------------

This will help to parse xml having cdata.Ox_xml parser returns complete hash structure of each parent tag you have 
specified in <parent_tag> to next_element method.You can write validation in valid method.Write your code to process hash_obj.

### test.xml ###

    <?xml version="1.0" encoding="UTF-8"?>
    <sammple>
      <item>
        <modelno>1001</modelno>
        <price><![CDATA[1595]]></price>
        <date><![CDATA[13/05/2013]]></date>
        <time><![CDATA[05:11]]></time>
        </item>
    </sample>

### hash_obj ###

    {
        "modelno" => "1001",
        "price" => {
        :cdata => "1595"
        },
        "date" => {
        :cdata => "13/05/2013"
        },
        "time" => {
        :cdata => "05:11"
        }
    }
    {
        "modelno" => "1002",
        "price" => {
        :cdata => "1595"
        },
        "date" => {
        :cdata => "13/05/2013"
        },
        "time" => {
        :cdata => "05:11"
        }
    }



### parse_xml_file.rb ###

    class ParseXmlFile
    
        def valid? hash_obj
          #    return true or false
        end

        def run
          parser = XmlParsing::Reader.new("/home/chetan/test.xml","item", self)
          @count = parser.count
          parser.parse
        end
    
        def next_element hash_obj
          return unless valid? hash_obj
          # write your code here
        end
    end
