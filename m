Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8DD3382
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfJJVgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:36:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65324 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfJJVgS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:36:18 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 3ad197a03b599e0a; Thu, 10 Oct 2019 23:36:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 3/4] cpuidle: teo: Consider hits and misses metrics of disabled states
Date:   Thu, 10 Oct 2019 23:36:15 +0200
Message-ID: <2237950.TTgtiEjdez@kreacher>
In-Reply-To: <60416800.X4hXmAfbqi@kreacher>
References: <60416800.X4hXmAfbqi@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The TEO governor uses idle duration "bins" defined in accordance with
the CPU idle states table provided by the driver, so that each "bin"
covers the idle duration range between the target residency of the
idle state corresponding to it and the target residency of the closest
deeper idle state.  The governor collects statistics for each bin
regardless of whether or not the idle state corresponding to it is
currently enabled.

In particular, the "hits" and "misses" metrics measure the likelihood
of a situation in which both the time till the next timer (sleep
length) and the idle duration measured after wakeup fall into the
given bin.  Namely, if the "hits" value is greater than the "misses"
one, that situation is more likely than the one in which the sleep
length falls into the given bin, but the idle duration measured after
wakeup falls into a bin corresponding to one of the shallower idle
states.

If the idle state corresponding to the given bin is disabled, it
cannot be selected and if it turns out to be the one that should be
selected, a shallower idle state needs to be used instead of it.
Nevertheless, the metrics collected for the bin corresponding to it
are still valid and need to be taken into account as though that
state had not been disabled.

For this reason, make teo_select() always use the "hits" and "misses"
values of the idle duration range that the sleep length falls into
even if the specific idle state corresponding to it is disabled and
if the "hits" values is greater than the "misses" one, select the
closest enabled shallower idle state in that case.

Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -233,7 +233,7 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
-	unsigned int duration_us, early_hits;
+	unsigned int duration_us, hits, misses, early_hits;
 	int max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
 
@@ -247,6 +247,8 @@ static int teo_select(struct cpuidle_dri
 	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
+	hits = 0;
+	misses = 0;
 	early_hits = 0;
 	max_early_idx = -1;
 	constraint_idx = drv->state_count;
@@ -265,6 +267,17 @@ static int teo_select(struct cpuidle_dri
 				continue;
 
 			/*
+			 * This state is disabled, so the range of idle duration
+			 * values corresponding to it is covered by the current
+			 * candidate state, but still the "hits" and "misses"
+			 * metrics of the disabled state need to be used to
+			 * decide whether or not the state covering the range in
+			 * question is good enough.
+			 */
+			hits = cpu_data->states[i].hits;
+			misses = cpu_data->states[i].misses;
+
+			/*
 			 * If the "early hits" metric of a disabled state is
 			 * greater than the current maximum, it should be taken
 			 * into account, because it would be a mistake to select
@@ -280,8 +293,11 @@ static int teo_select(struct cpuidle_dri
 			continue;
 		}
 
-		if (idx < 0)
+		if (idx < 0) {
 			idx = i; /* first enabled state */
+			hits = cpu_data->states[i].hits;
+			misses = cpu_data->states[i].misses;
+		}
 
 		if (s->target_residency > duration_us)
 			break;
@@ -290,6 +306,8 @@ static int teo_select(struct cpuidle_dri
 			constraint_idx = i;
 
 		idx = i;
+		hits = cpu_data->states[i].hits;
+		misses = cpu_data->states[i].misses;
 
 		if (early_hits < cpu_data->states[i].early_hits &&
 		    !(tick_nohz_tick_stopped() &&
@@ -307,8 +325,7 @@ static int teo_select(struct cpuidle_dri
 	 * "early hits" metric, but if that cannot be determined, just use the
 	 * state selected so far.
 	 */
-	if (cpu_data->states[idx].hits <= cpu_data->states[idx].misses &&
-	    max_early_idx >= 0) {
+	if (hits <= misses && max_early_idx >= 0) {
 		idx = max_early_idx;
 		duration_us = drv->states[idx].target_residency;
 	}



