require 'spec_helper'

RSpec.describe ActiveRecord::Locking::Pessimistic::ConvenienceMethods do

  let!(:subject) { Post.create(title: "big news") }

  it 'should save atomically' do
    update = Proc.new do |id|
      Post.connection.reconnect!
      Post.find_and_save_atomically!(id) {|post| post.views += 1 }
    end

    (1..20).map do |_|
      Thread.new(subject.id, &update)
    end.each(&:join)

    expect(subject.reload.views).to eq(20)
  end

end
