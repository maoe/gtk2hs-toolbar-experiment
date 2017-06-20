{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}
import Data.GI.Base
import Data.Text (Text)
import qualified GI.Gtk as Gtk

main :: IO ()
main = do
    Gtk.init Nothing
    window <- new Gtk.Window []
    on window #destroy Gtk.mainQuit
    toolbar <- new Gtk.Toolbar [Gtk.toolbarShowArrow := True]

    toolItem1 <- new Gtk.ToolItem []
    comboBox1 <- mkDropdownPicker ["foo", "bar", "baz"]
    #add toolItem1 comboBox1

    toolItem2 <- new Gtk.ToolItem []
    comboBox2 <- mkDropdownPicker ["qux", "quux", "quuux"]
    #add toolItem2 comboBox2

    Gtk.toolbarInsert toolbar toolItem1 (-1)
    Gtk.toolbarInsert toolbar toolItem2 (-1)

    vBox <- new Gtk.Box [#orientation := Gtk.OrientationVertical]
    Gtk.boxPackStart vBox toolbar False False 0

    #add window vBox
    #showAll window

    Gtk.main

mkDropdownPicker :: [Text] -> IO Gtk.ComboBoxText
mkDropdownPicker xs = do
    comboBox <- new Gtk.ComboBoxText []
    mapM_ (Gtk.comboBoxTextAppendText comboBox) xs
    set comboBox [#active := 0]
    return comboBox
