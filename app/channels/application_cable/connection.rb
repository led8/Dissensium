module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uid

    def connect
      self.uid = get_connecting_uid
      logger.add_tags 'ActionCable', uid
    end

    protected

    # the connection URL to this actioncable/channel must be
    # domain.tld?uid=the_uid
    def get_connecting_uid
      # this is just how I get the user id, you can keep using cookies,
      # but because this key gets used for redis, I'd
      # identify_by the user_id instead of the current_user object
      request.params[:uid]
    end
  end
end
