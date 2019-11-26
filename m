Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905FF10A237
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 17:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfKZQfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 11:35:15 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:60298 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKZQfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 11:35:14 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MqJH5gklz1dnL;
        Tue, 26 Nov 2019 11:35:11 -0500 (EST)
Date:   Tue, 26 Nov 2019 08:35:10 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911260833250.2714@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
 <alpine.DEB.2.21.1911251155440.2817@hp-x360n> <CAJZ5v0hMR8_i=oA1ovX0-xfa_w1x7nHhTwmmKRPu27ceFxpFow@mail.gmail.com> <alpine.DEB.2.21.1911251502490.13123@hp-x360n> <CAJZ5v0jR8OQVOniR++NJeDukDn9Bgp+DZtvmSCF_d0pH1LDr6w@mail.gmail.com> <alpine.DEB.2.21.1911260759220.6292@hp-x360n>
 <CAJZ5v0iJevs95=wpZF8iprXqs2R6H=T-FHfbFwGsQqcBe=Wk5w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 26 Nov 2019, Rafael J. Wysocki wrote:

> OK, so just to double check if I understand you correctly, you are
> running the Linus' tip with [the patch] on top and with two extra
> WARN_ON(1) statements in acpi_ec_query_flushed()?

Yeah:

----
$ git diff lk-linus/master drivers/acpi/

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index da1e5c5ce150..0bb13a596e4f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -530,9 +530,11 @@ static bool acpi_ec_query_flushed(struct acpi_ec *ec)
 	bool flushed;
 	unsigned long flags;

+	WARN_ON(1);
 	spin_lock_irqsave(&ec->lock, flags);
 	flushed = !ec->nr_pending_queries;
 	spin_unlock_irqrestore(&ec->lock, flags);
+	WARN_ON(1);
 	return flushed;
 }

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 2af937a8b1c5..003b314eda29 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -977,6 +977,13 @@ static int acpi_s2idle_prepare_late(void)
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
@@ -1024,6 +1029,8 @@ static void acpi_s2idle_restore_early(void)

 static void acpi_s2idle_restore(void)
 {
+	acpi_s2idle_sync();
+
 	s2idle_wakeup = false;

 	acpi_enable_all_runtime_gpes();
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
