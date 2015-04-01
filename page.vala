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
