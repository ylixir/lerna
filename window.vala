using Gtk;
using Gdk;

public class LernaWindow : Gtk.Window
{

    private static const string TITLE = "Lerna Browser";

    private Box box;
    private LernaTabstrip tabstrip;
    private Stack stack;

    public LernaWindow()
    {
        this.title = LernaWindow.TITLE;
        set_default_size (800, 600);

        create_widgets();
        connect_signals();
    }

    private void create_widgets()
    {
        stack = new Stack();
        tabstrip = new LernaTabstrip(stack);
        box =  new Box(Orientation.VERTICAL,0);
        box.pack_start(tabstrip,false,false);
        box.pack_start(stack,true,true);
        add(box);
    }

    private void connect_signals()
    {
        destroy.connect(Gtk.main_quit);
        tabstrip.new_clicked.connect((source)=>
        {
          LernaPage page = new LernaPage();
          stack.add(page);
          stack.child_set_property(page,"title","[No Title]");
          /*
          page.title_changed.connect((source,title)=>
          {
            stack.child_set_property(source,"title",title);
          });
          */
          page.start();
          stack.visible_child=page;
        });
    }

    public void start()
    {
        show_all();
        box.show_all();
        stack.show_all();
        tabstrip.start();
        tabstrip.new_clicked();
    }
}

