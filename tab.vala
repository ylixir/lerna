using Gtk;
using Pango;

class LernaTab : Box
{
  public signal void clicked();
  public signal void close();
  
  private LernaButton text;
  private LernaButton close_btn;
  private Separator divider;
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
    close_btn.destroy();
    divider.destroy();
  }
  public LernaTab(string str)
  {
    orientation = Orientation.HORIZONTAL;
    spacing =  2;
    homogeneous = false;

    text = new LernaButton(str);
    text.stretch=true;
    close_btn = new LernaButton("[x]");
    text.clicked.connect((source)=>{ clicked(); });
    close_btn.clicked.connect((source)=>{ close(); });
    divider = new Separator(Orientation.VERTICAL);
    pack_start(text,true,true);
    pack_start(close_btn,false,false);
    pack_start(divider,false,false);

    show_all();
  }
}
