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

public interface LernaLabel : Object
{
  /* the label that displays the text */
  protected abstract Label text { get; set; }
  /* properties that map to the above label */
  public double angle
  {
    get { return text.angle;  }
    set { text.angle = value; }
  }
  public AttrList attributes
  {
    get { return text.attributes;  }
    set { text.attributes = value; }
  }
  public EllipsizeMode ellipsize
  {
    get { return text.ellipsize;  }
    set { text.ellipsize = value; }
  }
  public Justification justify
  {
    get { return text.justify;  }
    set { text.justify = value; }
  }
  public string label
  {
    get { return text.label;  }
    set { text.label = value; }
  }
  public int lines
  {
    get { return text.lines;  }
    set { text.lines = value; }
  }
  public int  max_width_chars
  {
    get { return text.max_width_chars;  }
    set { text.max_width_chars = value; }
  }
  public Widget mnemonic_widget
  {
    get { return text.mnemonic_widget;  }
    set { text.mnemonic_widget = value; }
  }
  public bool selectable
  {
    get { return text.selectable;  }
    set { text.selectable = value; }
  }
  public bool single_line_mode
  {
    get { return text.single_line_mode;  }
    set { text.single_line_mode = value; }
  }
  public bool track_visited_links
  {
    get { return text.track_visited_links;  }
    set { text.track_visited_links = value; }
  }
  public bool use_markup
  {
    get { return text.use_markup;  }
    set { text.use_markup = value; }
  }
  public bool use_underline
  {
    get { return text.use_underline;  }
    set { text.use_underline = value; }
  }
  public int width_chars
  {
    get { return text.width_chars;  }
    set { text.width_chars = value; }
  }
  public bool wrap
  {
    get { return text.wrap;  }
    set { text.wrap = value; }
  }
  public Pango.WrapMode wrap_mode
  {
    get { return text.wrap_mode;  }
    set { text.wrap_mode = value; }
  }
 /* read only label properties */
  public int cursor_position { get { return text.cursor_position; } }
  public uint  mnemonic_keyval { get { return text.mnemonic_keyval; } }
  public int selection_bound { get { return text.selection_bound; } }
  /* write only label properties */
  public string pattern { set { text.pattern=value; } }

  /* you may connect to this to receive an event when a
   * button goes down on this widget. Later I plan on updating
   * this to make it a true "click" event
   */
  public signal void clicked();
  public signal void activate_current_link();
  public signal bool activate_link(string uri);
  public signal void copy_clipboard();
  public signal void move_cursor(MovementStep step, int count, bool extend_selection);
  public signal void populate_popup(Gtk.Menu menu);

  /* this must be called to make the pass through signals work */
  public void connect_text()
  {
    text.activate_current_link.connect((source)=>
      { activate_current_link(); });
    text.activate_link.connect((source,uri)=>
      { return activate_link(uri); });
    text.copy_clipboard.connect((source)=>
      { copy_clipboard(); });
    text.move_cursor.connect((source,step,count,extend_selection)=>
      { move_cursor(step,count,extend_selection); });
    text.populate_popup.connect((source,menu)=>
      { populate_popup(menu); });
  }
}
