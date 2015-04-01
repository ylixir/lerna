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
