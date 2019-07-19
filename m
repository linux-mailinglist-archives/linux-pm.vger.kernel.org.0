Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B870C6E406
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfGSKMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 06:12:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51416 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSKMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 06:12:45 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 20ad017dbcbabb9f; Fri, 19 Jul 2019 12:12:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] cpuidle: teo: Allow tick to be stopped if PM QoS is used
Date:   Fri, 19 Jul 2019 12:12:42 +0200
Message-ID: <18401254.HIz9ZfPvbb@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The TEO goveror prevents the scheduler tick from being stopped (unless
stopped already) if there is a PM QoS latency constraint for the given
CPU and the target residency of the deepest idle state matching that
constraint is below the tick boundary.

However, that is problematic if CPUs with PM QoS latency constraints
are idle for long times, because it effectively causes the tick to
run on them all the time which is wasteful.  [It is also confusing
and questionable if they are full dynticks CPUs.]

To address that issue, modify the TEO governor to carry out the
entire search for the most suitable idle state (from the target
residency perspective) even if a latency constraint is present,
to allow it to determine the expected idle duration in all cases.

Also, when using the last several measured idle duration values
to refine the idle state selection, make it compare those values
with the current expected idle duration value (instead of
comparing them with the target residency of the idle state
selected so far) which should prevent the tick from being
retained when it makes sense to stop it sometimes (especially
in the presence of PM QoS latency constraints).

Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This corresponds to the following menu governor change:

https://patchwork.kernel.org/patch/11048665/

It appears to improve idle power without any PM QoS constraints too, but
that's hard to establish due to significant differences between runs with the
same kernel.

---
 drivers/cpuidle/governors/teo.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -242,7 +242,7 @@ static int teo_select(struct cpuidle_dri
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
 	unsigned int duration_us, count;
-	int max_early_idx, idx, i;
+	int max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
 
 	if (cpu_data->last_state >= 0) {
@@ -257,6 +257,7 @@ static int teo_select(struct cpuidle_dri
 
 	count = 0;
 	max_early_idx = -1;
+	constraint_idx = drv->state_count;
 	idx = -1;
 
 	for (i = 0; i < drv->state_count; i++) {
@@ -286,16 +287,8 @@ static int teo_select(struct cpuidle_dri
 		if (s->target_residency > duration_us)
 			break;
 
-		if (s->exit_latency > latency_req) {
-			/*
-			 * If we break out of the loop for latency reasons, use
-			 * the target residency of the selected state as the
-			 * expected idle duration to avoid stopping the tick
-			 * as long as that target residency is low enough.
-			 */
-			duration_us = drv->states[idx].target_residency;
-			goto refine;
-		}
+		if (s->exit_latency > latency_req && constraint_idx > i)
+			constraint_idx = i;
 
 		idx = i;
 
@@ -321,7 +314,13 @@ static int teo_select(struct cpuidle_dri
 		duration_us = drv->states[idx].target_residency;
 	}
 
-refine:
+	/*
+	 * If there is a latency constraint, it may be necessary to use a
+	 * shallower idle state than the one selected so far.
+	 */
+	if (constraint_idx < idx)
+		idx = constraint_idx;
+
 	if (idx < 0) {
 		idx = 0; /* No states enabled. Must use 0. */
 	} else if (idx > 0) {
@@ -331,13 +330,12 @@ refine:
 
 		/*
 		 * Count and sum the most recent idle duration values less than
-		 * the target residency of the state selected so far, find the
-		 * max.
+		 * the current expected idle duration value.
 		 */
 		for (i = 0; i < INTERVALS; i++) {
 			unsigned int val = cpu_data->intervals[i];
 
-			if (val >= drv->states[idx].target_residency)
+			if (val >= duration_us)
 				continue;
 
 			count++;
@@ -356,8 +354,10 @@ refine:
 			 * would be too shallow.
 			 */
 			if (!(tick_nohz_tick_stopped() && avg_us < TICK_USEC)) {
-				idx = teo_find_shallower_state(drv, dev, idx, avg_us);
 				duration_us = avg_us;
+				if (drv->states[idx].target_residency > avg_us)
+					idx = teo_find_shallower_state(drv, dev,
+								       idx, avg_us);
 			}
 		}
 	}



