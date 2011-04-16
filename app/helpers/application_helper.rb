module ApplicationHelper
  include TweetButton
  
  def flash_messages
    output = ''
    [:notice, :warning, :success, :error].map { |f|
      if flash[f]
        output << "<div id=\"flash\" class=\"#{f}\">"
        output << '   <div id="icon"></div>'
        output << "   <div id=\"message\"><h2>#{f.to_s.titleize}!</h2>#{flash[f]}</div>"
        output << " <br />"
        output << '</div>'
        output << content_tag(:script, "fadeThenSlideToggle()")
      end
    }
    return output.html_safe
  end
  
  def facebook_like
    content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=button_count&show_faces=false&width=25&action=like&font&colorscheme=light&height=10", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end
  
  TweetButton.default_tweet_button_options = {:via => "Rubunity", :count => "horizontal"}
end
