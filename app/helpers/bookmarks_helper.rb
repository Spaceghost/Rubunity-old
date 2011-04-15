module BookmarksHelper
  
  def rails_versions
    clnt = HTTPClient.new
    versions = Array.new
    #version_string = clnt.get_content("http://github.com/api/v2/json/repos/show/rails/rails/tags")
    version_string = File.read('public/rails_versions.json')

    version_string = JSON.parse(version_string)

    #puts JSON.parse(version_string).inspect

    version_string["tags"].keys.each do |tag|
      versions << tag.gsub("v", "")
    end

    #versions.sort!
    #versions = %w( 1.0.9 2.0 1.0.10 1.0.3 )
    versions = VersionSorter.sort(versions) # => ["2.0", "1.0.10", "1.0.9", "1.0.3"]
    versions
  end
  
  def rails_versions_list
    version = rails_versions.reverse.first[0]
    list = "<h2>Rails #{version}</h2>\n\n"
    list += "<ul>\n"

    rails_versions.reverse.each do |rails|
      if version != rails[0]
        list += "</ul>\n\n"
        version = rails[0]
        list += "<h2>Rails #{ version.to_i > 0 ? version : ""}</h2>\n\n"
        list += "<ul>\n" 
      end
      list += "<li class='version_check_box'>" + check_box_tag("rails_versions[]", rails) + label_tag(rails) + "</li>\n"
    end

    list += "</ul>\n\n"
    list.html_safe
  end
end
