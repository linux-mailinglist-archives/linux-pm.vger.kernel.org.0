Return-Path: <linux-pm+bounces-8692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC198FE211
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9B51C258B1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11715382C;
	Thu,  6 Jun 2024 09:01:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306D153804;
	Thu,  6 Jun 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664504; cv=none; b=TSZ2TXgY0j0E2o8bAf4uPVTQRlo6mBG5/jyFJKs1W13NnYO5N7xuNxVJMiV0NuOSBflFN1x2jC4V1+mNnOedp+kbgkANQ1UGzJluHQvgbMtR/Wtz4wrta64jBQWPQVUo5yC84O0MGpfMFIi29g3y7LM+FqHcEbw2IRYUBbWBgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664504; c=relaxed/simple;
	bh=TpL6sIDxNCxPOYFSOiFcpIYT05cQUxQbaQzGEKLNkG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvzo1k5ENbvfyrF6Ri1zSEUXOahsHu77cWf7rUyP428204GN4flTmDxOLDeBITEI3d4cZQBPGCuUhguR+RFVtQ7IPDQc+aK38vZ9zfiyfXwQ6mHHM0rwrf8Vqun1KYnNhl+YkpKq3FCCI7d57QJ8qnQLHwTlTMmCg+6/XYXEfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADE01339;
	Thu,  6 Jun 2024 02:02:06 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.71.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A29E3F762;
	Thu,  6 Jun 2024 02:01:39 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	anna-maria@linutronix.de,
	kajetan.puchalski@arm.com,
	lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 6/6] cpuidle: teo: Don't count non-existent intercepts
Date: Thu,  6 Jun 2024 10:00:50 +0100
Message-Id: <20240606090050.327614-7-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606090050.327614-1-christian.loehle@arm.com>
References: <20240606090050.327614-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bailing out early, teo will not query the sleep length anymore
since commit 6da8f9ba5a87 ("cpuidle: teo:
Skip tick_nohz_get_sleep_length() call in some cases") with an
expected sleep_length_ns value of KTIME_MAX.
This lead to state0 accumulating lots of 'intercepts' because
the actually measured sleep length was < KTIME_MAX, so count KTIME_MAX
as a hit (we have to count them as something otherwise we are stuck).

Fundamentally we can only do one of the two:
1. Skip sleep_length_ns query when we think intercept is likely
2. Have accurate data if sleep_length_ns is actually intercepted when
we believe it is currently intercepted.

This patch chooses that latter as I've found the additional time it
takes to query the sleep length to be negligible and the variants of
option 1 (count all unknowns as misses or count all unknown as hits)
had significant regressions (as misses had lots of too shallow idle
state selections and as hits had terrible performance in
intercept-heavy workloads).

Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 3f4801d1e797..f41788ff0a94 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -288,8 +288,13 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * length, this is a "hit", so update the "hits" metric for that bin.
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
+	 * If teo_select() bailed out early, we have to count this as a hit as
+	 * we don't know what the true sleep length would've been. Otherwise
+	 * we accumulate lots of intercepts at the shallower state (especially
+	 * state0) even though there weren't any intercepts due to us
+	 * anticipating one.
 	 */
-	if (idx_timer == idx_duration)
+	if (idx_timer == idx_duration || cpu_data->sleep_length_ns == KTIME_MAX)
 		cpu_data->state_bins[idx_timer].hits += PULSE;
 	else
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;
@@ -349,6 +354,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
+	int prev_intercept_idx;
 	bool cpu_utilized;
 	s64 duration_ns;
 	int i;
@@ -463,6 +469,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * all of the deeper states a shallower idle state is likely to be a
 	 * better choice.
 	 */
+	prev_intercept_idx = idx;
 	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
 		int first_suitable_idx = idx;
 
@@ -514,6 +521,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			first_suitable_idx = i;
 		}
 	}
+	if (prev_intercept_idx != idx && !idx) {
+		/*
+		 * We have to query the sleep length here otherwise we don't
+		 * know after wakeup if our guess was correct.
+		 */
+		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
+		cpu_data->sleep_length_ns = duration_ns;
+	}
 
 	/*
 	 * If there is a latency constraint, it may be necessary to select an
-- 
2.34.1


