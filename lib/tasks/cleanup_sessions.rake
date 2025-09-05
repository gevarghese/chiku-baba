#bin/rails sessions:cleanup_viewed_blogs
namespace :sessions do
  desc "Clean up old viewed_blogs entries from session store"
  task cleanup_viewed_blogs: :environment do
    cutoff = 24.hours.ago

    if defined?(ActiveRecord::SessionStore::Session)
      puts "Cleaning up session store..."
      ActiveRecord::SessionStore::Session.find_each do |session|
        data = Marshal.load(session.data) rescue nil
        next unless data.is_a?(Hash) && data["viewed_blogs"]

        # Remove old blog view entries
        cleaned = data["viewed_blogs"].select do |_blog_id, timestamp|
          begin
            Time.parse(timestamp) > cutoff
          rescue
            false
          end
        end

        if cleaned.size != data["viewed_blogs"].size
          data["viewed_blogs"] = cleaned
          session.data = Marshal.dump(data)
          session.save!
        end
      end
    else
      puts "⚠️ Not using ActiveRecord session store — cleanup may not be needed."
    end
  end
end
