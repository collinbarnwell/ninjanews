require 'net/http'
require 'nokogiri'

module Calais
  def self.get_tags(article)
    host = "api.opencalais.com"
    request_url = "/enlighten/rest/"
    params = '  <c:params xmlns:c="http://s.opencalais.com/1/pred/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"> \
                <c:processingDirectives c:contentType="text/txt" c:enableMetadataType="GenericRelations" c:outputFormat="xml/rdf"> \
                </c:processingDirectives> <c:userDirectives c:allowDistribution="true" c:allowSearch="true" c:externalID="17cabs901" c:submitter="ABC"> \
                </c:userDirectives> <c:externalMetadata> </c:externalMetadata> </c:params>'
    content = "#{article.title}. #{article.content}"

    http = Net::HTTP.new(host)
    request = Net::HTTP::Post.new(request_url)
    request.set_form_data({licenseID: ENV['CALAIS_KEY'], 
                           paramsXML: params, content: content})
    begin
      resp = http.request(request)
    rescue
      puts 'Request failed.'
    end
    data = Nokogiri::XML(resp.body)
    tags = []
    begin
      data.xpath('//c:name').each do |el|
        if el.to_s.match(/c:shortname/)
          tags << el.next_element.text
        else
          tags << el.text
        end
      end
    rescue
      puts 'An error occured with OpenCalais.'
    end
    tags.uniq
  end
end
