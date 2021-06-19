require_relative "./theme_serializer"

class TeacherSerializer
  def initialize(teacher)
    @teacher = teacher
  end

  def as_json(*)
    data = {
      id: @teacher["_id"].to_s,
      nome: @teacher["name"],
      email: @teacher["email"],
      latex_url: @teacher["latex_url"],
      themes: serializer_theme(@teacher.themes)
    }
    data
  end

  private 

  def serializer_theme(themes)
    themes.as_json(only: ["title","description","data","tags"])
  end
  
end