Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74539925F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBSUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 14:20:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49270 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSUg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 14:20:36 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id fdbbbdf489298b23; Wed, 2 Jun 2021 20:18:51 +0200
Received: from kreacher.localnet (89-64-80-45.dynamic.chello.pl [89.64.80.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9963A6697FA;
        Wed,  2 Jun 2021 20:18:50 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/5] cpuidle: teo: Rework most recent idle duration values treatment
Date:   Wed, 02 Jun 2021 20:17:18 +0200
Message-ID: <1702889.VLH7GnMWUR@kreacher>
In-Reply-To: <1867445.PYKUYFuaPT@kreacher>
References: <1867445.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.45
X-CLIENT-HOSTNAME: 89-64-80-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The TEO (Timer Events Oriented) cpuidle governor uses several most
recent idle duration values for a given CPU to refine the idle state
selection in case the previous long-term trends have not been
followed recently and a new trend appears to be forming.  That is
done by computing the average of the most recent idle duration
values falling below the time till the next timer event ("sleep
length"), provided that they are the majority of the most recent
idle duration values taken into account, and using it as the new
expected idle duration value.

However, idle state selection based on that value may not be optimal,
because the average does not really indicate which of the idle states
with target residencies less than or equal to it is likely to be the
best fit.

Thus, instead of computing the average, make the governor carry out
computations based on the distribution of the most recent idle
duration values among the bins corresponding to different idle
states.  Namely, if the majority of the most recent idle duration
values taken into consideration are less than the current sleep
length (which means that the CPU is likely to wake up early), find
the idle state closest to the "candidate" one "matching" the sleep
length whose target residency is less than or equal to the majority
of the most recent idle duration values that have fallen below the
current sleep length (which means that it is likely to be "shallow
enough" this time).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |  157 ++++++++++++++++++----------------------
 1 file changed, 72 insertions(+), 85 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -47,15 +47,20 @@
  * length).  In turn, the "intercepts" metric reflects the relative frequency of
  * situations in which the measured idle duration is so much shorter than the
  * sleep length that the bin it falls into corresponds to an idle state
- * shallower than the one whose bin is fallen into by the sleep length.
+ * shallower than the one whose bin is fallen into by the sleep length (these
+ * situations are referred to as "intercepts" below).
+ *
+ * In addition to the metrics described above, the governor counts recent
+ * intercepts (that is, intercepts that have occurred during the last NR_RECENT
+ * invocations of it for the given CPU) for each bin.
  *
  * In order to select an idle state for a CPU, the governor takes the following
  * steps (modulo the possible latency constraint that must be taken into account
  * too):
  *
  * 1. Find the deepest CPU idle state whose target residency does not exceed
- *    the current sleep length (the candidate idle state) and compute two sums
- *    as follows:
+ *    the current sleep length (the candidate idle state) and compute 3 sums as
+ *    follows:
  *
  *    - The sum of the "hits" and "intercepts" metrics for the candidate state
  *      and all of the deeper idle states (it represents the cases in which the
@@ -67,25 +72,29 @@
  *      idle long enough to avoid being intercepted if the sleep length had been
  *      equal to the current one).
  *
- * 2. If the second sum is greater than the first one, look for an alternative
- *    idle state to select.
+ *    - The sum of the numbers of recent intercepts for all of the idle states
+ *      shallower than the candidate one.
+ *
+ * 2. If the second sum is greater than the first one or the third sum is
+ *    greater than NR_RECENT / 2, the CPU is likely to wake up early, so look
+ *    for an alternative idle state to select.
  *
  *    - Traverse the idle states shallower than the candidate one in the
  *      descending order.
  *
- *    - For each of them compute the sum of the "intercepts" metrics over all of
- *      the idle  states between it and the candidate one (including the former
- *      and excluding the latter).
- *
- *    - If that sum is greater than a half of the second sum computed in step 1
- *      (which means that the target residency of the state in question had not
- *      exceeded the idle duration in over a half of the relevant cases), select
- *      the given idle state instead of the candidate one.
- *
- * 3. If the majority of the most recent idle duration values are below the
- *    current anticipated idle duration, use those values to compute the new
- *    expected idle duration and find an idle state matching it (which has to
- *    be shallower than the current candidate one).
+ *    - For each of them compute the sum of the "intercepts" metrics and the sum
+ *      of the numbers of recent intercepts over all of the idle states between
+ *      it and the candidate one (including the former and excluding the
+ *      latter).
+ *
+ *    - If each of these sums that needs to be taken into account (because the
+ *      check related to it has indicated that the CPU is likely to wake up
+ *      early) is greater than a half of the corresponding sum computed in step
+ *      1 (which means that the target residency of the state in question had
+ *      not exceeded the idle duration in over a half of the relevant cases),
+ *      select the given idle state instead of the candidate one.
+ *
+ * 3. By default, select the candidate state.
  */
 
 #include <linux/cpuidle.h>
@@ -103,18 +112,20 @@
 
 /*
  * Number of the most recent idle duration values to take into consideration for
- * the detection of wakeup patterns.
+ * the detection of recent early wakeup patterns.
  */
-#define INTERVALS	8
+#define NR_RECENT	9
 
 /**
  * struct teo_bin - Metrics used by the TEO cpuidle governor.
  * @intercepts: The "intercepts" metric.
  * @hits: The "hits" metric.
+ * @recent: The number of recent "intercepts".
  */
 struct teo_bin {
 	unsigned int intercepts;
 	unsigned int hits;
+	unsigned int recent;
 };
 
 /**
@@ -123,16 +134,16 @@ struct teo_bin {
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
  * @state_bins: Idle state data bins for this CPU.
  * @total: Grand total of the "intercepts" and "hits" mertics for all bins.
- * @interval_idx: Index of the most recent saved idle interval.
- * @intervals: Saved idle duration values.
+ * @next_recent_idx: Index of the next @recent_idx entry to update.
+ * @recent_idx: Indices of bins corresponding to recent "intercepts".
  */
 struct teo_cpu {
 	s64 time_span_ns;
 	s64 sleep_length_ns;
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
-	int interval_idx;
-	u64 intervals[INTERVALS];
+	int next_recent_idx;
+	int recent_idx[NR_RECENT];
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -201,26 +212,29 @@ static void teo_update(struct cpuidle_dr
 		}
 	}
 
+	i = cpu_data->next_recent_idx++;
+	if (cpu_data->next_recent_idx >= NR_RECENT)
+		cpu_data->next_recent_idx = 0;
+
+	if (cpu_data->recent_idx[i] >= 0)
+		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
+
 	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
 	 */
-	if (idx_timer == idx_duration)
+	if (idx_timer == idx_duration) {
 		cpu_data->state_bins[idx_timer].hits += PULSE;
-	else
+		cpu_data->recent_idx[i] = -1;
+	} else {
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;
+		cpu_data->state_bins[idx_duration].recent++;
+		cpu_data->recent_idx[i] = idx_duration;
+	}
 
 	cpu_data->total += PULSE;
-
-	/*
-	 * Save idle duration values corresponding to non-timer wakeups for
-	 * pattern detection.
-	 */
-	cpu_data->intervals[cpu_data->interval_idx++] = measured_ns;
-	if (cpu_data->interval_idx >= INTERVALS)
-		cpu_data->interval_idx = 0;
 }
 
 static bool teo_time_ok(u64 interval_ns)
@@ -271,10 +285,13 @@ static int teo_select(struct cpuidle_dri
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
+	unsigned int idx_recent_sum = 0;
+	unsigned int recent_sum = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
+	bool alt_intercepts, alt_recent;
 	ktime_t delta_tick;
 	s64 duration_ns;
 	int i;
@@ -317,6 +334,7 @@ static int teo_select(struct cpuidle_dri
 		 */
 		intercept_sum += prev_bin->intercepts;
 		hit_sum += prev_bin->hits;
+		recent_sum += prev_bin->recent;
 
 		if (dev->states_usage[i].disable)
 			continue;
@@ -336,6 +354,7 @@ static int teo_select(struct cpuidle_dri
 
 		idx_intercept_sum = intercept_sum;
 		idx_hit_sum = hit_sum;
+		idx_recent_sum = recent_sum;
 	}
 
 	/* Avoid unnecessary overhead. */
@@ -350,27 +369,36 @@ static int teo_select(struct cpuidle_dri
 	 * If the sum of the intercepts metric for all of the idle states
 	 * shallower than the current candidate one (idx) is greater than the
 	 * sum of the intercepts and hits metrics for the candidate state and
-	 * all of the deeper states, the CPU is likely to wake up early, so find
-	 * an alternative idle state to select.
+	 * all of the deeper states, or the sum of the numbers of recent
+	 * intercepts over all of the states shallower than the candidate one
+	 * is greater than a half of the number of recent events taken into
+	 * account, the CPU is likely to wake up early, so find an alternative
+	 * idle state to select.
 	 */
-	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
+	alt_intercepts = 2 * idx_intercept_sum > cpu_data->total - idx_hit_sum;
+	alt_recent = idx_recent_sum > NR_RECENT / 2;
+	if (alt_recent || alt_intercepts) {
 		s64 last_enabled_span_ns = duration_ns;
 		int last_enabled_idx = idx;
 
 		/*
 		 * Look for the deepest idle state whose target residency had
 		 * not exceeded the idle duration in over a half of the relevant
-		 * cases in the past.
+		 * cases (both with respect to intercepts overall and with
+		 * respect to the recent intercepts only) in the past.
 		 *
 		 * Take the possible latency constraint and duration limitation
 		 * present if the tick has been stopped already into account.
 		 */
 		intercept_sum = 0;
+		recent_sum = 0;
 
 		for (i = idx - 1; i >= idx0; i--) {
+			struct teo_bin *bin = &cpu_data->state_bins[i];
 			s64 span_ns;
 
-			intercept_sum += cpu_data->state_bins[i].intercepts;
+			intercept_sum += bin->intercepts;
+			recent_sum += bin->recent;
 
 			if (dev->states_usage[i].disable)
 				continue;
@@ -386,7 +414,9 @@ static int teo_select(struct cpuidle_dri
 				break;
 			}
 
-			if (2 * intercept_sum > idx_intercept_sum) {
+			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
+			    (!alt_intercepts ||
+			     2 * intercept_sum > idx_intercept_sum)) {
 				idx = i;
 				duration_ns = span_ns;
 				break;
@@ -404,49 +434,6 @@ static int teo_select(struct cpuidle_dri
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
-	if (idx > idx0) {
-		unsigned int count = 0;
-		u64 sum = 0;
-
-		/*
-		 * The target residencies of at least two different enabled idle
-		 * states are less than or equal to the current expected idle
-		 * duration.  Try to refine the selection using the most recent
-		 * measured idle duration values.
-		 *
-		 * Count and sum the most recent idle duration values less than
-		 * the current expected idle duration value.
-		 */
-		for (i = 0; i < INTERVALS; i++) {
-			u64 val = cpu_data->intervals[i];
-
-			if (val >= duration_ns)
-				continue;
-
-			count++;
-			sum += val;
-		}
-
-		/*
-		 * Give up unless the majority of the most recent idle duration
-		 * values are in the interesting range.
-		 */
-		if (count > INTERVALS / 2) {
-			u64 avg_ns = div64_u64(sum, count);
-
-			/*
-			 * Avoid spending too much time in an idle state that
-			 * would be too shallow.
-			 */
-			if (teo_time_ok(avg_ns)) {
-				duration_ns = avg_ns;
-				if (drv->states[idx].target_residency_ns > avg_ns)
-					idx = teo_find_shallower_state(drv, dev,
-								       idx, avg_ns);
-			}
-		}
-	}
-
 end:
 	/*
 	 * Don't stop the tick if the selected state is a polling one or if the
@@ -507,8 +494,8 @@ static int teo_enable_device(struct cpui
 
 	memset(cpu_data, 0, sizeof(*cpu_data));
 
-	for (i = 0; i < INTERVALS; i++)
-		cpu_data->intervals[i] = U64_MAX;
+	for (i = 0; i < NR_RECENT; i++)
+		cpu_data->recent_idx[i] = -1;
 
 	return 0;
 }



