require "graphql"
require_relative "queries"

class TeacherSchema < GraphQL::Schema
  query(QueryType)
end