module NotesHelper
  def note_color(note)
    panel_class = "panel panel-danger" if note.author_type == "Tutor"
    panel_class = "panel panel-default" if note.author_type == "User"

    return panel_class
  end

  def note_author(note)
    author_name = " by The Tutor" if note.author_type == "Tutor"
    # author_name = User.find(note.author_id).name if note.author_type == "User"

    return author_name
  end
end
