incamount = 1.0
money = 0.0
mps = 0.0

amounts = [0, 0, 0]
costs = [8.0, 120.0, 1337.0]
upgs = [[0, 0], [0], [0]]
upgcosts = [[1000, 42000], [5000], [16900]]
upgeffects = [[1.5, 2.5], [2.0], [2.0]]
buildings = ["ac", "mp", "cc"]
buildnames = ["Auto-Clicker", "Money Printer", "Counterfeit Company"]

idlecheck = 0

totalclicks = 0

inc = ->
  money += incamount
  totalclicks += 1
  $("#money").html "Balance: $" + money
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
  mps = amounts[0] + 4 * amounts[1] + 10 * amounts[2]
  money = (money + (mps / 1000)).toFixed(3)
  $("#money").html "Balance: $" + parseFloat(money).toFixed(1)
  money = parseFloat(money)
  window.setTimeout idleInc, 10
  return

buildingFunc = (n) ->
  if money >= costs[n]
    money -= costs[n]
    costs[n] = parseFloat((costs[n] * 1.2).toFixed(3))
    amounts[n] += 1
    ucheck = 0
    while ucheck <= upgs[n].length - 1
      amounts[n] += upgs[n][ucheck] * upgeffects[n][ucheck]
      ucheck += 1
    $("#" + buildings[n] + "build").html buildnames[n] + " ($" + costs[n].toFixed(0) + ")"
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
    (upgs[n])[step] += 1
    amounts[n] *= (upgeffects[n])[step]
    $("#" + buildings[n] + "upg" + (step + 1)).hide();
    return
  else
    window.alert "You do not have enough money."
    return
    
