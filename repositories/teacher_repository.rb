class TeacherRepository
  # find_by
  # all 
  # update 
  # delete 
  # create 

  def initialize(teacher)
    @teacher_instance = teacher
  end

  def all
    @teacher_instance.all
  end

  def find_by_id(id)
    @teacher_instance.find(id)
  end

  def create_teacher(attributes)
    if validate_teacher?(attributes["name"])
      teacher =  @teacher_instance.new(attributes)
      teacher.save!
      return teacher
    end
    raise Mongoid::Errors::MongoidError
  end

  def delete_teacher(id)
    find_by_id(id).delete
  end

  def update_teacher(id,attributes)
    teacher = find_by_id(id)
    attributes.each do |key,value| 
      teacher.set("#{key}" => value)
    end
    teacher
  end

  private 

  def validate_teacher?(name)
    @teacher_instance.where(name: name).one.nil?    
  end
end