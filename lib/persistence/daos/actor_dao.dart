import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class ActorDao{
  static final ActorDao _singleton = ActorDao._internal();

  factory ActorDao(){
    return _singleton;
  }

  ActorDao._internal();

  void saveAllActors(List<ActorVO> actors) async{
    Map<int, ActorVO> actorMap = Map.fromIterable(
      actors,
      key: (actor) => actor.id ,
        value: (actor)=> actor
    );

    await getActorBox().putAll(actorMap);
  }

  List<ActorVO> getAllActors(){
    return getActorBox().values.toList();
  }


  Box<ActorVO> getActorBox(){
    return Hive.box<ActorVO>(BOX_NAME_ACTOR_VO);
  }

}