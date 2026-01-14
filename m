Return-Path: <linux-pm+bounces-40879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A548DD21166
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7889830239C4
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3512F1FEC;
	Wed, 14 Jan 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="actvCBZa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BD2D5410;
	Wed, 14 Jan 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420121; cv=none; b=iOeh10Dw0OdmF1ytDzto8Hhl1W6Ro9rHrjSXInImOKVgqHKWru/al8JfBvVo834LFAkEK07MVxO31VcDdfZm+vsd1Nznz8IqFh8cdTsPZbZLE9uvEJLu9hcJSpPJGYyhAUl+mZ2Iv3THtz7XMwvrTZiF7pxhYKAWTjtl4JGGOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420121; c=relaxed/simple;
	bh=fBPAsJpQifTNlT3+4XiMZYA6irZ2Pe4hZRZtId3buP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGmaYsRnBy+Jcri01V9v6VuQw2XKT8aGmBsH4gKx+a7FU/GuxBpCpA3P4CKurWAOIfdql+a3z+JcVDo/TFohHQeNJKLCIjANec+xiFotCGMnPK242wTfvfoc+GCzNgd3OV9eYqtps/mq+E2AjTZgWttKmGTYYAFL4sow7KzhD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=actvCBZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F711C4CEF7;
	Wed, 14 Jan 2026 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420120;
	bh=fBPAsJpQifTNlT3+4XiMZYA6irZ2Pe4hZRZtId3buP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=actvCBZa9Vt3gxaGYzptEZ3Ur1z4OELcFQlhnYNXuPc4niyU1dqh6hv/vL94Bpwd4
	 7cEJxsNSkN8iulJxtKSqIXkO6aVwCvzmZ0SjuiGGoA0rbjNU6sPERJhDKcoyiG0dXB
	 ZHLvsNZnAddsJ1EpHdhstS9VgTcdI0VwPTiuDO1yXD6dj3ZuVDg1308NJKkxyCTTRp
	 aJWVAuSETTYKvwZrvXfUyHxMmsTMZEipxV7DXFGe6J0ZK92AL52KeO1hiXjUTnS08O
	 fJJ+IY14k91jJsKoRov4DafXrt8xnL38VlOhBJtSGMxk3oXoI2K9t2ImgO3tQFgGRh
	 xiJ11xOIdIZfg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1 5/5] cpuidle: governors: teo: Refine intercepts-based idle state
 lookup
Date: Wed, 14 Jan 2026 20:47:09 +0100
Message-ID: <3931434.kQq0lBPeGt@rafael.j.wysocki>
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

There are cases in which decisions made by the teo governor are
arguably overly conservative.

For instance, suppose that there are 4 idle states and the values of
the intercepts metric for the first 3 of them are 400, 250, and 251,
respectively.  If the total sum computed in teo_update() is 1000, the
governor will select idle state 1 (provided that all idle states are
enabled and the scheduler tick has not been stopped) although arguably
idle state 0 would be a better choice because the likelihood of getting
an idle duration below the target residency of idle state 1 is greater
than the likelihood of getting an idle duration between the target
residency of idle state 1 and the target residency of idle state 2.

To address this, refine the candidate idle state lookup based on
intercepts to start at the state with the maximum intercepts metric,
below the deepest enabled one, to avoid the cases in which the search
may stop before reaching that state.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   46 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -73,12 +73,17 @@
  *      than the candidate one (it represents the cases in which the CPU was
  *      likely woken up by a non-timer wakeup source).
  *
+ *    Also find the idle state with the maximum intercepts metric (if there are
+ *    multiple states with the maximum intercetps metric, choose the one with
+ *    the highest index).
+ *
  * 2. If the second sum computed in step 1 is greater than a half of the sum of
  *    both metrics for the candidate state bin and all subsequent bins (if any),
  *    a shallower idle state is likely to be more suitable, so look for it.
  *
  *    - Traverse the enabled idle states shallower than the candidate one in the
- *      descending order.
+ *      descending order, starting at the state with the maximum intercepts
+ *      metric found in step 1.
  *
  *    - For each of them compute the sum of the "intercepts" metrics over all
  *      of the idle states between it and the candidate one (including the
@@ -306,9 +311,12 @@ static int teo_select(struct cpuidle_dri
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	ktime_t delta_tick = TICK_NSEC / 2;
 	unsigned int idx_intercept_sum = 0;
+	unsigned int intercept_max_sum = 0;
 	unsigned int intercept_sum = 0;
+	unsigned int intercept_max = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
+	int intercept_max_idx = -1;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	s64 duration_ns;
@@ -339,17 +347,33 @@ static int teo_select(struct cpuidle_dri
 	if (!dev->states_usage[0].disable)
 		idx = 0;
 
-	/* Compute the sums of metrics for early wakeup pattern detection. */
+	/*
+	 * Compute the sums of metrics for early wakeup pattern detection and
+	 * look for the state bin with the maximum intercepts metric below the
+	 * deepest enabled one (if there are multiple states with the maximum
+	 * intercepts metric, choose the one with the highest index).
+	 */
 	for (i = 1; i < drv->state_count; i++) {
 		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
+		unsigned int prev_intercepts = prev_bin->intercepts;
 		struct cpuidle_state *s = &drv->states[i];
 
 		/*
 		 * Update the sums of idle state metrics for all of the states
 		 * shallower than the current one.
 		 */
-		intercept_sum += prev_bin->intercepts;
 		hit_sum += prev_bin->hits;
+		intercept_sum += prev_intercepts;
+		/*
+		 * Check if this is the bin with the maximum number of
+		 * intercepts so far and in that case update the index of
+		 * the state with the maximum intercetps metric.
+		 */
+		if (prev_intercepts >= intercept_max) {
+			intercept_max = prev_intercepts;
+			intercept_max_sum = intercept_sum;
+			intercept_max_idx = i - 1;
+		}
 
 		if (dev->states_usage[i].disable)
 			continue;
@@ -411,14 +435,26 @@ static int teo_select(struct cpuidle_dri
 		}
 
 		/*
-		 * Look for the deepest idle state whose target residency had
+		 * If the minimum state index is greater than or equal to the
+		 * index of the state with the maximum intercepts metric, there
+		 * is no need to look at the shallower states.
+		 */
+		if (min_idx >= intercept_max_idx) {
+			idx = min_idx;
+			goto constraint;
+		}
+
+		/*
+		 * Look for the deepest idle state at least as deep as the one
+		 * with the maximum intercetps metric whose target residency had
 		 * not exceeded the idle duration in over a half of the relevant
 		 * cases in the past.
 		 *
 		 * Take the possible duration limitation present if the tick
 		 * has been stopped already into account.
 		 */
-		for (i = idx - 1, intercept_sum = 0; i >= min_idx; i--) {
+		intercept_sum = idx_intercept_sum - intercept_max_sum;
+		for (i = intercept_max_idx; i >= min_idx; i--) {
 			intercept_sum += cpu_data->state_bins[i].intercepts;
 
 			if (dev->states_usage[i].disable)




