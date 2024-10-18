{configLib, ...}: {
  imports =
    (configLib.scanPaths ./.)
    ++ [../core];
}
