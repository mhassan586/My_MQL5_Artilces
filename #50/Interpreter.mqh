//+------------------------------------------------------------------+
//|                                                  Interpreter.mqh |
//+------------------------------------------------------------------+
namespace Interpreter
{
class Context
  {
public:
   string            m_source;
   char              m_vocabulary;
   int               m_position;
   bool              m_result;
                     Context(char,string);
   void              Result(void);
  };
Context::Context(char vocabulary,string source):
   m_source(source),
   m_vocabulary(vocabulary),
   m_position(0),
   m_result(false)
  {
  }
void Context::Result(void)
  {
  }
class AbstractExpression
  {
public:
   virtual void      Interpret(Context&)=0;
  };
class TerminalExpression:public AbstractExpression
  {
public:
   void              Interpret(Context&);
  };
void TerminalExpression::Interpret(Context& context)
  {
   context.m_result=
      StringSubstr(context.m_source,context.m_position,1)==
      CharToString(context.m_vocabulary);
  }
class NonterminalExpression:public AbstractExpression
  {
protected:
   AbstractExpression* m_nonterminal_expression;
   AbstractExpression* m_terminal_expression;
public:
   void              Interpret(Context&);
                    ~NonterminalExpression(void);
  };
NonterminalExpression::~NonterminalExpression(void)
  {
   delete m_nonterminal_expression;
   delete m_terminal_expression;
  }
void NonterminalExpression::Interpret(Context& context)
  {
   if(context.m_position<StringLen(context.m_source))
     {
      m_terminal_expression=new TerminalExpression;
      m_terminal_expression.Interpret(context);
      context.m_position++;
      if(context.m_result)
        {
         m_nonterminal_expression=new NonterminalExpression;
         m_nonterminal_expression.Interpret(context);
        }
     }
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
   Context context_1('a',"aaa");
   Context context_2('a',"aba");
   AbstractExpression* expression;
   expression=new NonterminalExpression;
   expression.Interpret(context_1);
   context_1.Result();
   delete expression;
   expression=new NonterminalExpression;
   expression.Interpret(context_2);
   context_2.Result();
   delete expression;
  }
}