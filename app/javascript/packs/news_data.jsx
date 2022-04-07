import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

var target_dom = null;

document.addEventListener('DOMContentLoaded', () => {
  target_dom = document.querySelector('#data');
  const url = new URL(location.href);
  let f = url.searchParams.get("name");
  if (f == null){ f = ''; }
  getData(f);
});

function getData(f){
  let url = location.protocol + "//" + location.host + "/top/news";
  fetch(url)
  .then(
    res => res.json(),
    (error) => {
      const el = (
        <p>ERROR!!</p>
      );
      ReactDOM.render(el, target_dom);
    }
  )
  .then(
    (result) => {
      console.log(result);
      let arr = [];
      for(let n in result.rss.channel.item){  
        let data = result.rss.channel.item[n];
        let newsdate = dateFormat(result.rss.channel.item[n].pubDate);
        arr.push(
          <tr>
            <th><a href={data.link} target="_blank" rel="noopener noreferrer">{data.title}</a></th>
            <td class="small">{newsdate}</td>
          </tr>
        );
      }
      const el = (
        <table class="table mt-4">
          <thead class="thead-light">
          <tr><th>News Title</th>
            <th>Date</th></tr>
          </thead>
          <tbody>{arr}</tbody>
          </table>
      );
      ReactDOM.render(el, target_dom);
    },
    (error) => {
      console.log(error);
      const el = (
        <p>ERROR!!</p>
      );
      ReactDOM.render(el, target_dom);
    }
  );
}

// 日付の整形
var weeks = ['日', '月', '火', '水', '木', '金', '土'];
function dateFormat(date) {
    // 日付の変換
    var dateStr = new Date(date);
    // 年の取得
    var year = dateStr.getFullYear();
    // 月の取得
    var month = dateStr.getMonth() + 1;
    // 日の取得
    var day = dateStr.getDate();
    // 曜日の取得
    var week = dateStr.getDay();
    // 時の取得
    var hour = dateStr.getHours();
    // 分の取得
    var minute = dateStr.getMinutes();
    // 秒の取得
    var second = dateStr.getSeconds();
 
    return year + '/' + month + '/' + day + '(' + weeks[week] + ') ' + hour + ':' + minute + ':' + second;
}
