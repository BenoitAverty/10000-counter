// Require index.html so it gets copied to dist
require("./index.html");

var Elm = require("./Counter/Counter.elm");
var mountNode = document.getElementById("app-root");

var app = Elm.Counter.embed(mountNode);
