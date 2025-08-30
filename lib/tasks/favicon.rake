require "rmagick"

namespace :favicon do
  desc "Generate environment-based favicons (dev/test/prod)"
  task :generate_all => :environment do
    include Magick

    size = 64
    gradients = {
      "development" => ["#00c6ff", "#0072ff"], # blue gradient
      "test"        => ["#ff9966", "#ff5e62"], # orange/red gradient
      "production"  => ["#56ab2f", "#a8e063"], # green gradient
    }

    gradients.each do |env, colors|
      gradient = Magick::GradientFill.new(0, 0, size, size, colors[0], colors[1])
      img = Magick::Image.new(size, size, gradient)

      gc = Magick::Draw.new
      gc.gravity = Magick::CenterGravity
      gc.pointsize = 22
      gc.font_weight = Magick::BoldWeight
      gc.fill = "white"

      # annotate applies text directly on the image
      gc.annotate(img, 0, 0, 0, 0, env[0].upcase)

      path = Rails.root.join("app/assets/images/favicon-#{env}.ico")
      img.write(path)

      puts "✅ Generated #{path}"
    end
  end
end
