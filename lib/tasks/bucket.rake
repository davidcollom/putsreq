task :clean_requests => :environment do
  retention_period = 3.days.ago

  request.delete_all  created_at: { '$lt' => retention_period }
  response.delete_all created_at: { '$lt' => retention_period }
end

task :clean_buckets => :environment do
  retention_period = 2.week.ago

  Bucket.delete_all(last_request_at: { '$lt' => retention_period }, updated_at:  { '$lt' => retention_period } )

  Bucket.delete_all(last_request_at: nil, updated_at:  { '$lt' => retention_period } )
end
