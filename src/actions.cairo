use dojo_examples::models::{Position, Moves, Direction, Vec2};

// define the interface
#[starknet::interface]
trait IActions<TContractState> {
    fn spawn(self: @TContractState);
}

// dojo decorator
#[dojo::contract]
mod actions {
    use starknet::{ContractAddress, get_caller_address};
    use super::{Position, Moves, Direction, Vec2};
    use dojo_examples::utils::next_position;
    use super::IActions;

    // declaring custom event struct
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Moved: Moved,
    }

    // declaring custom event struct
    #[derive(Drop, starknet::Event)]
    struct Moved {
        player: ContractAddress,
        direction: Direction
    }

    // impl: implement functions specified in trait
    #[external(v0)]
    impl ActionsImpl of IActions<ContractState> {
        // ContractState is defined by system decorator expansion
        fn spawn(self: @ContractState) {
            // Access the world dispatcher for reading.
            let world = self.world();

            // Get the address of the current caller, possibly the player's address.
            let player = get_caller_address();

            let mut i = 0;
            loop {
                if i == 1 {
                    break;
                }

                // let position = get!(world, player, (Position));
                // let moves = get!(world, player, (Moves));
                let (position,moves) = get!(world, player, (Position,Moves));
        
                let moves = Moves { player, remaining: 100, last_direction: Direction::None(()) };
                let positions = Position { player, vec: Vec2 { x: 10, y: 10 } };

                // this fails
                set!(world, (moves,positions));

                let (position,moves) = get!(world, player, (Position,Moves));

                // this fails
                set!(world, (moves));
                set!(world, (positions));

                // // this generate right writes
                // set!(world, Moves { player, remaining: 100, last_direction: Direction::None(()) });
                // set!(world, Position { player, vec: Vec2 { x: 10, y: 10 } });

                i +=1;

            };
            
        }

    }
}
