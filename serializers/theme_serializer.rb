class ThemeSerializer
  def initialize(theme)
    @theme = theme
  end

  def as_json(*)
    data = {
      id: @theme["_id"].to_s,
      title: @theme["title"],
      description: @theme["description"],
      tags: @theme["tags"],
      teacher_id: @theme["teacher_id"].to_s
    }
    data
  end
end