namespace Bridge
{
interface Implementor
  {
   void OperationImp();
  };
class Abstraction
  {
public:
   virtual void      Operation();
                     Abstraction(Implementor*);
                     Abstraction();
                    ~Abstraction();
protected:
   Implementor*      implementor;
  };
void Abstraction::Abstraction(void) {}
void Abstraction::Abstraction(Implementor*i):implementor(i) {}
void Abstraction::~Abstraction()
  {
   delete implementor;
  }
void Abstraction::Operation()
  {
   implementor.OperationImp();
  }
class RefinedAbstraction:public Abstraction
  {
public:
                     RefinedAbstraction(Implementor*);
   void              Operation();
  };
void RefinedAbstraction::RefinedAbstraction(Implementor*i):Abstraction(i) {}
void RefinedAbstraction::Operation()
  {
   Abstraction::Operation();
  }
class ConcreteImplementorA:public Implementor
  {
public:
   void              OperationImp();
  };
void ConcreteImplementorA::OperationImp(void)
  {
   Print("The implementor A");
  }
class ConcreteImplementorB:public Implementor
  {
public:
   void              OperationImp();
  };
void ConcreteImplementorB::OperationImp(void)
  {
   Print("The implementor B");
  }
class Client
  {
public:
   string            Output();
   void              Run();
  };
string Client::Output(void)
  {
   return __FUNCTION__;
  }
void Client::Run(void)
  {
   Abstraction* abstraction;
   abstraction=new RefinedAbstraction(new ConcreteImplementorA);
   abstraction.Operation();
   delete abstraction;
   abstraction=new RefinedAbstraction(new ConcreteImplementorB);
   abstraction.Operation();
   delete abstraction;
  }
}