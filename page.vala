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
using WebKit;

public class LernaPage : Box
{
    //public signal void title_changed(string title);
    public string title { get; set; }

    private WebView web_view;
    private Entry url_bar;
    private Separator divider;

    ~LernaPage()
    {
      web_view.destroy();
      url_bar.destroy();
      divider.destroy();
    }
    public LernaPage(Orientation o=Orientation.VERTICAL, int s=0)
    {
        orientation=o;
        spacing=s;

        web_view = new WebView();
        url_bar = new Entry();
        divider = new Separator(Orientation.HORIZONTAL);
        url_bar.has_frame=false;
        pack_start(url_bar,false,false);
        pack_start(divider,false,false);
        pack_start(web_view,true,true);

        web_view.close.connect(
        (source)=>
        {
          this.destroy();
        });
        web_view.load_changed.connect(
        (source,event)=>
        {
          if( LoadEvent.COMMITTED == event )
          {
            url_bar.text=web_view.uri;
          }
        });
        web_view.notify["title"].connect(
        (source)=>
        {
          title=web_view.title;
        });
        web_view.notify["uri"].connect(
        (source)=>
        {
          url_bar.text=web_view.uri;
        });
        url_bar.activate.connect((source)=>
        {
          if( !("://" in url_bar.text) )
          {
            web_view.load_uri(@"https://$(url_bar.text)");
          }
          else
            web_view.load_uri(url_bar.text);
        });
    }

    public void start()
    {
        url_bar.grab_focus();
        show_all();
    }
}
