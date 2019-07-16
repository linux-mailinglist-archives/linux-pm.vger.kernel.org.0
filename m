Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AA6ABA8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbfGPPZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 11:25:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55704 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfGPPZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 11:25:12 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id fc8f4a0a9c6fad49; Tue, 16 Jul 2019 17:25:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] cpuidle: Always stop scheduler tick on adaptive-tick CPUs
Date:   Tue, 16 Jul 2019 17:25:10 +0200
Message-ID: <6254683.2O5gIZElE2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Running the scheduler tick on idle adaptive-tick CPUs is not useful
and it may also be not expected by users (as reported by Thomas), so
add a check to cpuidle_idle_call() to always stop the tick on them
regardless of the idle duration predicted by the governor.

Fixes: 554c8aa8ecad ("sched: idle: Select idle state before stopping the tick")
Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick || tick_nohz_tick_stopped())
+		if (stop_tick || tick_nohz_tick_stopped() ||
+		    !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))
 			tick_nohz_idle_stop_tick();
 		else
 			tick_nohz_idle_retain_tick();



