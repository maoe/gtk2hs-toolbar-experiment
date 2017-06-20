{-# LANGUAGE OverloadedStrings #-}
import Control.Monad
import Graphics.UI.Gtk

main :: IO ()
main = do
    initGUI
    window <- windowNew
    on window objectDestroy mainQuit
    toolbar <- toolbarNew

    toolItem1 <- toolItemNew
    comboBox1 <- mkDropdownPicker ["foo", "bar", "baz"]
    containerAdd toolItem1 comboBox1

    toolItem2 <- toolItemNew
    comboBox2 <- mkDropdownPicker ["qux", "quux", "quuux"]
    containerAdd toolItem2 comboBox2

    toolbarInsert toolbar toolItem1 (-1)
    toolbarInsert toolbar toolItem2 (-1)

    set toolbar [toolbarShowArrow := True]

    vBox <- vBoxNew False 0
    boxPackStart vBox toolbar PackNatural 0

    containerAdd window vBox
    widgetShowAll window

    mainGUI

mkDropdownPicker :: [ComboBoxText] -> IO ComboBox
mkDropdownPicker xs = do
    comboBox <- comboBoxNewText
    comboBoxSetModelText comboBox
    mapM_ (comboBoxAppendText comboBox) xs
    comboBoxSetActive comboBox 0
    return comboBox
