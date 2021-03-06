# frozen_string_literal: true

require_relative '../lib/db'

DB.create_table(:users) do
  primary_key :id
  Integer :goodreads_user_id, uniq: true, null: false
  String :first_name
  String :email
end
