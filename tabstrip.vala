using Gtk;
using Gee;
using Pango;

public class LernaTabstrip : Box
{
    public signal void new_clicked();
    private LernaButton new_btn;
    private HashMap<Widget,LernaTab> tabs;
    private Stack stack;

    ~LernaTabstrip()
    {
      new_btn.destroy();
      stack.destroy();
    }
    public LernaTabstrip(Stack stack, Orientation o=Orientation.HORIZONTAL, int space=2)
    {
        orientation=o;
        spacing=space;
        homogeneous = false;

        new_btn = new LernaButton("[+]");
        tabs = new HashMap<Widget,LernaTab>();
        this.stack = stack;
        pack_end(new_btn,false,false);

        new_btn.clicked.connect((source)=>
        {
          new_clicked();
        });

        stack.add.connect(
        (source, child)=>
        {
          AttrList attr;
          LernaTab old_tab;

          LernaTab tab = new LernaTab("[No Title]");

          //unbold the old tab
          old_tab = tabs.get(stack.visible_child);
          if( null != old_tab )
          {
            attr = old_tab.attributes ?? new AttrList();
            attr.change(attr_weight_new(Weight.NORMAL));
            old_tab.attributes = attr;
          }
          //bold the new tab
          attr = tab.attributes ?? new AttrList();
          attr.change(attr_weight_new(Weight.BOLD));
          tab.attributes = attr;

          tabs.set(child, tab);
          child.notify["title"].connect(
          (source)=>
          {
            tabs.get(child).label=((LernaPage)child).title;
          });
          tab.clicked.connect(
          (source)=>
          {
            //unbold the old tab
            old_tab = tabs.get(stack.visible_child);
            if( null != old_tab )
            {
              attr = old_tab.attributes ?? new AttrList();
              attr.change(attr_weight_new(Weight.NORMAL));
              old_tab.attributes = attr;
            }
            //bold the new tab
            attr = tab.attributes ?? new AttrList();
            attr.change(attr_weight_new(Weight.BOLD));
            tab.attributes = attr;

            stack.visible_child=child;
          });
          tab.close.connect(
          (source)=>
          {
            stack.remove(child);

            //bold the new tab
            LernaTab new_tab = tabs.get(stack.visible_child);
            if( null != new_tab )
            {
              attr = new_tab.attributes ?? new AttrList();
              attr.change(attr_weight_new(Weight.BOLD));
              new_tab.attributes = attr;
            }
          });
          pack_start(tab,true,true);
        });
        stack.remove.connect(
        (stack, child)=>
        {
          var tab = tabs.get(child);
          tabs.unset(child);
          child.destroy();
          tab.destroy();
        });
    }

    public void start()
    {
        show_all();
    }
}

