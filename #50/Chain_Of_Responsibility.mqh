//+------------------------------------------------------------------+
//|                                      Chain_Of_Responsibility.mqh |
//+------------------------------------------------------------------+
namespace Chain_Of_Responsibility
{
class Handler
  {
public:
   Handler*          successor;
   virtual void      HandleRequest(int)=0;
                    ~Handler(void);
  };
Handler::~Handler(void)
  {
   delete successor;
  }
class ConcreteHandler1:public Handler
  {
public:
   void              HandleRequest(int);
  };
void ConcreteHandler1::HandleRequest(int request)
  {
   if(request==1)
      Print("The request: ",request,". The request handled by: ",&this);
   else
      if(CheckPointer(successor))
        {
         Print("The request: ",request,". The request cannot be handled by ",&this,", but it is forwarding to the successor...");
         successor.HandleRequest(request);
        }
  }
class ConcreteHandler2:public Handler
  {
public:
   void              HandleRequest(int);
  };
void ConcreteHandler2::HandleRequest(int request)
  {
   if(request==2)
      Print("The request: ",request,". The request handled by: ",&this);
   else
      if(CheckPointer(successor))
        {
         Print("The request: ",request,". The request cannot be handled by ",&this,", but it is forwarding to successor...");
         successor.HandleRequest(request);
        }
  }
class Client
  {
public:
   string            Output();
   void              Run();
  };
string Client::Output()
  {
   return __FUNCTION__;
  }
void   Client::Run()
  {
   Handler* h1=new ConcreteHandler1();
   Handler* h2=new ConcreteHandler2();
   h1.successor=h2;
   h1.HandleRequest(1);
   h1.HandleRequest(2);
   delete h1;
  }
}