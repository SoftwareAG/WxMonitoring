var previousMenuImage;
var menuInit = false;

function adapterMenuClick(url, help) {
    document.forms["urlsaver"].helpURL.value = help;
    return true;
}

function tdClick(thisTD, id) {
    alert(thisTD.all);
    thisTD.all[id].click();
}

function menuClick(url, target) {
    switch (target) {
    case "body":
        parent[target].window.location.href= url;
    break;
    default:   
        window.open(url, target, "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes");
    break;
    }

    menuMove(url, target);

    return false;
}

function menuSelect(object, url, target) {
    object.style.background = "rgb(0, 102, 153)";
    object.className += " menuitem-selected";
}

function IE() {
    if (navigator.appName == "Microsoft Internet Explorer")
        return true;
    return false;
}

function menuMouseOver(object, id) {
    object.style.background = "red";
    window.status = id;
}

function menuMouseOut(object) {
    object.style.background = "green";
    window.status = "";
}

function initMenu(firstImage) {
    previousMenuImage = document.images[firstImage];
    // previousMenuImage.src="images/selectedarrow.gif";
    menuInit = true;
    return true;
}
