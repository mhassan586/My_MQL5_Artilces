namespace Prototype
{
class Prototype
  {
public:
   virtual Prototype* Clone(void)=0;
                     Prototype(int);
protected:
   int               id;
  };
Prototype::Prototype(int i):id(i)
  {
   Print("The prototype ",&this,", id - ",id," is created");
  }
class ConcretePrototype1:public Prototype
  {
public:
                     ConcretePrototype1(int);
   Prototype*        Clone(void);
  };
ConcretePrototype1::ConcretePrototype1(int i):
   Prototype(i)
  {
   Print("The concrete prototype 1 - ",&this,", id - ",id," is created");
  }
Prototype* ConcretePrototype1::Clone(void)
  {
   Print("The cloning concrete prototype 1 - ",&this,", id - ",id);
   return new ConcretePrototype1(id);
  }
class ConcretePrototype2:public Prototype
  {
public:
                     ConcretePrototype2(int);
   Prototype*        Clone(void);
  };
ConcretePrototype2::ConcretePrototype2(int i):
   Prototype(i)
  {
   Print("The concrete prototype 2 - ",&this,", id - ",id," is created");
  }
Prototype* ConcretePrototype2::Clone(void)
  {
   Print("The cloning concrete prototype 2 - ",&this,", id - ",id);
   return new ConcretePrototype2(id);
  }
class Client
  {
public:
   string            Output(void);
   void              Run(void);
  };
string Client::Output(void) {return __FUNCTION__;}
void Client::Run(void)
  {
   Prototype* prototype;
   Prototype* clone;
   Print("requests to create the concrete prototype 1 with id 1");
   prototype=new ConcretePrototype1(1);
   Print("requests the prototype ",prototype," to create its clone");
   clone=prototype.Clone();
   delete prototype;
   delete clone;
   Print("requests to create the concrete prototype 2 with id 2");
   prototype=new ConcretePrototype2(2);
   Print("requests the prototype ",prototype," to create its clone");
   clone=prototype.Clone();
   delete prototype;
   delete clone;
  }
}