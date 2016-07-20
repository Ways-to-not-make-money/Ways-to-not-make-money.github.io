# General
incamount = 1.0
money = 0.0
mps = 0.0

# Building Lists
amounts = [0, 0, 0, 0]
costs = [8.0, 120.0, 1337.0, 20160.0]
mpsadds = [0.1, 0.4, 3.0, 7.5]
buildings = ["ac", "mp", "cc", "sc"]
buildnames = ["Auto-Clicker", "Money Printer", "Counterfeit Company", "Sharemarket Crash"]

# Upgrade Lists
upgs = [[0, 0], [0], [0], [0]]
upgcosts = [[1000, 42000], [5000, 150000], [16900], [150000]]
upgeffects = [[1.5, 2.5], [2.0, 3.0], [2.0], [3.0]]
upgnames = [["Clicking Factories", "Iron-Clad Mice"], ["Skilled Fake Money Making", "Efficient Ink Cartridges"], ["Printing Templates"], ["Fire on Wall Street"]]

# Click Upgrade Lists
clickupgs = [0]
clickcosts = [2100]
clickeffects = [3]
clicknames = ["Flexible Fingers"]

# Launch Checks
idlecheck = 0

# Stats
totalclicks = 0

inc = ->
  money = parseFloat((money + incamount).toFixed(3))
  totalclicks += 1
  $("#money").html "Balance: $" + (money).toFixed(1)
  $("#clicks").html "Total Clicks: " + totalclicks

toggleDisplay = (id) ->
  if id == "build"
    $("#buildings").toggle()
    if $("#buildings").css("display") != "none"
      $("#upgrades").hide()
      $("#stats").hide()
  else if id == "upg"
    $("#upgrades").toggle()
    if $("#upgrades").css("display") != "none"
      $("#buildings").hide()
      $("#stats").hide()
  else
    $("#stats").toggle()
    if $("#stats").css("display") != "none"
      $("#buildings").hide()
      $("#upgrades").hide()

idleInc = ->
  money = (money + (mps / 100)).toFixed(3)
  $("#money").html "Balance: $" + parseFloat(money).toFixed(1)
  money = parseFloat(money)
  window.setTimeout idleInc, 10
  return

buildingFunc = (n) ->
  if money >= costs[n]
    money -= costs[n]
    costs[n] = parseFloat((costs[n] * 1.15).toFixed(3))
    amounts[n] += 1
    $("#" + buildings[n] + "build").html buildnames[n] + " ($" + costs[n].toFixed(1) + ")"
    mps = parseFloat((mps + mpsadds[n]).toFixed(1))
    $("#mps").html "$" + mps + "/second"
    if idlecheck == 0
      idlecheck += 1
      idleInc()
      return
  else
    window.alert "You do not have enough money."
    return
    
upgradeFunc = (n, step) ->
  if money >= upgcosts[n][step] and amounts[n] >= 1
    money -= upgcosts[n][step]
    upgs[n][step] += 1
    mpsadds[n] *= (upgeffects[n])[step]
    $("#" + buildings[n] + "upg" + (step + 1)).hide()
    mpsadds[n] = parseFloat((mpsadds[n] * upgeffects[n][step]).toFixed(3))
    return
  else
    window.alert "You do not have enough money."
    return

clickUpg = (n) ->
  if money >= clickcosts[n]
    money -= clickcost[n]
    clickupgs[n] += 1
    incamount *= clickeffects[n]
    $("#clickupg" + (n + 1)).hide()
  else
    window.alert "You do not have enough money."
   
hoverFuncBuild = (n) ->
  boughtupgs = []
  upgcheck = 0
  while upgcheck < upgs[n].length
    if upgs[n][upgcheck] == 1
      boughtupgs.push(upgnames[n][upgcheck] + " (*" + upgeffects[n][upgcheck] + "MPS)")
    upgcheck += 1
  if boughtupgs.length == 0
    boughtupgs.push("None yet!")
  boughtupgs = boughtupgs.join("<br>")
  $("#hoverinfo").html buildnames[n] + "<br>Amount: " + amounts[n] + "<br>Total MPS: " + (amounts[n] * mpsadds[n]).toFixed(1) + "<br>Upgrades unlocked:<br>" + boughtupgs
  
hoverFuncUpg = (n, step) ->
  if n == -1
    hovertemp1 = clicknames[step]
    hovertemp2 = "Main Button "
    hovertemp3 = clickeffects[step]
  else
    hovertemp1 = upgnames[n][step]
    hovertemp2 = buildnames[n]
    hovertemp3 = upgeffects[n][step] + "MPS"
  $("#hoverinfo").html hovertemp1 + "<br>Effects:<br>" + hovertemp2 + " * " + hovertemp3
  
hoverRemove = ->
$("#hoverinfo").html "Hover over something!"
