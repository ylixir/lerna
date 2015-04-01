/*

Flat buttons are generally bad UI design in my opinion.

Regular GTK+ buttons take up a ton of screen real estate.

This program is meant to be no more difficult to use than necessary.

It should also be keyboard friendly and take up very little screen
real estate.

This is the compromise: flat buttons are evil but these buttons still help
out those who aren't born magically knowing keyboard shortcuts while
taking up less screen real estate.

*/

using Gtk;
using Pango;

public class LernaButton : EventBox
{
    private Label text;

    public signal void clicked();

    public bool stretch 
    {
      get { return text.hexpand;  }
      set { hexpand=value; text.hexpand = value; }
    }
    public string label
    {
      get { return text.label;  }
      set { text.label = value; }
    }
    public AttrList attributes
    {
      get { return text.attributes;  }
      set { text.attributes = value; }
    }

    ~LernaButton()
    {
      text.destroy();
    }

    public LernaButton(string? str)
    {
        text = new Label(str);
        text.justify = Justification.CENTER;
        add(text);
        button_press_event.connect((source, event)=>
        {
          clicked();
          return false;
        });
    }

    public void start()
    {
        show_all();
    }
}