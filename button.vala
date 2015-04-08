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

///public class LernaButton : EventBox
public class LernaButton : EventBox
{
  /* the label that displays the text */
  private Label text;
  /* properties that map to the above label */
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
  public int cursor_position
  {
    get { return text.cursor_position; }
  }
  public uint  mnemonic_keyval
  {
    get { return text.mnemonic_keyval; }
  }
  public int selection_bound
  {
    get { return text.selection_bound; }
  }
  /* write only label properties */
  public string pattern
  {
    set { text.pattern=value; }
  }

  /* you may connect to this to receive an event when a
   * button goes down on this widget. Later I plan on updating
   * this to make it a true "click" event
   */
  public signal void clicked();

  /* the constructor */
  public LernaButton(string? str)
  {
      text = new Label(str);
      text.justify = Justification.CENTER;
  }

  /* this must be called to use this widget
   * later maybe replace with an event
   */
  public void start()
  {
    /* pack the child widgets */
    add(text);

    /* connect signals */
    button_press_event.connect((source, event)=>
    {
      clicked();
      return false;
    });

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

    /* show all the children */
    show_all();
  }
}
