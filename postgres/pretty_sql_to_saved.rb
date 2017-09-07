#!/usr/bin/env ruby -w
# ./pretty_sql_to_saved.rb ~/code/notes/mx/ballista_vertica_merge_saved.sql

def pretty_sql_to_psql_saved_query(query)
  require 'active_support/core_ext/string/filters'
  query = query.squish # Single line
  return false if query.empty?
  query = query.gsub("'", "\\\\'").to_s # Escape single quotes
  query += ';' unless query[-1] == ';'

  title = query.match(/^-- \w*/).to_s # Check for title comment
  if title
    query = query.gsub(title, '').squish
    title = title.gsub(/^-- /, '')
    puts "\\set #{title} '#{query}'"
  else
    puts "\n\n'#{query}'\n\n"
  end
  query
end

def process_all_pretty_queries(queries)
  queries.split(';').map do |query|
    pretty_sql_to_psql_saved_query(query)
  end
end

def start(args)
  arg = args.first
  if arg =~ (/^(\.|\/)/)
    queries = File.read(arg)
    process_all_pretty_queries(queries)
  else
    pretty_sql_to_psql_saved_query(arg)
  end
end

start(ARGV)
