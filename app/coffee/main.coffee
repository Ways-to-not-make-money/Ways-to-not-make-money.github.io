incamount = 1.0
money = 0.0
mps = 0.0
amounts = [0, 0]
costs = [8.00, 120.00]
upgs = [[0], [0]]
upgcosts = [[1000.00], [5000.00]]
upgeffects = [[1.5], [2.0]]
buildings = ["ac", "mp"]
buildnames = ["Auto-Clicker", "Money Printer"]
idlecheck = 0

inc = ->
  money += incamount
  $("#money").html "Balance: $" + money

toggleDisplay = (id) ->
  if id == "build"
    $("#buildings").toggle()
    if $("#buildings").css("display") != "none"
      $("#upgrades").hide()
  else
    $("#upgrades").toggle()
    if $("#upgrades").css("display") != "none"
      $("#buildings").hide()

idleInc = ->
  mps = amounts[0] + 15 * amounts[1]
  money = (money + (mps / 100)).toFixed(2)
  $("#money").html "Balance: $" + money
  money = parseFloat(money)
  window.setTimeout idleInc, 30
  return

buildingFunc = (n) ->
  if money >= costs[n]
    money -= costs[n]
    costs[n] = parseFloat((costs[n] * 1.2).toFixed(2))
    amounts[n] += 1 + upgs[n] * upgeffects[n]
    $("#" + buildings[n] + "build").html buildnames[n] + " ($" + costs[n].toFixed(2) + ")"
    if idlecheck == 0
      idlecheck += 1
      idleInc()
      return
  else
    window.alert "You do not have enough money."
    return
    
upgradeFunc = (n, step) ->
  if money >= (upgcosts[n])[step] and amounts[n] >= 1
    money -= (upgcosts[n])[step]
    (upgs[n])[step] += 1
    amounts[n] *= (upgeffects[n])[step]
    $("#" + buildings[n] + "upg" + (step + 1)).hide();
    return
  else
    window.alert "You do not have enough money."
    return
    