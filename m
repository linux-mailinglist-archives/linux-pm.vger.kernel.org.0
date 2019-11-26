Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F810A42C
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 19:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKZSs4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 13:48:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43510 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKZSs4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 13:48:56 -0500
Received: from 79.184.255.91.ipv4.supernova.orange.pl (79.184.255.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 805fb0028ee63f75; Tue, 26 Nov 2019 19:48:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify suspend-to-idle control flow)
Date:   Tue, 26 Nov 2019 19:48:50 +0100
Message-ID: <12933162.9b7K5rSXZx@kreacher>
In-Reply-To: <alpine.DEB.2.21.1911260833250.2714@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com> <alpine.DEB.2.21.1911260833250.2714@hp-x360n>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, November 26, 2019 5:35:10 PM CET Kenneth R. Crudup wrote:
> On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:
> 
> > OK, so just to double check if I understand you correctly, you are
> > running the Linus' tip with [the patch] on top and with two extra
> > WARN_ON(1) statements in acpi_ec_query_flushed()?
> 
> Yeah:
> 
> ----
> $ git diff lk-linus/master drivers/acpi/
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index da1e5c5ce150..0bb13a596e4f 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -530,9 +530,11 @@ static bool acpi_ec_query_flushed(struct acpi_ec *ec)
>  	bool flushed;
>  	unsigned long flags;
> 
> +	WARN_ON(1);
>  	spin_lock_irqsave(&ec->lock, flags);
>  	flushed = !ec->nr_pending_queries;
>  	spin_unlock_irqrestore(&ec->lock, flags);
> +	WARN_ON(1);
>  	return flushed;
>  }

I've just realized that it is not necessary to use acpi_ec_query_flushed() in
acpi_ec_flush_work() at all, because it calls flush_scheduled_work() anyway,
so the appended patch should be good to go.

Can you try it, please?

---
 drivers/acpi/ec.c    |   20 ++++++++++----------
 drivers/acpi/sleep.c |   13 ++++++++++---
 2 files changed, 20 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -977,6 +977,13 @@ static int acpi_s2idle_prepare_late(void
 	return 0;
 }
 
+static void acpi_s2idle_sync(void)
+{
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+	acpi_ec_flush_work();
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+}
+
 static void acpi_s2idle_wake(void)
 {
 	/*
@@ -1005,9 +1012,7 @@ static void acpi_s2idle_wake(void)
 		 * The EC driver uses the system workqueue and an additional
 		 * special one, so those need to be flushed too.
 		 */
-		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
-		acpi_ec_flush_work();
-		acpi_os_wait_events_complete(); /* synchronize Notify handling */
+		acpi_s2idle_sync();
 
 		rearm_wake_irq(acpi_sci_irq);
 	}
@@ -1024,6 +1029,8 @@ static void acpi_s2idle_restore_early(vo
 
 static void acpi_s2idle_restore(void)
 {
+	acpi_s2idle_sync();
+
 	s2idle_wakeup = false;
 
 	acpi_enable_all_runtime_gpes();
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -536,13 +536,8 @@ static bool acpi_ec_query_flushed(struct
 	return flushed;
 }
 
-static void __acpi_ec_flush_event(struct acpi_ec *ec)
+static void acpi_ec_flush_query_queue(void)
 {
-	/*
-	 * When ec_freeze_events is true, we need to flush events in
-	 * the proper position before entering the noirq stage.
-	 */
-	wait_event(ec->wait, acpi_ec_query_flushed(ec));
 	if (ec_query_wq)
 		flush_workqueue(ec_query_wq);
 }
@@ -554,14 +549,19 @@ static void acpi_ec_disable_event(struct
 	spin_lock_irqsave(&ec->lock, flags);
 	__acpi_ec_disable_event(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
-	__acpi_ec_flush_event(ec);
+
+	/*
+	 * When ec_freeze_events is true, we need to flush events in
+	 * the proper position before entering the noirq stage.
+	 */
+	wait_event(ec->wait, acpi_ec_query_flushed(ec));
+
+	acpi_ec_flush_query_queue();
 }
 
 void acpi_ec_flush_work(void)
 {
-	if (first_ec)
-		__acpi_ec_flush_event(first_ec);
-
+	acpi_ec_flush_query_queue();
 	flush_scheduled_work();
 }
 #endif /* CONFIG_PM_SLEEP */



