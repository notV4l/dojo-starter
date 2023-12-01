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
    use dojo_examples::utils::spawn_player;
    use super::IActions;

    // impl: implement functions specified in trait
    #[external(v0)]
    impl ActionsImpl of IActions<ContractState> {
        // ContractState is defined by system decorator expansion
        fn spawn(self: @ContractState) {
            // Access the world dispatcher for reading.
            let world = self.world();

            // Get the address of the current caller, possibly the player's address.
            let player = get_caller_address();

            spawn_player(world, player);
        }

    }
}
