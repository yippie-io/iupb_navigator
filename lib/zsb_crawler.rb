require "open-uri"

#Faculty = Struct.new(:name, :source_id)
#Study = Struct.new(:name, :source_id, :faculty)
#Info = Struct.new(:name, :description, :link, :mail, :study, :custom_role_name)

class ZSBCrawler
  
  attr_reader :root_host, :root_path
  
  def initialize(root_host = "http://www.uni-paderborn.de", root_path = "/studium/wegweiser/")
    @root_host = root_host
    @root_path = root_path
    @decoder = Typo3EmailDecoder.new
  end
  
  def fetch_all
    faculties = find_faculties
    faculties.each(&:save)

    studies = faculties.flat_map do |fac|
      find_studies_for_faculty(fac)
    end
    studies.each(&:save)

    infos = studies.flat_map do |study|
      find_infos_for_study(study)
    end
    infos.each(&:save)
  end
  
  def find_faculties
    doc = Nokogiri::HTML(open(root_host + root_path))
    doc.css("select[name='tx_upbstudy_pi2[selectedFacultyId]'] option").map do |fac|
      Faculty.new(name: fac.content, source_id: fac.attr("value")) unless fac.attr("value") == "0"
    end.compact
  end
  
  def find_studies_for_faculty(faculty)
    doc = Nokogiri::HTML(open(root_host + root_path + "?tx_upbstudy_pi2%5BselectedFacultyId%5D=#{faculty.source_id.to_s}"))
    doc.css("select[name='tx_upbstudy_pi2[selectedFacMajorId]'] option").map do |maj|
      Study.new(name: maj.content, source_id: maj.attr("value"), faculty_id: faculty.id) unless maj.attr("value") == "0"
    end.compact
  end
  
  def find_infos_for_study(study)
    doc = Nokogiri::HTML(open(root_host + root_path + "?tx_upbstudy_pi2%5BselectedFacultyId%5D=#{study.faculty.source_id.to_s}&tx_upbstudy_pi2%5BselectedFacMajorId%5D=#{study.source_id.to_s}"))
    doc.css("#detailtable tr").map do |info|
      begin
        role_name = info.css("b").first.content
        contact = info.css(".studyContact").first
        name = contact.css("a[target='_blank']").first
        if name
          name_text = name.content
          link = name.attr("href")
        else
          name_text = contact.content.split("<br>").first
          link = nil
        end
        email = @decoder.decode_href(contact.css("a").last.attr("href"))
        Info.new(name: name_text, description: contact.text, link: link, study_id: study.id, custom_role_name: role_name, mail: email)
      rescue
        puts "ERROR! at " + root_host + root_path + "?tx_upbstudy_pi2%5BselectedFacultyId%5D=#{study.faculty.source_id.to_s}&tx_upbstudy_pi2%5BselectedFacMajorId%5D=#{study.source_id.to_s}"
        puts "CONTACTCARD: #{contact.inspect}"
      end
    end
  end
end