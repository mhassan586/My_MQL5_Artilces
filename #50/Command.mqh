//+------------------------------------------------------------------+
//|                                                      Command.mqh |
//+------------------------------------------------------------------+
namespace Command
{
class Receiver
  {
public:
                     Receiver(void);
                     Receiver(Receiver&);
   void              Action(void);
  };
Receiver::Receiver(void)
  {
  }
Receiver::Receiver(Receiver &src)
  {
  }
void Receiver::Action(void)
  {
  }
class Command
  {
protected:
   Receiver*         m_receiver;
public:
                     Command(Receiver*);
                    ~Command(void);
   virtual void      Execute(void)=0;
  };
Command::Command(Receiver* receiver)
  {
   m_receiver=new Receiver(receiver);
  }
Command::~Command(void)
  {
   if(CheckPointer(m_receiver)==1)
     {
      delete m_receiver;
     }
  }
class ConcreteCommand:public Command
  {
protected:
   int               m_state;
public:
                     ConcreteCommand(Receiver*);
   void              Execute(void);
  };
ConcreteCommand::ConcreteCommand(Receiver* receiver):
   Command(receiver),
   m_state(0)
  {
  }
void ConcreteCommand::Execute(void)
  {
   m_receiver.Action();
   m_state=1;
  }
class Invoker
  {
public:
                    ~Invoker(void);
   void              StoreCommand(Command*);
   void              Execute(void);
protected:
   Command*          m_command;
  };
Invoker::~Invoker(void)
  {
   if(CheckPointer(m_command)==1)
     {
      delete m_command;
     }
  }
void Invoker::StoreCommand(Command* command)
  {
   m_command=command;
  }
void Invoker::Execute(void)
  {
   m_command.Execute();
  }
class Client
  {
public:
   string            Output(void);
   void              Run(void);
  };
string Client::Output(void)
  {
   return __FUNCTION__;
  }
void Client::Run(void)
  {
   Receiver receiver;
   Invoker invoker;
   invoker.StoreCommand(new ConcreteCommand(&receiver));
   invoker.Execute();
  }
}