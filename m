Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4778D10CFD6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 23:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1WvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 17:51:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63649 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfK1WvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 17:51:02 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5936317b2e2d446d; Thu, 28 Nov 2019 23:51:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ACPI: EC: Rework flushing of pending work
Date:   Thu, 28 Nov 2019 23:47:51 +0100
Message-ID: <5947679.MAvhsAmGqv@kreacher>
In-Reply-To: <2787005.CsmIKtZlk9@kreacher>
References: <2787005.CsmIKtZlk9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a race condition in the ACPI EC driver, between
__acpi_ec_flush_event() and acpi_ec_event_handler(), that may
cause systems to stay in suspended-to-idle forever after a wakeup
event coming from the EC.

Namely, acpi_s2idle_wake() calls acpi_ec_flush_work() to wait until
the delayed work resulting from the handling of the EC GPE in
acpi_ec_dispatch_gpe() is processed, and that function invokes
__acpi_ec_flush_event() which uses wait_event() to wait for
ec->nr_pending_queries to become zero on ec->wait, and that wait
queue may be woken up too early.

Suppose that acpi_ec_dispatch_gpe() has caused acpi_ec_gpe_handler()
to run, so advance_transaction() has been called and it has invoked
acpi_ec_submit_query() to queue up an event work item, so
ec->nr_pending_queries has been incremented (under ec->lock).  The
work function of that work item, acpi_ec_event_handler() runs later
and calls acpi_ec_query() to process the event.  That function calls
acpi_ec_transaction() which invokes acpi_ec_transaction_unlocked()
and the latter wakes up ec->wait under ec->lock, but it drops that
lock before returning.

When acpi_ec_query() returns, acpi_ec_event_handler() acquires
ec->lock and decrements ec->nr_pending_queries, but at that point
__acpi_ec_flush_event() (woken up previously) may already have
acquired ec->lock, checked the value of ec->nr_pending_queries (and
it would not have been zero then) and decided to go back to sleep.
Next, if ec->nr_pending_queries is equal to zero now, the loop
in acpi_ec_event_handler() terminates, ec->lock is released and
acpi_ec_check_event() is called, but it does nothing unless
ec_event_clearing is equal to ACPI_EC_EVT_TIMING_EVENT (which is
not the case by default).  In the end, if no more event work items
have been queued up while executing acpi_ec_transaction_unlocked(),
there is nothing to wake up __acpi_ec_flush_event() again and it
sleeps forever, so the suspend-to-idle loop cannot make progress and
the system is permanently suspended.

To avoid this issue, notice that it actually is not necessary to
wait for ec->nr_pending_queries to become zero in every case in
which __acpi_ec_flush_event() is used.

First, during platform-based system suspend (not suspend-to-idle),
__acpi_ec_flush_event() is called by acpi_ec_disable_event() after
clearing the EC_FLAGS_QUERY_ENABLED flag, which prevents
acpi_ec_submit_query() from submitting any new event work items,
so calling flush_scheduled_work() and flushing ec_query_wq
subsequently (in order to wait until all of the queries in that
queue have been processed) would be sufficient to flush all of
the pending EC work in that case.

Second, the purpose of the flushing of pending EC work while
suspended-to-idle described above really is to wait until the
first event work item coming from acpi_ec_dispatch_gpe() is
complete, because it should produce system wakeup events if
that is a valid EC-based system wakeup, so calling
flush_scheduled_work() followed by flushing ec_query_wq is also
sufficient for that purpose.

Rework the code to follow the above observations.

Fixes: 56b9918490 ("PM: sleep: Simplify suspend-to-idle control flow")
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |   36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -525,26 +525,10 @@ static void acpi_ec_enable_event(struct
 }
 
 #ifdef CONFIG_PM_SLEEP
-static bool acpi_ec_query_flushed(struct acpi_ec *ec)
+static void __acpi_ec_flush_work(void)
 {
-	bool flushed;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ec->lock, flags);
-	flushed = !ec->nr_pending_queries;
-	spin_unlock_irqrestore(&ec->lock, flags);
-	return flushed;
-}
-
-static void __acpi_ec_flush_event(struct acpi_ec *ec)
-{
-	/*
-	 * When ec_freeze_events is true, we need to flush events in
-	 * the proper position before entering the noirq stage.
-	 */
-	wait_event(ec->wait, acpi_ec_query_flushed(ec));
-	if (ec_query_wq)
-		flush_workqueue(ec_query_wq);
+	flush_scheduled_work(); /* flush ec->work */
+	flush_workqueue(ec_query_wq); /* flush queries */
 }
 
 static void acpi_ec_disable_event(struct acpi_ec *ec)
@@ -554,15 +538,21 @@ static void acpi_ec_disable_event(struct
 	spin_lock_irqsave(&ec->lock, flags);
 	__acpi_ec_disable_event(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
-	__acpi_ec_flush_event(ec);
+
+	/*
+	 * When ec_freeze_events is true, we need to flush events in
+	 * the proper position before entering the noirq stage.
+	 */
+	__acpi_ec_flush_work();
 }
 
 void acpi_ec_flush_work(void)
 {
-	if (first_ec)
-		__acpi_ec_flush_event(first_ec);
+	/* Without ec_query_wq there is nothing to flush. */
+	if (!ec_query_wq)
+		return;
 
-	flush_scheduled_work();
+	__acpi_ec_flush_work();
 }
 #endif /* CONFIG_PM_SLEEP */
 



