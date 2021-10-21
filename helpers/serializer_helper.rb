require_relative "../serializers/teacher_serializer"
require_relative "../serializers/theme_serializer"

helpers do
  def serializer_teacher(teacher, options={}) 
    TeacherSerializer.new(teacher).to_json
  end

  def serializer_theme(theme,options={})
    ThemeSerializer.new(theme).to_json
  end

  # Deprecado
  def json_body(request)
    JSON.parse(request.body.read) 
  end
end
