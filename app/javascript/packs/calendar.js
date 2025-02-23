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
        // Bootstrap 5のモーダルを表示
        var modal = new bootstrap.Modal(document.getElementById('createEventModal'));  // 修正箇所
        modal.show();

        // モーダルフォームにクリックされた日付をセット
        document.getElementById('eventStartDate').value = info.dateStr;
        document.getElementById('eventEndDate').value = info.dateStr;
      }
    });

    calendar.render();

    // モーダルフォームの送信イベント
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
        // サーバーから受け取った新しいイベントをカレンダーに追加
        calendar.addEvent({
          id: data.id,
          title: data.title,
          start: data.start,
          end: data.end
        });

        // モーダルを閉じる
        var modalElement = document.getElementById('createEventModal');
        var modalInstance = bootstrap.Modal.getInstance(modalElement);  // モーダルのインスタンスを取得
        modalInstance.hide();
      })
      .catch(error => {
        console.error("Error creating event:", error.message);
      });
    });
  }
});
