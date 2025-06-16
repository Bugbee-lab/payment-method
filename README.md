Payment processing system (Event driven architecture solution):
		
Considering following three scenario
  1.	Payment requested.
        a.	 A user initiates a payment.
        b.	 Event: PaymentRequested
        c.	Status: PENDING
 2.	Payment completed or failed:
        a.	The payment either succeeds or fails.
        b.	Events: PaymentSucceeded, PaymentFailed
        c.	Status: PAID or FAILED
 3.	Invoice generated:
        a.	When payment succeeds, generate or update an invoice.
        b.	Event: InvoiceCreated (on success) or InvoiceFailed

AWS Services for this :
1.	Event bridge :  Event Bus
2.	Processing Logic :  Lambda
3.	Data Store :  Dynamodb
4.	SQS and DLQ : Handling payment failure
5.	Unit test : Terraform(go language)
6.	

 
