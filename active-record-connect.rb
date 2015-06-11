def connect
  #ActiveRecord::Base.logger = Logger.new(STDOUT)

  puts 'Establishing connection to database ...'
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    database: 'dgov5rgrrl6k6',
    username: 'mqcgmfcjzepxqh',
    password: 'X1jMGWQ4jA1oLcYLdnh7uUbZV9',
    host: 'ec2-54-83-57-86.compute-1.amazonaws.com',
    port: 5432,
    pool: 5,
    encoding: 'unicode',
    min_messages: 'error'
  )
  puts 'CONNECTED'
end