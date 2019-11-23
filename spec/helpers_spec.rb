require 'bundler'
Bundler.require(:default, :test)

require_relative '../helpers'

describe "@regardstomlane" do
  tests = [
    [ "Hello.\nregards, tom lane", "Hello." ],
    [ "Hello?\nregards, tom lane", "Hello?" ],
    [ "Hello!\nregards, tom lane", "Hello!" ],
    [ "Hello world.\nregards, tom lane", "Hello world." ],
    [ "Hello\nworld.\nregards, tom lane", "Hello world." ],
    [ "Hello world. Goodbye.\nregards, tom lane", "Goodbye." ],
    [ "Hello world.\nGoodbye.\nregards, tom lane", "Goodbye." ],
    [ "Hello world. C.C.H. Pounder is an actor.\nregards, tom lane",
      "C.C.H. Pounder is an actor." ],
    [ "Hello world. C.C.H. Pounder is an actor. B.D. Wong is also an actor.\nregards, tom lane",
      "B.D. Wong is also an actor." ],
    [ "Something something. There's definitely a CommandCounterIncrement in exec_execute_message ...\nregards, tom lane",
      "There's definitely a CommandCounterIncrement in exec_execute_message ..."],
    [ %q(Which is why we invented the ENCRYPTED PASSWORD syntax, as well as
psql's \password command ... but using that approach for actual
login to an account would be a security fail as well.



			regards, tom lane), "Which is why we invented the ENCRYPTED PASSWORD syntax, as well as psql's \\password command ... but using that approach for actual login to an account would be a security fail as well." ],
    ]

  tests.each do |(body, expected)|
    it "extracts '#{expected}' from '#{body}'" do
      result = find_last_sentence(body)
      expect(result).to eq(expected)
    end
  end
end
