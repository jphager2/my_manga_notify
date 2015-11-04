This is a library that sends allows users to watch mangas based on a url and then sends and email after a given number of new chapters are given, or sends an email summary new chapters for a list of manga every given day of the week or every given number of days.

Users can manage their notifications. They can either remove notifications, or update the time or manga related to notifications.

Set up a notification for the "Detective Conan" manga, so that a new notification is sent every 5 new chapters
```
MyManga::Notifier::Update.new("http://www.mangareader.net/detective-conan", every: 5)
```

Set up notifications for multiple mangas for the same number of chapters.
```
MyManga::Notifier::Update.new("http://www.mangareader.net/bleach", "http://mangafox.me/one-piece", every: 2)
```

Set up a summary notification for every 14 days.
```
MyManga::Notifier::Summary.new("http://www.mangareader.net/naruto-gaiden", "http://www.mangareader.net/nisekoi", "http://www.mangareader.net/onepunch-man", recurance: :daily, interval: 14)
```

Set up a summary notification for every Monday.
```
MyManga::Notifier::Summary.new(..., recurance: :weekly, on: 1)
```

Set up a summary notification for every other Sunday.
```
MyManga::Notifier::Summary.new(..., recurance: :weekly, on: 7, interval: 2)
```

Set up a summary notification for every month on the 5th of the month.
```
MyManga::Notifier::Summary.new(..., recurance: :monthly, on: 5)
```

Set up a summary notification for every quarter on the last day of the month.
```
MyManga::Notifier::Summary.new(..., recurnce: :monthly, on: -1, interval: 3)
```
