//+------------------------------------------------------------------+
//|                                                   simple TSI.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 8
#property indicator_plots   1
#property indicator_label1  "TSI"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrBlue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  3
#include <MovingAverages.mqh>
input uint     InpSmPeriod1   =  25;    // Smoothing period 1
input uint     InpSmPeriod2   =  13;   // Smoothing period 2
int            smperiod1;
int            smperiod2;
double         indBuff[];
double         momBuff[];
double         momSmBuff1[];
double         momSmBuff2[];
double         absMomBuff[];
double         absMomSmBuff1[];
double         absMomSmBuff2[];
int OnInit()
  {
   smperiod1=int(InpSmPeriod1<2 ? 2 : InpSmPeriod1);
   smperiod2=int(InpSmPeriod2<2 ? 2 : InpSmPeriod2);
   SetIndexBuffer(0,indBuff,INDICATOR_DATA);
   SetIndexBuffer(2,momBuff,INDICATOR_CALCULATIONS);
   SetIndexBuffer(3,momSmBuff1,INDICATOR_CALCULATIONS);
   SetIndexBuffer(4,momSmBuff2,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,absMomBuff,INDICATOR_CALCULATIONS);
   SetIndexBuffer(6,absMomSmBuff1,INDICATOR_CALCULATIONS);
   SetIndexBuffer(7,absMomSmBuff2,INDICATOR_CALCULATIONS);
   IndicatorSetString(INDICATOR_SHORTNAME,"True Strength Index ("+(string)smperiod1+","+(string)smperiod2+")");
   IndicatorSetInteger(INDICATOR_DIGITS,Digits());
   ArraySetAsSeries(indBuff,true);
   ArraySetAsSeries(momBuff,true);
   ArraySetAsSeries(momSmBuff1,true);
   ArraySetAsSeries(momSmBuff2,true);
   ArraySetAsSeries(absMomBuff,true);
   ArraySetAsSeries(absMomSmBuff1,true);
   ArraySetAsSeries(absMomSmBuff2,true);
   return(INIT_SUCCEEDED);
  }
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   ArraySetAsSeries(close,true);
   if(rates_total<2)
      return 0;

   int limit=rates_total-prev_calculated;
   if(limit>1)
     {
      limit=rates_total-2;
      ArrayInitialize(indBuff,EMPTY_VALUE);
      ArrayInitialize(momBuff,0);
      ArrayInitialize(momSmBuff1,0);
      ArrayInitialize(momSmBuff2,0);
      ArrayInitialize(absMomBuff,0);
      ArrayInitialize(absMomSmBuff1,0);
      ArrayInitialize(absMomSmBuff2,0);
     }
   for(int i=limit; i>=0 && !IsStopped(); i--)
     {
      momBuff[i]=close[i]-close[i+1];
      absMomBuff[i]=MathAbs(momBuff[i]);
     }
   if(ExponentialMAOnBuffer(rates_total,prev_calculated,0,smperiod1,momBuff,momSmBuff1)==0)
      return 0;
   if(ExponentialMAOnBuffer(rates_total,prev_calculated,0,smperiod1,absMomBuff,absMomSmBuff1)==0)
      return 0;
   if(ExponentialMAOnBuffer(rates_total,prev_calculated,smperiod1,smperiod2,momSmBuff1,momSmBuff2)==0)
      return 0;
   if(ExponentialMAOnBuffer(rates_total,prev_calculated,smperiod1,smperiod2,absMomSmBuff1,absMomSmBuff2)==0)
      return 0;
   for(int i=limit; i>=0 && !IsStopped(); i--)
      indBuff[i]=(absMomSmBuff2[i]!=0 ? 100.0*momSmBuff2[i]/absMomSmBuff2[i] : 0);
   return(rates_total);
  }