require "prawn"
require "prawn/measurement_extensions"

class BDCGenerator

  def generate_bdc(turret, ballistics, file, label)
    margin = 5.mm
    page_size = [turret.circumference_mm.mm + margin * 2, turret.height_mm.mm + margin * 2]

    Prawn::Document.generate(file, page_size: page_size, margin: margin) do
      bounding_box([0, turret.height_mm.mm], :width => turret.circumference_mm.mm, :height => turret.height_mm.mm) do
        line_width(0.2.mm)
        stroke_bounds

        # used to figure out when we "tick" over to the next windage number
        prev_windage_clicks = 0

        ballistics.distances.each do |distance|
          elevation_mils = ballistics.elevation_mils(distance)
          elevation_pos = turret.mm_per_mil * elevation_mils

          # to make it easier to spot the 100 marks, reduce all the others in size
          line_height = if distance % 100 == 0 then
            turret.height_mm.mm / 2
          elsif distance % 50 == 0
            turret.height_mm.mm / 3
          else
            turret.height_mm.mm / 6
          end

          # the vertical lines that mark the distances
          stroke { line [elevation_pos.mm, 0], [elevation_pos.mm, line_height] }

          # marking windage (spin drift) so we can look on the elevation turret
          # what we need to add to our windage calculations
          windage_clicks = (ballistics.windage_mils(distance) * 10).round
          if windage_clicks > prev_windage_clicks
            circle_y = turret.height_mm.mm / 2
            circle_x = elevation_pos.mm - (0.5.mm / 2)
            circle([circle_x, circle_y], 0.5.mm)
            fill()
          end
          prev_windage_clicks = windage_clicks

          # only print numbers at even 100 marks
          unless distance % 100 == 0
            next
          end

          # figure out where to write the distance labels
          distance_hundreds = (distance / 100).to_s
          text_y = (turret.height_mm.mm - (turret.height_mm.mm / 3))
          text_width = width_of(distance_hundreds, :size => 10)
          text_x = elevation_pos.mm - (text_width / 2)

          # the distance labels (only the hundreds)
          draw_text distance_hundreds, :size => 10, :at => [text_x, text_y]
        end
      end

      draw_text label, :size => 10, :at => [0, -margin/1.5]
    end
  end
end
