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
      themes: @teacher.themes
    }
    data
  end
end