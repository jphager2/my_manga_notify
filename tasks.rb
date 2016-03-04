# This is a file used by MyMangaNotifier to load tasks
#
# Examples:
#
## Set up a notification for the "Detective Conan" manga, so 
## that a new notification is sent every 5 new chapters
#MyManga::Notifier::Update.new("http://www.mangareader.net/detective-conan", every: 5).save()

##Set up notifications for multiple mangas for the same number of chapters.
#MyManga::Notifier::Update.new("http://www.mangareader.net/bleach", "http://mangafox.me/one-piece", every: 2).save()

##Set up a summary notification for every 14 days.
#MyManga::Notifier::Summary.new("http://www.mangareader.net/naruto-gaiden", "http://www.mangareader.net/nisekoi", "http://www.mangareader.net/onepunch-man", recurrence: :daily, interval: 14).save()

##Set up a summary notification for every Monday.
#MyManga::Notifier::Summary.new("http://www.mangareader.net/detective-conan", recurrence: :weekly, on: 1).save()

##Set up a summary notification for every other Sunday.
#MyManga::Notifier::Summary.new("http://www.mangareader.net/detective-conan", recurrence: :weekly, on: 7, interval: 2).save()

##Set up a summary notification for every month on the 5th of the month.
#MyManga::Notifier::Summary.new("http://www.mangareader.net/detective-conan", recurrence: :monthly, on: 5).save()

#Set up a summary notification for every quarter on the last day of the month.
#MyManga::Notifier::Summary.new("http://www.mangareader.net/detective-conan", recurrence: :monthly, on: -1, interval: 3).save()
