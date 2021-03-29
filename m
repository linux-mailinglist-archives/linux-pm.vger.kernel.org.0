Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7934D76D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhC2Shl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 14:37:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46042 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhC2Shf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 14:37:35 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 090bfece032b69b7; Mon, 29 Mar 2021 20:37:33 +0200
Received: from kreacher.localnet (89-64-81-131.dynamic.chello.pl [89.64.81.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E72FC669165;
        Mon, 29 Mar 2021 20:37:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Subject: [PATCH v1 4/5] cpuidle: teo: Take negative "sleep length" values into account
Date:   Mon, 29 Mar 2021 20:21:43 +0200
Message-ID: <8741445.CDJkKcVGEf@kreacher>
In-Reply-To: <2764850.e9J7NaK4W3@kreacher>
References: <2764850.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdekuddrudefudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrudefuddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghp
 thhtohepgidvtddulegtfihmsehsthhfgidrtggr
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Modify the TEO governor to take possible negative return values of
tick_nohz_get_next_hrtimer() into account by changing the data type
of some variables used by it to s64 which allows it to carry out
computations without potentially problematic data type conversions
into u64.

Also change the computations in teo_select() so that the negative
values themselves are handled in a natural way to avoid adding extra
negative value checks to that function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -100,8 +100,8 @@ struct teo_idle_state {
  * @intervals: Saved idle duration values.
  */
 struct teo_cpu {
-	u64 time_span_ns;
-	u64 sleep_length_ns;
+	s64 time_span_ns;
+	s64 sleep_length_ns;
 	struct teo_idle_state states[CPUIDLE_STATE_MAX];
 	int interval_idx;
 	u64 intervals[INTERVALS];
@@ -214,7 +214,7 @@ static bool teo_time_ok(u64 interval_ns)
  */
 static int teo_find_shallower_state(struct cpuidle_driver *drv,
 				    struct cpuidle_device *dev, int state_idx,
-				    u64 duration_ns)
+				    s64 duration_ns)
 {
 	int i;
 
@@ -240,10 +240,10 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
-	u64 duration_ns;
+	int max_early_idx, prev_max_early_idx, constraint_idx, idx0, idx, i;
 	unsigned int hits, misses, early_hits;
-	int max_early_idx, prev_max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
+	s64 duration_ns;
 
 	if (dev->last_state_idx >= 0) {
 		teo_update(drv, dev);
@@ -262,6 +262,7 @@ static int teo_select(struct cpuidle_dri
 	prev_max_early_idx = -1;
 	constraint_idx = drv->state_count;
 	idx = -1;
+	idx0 = idx;
 
 	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
@@ -322,6 +323,7 @@ static int teo_select(struct cpuidle_dri
 			idx = i; /* first enabled state */
 			hits = cpu_data->states[i].hits;
 			misses = cpu_data->states[i].misses;
+			idx0 = i;
 		}
 
 		if (s->target_residency_ns > duration_ns)
@@ -374,11 +376,16 @@ static int teo_select(struct cpuidle_dri
 
 	if (idx < 0) {
 		idx = 0; /* No states enabled. Must use 0. */
-	} else if (idx > 0) {
+	} else if (idx > idx0) {
 		unsigned int count = 0;
 		u64 sum = 0;
 
 		/*
+		 * The target residencies of at least two different enabled idle
+		 * states are less than or equal to the current expected idle
+		 * duration.  Try to refine the selection using the most recent
+		 * measured idle duration values.
+		 *
 		 * Count and sum the most recent idle duration values less than
 		 * the current expected idle duration value.
 		 */
@@ -426,7 +433,8 @@ static int teo_select(struct cpuidle_dri
 		 * till the closest timer including the tick, try to correct
 		 * that.
 		 */
-		if (idx > 0 && drv->states[idx].target_residency_ns > delta_tick)
+		if (idx > idx0 &&
+		    drv->states[idx].target_residency_ns > delta_tick)
 			idx = teo_find_shallower_state(drv, dev, idx, delta_tick);
 	}
 



