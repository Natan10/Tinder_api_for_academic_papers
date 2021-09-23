require "graphql"
require_relative "types"
require_relative "query"
require_relative "mutation"


class TeacherSchema < GraphQL::Schema
  query QueryType
  mutation MutationType
end