var Main = {};

var widgetAPI = new Common.API.Widget();
var tvKey = new Common.API.TVKeyValue();

var startEnabled = false;
var LabelString = "";
var usbPlugin;
var filePlugin;
var homeDir = "";

Main.onLoad = function() {
  alert("Main.onLoad()");
  this.enableKeys();
  widgetAPI.sendReadyEvent();
  Init();
};

Main.onUnload = function() {
};

Main.enableKeys = function() {
  document.getElementById("anchor").focus();
};

Main.keyDown = function() {
  switch (event.keyCode) {
    case tvKey.KEY_RETURN:
    case tvKey.KEY_PANEL_RETURN:
      widgetAPI.sendReturnEvent();
      break;
    case tvKey.KEY_ENTER:
    case tvKey.KEY_PANEL_ENTER:
      if (startEnabled) {
        startEnabled = false;

        Log("Install...");
        DoInstall();

        // просто таймаут, чтобы надпись не появлялась сразу
        setTimeout(function() {
          Log("Setup completed.");
        }, 2500);
      }
      break;
    default:
      alert("Unhandled key");
      break;
  }
};

function Log(message) {
  var label = document.getElementById("LogLabel");
  LabelString = LabelString + message + "<br>";
  widgetAPI.putInnerHTML(label, LabelString);
};

function Init() { 
  usbPlugin = document.getElementById("pluginStorage");
  filePlugin = document.getElementById("pluginObjectFile");

  homeDir = GetInstallDir();
  if (homeDir != null) {
    Log("Boot found on " + homeDir);
    startEnabled = true;
  } else {
    Log("Boot script not found.");
  }
};

function GetInstallDir() {
  var usbNum = usbPlugin.GetUSBListSize();

  Log("Found <b style='font-size:30px; color:green'>" + usbNum + "</b> USB devices");
  for (var i = 0; i < usbNum; i++) {
    var deviceId = usbPlugin.GetUSBDeviceID(i);

    var vendor = usbPlugin.GetUSBVendorName(deviceId);
    var model = usbPlugin.GetUSBModelName(deviceId);
    Log("- <span style='color:green'>" + vendor + "&nbsp;" + model + "</span>");

    var partitionNum = usbPlugin.GetUSBPartitionNum(deviceId);
    for (var j = 0; j < partitionNum; j++) {
      var mountDir = '/dtv/usb/' + usbPlugin.GetUSBMountPath(deviceId, j);
      if (IsPathExist(mountDir + "/samapp/data")) {
        return mountDir;
      }
    }
  }
  return null;
}


function IsPathExist(path) {
  var hresult = filePlugin.IsExistedPath(path);
  return (hresult == 1);
}

function CopyFile(source, target) {
  try {
    var hresult = filePlugin.Copy(source, target);
  } catch (e) {
    return e;
  }  
  return hresult;
}

function DoInstall() {
  var filemap = [
    ["Copy", homeDir + "/samapp/data/agent.conf", "/mtd_rwarea/agent.conf"], 
    ["Copy", homeDir + "/samapp/data/VD_TOOLS.sh", "/mtd_rwarea/VD_TOOLS.sh"],
    ["Copy", homeDir + "/samapp/data/initd.sh", "/mtd_rwcommon/samboot/initd.sh"]
  ];

  for (var i = 0; i < filemap.length; i++) {
    var actionName = filemap[i][0];
    var source = filemap[i][1];
    var target = filemap[i][2];

    if (actionName === "Backup") {
      if (IsPathExist(target)) {
        Log(actionName + " " + source + " -> " + target + ": [Skip]");
        continue;
      }
    }

    Log(actionName + " " + source + " -> " + target);
    var status = CopyFile(source, target);
    Log(status);
  } 
}