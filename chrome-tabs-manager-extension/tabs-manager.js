chrome.commands.onCommand.addListener(function (command) {

  var createRange = function (value, step, count) {
    var list = [];
    for (var i = 0; i < count; i++, value += step) {
      list.push(value);
    }
    return list;
  }

  var tabsInfo = { all: 0, pinned: 0, activeIndex: 0 };

  var countPinned = function(tabs) {
    tabsInfo.pinned = tabs.length;
  }

  var countAll = function(tabs) {
    tabsInfo.all = tabs.length;
  }

  var movePinnedTabs = function (tabs) {
    moveTabs(tabs, 0, tabsInfo.pinned - 1);
  }

  var moveUnpinnedTabs = function (tabs) {
    moveTabs(tabs, tabsInfo.pinned, tabsInfo.all - 1);
  }

  var findActiveTab = function (tabs) {
    tabs.forEach(tab => {
      if (tab.active) {
        tabsInfo.activeIndex = tab.index;
      }
    });
  }

  var switchTab = function(tabs) {
      var toSelect =
        (() => { switch (command) {
          case "select-next-tab":
            return (tabsInfo.activeIndex + 1) % tabsInfo.all;
          case "select-previous-tab":
            return ((tabsInfo.activeIndex - 1) + tabsInfo.all) % tabsInfo.all;
        } })();
      chrome.tabs.update(tabs[toSelect].id, {active: true});
  };

  var moveTabs = function (tabs, leftBoundary, rightBoundary) {
    var newPositions = (() => {
      switch (command) {
        case "move-tab-left":
          if (tabs[0].index === leftBoundary) {
            chrome.tabs.move(tabs[0].id, { index: rightBoundary});
            return [];
          }
          return tabs.map(tab => tab.index - 1);
        case "move-tab-right":
          if (tabs[tabs.length - 1].index === rightBoundary) {
            chrome.tabs.move(tabs[tabs.length - 1].id, { index: leftBoundary });
            return [];
          }
          tabs.reverse();
          return tabs.map(tab => tab.index + 1);
      }
    })()
    for (var i = 0; i < newPositions.length; i++) {
      chrome.tabs.move(tabs[i].id, { index: newPositions[i] });
    }
  }

  chrome.tabs.query({ currentWindow: true }, countAll);
  chrome.tabs.query({ currentWindow: true, active: true }, findActiveTab);
  chrome.tabs.query({ currentWindow: true}, switchTab);
  chrome.tabs.query({ currentWindow: true, pinned: true }, countPinned);
  chrome.tabs.query({ currentWindow: true, highlighted: true, pinned: true }, movePinnedTabs);
  chrome.tabs.query({ currentWindow: true, highlighted: true, pinned: false }, moveUnpinnedTabs);
});
