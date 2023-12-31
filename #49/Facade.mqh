namespace Facade
{
class SubSystemA
  {
public:
   void              Operation(void);
  };
void SubSystemA::Operation(void)
  {
   Print("The operation of the subsystem A");
  }
class SubSystemB
  {
public:
   void              Operation(void);
  };
void SubSystemB::Operation(void)
  {
   Print("The operation of the subsystem B");
  }
class SubSystemC
  {
public:
   void              Operation(void);
  };
void SubSystemC::Operation(void)
  {
   Print("The operation of the subsystem C");
  }
class Facade
  {
public:
   void              Operation_A_B(void);
   void              Operation_B_C(void);
protected:
   SubSystemA        subsystem_a;
   SubSystemB        subsystem_b;
   SubSystemC        subsystem_c;
  };
void Facade::Operation_A_B(void)
  {
   Print("The facade of the operation of A & B");
   Print("The request of the facade of the subsystem A operation");
   subsystem_a.Operation();
   Print("The request of the facade of the subsystem B operation");
   subsystem_b.Operation();
  }
void Facade::Operation_B_C(void)
  {
   Print("The facade of the operation of B & C");
   Print("The request of the facade of the subsystem B operation");
   subsystem_b.Operation();
   Print("The request of the facade of the subsystem C operation");
   subsystem_c.Operation();
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
   Facade facade;
   Print("The request of client of the facade operation A & B");
   facade.Operation_A_B();
   Print("The request of client of the facade operation B & C");
   facade.Operation_B_C();
  }
}