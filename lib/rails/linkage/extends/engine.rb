module Rails
  module Linkage
    module Extends
      class Engine < ::Rails::Engine
        initializer "rails-linkage-extends.init" do |app|
          FilterSetHelper::DefaultFilterBuilder.define_method :columns do |key, options={}|
            filter_class = " columns-#{key}"
            caption_class = "caption caption-#{key}"
            caption = options.delete(:caption)
            caption ||= @helper.t("filter_set.columns.default", default: nil)
            caption ||= @helper.t("filter_set.columns.#{key}")
            options[:class] = (options[:class] ? options[:class]+' ' : '') +  filter_class
            @helper.render "filter_set/columns", builder: self, key: key, caption: caption, caption_class: caption_class, options: options
          end

          app.config.i18n.load_path += Dir[Engine.root.join('config', 'locales','**', '*.{rb,yml}').to_s]
          app.config.i18n.default_locale = :"zh-CN"
        end
      end
    end
  end
end

