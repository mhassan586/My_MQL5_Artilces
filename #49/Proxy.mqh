namespace Proxy
{
class Subject
  {
public:
   virtual void      Request(void)=0;
  };
class RealSubject:public Subject
  {
public:
   void              Request(void);
  };
void RealSubject::Request(void)
  {
   Print("The real subject");
  }
class Proxy:public Subject
  {
protected:
   RealSubject*      real_subject;
public:
                    ~Proxy(void);
   void              Request(void);
  };
Proxy::~Proxy(void)
  {
   delete real_subject;
  }
void Proxy::Request(void)
  {
   if(!CheckPointer(real_subject))
     {
      real_subject=new RealSubject;
     }
   real_subject.Request();
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
   Subject* subject=new Proxy;
   subject.Request();
   delete subject;
  }
}