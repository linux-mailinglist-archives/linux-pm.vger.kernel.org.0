Return-Path: <linux-pm+bounces-41730-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCSpBaHIe2n5IQIAu9opvQ
	(envelope-from <linux-pm+bounces-41730-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:52:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB1B45C8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2571130297BD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D535A92B;
	Thu, 29 Jan 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joi/Rwfb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C513587BB;
	Thu, 29 Jan 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719944; cv=none; b=qWUlTliu3gx/1eVa88cs7NjqZ9SAZp7FJW1tyad2MCSebDhvRhSOLUScLQWbN0v1LzSVzjDM31bsiV1cX/PfhcueYxQXcUCGGbEmX5ZcicageOlWKrVv1xbELjgvaPcHfSxWMX1+JK9K6QTw+VswOjd//mVNixgmHIUzAEW4qQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719944; c=relaxed/simple;
	bh=/t4zdbI5HR5X97cGbXWP2RIM8+8+6YNuocWktiW/olA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRyud/1g4eU0BwstzjAAUVBG0mtPnhCZbmfcI6Ya3zctKCHu6sxj5rforciWSAYXCkAbtAT4TQKectLsxYbJ5KLJyS7NlThrUdiRtdK6kHSY8sr+uGtCP6KR5j1/0qFH/D79HZAeg7LUkyubay9Mog3DC2/NQKIZjUYuDnmtQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Joi/Rwfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5343C4CEF7;
	Thu, 29 Jan 2026 20:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769719943;
	bh=/t4zdbI5HR5X97cGbXWP2RIM8+8+6YNuocWktiW/olA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Joi/Rwfb188jf22Z1JmTKFFV5w8d/RHwI8T8BlnkbuVFaF+ffe0LMIvOBhN5BTpG2
	 dDu4FbTMf1FwWgPVQo3SAmxPfVmw7AFWAohOj/W9LBPKSphPE2b+TupjxUP84Wy4RY
	 9PfFJTXY8eUOQyp3RkIbdVl0Lr30k1xPaWN9cekn/ByMISbC39Xu0A2qP4HHAdWO/9
	 WEEdrKkKds5Bu+ETjc0hEjX74FfYknwgl9j1FoIjXcoIygszxI/DpD47zr4Rnq/wwE
	 5Tn5vuYnrN3ntWXrNXZW2PxP09bKfpXoFaGnVm29InfdoPhzqTa6kSaJzxT6ohCxO/
	 VQsvWL9Xi3M/g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 1/2] cpuidle: governors: teo: Adjust the classification of wakeup
 events
Date: Thu, 29 Jan 2026 21:49:12 +0100
Message-ID: <5093379.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12846604.O9o76ZdvQC@rafael.j.wysocki>
References: <12846604.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41730-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CBB1B45C8
X-Rspamd-Action: no action

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

For this reason, amend the rule in question with a check that will only
allow a wakeup event to be counted as a hit if the sleep length is less
than the "raw" measured idle duration (which means that the wakeup
appears to have occurred after the anticipated timer event).  Otherwise,
the event will be counted as an intercept.

Also update the documentation part explaining the difference between
"hits" and "intercepts" to take the above change into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Use 1/2 of the entered state exit latency instead of a constant
     margin in the inequality driving the classification (Christian).
   * Update code comments and the changelog.

v1.1 -> v2: No changes

v1 -> v1.1
   * Drop the change in teo_select() along with the corresponding
     part of the changelog (after receiving testing feedback from
     Christian)

---
 drivers/cpuidle/governors/teo.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -48,12 +48,11 @@
  * in accordance with what happened last time.
  *
  * The "hits" metric reflects the relative frequency of situations in which the
- * sleep length and the idle duration measured after CPU wakeup fall into the
- * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
- * length).  In turn, the "intercepts" metric reflects the relative frequency of
- * non-timer wakeup events for which the measured idle duration falls into a bin
- * that corresponds to an idle state shallower than the one whose bin is fallen
- * into by the sleep length (these events are also referred to as "intercepts"
+ * sleep length and the idle duration measured after CPU wakeup are close enough
+ * (that is, the CPU appears to wake up "on time" relative to the sleep length).
+ * In turn, the "intercepts" metric reflects the relative frequency of non-timer
+ * wakeup events for which the measured idle duration is significantly different
+ * from the sleep length (these events are also referred to as "intercepts"
  * below).
  *
  * The governor also counts "intercepts" with the measured idle duration below
@@ -167,6 +166,7 @@ static void teo_decay(unsigned int *metr
  */
 static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
+	s64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
 	struct teo_cpu *cpu_data = this_cpu_ptr(&teo_cpus);
 	int i, idx_timer = 0, idx_duration = 0;
 	s64 target_residency_ns, measured_ns;
@@ -182,8 +182,6 @@ static void teo_update(struct cpuidle_dr
 		 */
 		measured_ns = S64_MAX;
 	} else {
-		s64 lat_ns = drv->states[dev->last_state_idx].exit_latency_ns;
-
 		measured_ns = dev->last_residency_ns;
 		/*
 		 * The delay between the wakeup and the first instruction
@@ -253,12 +251,17 @@ static void teo_update(struct cpuidle_dr
 	}
 
 	/*
-	 * If the measured idle duration falls into the same bin as the sleep
-	 * length, this is a "hit", so update the "hits" metric for that bin.
+	 * If the measured idle duration (adjusted for the entered state exit
+	 * latency) falls into the same bin as the sleep length and the latter
+	 * is less than the "raw" measured idle duration (so the wakeup appears
+	 * to have occurred after the anticipated timer event), this is a "hit",
+	 * so update the "hits" metric for that bin.
+	 *
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
 	 */
-	if (idx_timer == idx_duration) {
+	if (idx_timer == idx_duration &&
+	    cpu_data->sleep_length_ns - measured_ns < lat_ns / 2) {
 		cpu_data->state_bins[idx_timer].hits += PULSE;
 	} else {
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;




