require_relative "./mutations/teacher_mutations"

class MutationType < GraphQL::Schema::Object
  description "root mutation"

  field :createTeacher, mutation: Mutation::CreateTeacher
  field :deleteTeacher, mutation: Mutation::DeleteTeacher
  field :updateTeacher, mutation: Mutation::UpdateTeacher
end