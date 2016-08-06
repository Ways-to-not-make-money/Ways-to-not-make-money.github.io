var amounts, buildingFunc, buildings, buildnames, clickUpg, clickcosts, clickeffects, clicknames, clickupgs, convertCosts, costs, hoverFuncBuild, hoverFuncUpg, hoverRemove, idleInc, idlecheck, inc, incamount, money, moneynameacr, mps, mpsadds, toggleDisplay, totalclicks, totalearned, upgcosts, upgeffects, upgnames, upgradeFunc, upgs;

incamount = 1.0;

money = 0.0;

moneynameacr = ["", "million", "billion", "trillion", "quadrillion", "quintillion"];

mps = 0.0;

amounts = [0, 0, 0, 0];

costs = [8.0, 120.0, 1337.0, 20160.0, 123456.0];

mpsadds = [0.1, 0.4, 3.0, 7.5, 32.1];

buildings = ["ac", "mp", "cc", "sc", "bh"];

buildnames = ["Auto-Clicker", "Money Printer", "Counterfeit Company", "Sharemarket Crash", "Bank Heist"];

upgs = [[0, 0], [0], [0], [0]];

upgcosts = [[100, 4200], [500, 15000], [1690, 40000], [15000], [500000]];

upgeffects = [[1.5, 2.5], [2.0, 3.0], [2.0], [3.0]];

upgnames = [["Clicking Factories", "Iron-Clad Mice"], ["Printing Templates", "Efficient Ink Cartridges"], ["Skilled Fake Money Making", "Patented Products"], ["Fire on Wall Street"], ["Lockpicks"]];

clickupgs = [0];

clickcosts = [210, 70000];

clickeffects = [3, 10];

clicknames = ["Flexible Fingers", "More Clicks!"];

idlecheck = 0;

totalclicks = 0;

totalearned = 0;

convertCosts = function(n) {
  var b, check, i, ref;
  check = 0;
  for (b = i = 1, ref = moneynameacr.length - 1; 1 <= ref ? i <= ref : i >= ref; b = 1 <= ref ? ++i : --i) {
    if (n >= Math.pow(10, 6 + ((b - 1) * 3))) {
      check += 1;
    }
  }
  if (check === 0) {
    return n.toFixed(1);
  } else {
    return (n / Math.pow(10, 6 + ((check - 1) * 3))).toFixed(1) + " " + moneynameacr[check];
  }
};

inc = function() {
  money = parseFloat((money + incamount).toFixed(3));
  totalearned = parseFloat((totalearned + incamount).toFixed(3));
  totalclicks += 1;
  $("#money").html("Balance: $" + convertCosts(money));
  $("#earned").html("Total Money Earned: $" + convertCosts(totalearned));
  return $("#clicks").html("Total Clicks: " + totalclicks);
};

toggleDisplay = function(id) {
  if (id === "build") {
    $("#buildings").toggle();
    if ($("#buildings").css("display") !== "none") {
      $("#upgrades").hide();
      $("#upgbutton").css("background-color", "grey");
      $("#stats").hide();
      $("#statsbutton").css("background-color", "grey");
      return $("#buildbutton").css("background-color", "#5555cc");
    } else {
      return $("#buildbutton").css("background-color", "grey");
    }
  } else if (id === "upg") {
    $("#upgrades").toggle();
    if ($("#upgrades").css("display") !== "none") {
      $("#buildings").hide();
      $("#buildbutton").css("background-color", "grey");
      $("#stats").hide();
      $("#statsbutton").css("background-color", "grey");
      return $("#upgbutton").css("background-color", "#5555cc");
    } else {
      return $("#upgbutton").css("background-color", "grey");
    }
  } else {
    $("#stats").toggle();
    if ($("#stats").css("display") !== "none") {
      $("#buildings").hide();
      $("#buildbutton").css("background-color", "grey");
      $("#upgrades").hide();
      $("#upgbutton").css("background-color", "grey");
      return $("#statsbutton").css("background-color", "#5555cc");
    } else {
      return $("#statsbutton").css("background-color", "grey");
    }
  }
};

idleInc = function() {
  money = (money + (mps / 100)).toFixed(3);
  totalearned = (totalearned + (mps / 100)).toFixed(3);
  $("#money").html("Balance: $" + convertCosts(parseFloat(money)));
  $("#earned").html("Total Money Earned: $" + convertCosts(parseFloat(totalearned)));
  money = parseFloat(money);
  totalearned = parseFloat(totalearned);
  window.setTimeout(idleInc, 10);
};

buildingFunc = function(n) {
  if (money >= costs[n]) {
    money -= costs[n];
    costs[n] = parseFloat((costs[n] * 1.15).toFixed(3));
    amounts[n] += 1;
    $("#" + buildings[n] + "build").html(buildnames[n] + "<br>($" + convertCosts(costs[n]) + ")");
    mps = parseFloat((mps + mpsadds[n]).toFixed(1));
    $("#mps").html("$" + convertCosts(mps) + "/second");
    if (idlecheck === 0) {
      idlecheck += 1;
      idleInc();
      return;
    }
    return hoverFuncBuild(n);
  } else {
    window.alert("You do not have enough money.");
  }
};

upgradeFunc = function(n, step) {
  if (money >= upgcosts[n][step] && amounts[n] >= 1) {
    money -= upgcosts[n][step];
    upgs[n][step] += 1;
    $("#" + buildings[n] + "upg" + (step + 1)).hide();
    mps += amounts[n] * (mpsadds[n] * (upgeffects[n][step] - 1));
    mpsadds[n] = parseFloat((mpsadds[n] * upgeffects[n][step]).toFixed(3));
    $("#mps").html("$" + convertCosts(mps) + "/second");
  } else {
    window.alert("You do not have enough money.");
  }
};

clickUpg = function(n) {
  if (money >= clickcosts[n]) {
    money -= clickcosts[n];
    clickupgs[n] += 1;
    incamount *= clickeffects[n];
    return $("#clickupg" + (n + 1)).hide();
  } else {
    return window.alert("You do not have enough money.");
  }
};

hoverFuncBuild = function(n) {
  var boughtupgs, upgcheck;
  boughtupgs = [];
  upgcheck = 0;
  while (upgcheck < upgs[n].length) {
    if (upgs[n][upgcheck] === 1) {
      boughtupgs.push(upgnames[n][upgcheck] + " (*" + upgeffects[n][upgcheck] + "MPS)");
    }
    upgcheck += 1;
  }
  if (boughtupgs.length === 0) {
    boughtupgs.push("None yet!");
  }
  boughtupgs = boughtupgs.join("<br>");
  return $("#hoverinfo").html(buildnames[n] + "<br>Amount: " + amounts[n] + "<br>Total MPS: " + convertCosts(amounts[n] * mpsadds[n]) + "<br>Upgrades unlocked:<br>" + boughtupgs);
};

hoverFuncUpg = function(n, step) {
  var hovertemp1, hovertemp2, hovertemp3;
  if (n === -1) {
    hovertemp1 = clicknames[step];
    hovertemp2 = "Main Button ";
    hovertemp3 = clickeffects[step];
  } else {
    hovertemp1 = upgnames[n][step];
    hovertemp2 = buildnames[n];
    hovertemp3 = upgeffects[n][step] + "MPS";
  }
  return $("#hoverinfo").html(hovertemp1 + "<br>Effects:<br>" + hovertemp2 + " * " + hovertemp3);
};

hoverRemove = function() {
  return $("#hoverinfo").html("Hover over something!");
};
