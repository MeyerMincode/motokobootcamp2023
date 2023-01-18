actor {
    stable var currentValue: Nat = 0;
    var message: Text = "Hello Meyer";

    public func increment(): async () {
        currentValue += 1;
    };

    public query func getValue(): async Nat {
        currentValue;
    };

    public query func getMessage(): async Text {
        message;
    };

    public func changeMessage(m: Text) : async Text {
        message := m;
        return message;
    };
};