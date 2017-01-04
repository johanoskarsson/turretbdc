require "prawn"
require "prawn/measurement_extensions"

class BDCGenerator

  def generate_bdc(turret, ballistics, file)
    margin = 10.mm
    page_size = [turret.circumference_mm.mm + margin * 2, turret.height_mm.mm + margin * 2]

    Prawn::Document.generate(file, page_size: page_size, margin: margin) do
      bounding_box([0, margin], :width => turret.circumference_mm.mm, :height => turret.height_mm.mm) do
        stroke_bounds

        ballistics.distances.each do |distance|
          even_hundred = distance % 100 == 0
          elevation_mils = ballistics.elevation_mils(distance)
          elevation_pos = turret.mm_per_mil * elevation_mils
          # to make it easier to spot the 100 marks, reduce all the others in size
          line_height = even_hundred ? (turret.height_mm.mm / 2) : (turret.height_mm.mm / 3)

          stroke { line [elevation_pos.mm, 0], [elevation_pos.mm, line_height] }

          # only print numbers at even 100 marks
          unless even_hundred
            next
          end

          distance_hundreds = (distance / 100).to_s
          text_y = (turret.height_mm.mm - (turret.height_mm.mm / 3))
          text_width = width_of(distance_hundreds, :size => 10)
          text_x = elevation_pos.mm - (text_width / 2)

          draw_text distance_hundreds, :size => 10, :at => [text_x, text_y]
        end
      end
    end
  end
end
