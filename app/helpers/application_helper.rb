module ApplicationHelper
  def link_to_add_fields(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def status_tag(str, options={})
      options[:true_text] ||=''
      options[:false_text] ||=''

      if str == "OPEN"
        content_tag(:span, options[:true_text], :class => 'status true')
      else
        content_tag(:span, options[:false_text], :class => 'status false')
      end
    end
end
