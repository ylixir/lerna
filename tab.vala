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
  public LernaButton text;     //the text of the tab
  public LernaButton close_btn; //a close button
  private Separator divider;

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
    text.label.hexpand=true;
  }

  public void start()
  {
    /* pack the children */
    pack_start(text,true,true);
    pack_start(close_btn,false,false);
    pack_start(divider,false,false);

    /* start the buttons */
    text.start();
    close_btn.start();

    /* show all the children */
    show_all();
  }
}
