import Array "mo:base/Array";
import Bool "mo:base/Bool";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";

actor Dao{

    type Status = {
		#Pending;
		#Accepted;
		#Rejected;
	};

    type Proposal = {
        id: Nat;
        creator: Principal;
        motion: Text;
        downVotes: Nat;
        upVotes: Nat;
        status : Status;
    };

    stable var stableProposals : [(Nat, Proposal)] = [];

    let proposals = HashMap.fromIter<Nat, Proposal>(stableProposals.vals(), Iter.size(stableProposals.vals()), Nat.equal, Hash.hash);

    system func preupgrade() {
        stableProposals := Iter.toArray(proposals.entries());
    };

    system func postupgrade() {
        stableProposals := [];
    };

    stable var proposalCurrentID : Nat = 0;

    // Create, Read, Update, Delete

    public shared ({caller}) func add_proposal(motion : Text) : async {#ok : Text; #error : Text}{
        if(motion == "") {
            return #error("Enter a valid proposal");
        } else {
            let newProposal = {
                id = proposalCurrentID;
                creator = caller;
                motion = motion;
                downVotes = 0;
                upVotes = 0;
                status = #Pending;
            };
            proposals.put(proposalCurrentID, newProposal);
            proposalCurrentID += 1;
            return #ok("New proposal have been created successfully");
        };
    };

    public query func list_all_proposals() : async [(Nat, Proposal)] {
        return Iter.toArray<(Nat, Proposal)>(proposals.entries());
    };

    public query func get_proposal_by_id(id : Nat) : async {#ok : (Nat,Proposal); #error : Text} {
        let wantedProposal : ?Proposal = proposals.get(id);
        switch(wantedProposal){
            case null {
                return #error("Proposal with id: " # Nat.toText(id) # " does not exist");
            };
            case(?found){
                return #ok((id, found));
            };
        };
    };

    public shared ({caller}) func update_proposal_motion(id : Nat, newMotion : Text) : async {#ok : Text; #error : Text}{
        let wantedProposal : ?Proposal = proposals.get(id);
        switch(wantedProposal){
            case null {
                return #error("Proposal with id: " # Nat.toText(id) # " does not exist");
            };
            case(?found){
                if(caller == found.creator){
                    let updatedProposal = {
                        id = found.id;
                        creator = caller;
                        motion = newMotion;
                        downVotes = found.downVotes;
                        upVotes = found.upVotes;
                        status = found.status;
                    };
                    let result = proposals.replace(id, updatedProposal);
                    switch(result){
                        case null {
                            return #error("Proposal does not exist");
                        };
                        case(?allGood){
                            return #ok("New proposal have been created successfully");
                        };
                    };
                } else return #error("You are not allowed to change the proposal");
            };
        };
    };

    public func up_vote(id : Nat) : async {#ok : Text; #error : Text}{
        let wantedProposal : ?Proposal = proposals.get(id);
        switch(wantedProposal){
            case null {
                return #error("Proposal with id: " # Nat.toText(id) # " does not exist");
            };
            case(?found){
                let updatedProposal = {
                    id = found.id;
                    creator = found.creator;
                    motion = found.motion;
                    downVotes = found.downVotes;
                    upVotes = found.upVotes + 1;
                    status = found.status;
                };
                let result = proposals.replace(id, updatedProposal);
                switch(result){
                    case null {
                        return #error("Proposal does not exist");
                    };
                    case(?allGood){
                        return #ok("Thanks for your vote.");
                    };
                };
            };
        };
    };

    public func down_vote(id : Nat) : async {#ok : Text; #error : Text}{
        let wantedProposal : ?Proposal = proposals.get(id);
        switch(wantedProposal){
            case null {
                return #error("Proposal with id: " # Nat.toText(id) # " does not exist");
            };
            case(?found){
                let updatedProposal = {
                    id = found.id;
                    creator = found.creator;
                    motion = found.motion;
                    downVotes = found.downVotes + 1;
                    upVotes = found.upVotes;
                    status = found.status;
                };
                let result = proposals.replace(id, updatedProposal);
                switch(result){
                    case null {
                        return #error("Proposal does not exist");
                    };
                    case(?allGood){
                        return #ok("Thanks for your vote");
                    };
                };
            };
        };
    };

    public shared ({caller}) func delete_proposal(id : Nat) : async {#ok : Text; #error : Text}{
        let wantedProposal : ?Proposal = proposals.get(id);
        switch(wantedProposal){
            case null {
                return #error("Proposal with id: " # Nat.toText(id) # " does not exist");
            };
            case(?found){
                if(caller == found.creator){
                    let result = proposals.remove(id);
                    switch(result){
                        case null {
                            return #error("Proposal does not exist");
                        };
                        case(?allGood){
                            return #ok("Proposal with id: " # Nat.toText(id) # " has been deleted");
                        };
                    };
                } else return #error("You are not allowed to delete this proposal");
            };
        };
    };
};