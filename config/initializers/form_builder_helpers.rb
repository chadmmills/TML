module ActionView
  module Helpers
    class FormBuilder
      def inline_errors(field)
        if object.errors[field].any?
          error_html = error_html = object.errors.full_messages_for(field).map do |msg|
            @template.content_tag(
              :div,
              msg,
              class: "field-error",
            )
          end
          error_html.join().html_safe
        end
      end
    end
  end
end
