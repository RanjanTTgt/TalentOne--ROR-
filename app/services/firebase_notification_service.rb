class FirebaseNotificationService

  def self.send_push_notification(employee_device_ids, message, title)
    HTTParty.post('https://fcm.googleapis.com/fcm/send', body: options(employee_device_ids, message, title).to_json, headers: {'content-type': 'application/json', authorization: "key=#{ENV['FIREBASE_SERVER_KEY']}"})
  end

  private

  def self.options(registration_ids, message, title)
    {
      priority: 'high',
      registration_ids: registration_ids,
      title: title,
      data: {
        title: title,
        message: message
      },
      notification: {
        title: title,
        body: message,
        sound: 'default'
      }
    }
  end

end