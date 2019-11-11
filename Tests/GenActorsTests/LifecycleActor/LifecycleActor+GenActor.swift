// ==== ------------------------------------------------------------------ ====
// === DO NOT EDIT: Generated by GenActors                     
// ==== ------------------------------------------------------------------ ====

import DistributedActors
// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: DO NOT EDIT: Generated LifecycleActor messages 

/// DO NOT EDIT: Generated LifecycleActor messages
extension LifecycleActor {
    public enum Message { 
        case pleaseStop 
        case watchChildAndTerminateIt 
    }

    
}
// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: DO NOT EDIT: Generated LifecycleActor behavior

extension LifecycleActor {

    public static func makeBehavior(instance: LifecycleActor) -> Behavior<Message> {
        return .setup { _context in
            let context = Actor<LifecycleActor>.Context(underlying: _context)
            var instance = instance // TODO only var if any of the methods are mutating

            /* await */ instance.preStart(context: context)

            return Behavior<Message>.receiveMessage { message in
                switch message { 
                
                case .pleaseStop:
                    return instance.pleaseStop() 
                case .watchChildAndTerminateIt:
                    try instance.watchChildAndTerminateIt() 
                
                }
                return .same
            }.receiveSignal { _context, signal in 
                let context = Actor<LifecycleActor>.Context(underlying: _context)

                switch signal {
                case is Signals.PostStop: 
                    instance.postStop(context: context)
                    return .same
                case let terminated as Signals.Terminated:
                    switch instance.receiveTerminated(context: context, terminated: terminated) {
                    case .unhandled: 
                        return .unhandled
                    case .stop: 
                        return .stop
                    case .ignore: 
                        return .same
                    }
                default:
                    return .unhandled
                }
            }
        }
    }
}
// ==== ----------------------------------------------------------------------------------------------------------------
// MARK: Extend Actor for LifecycleActor

extension Actor where A.Message == LifecycleActor.Message {
    
    public func pleaseStop() { 
        self.ref.tell(.pleaseStop)
    } 
    
    func watchChildAndTerminateIt() { 
        self.ref.tell(.watchChildAndTerminateIt)
    } 
    
}