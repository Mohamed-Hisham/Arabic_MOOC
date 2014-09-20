pdf.text "Video Name: #{@video.title}", size: 30, style: :bold, position: :center

pdf.move_down(20)

notes = [["Note Description", "Time"]]
notes += @notes.map do |note|
  [
    note.description,
    note.synmarks.first.start_time
  ]
end

pdf.table (notes),
  row_colors: ["F0F0F0", "FFFFFF"],
  position: :center,
  header: true do
    cells.padding = 12
    cells.borders = []
    row(0).borders = [:bottom]
    row(0).border_width = 2
    row(0).font_style = :bold
    row(0).min_font_size = 20
  end