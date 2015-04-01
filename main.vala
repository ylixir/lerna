//compile with:
//valac --pkg gtk+-3.0 --pkg webkit2gtk-4.0 -o simple simple.vala

using Gtk;

int main (string[] args)
{
    Gtk.init(ref args);

    var browser = new LernaWindow();
    browser.start();

    Gtk.main();

    return 0;
}

