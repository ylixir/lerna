/*
Copyright 2015 Jon "ylixir" Allen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
using Gtk;
using Pango;

class LernaTab : Box
{
  private LernaButton text;     //the text of the tab
  public LernaButton close_btn; //a close button
  private Separator divider;
  /* properties that map to the text button */
  public double angle { get; set; }
  public AttrList attributes { get; set; }
  public EllipsizeMode ellipsize { get; set; }
  public Justification justify { get; set; }
  public string label { get; set; }
  public int lines { get; set; }
  public int  max_width_chars { get; set; }
  public Widget mnemonic_widget { get; set; }
  public bool selectable { get; set; }
  public bool single_line_mode { get; set; }
  public bool track_visited_links { get; set; }
  public bool use_markup { get; set; }
  public bool use_underline { get; set; }
  public int width_chars { get; set; }
  public bool wrap { get; set; }
  public Pango.WrapMode wrap_mode { get; set; }
  /* read only label properties */
  public int cursor_position { get { return text.cursor_position; } }
  public uint  mnemonic_keyval { get { return text.mnemonic_keyval; } }
  public int selection_bound { get { return text.selection_bound; } }
  /* write only label properties */
  public string pattern { set { text.pattern=value; } }

  /* this is fired whenever the text button is clicked */
  public signal void clicked();

  //string just gets passed along to the label
  public LernaTab(string? str)
  {
    /* create the children */
    text = new LernaButton(str);
    close_btn = new LernaButton("[x]");
    divider = new Separator(Orientation.VERTICAL);

    /* set the defaults */
    orientation = Orientation.HORIZONTAL;
    spacing =  2;
    homogeneous = false;
    text.hexpand=true;
  }

  public void start()
  {
    /* pack the children */
    pack_start(text,true,true);
    pack_start(close_btn,false,false);
    pack_start(divider,false,false);

    /* bind the label properties */
    BindingFlags flags = BindingFlags.SYNC_CREATE|BindingFlags.BIDIRECTIONAL;
    string[] props =
    {
      "angle",            "attributes",         "ellipsize",
      "justify",          "label",              "lines",
      "max_width_chars",  "mnemonic_widget",    "selectable",
      "single_line_mode", "track_visited_links","use_markup",
      "use_underline",    "width_chars",        "wrap",
      "wrap_mode"
    };
    foreach(var p in props)
      text.bind_property(p,this,p,flags);

    /* connect the signals */
    text.clicked.connect(
    (source)=>
    {
      clicked();
    });
    /* start the buttons */
    text.start();
    close_btn.start();

    /* show all the children */
    show_all();
  }
}
