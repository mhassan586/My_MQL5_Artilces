namespace Decorator
{
class Component
  {
public:
   virtual void      Operation(void)=0;
  };
class Decorator:public Component
  {
public:
   Component*        component;
   void              Operation(void);
  };
void Decorator::Operation(void)
  {
   if(CheckPointer(component)>0)
     {
      component.Operation();
     }
  }
class ConcreteComponent:public Component
  {
public:
   void              Operation(void);
  };
void ConcreteComponent::Operation(void)
  {
   Print("The concrete operation");
  }
class ConcreteDecoratorA:public Decorator
  {
protected:
   string            added_state;
public:
                     ConcreteDecoratorA(void);
   void              Operation(void);
  };
ConcreteDecoratorA::ConcreteDecoratorA(void):
   added_state("The added state()")
  {
  }
void ConcreteDecoratorA::Operation(void)
  {
   Decorator::Operation();
   Print(added_state);
  }
class ConcreteDecoratorB:public Decorator
  {
public:
   void              AddedBehavior(void);
   void              Operation(void);
  };
void ConcreteDecoratorB::AddedBehavior(void)
  {
   Print("The added behavior()");
  }
void ConcreteDecoratorB::Operation(void)
  {
   Decorator::Operation();
   AddedBehavior();
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
   Component* component=new ConcreteComponent();
   Decorator* decorator_a=new ConcreteDecoratorA();
   Decorator* decorator_b=new ConcreteDecoratorB();
   decorator_a.component=component;
   decorator_b.component=decorator_a;
   decorator_b.Operation();
   delete component;
   delete decorator_a;
   delete decorator_b;
  }
}