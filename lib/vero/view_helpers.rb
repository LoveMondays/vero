module Vero
  module ViewHelpers
    def vero_javascript_tag(method = :default)
      return "" unless Vero::App.configured?

      unless [:default, :mixpanel, :kissmetrics].include?(method)
        method = :default
      end

      method_name = method.to_s + "_vero_javascript_tag"
      self.send(method_name.to_sym, Vero::App.config.config_params)
    end

    private
    def default_vero_javascript_tag(options = {})
      content_tag :script, {:type => "text/javascript"} do
        result = "var _veroq = _veroq || [];" +
        "setTimeout(function(){if(typeof window.Semblance==\"undefined\"){console.log(\"Vero did not load in time.\");for(var i=0;i<_veroq.length;i++){a=_veroq[i];if(a.length==3&&typeof a[2]==\"function\")a[2](null,false);}}},3000);" +
        "_veroq.push(['init', {" +
        options_to_string(options) +
        "}]);" + 
        "(function() {var ve = document.createElement('script'); ve.type = 'text/javascript'; ve.async = true; ve.src = '//getvero.com/assets/m.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ve, s);})();"
        result.html_safe
      end.html_safe
    end

    def mixpanel_vero_javascript_tag(options = {})
    end

    def kissmetrics_vero_javascript_tag(options = {})
    end

    def options_to_string(options)
      options = {} unless options.kind_of?(Hash)
      result = options.keys.collect { |k| "\"#{k}\": \"#{options[k]}\"" }
      result.join(", ")
    end
  end
end