Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4FF9F18
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 01:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKMALn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 19:11:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52360 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfKMALj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 19:11:39 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 1848fb0b0f378da5; Wed, 13 Nov 2019 01:11:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 1/3] cpuidle: teo: Avoid using "early hits" incorrectly
Date:   Wed, 13 Nov 2019 01:03:24 +0100
Message-ID: <4252573.bgB6ll4ivO@kreacher>
In-Reply-To: <13588000.TfE7eV4KYW@kreacher>
References: <13588000.TfE7eV4KYW@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the current state with the maximum "early hits" metric in
teo_select() is also the one "matching" the expected idle duration,
it will be used as the candidate one for selection even if its
"misses" metric is greater than its "hits" metric, which is not
correct.

In that case, the candidate state should be shallower than the
current one and its "early hits" metric should be the maximum
among the idle states shallower than the current one.

To make that happen, modify teo_select() to save the index of
the state whose "early hits" metric is the maximum for the
range of states below the current one and go back to that state
if it turns out that the current one should be rejected.

Fixes: 159e48560f51 ("cpuidle: teo: Fix "early hits" handling for disabled idle states")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -239,7 +239,7 @@ static int teo_select(struct cpuidle_dri
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	u64 duration_ns;
 	unsigned int hits, misses, early_hits;
-	int max_early_idx, constraint_idx, idx, i;
+	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
 
 	if (dev->last_state_idx >= 0) {
@@ -256,6 +256,7 @@ static int teo_select(struct cpuidle_dri
 	misses = 0;
 	early_hits = 0;
 	max_early_idx = -1;
+	prev_max_early_idx = -1;
 	constraint_idx = drv->state_count;
 	idx = -1;
 
@@ -307,6 +308,7 @@ static int teo_select(struct cpuidle_dri
 			 */
 			if (!(tick_nohz_tick_stopped() &&
 			      drv->states[idx].target_residency_ns < TICK_NSEC)) {
+				prev_max_early_idx = max_early_idx;
 				early_hits = cpu_data->states[i].early_hits;
 				max_early_idx = idx;
 			}
@@ -333,6 +335,7 @@ static int teo_select(struct cpuidle_dri
 		if (early_hits < cpu_data->states[i].early_hits &&
 		    !(tick_nohz_tick_stopped() &&
 		      drv->states[i].target_residency_ns < TICK_NSEC)) {
+			prev_max_early_idx = max_early_idx;
 			early_hits = cpu_data->states[i].early_hits;
 			max_early_idx = i;
 		}
@@ -346,9 +349,19 @@ static int teo_select(struct cpuidle_dri
 	 * "early hits" metric, but if that cannot be determined, just use the
 	 * state selected so far.
 	 */
-	if (hits <= misses && max_early_idx >= 0) {
-		idx = max_early_idx;
-		duration_ns = drv->states[idx].target_residency_ns;
+	if (hits <= misses) {
+		/*
+		 * The current candidate state is not suitable, so take the one
+		 * whose "early hits" metric is the maximum for the range of
+		 * shallower states.
+		 */
+		if (idx == max_early_idx)
+			max_early_idx = prev_max_early_idx;
+
+		if (max_early_idx >= 0) {
+			idx = max_early_idx;
+			duration_ns = drv->states[idx].target_residency_ns;
+		}
 	}
 
 	/*



