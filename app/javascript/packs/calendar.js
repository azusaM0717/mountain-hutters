import * as bootstrap from 'bootstrap';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
  let calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    let calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin, interactionPlugin],
      initialView: 'dayGridMonth',
      events: '/mypage/calendars/events',
      dateClick: function(info) {
        let modalElement = document.getElementById('createEventModal');

        // すでにインスタンスが存在する場合はそれを使用
        if (!window.eventModal) {
          window.eventModal = new bootstrap.Modal(modalElement);
        }
        window.eventModal.show(); // モーダルを開く

        document.getElementById('eventStartDate').value = info.dateStr;
        document.getElementById('eventEndDate').value = info.dateStr;
      }
    });

    calendar.render();

    document.getElementById('createEventForm').addEventListener('submit', function(event) {
      event.preventDefault();

      let startDate = document.getElementById('eventStartDate').value;
      let endDate = document.getElementById('eventEndDate').value;
      let hutId = document.getElementById('hutSelect').value;

      fetch('/mypage/calendars', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({
          calendar: {
            start_date: startDate,
            end_date: endDate,
            hut_id: hutId
          }
        })
      })
      .then(response => {
        if (!response.ok) {
          return response.json().then(errorData => {
            throw new Error(errorData.errors.join(", "));
          });
        }
        return response.json();
      })
      
      .then(data => {
        let endDate = new Date(data.end);
        endDate.setDate(endDate.getDate() + 1); // `end` を1日後ろにずらす
      
        calendar.addEvent({
          id: data.id,
          title: data.title,
          start: data.start,
          end: endDate.toISOString().split("T")[0] // yyyy-mm-dd 形式に変換
        });
      
        console.log("追加されたイベント：", data);
      
        // モーダルを閉じる
        if (window.eventModal) {
          window.eventModal.hide();
        }
      })
      
      .catch(error => {
        console.error("Error creating event:", error.message);
      });
    });
  }
});
