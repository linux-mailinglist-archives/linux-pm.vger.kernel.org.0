Return-Path: <linux-pm+bounces-40880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FDBD2116C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81E6730407DA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDAD2D73AE;
	Wed, 14 Jan 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlKR9QHp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F2A41;
	Wed, 14 Jan 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420125; cv=none; b=B6obMadHshk8QCgm7ZBb7N7yvehP6sVqXrx3HjJZUIX6eTRX5yUeKT4MPEKNhO7ZQ+p8OvTu3/BmTwYbZojtnjhyNlQssOrrp7Urnomo7i+qlx3xTSpjqOoBInxwE4FrZzRonK098T3wYf40OMUWzTFosgSQLRHVGDHVJA7cua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420125; c=relaxed/simple;
	bh=JYal1LHhF3Uxoy6NE/Qt8YDegA7c0ntG5a9eXA+X9KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu7KiR6TuwDZXQ8PJahQppRav9g5doqPpXH58CIrztp1F6gyLrJ/y5HgmqezWSJWpN0/qrpfb4bo7WzQkcXg6HA9WUc/8yjOD0J/OLmlk735EzVSa8v7NG/uN8O+Zh/1oTMi/ik4N7K09BCRJ9eeLXDh8N2H1LVjzjBQE8jkhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlKR9QHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F63C19421;
	Wed, 14 Jan 2026 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420125;
	bh=JYal1LHhF3Uxoy6NE/Qt8YDegA7c0ntG5a9eXA+X9KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlKR9QHpbUyYCzv6yggdfqnAcqRvZwK48Mz9EX+fmvwNiJ97SK8uVQ4b5p5BdFA7m
	 iO4XS0QoFULC3TLNsYlXhe2hFcLojKHEFPly2BMcn2xPNZnBKzqeTvEiCJ7b0S6a2v
	 9RIPsPRFl1IZKryh8hKAe7eFvt4tTPnw4EFnL1oDnYpm9ryMKZIgOg9OGoaImb4ewi
	 YwvZ3UmyHYA/nASy2183Dj9nGksMPYghY/51rQ3+XVi9qw5L/YbJj0uRE73P4rNEqQ
	 wI4oBKJFcJMrSK0H2Q98n3RO25ce0/aVCAr8kKeh4axaunJyybCaWtfB8LenWP2qcm
	 r5O3YwUd9x3uw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1 4/5] cpuidle: governors: teo: Adjust the classification of wakeup
 events
Date: Wed, 14 Jan 2026 20:46:12 +0100
Message-ID: <2033689.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2257365.irdbgypaU6@rafael.j.wysocki>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If differences between target residency values of adjacent idle states
of a given CPU are relatively large, the corresponding idle state bins
used by the teo governors are large either and the rule by which hits
are distinguished from intercepts is inaccurate.

Namely, by that rule, a wakeup event is classified as a hit if the
sleep length (the time till the closest timer other than the tick)
and the measured idle duration, adjusted for the entered idle state
exit latency, fall into the same idle state bin.  However, if that bin
is large enough, the actual difference between the sleep length and
the measured idle duration may be significant.  It may in fact be
significantly greater than the analogous difference for an event where
the sleep length and the measured idle duration fall into different
bins.

For this reason, amend the rule in question with a check that will
only allow a wakeup event to be counted as a hit if the difference
between the sleep length and the measured idle duration is less than
LATENCY_THRESHOLD_NS (which means that the difference between the
sleep length and the raw measured idle duration is below the sum of
LATENCY_THRESHOLD_NS and 1/2 of the entered idle state exit latency).
Otherwise, the event will be counted as an intercept.

Moreover, since the above change is likely to cause more intercepts
and fewer hits to be counted than before, at least in some cases, also
adjust the check in teo_select() deciding whether or not to take
intercepts into account at all.  Specifically, remove idx_hit_sum from
the right-hand side of the inequality in that check on the premise that
intercepts previously counted as hits will now be included in
idx_intercept_sum and there is no reason to subtract the remaining
events (that are still counted as hits) from cpu_data->total.  Also
adjust the comment preceding the check in question to reflect that
modification.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -48,13 +48,11 @@
  * in accordance with what happened last time.
  *
  * The "hits" metric reflects the relative frequency of situations in which the
- * sleep length and the idle duration measured after CPU wakeup fall into the
- * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
- * length).  In turn, the "intercepts" metric reflects the relative frequency of
- * non-timer wakeup events for which the measured idle duration falls into a bin
- * that corresponds to an idle state shallower than the one whose bin is fallen
- * into by the sleep length (these events are also referred to as "intercepts"
- * below).
+ * sleep length and the idle duration measured after CPU wakeup are close enough
+ * (that is, the CPU appears to wake up "on time" relative to the sleep length).
+ * In turn, the "intercepts" metric reflects the relative frequency of non-timer
+ * wakeup events for which the measured idle duration is measurably less than
+ * the sleep length (these events are also referred to as "intercepts" below).
  *
  * The governor also counts "intercepts" with the measured idle duration below
  * the tick period length and uses this information when deciding whether or not
@@ -253,12 +251,16 @@ static void teo_update(struct cpuidle_dr
 	}
 
 	/*
-	 * If the measured idle duration falls into the same bin as the sleep
-	 * length, this is a "hit", so update the "hits" metric for that bin.
+	 * If the measured idle duration falls into the same bin as the
+	 * sleep length and the difference between them is less than
+	 * LATENCY_THRESHOLD_NS, this is a "hit", so update the "hits"
+	 * metric for that bin.
+	 *
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
 	 */
-	if (idx_timer == idx_duration) {
+	if (idx_timer == idx_duration &&
+	    cpu_data->sleep_length_ns - measured_ns < LATENCY_THRESHOLD_NS) {
 		cpu_data->state_bins[idx_timer].hits += PULSE;
 	} else {
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;
@@ -381,13 +383,11 @@ static int teo_select(struct cpuidle_dri
 	}
 
 	/*
-	 * If the sum of the intercepts metric for all of the idle states
-	 * shallower than the current candidate one (idx) is greater than the
-	 * sum of the intercepts and hits metrics for the candidate state and
-	 * all of the deeper states, a shallower idle state is likely to be a
-	 * better choice.
+	 * If intercepts in the range below the target residency of the current
+	 * candidate state are the majority of all wakeups, a shallower state is
+	 * likely to be a better choice.
 	 */
-	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
+	if (2 * idx_intercept_sum > cpu_data->total) {
 		int min_idx = idx0;
 
 		if (tick_nohz_tick_stopped()) {




