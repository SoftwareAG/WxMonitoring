
function toggle(parent, id, imgId) {
    var set = "none";
    var image = document.getElementById(imgId);
    if (parent.getAttribute("manualhide") == "true") {
        set = "table-row";
        parent.setAttribute("manualhide", "false");
        image.src = "images/expanded.gif";
        var item = document.getElementById("elmt_" + id);
        item.style.backgroundColor = "#006f97";
        item.style.color = "#fff";
    }
    else {
        parent.setAttribute("manualhide", "true");
        image.src = "images/collapsed_blue.png";
        var item = document.getElementById("elmt_" + id);
        item.style.backgroundColor = "#fff";
        item.style.color = "#0c3b60";
    }
    var elements = getElements("tr", id);

    for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        element.style.cssText = "display:" + set;
    }
}

function getElements(tag, name) {
    var elem = document.getElementsByTagName(tag);
    var arr = new Array();
    for (i = 0, idx = 0; i < elem.length; i++) {
        att = elem[i].getAttribute("name");
        if (att == name) {
            arr[idx++] = elem[i];
        }
    }
    return arr;
}


function setMenuItem(rootid, bgcolor, color) {
    /* the td element */
    var tdobj = document.getElementById("i" + rootid);
    tdobj.style.backgroundColor = bgcolor;

    /* the a element within the td element above */
    var aobj = document.getElementById("a" + rootid);
    aobj.style.color = color;
}

(function(exports) {
  exports.select = function(object, id, selected) {
    if (selected != null) {
        setMenuItem(selected, "#fff", "#2e5e83");
    }
    setMenuItem(id, "#0899cc", "#fff");
    return id;
  };

  exports.mouseOver = function(object, id, selected) {
    if (id != selected) {
        setMenuItem(id, "#8bcfed", "#333");
    }
    window.status = id;
  };

  exports.mouseOut = function(object, id, selected) {
    if (id != selected) {
        setMenuItem(id, "#fff", "#2e5e83");
    }
    window.status = "";
  };
})(this.menuext = {});
