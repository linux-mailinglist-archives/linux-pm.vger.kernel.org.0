Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24ED3379
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJJVeO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:34:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58721 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfJJVeO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:34:14 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 3a48057531757d0a; Thu, 10 Oct 2019 23:34:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 2/4] cpuidle: teo: Rename local variable in teo_select()
Date:   Thu, 10 Oct 2019 23:32:59 +0200
Message-ID: <5976014.dk64zBpnPU@kreacher>
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

Rename a local variable in teo_select() in preparation for subsequent
code modifications, no intentional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -233,7 +233,7 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
-	unsigned int duration_us, count;
+	unsigned int duration_us, early_hits;
 	int max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
 
@@ -247,7 +247,7 @@ static int teo_select(struct cpuidle_dri
 	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
-	count = 0;
+	early_hits = 0;
 	max_early_idx = -1;
 	constraint_idx = drv->state_count;
 	idx = -1;
@@ -270,12 +270,12 @@ static int teo_select(struct cpuidle_dri
 			 * into account, because it would be a mistake to select
 			 * a deeper state with lower "early hits" metric.  The
 			 * index cannot be changed to point to it, however, so
-			 * just increase the max count alone and let the index
-			 * still point to a shallower idle state.
+			 * just increase the "early hits" count alone and let
+			 * the index still point to a shallower idle state.
 			 */
 			if (max_early_idx >= 0 &&
-			    count < cpu_data->states[i].early_hits)
-				count = cpu_data->states[i].early_hits;
+			    early_hits < cpu_data->states[i].early_hits)
+				early_hits = cpu_data->states[i].early_hits;
 
 			continue;
 		}
@@ -291,10 +291,10 @@ static int teo_select(struct cpuidle_dri
 
 		idx = i;
 
-		if (count < cpu_data->states[i].early_hits &&
+		if (early_hits < cpu_data->states[i].early_hits &&
 		    !(tick_nohz_tick_stopped() &&
 		      drv->states[i].target_residency < TICK_USEC)) {
-			count = cpu_data->states[i].early_hits;
+			early_hits = cpu_data->states[i].early_hits;
 			max_early_idx = i;
 		}
 	}
@@ -323,10 +323,9 @@ static int teo_select(struct cpuidle_dri
 	if (idx < 0) {
 		idx = 0; /* No states enabled. Must use 0. */
 	} else if (idx > 0) {
+		unsigned int count = 0;
 		u64 sum = 0;
 
-		count = 0;
-
 		/*
 		 * Count and sum the most recent idle duration values less than
 		 * the current expected idle duration value.



