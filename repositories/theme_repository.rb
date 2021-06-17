class ThemeRepository 
  def initialize(theme,teacher)
    @theme = theme
    @teacher = teacher
  end

  def all 
    @theme.all 
  end

  def find_by_id(id)
    @theme.find(id)
  end

  def create(teacher_id,attributes) 
    teacher = @teacher.find_by_id(teacher_id)
    theme = teacher.themes.create!(attributes)
    return theme
  end
end