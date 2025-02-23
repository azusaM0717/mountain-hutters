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
        var modal = new bootstrap.Modal(document.getElementById('createEventModal'));
        modal.show();

        // モーダルフォームにクリックされた日付をセット
        document.getElementById('eventStartDate').value = info.dateStr;
        document.getElementById('eventEndDate').value = info.dateStr;
      }
    });

    calendar.render();
  }
});
