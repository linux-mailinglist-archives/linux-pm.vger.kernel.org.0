Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA56CB49
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfGRIxY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 04:53:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44905 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfGRIxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 04:53:24 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 5b3d82715b2f7795; Thu, 18 Jul 2019 10:53:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] cpuidle: menu: Allow tick to be stopped if PM QoS is used
Date:   Thu, 18 Jul 2019 10:53:21 +0200
Message-ID: <71073128.vkdIulrjX3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 554c8aa8ecad ("sched: idle: Select idle state before
stopping the tick") the menu governor prevents the scheduler tick from
being stopped (unless stopped already) if there is a PM QoS latency
constraint for the given CPU and the target residency of the deepest
idle state matching that constraint is below the tick boundary.

However, that is problematic if CPUs with PM QoS latency constraints
are idle for long times, because it effectively causes the tick to
run on them all the time which is wasteful.  [It is also confusing
and questionable if they are full dynticks CPUs.]

To address that issue, make the menu governor allow the tick to be
stopped only if the idle duration predicted by it is beyond the tick
boundary, except when the shallowest idle state is selected upfront
and it is not a "polling" one.

Fixes: 554c8aa8ecad ("sched: idle: Select idle state before stopping the tick")
Link: https://lore.kernel.org/lkml/79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com/
Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -302,9 +302,10 @@ static int menu_select(struct cpuidle_dr
 	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
 		/*
 		 * In this case state[0] will be used no matter what, so return
-		 * it right away and keep the tick running.
+		 * it right away and keep the tick running if state[0] is a
+		 * polling one.
 		 */
-		*stop_tick = false;
+		*stop_tick = !(drv->states[0].flags & CPUIDLE_FLAG_POLLING);
 		return 0;
 	}
 
@@ -395,16 +396,9 @@ static int menu_select(struct cpuidle_dr
 
 			return idx;
 		}
-		if (s->exit_latency > latency_req) {
-			/*
-			 * If we break out of the loop for latency reasons, use
-			 * the target residency of the selected state as the
-			 * expected idle duration so that the tick is retained
-			 * as long as that target residency is low enough.
-			 */
-			predicted_us = drv->states[idx].target_residency;
+		if (s->exit_latency > latency_req)
 			break;
-		}
+
 		idx = i;
 	}
 



