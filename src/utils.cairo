use dojo_examples::models::{Position, Moves, Direction, Vec2};
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use starknet::ContractAddress;

fn next_position(mut position: Position, direction: Direction) -> Position {
    match direction {
        Direction::None(()) => {
            return position;
        },
        Direction::Left(()) => {
            position.vec.x -= 1;
        },
        Direction::Right(()) => {
            position.vec.x += 1;
        },
        Direction::Up(()) => {
            position.vec.y -= 1;
        },
        Direction::Down(()) => {
            position.vec.y += 1;
        },
    };

    position
}


fn spawn_player(world: IWorldDispatcher, player: ContractAddress) {

    let moves = Moves { player, remaining: 100, last_direction: Direction::None(()) };
    let positions = Position { player, vec: Vec2 { x: 10, y: 10 } };

    // this is not detected
    set!(world, (moves));
    set!(world, (positions));

    // this is not detected
    set!(world, Moves { player, remaining: 100, last_direction: Direction::None(()) });
}