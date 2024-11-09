// ==UserScript==
// @name         Yt_url
// @namespace    http://tampermonkey.net/hello
// @version      0.1
// @description  try to take over the world!
// @author       ls13
// @match        https://www.youtube.com/watch?v=*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  var start, end, b;
  var time, hours, minutes, seconds;
  var time2, hours2, minutes2, seconds2;

  // get video player
  var htmlVideoPlayer = document.querySelector("video");

  // get youtube url
  var url = window.location.href;

  function pad(num, size) {
    num = num.toString();
    while (num.length < size) num = "0" + num;
    return num;
  }

  document.onkeydown = function (e) {
    e = e || window.event;
    var key = e.which || e.keyCode;

    // key q
    if (key == 81) {
      htmlVideoPlayer = document.querySelector("video");
      alert(url);
    }

    // key w
    if (key == 87) {
      time = htmlVideoPlayer.currentTime;
      hours = Math.floor(time / 3600);
      hours = pad(hours, 2);
      minutes = Math.floor((time - hours * 3600) / 60);
      minutes = pad(minutes, 2);
      seconds = Math.floor(time - hours * 3600 - minutes * 60);
      seconds = pad(seconds, 2);
      start = hours + ":" + minutes + ":" + seconds;
      alert("start: " + start);
    }

    // key e
    if (key == 69) {
      time2 = htmlVideoPlayer.currentTime;
      hours2 = Math.floor(time2 / 3600);
      hours2 = pad(hours2, 2);
      minutes2 = Math.floor((time2 - hours2 * 3600) / 60);
      minutes2 = pad(minutes2, 2);
      seconds2 = Math.floor(time2 - hours2 * 3600 - minutes2 * 60);
      seconds2 = pad(seconds2, 2);
      end = hours2 + ":" + minutes2 + ":" + seconds2;
      alert("end: " + end);
    }

    // key r
    if (key == 82) {
      b =
        "[vod](" +
        url +
        "#t=" +
        hours +
        ":" +
        minutes +
        ":" +
        seconds +
        "," +
        hours2 +
        ":" +
        minutes2 +
        ":" +
        seconds2 +
        ")";
      navigator.clipboard
        .writeText(b)
        .then(() => {
          alert("successfully copied");
        })
        .catch(() => {
          alert("something went wrong");
        });
    }
  };
})();
