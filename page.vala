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
    //the tab for this page will show this
    public string title { get; set; }

    private WebView web_view;
    private Entry url_bar;

    //it's hard to see the separation between the page and url bar
    private Separator divider;

    //public LernaPage(Orientation o=Orientation.VERTICAL, int s=0)
    public LernaPage()
    {
        /* create the children */
        web_view = new WebView();
        url_bar = new Entry();
        divider = new Separator(Orientation.HORIZONTAL);

        /* set the defaults */
        url_bar.has_frame=false;
        orientation=Orientation.VERTICAL;
        spacing=0;
    }

    public void start()
    {
        /* pack the widgets */
        pack_start(url_bar,false,false);
        pack_start(divider,false,false);
        pack_start(web_view,true,true);

        /* connect the signals */
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

        /* the url bar should have the focus when the window is created */
        url_bar.grab_focus();

        /* show all the children */
        show_all();
    }
}
