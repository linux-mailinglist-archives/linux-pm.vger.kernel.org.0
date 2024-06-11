Return-Path: <linux-pm+bounces-8941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCE9039FC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE95C285B8D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D1517C7A4;
	Tue, 11 Jun 2024 11:24:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533F17C22B;
	Tue, 11 Jun 2024 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105081; cv=none; b=AOk7FE1Hd8VStnxvmFcDuWcX8j0/8jJqK3QEbSYNh/i78tNp1cD2kBQWq7blPSGrwXxi/AznM4hKddB2GuHAP8vLidjtdYYkKzK1JP0NagY/j/gWSG7V8CuizKnTFBIJKC2AaGqI3fhNnt969KTztH54jE9uzo/tHXExKcR8q3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105081; c=relaxed/simple;
	bh=fHD5oPENUsfVgGeH0bAFr+9+RB6uqV+WC51G1sQTKQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=po8IyVNuuE9Y34eE83MQ5uOSljenUW9fNCpGuIxvWU5T6D0JxmmzYDYFsmPsOGi+cLP0po+tOY36tQOoUKsKY85SvKP3BIftkDmJFDfn7nYTzYcAONN69berK6EcWq6jMfF8E6ujrZVjrKyEO1M625wKY4hnCTWbw0RwzypxktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F265152B;
	Tue, 11 Jun 2024 04:25:03 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.32.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB22F3F64C;
	Tue, 11 Jun 2024 04:24:35 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	ulf.hansson@linaro.org,
	anna-maria@linutronix.de,
	kajetan.puchalski@arm.com,
	lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2 3/3] cpuidle: teo: Don't count non-existent intercepts
Date: Tue, 11 Jun 2024 12:24:13 +0100
Message-Id: <20240611112413.1241352-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611112413.1241352-1-christian.loehle@arm.com>
References: <20240611112413.1241352-1-christian.loehle@arm.com>
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
as a hit (we have to count them as something otherwise we are stuck)
and therefore teo taking too long to recover from intercept-heavy
scenarios.

Fundamentally we can only do one of the two:
1. Skip sleep_length_ns query when we think intercept is likely
2. Have accurate data if sleep_length_ns is actually intercepted when
we believe it is currently intercepted.

This patch chooses the latter as I've found the additional time it
takes to query the sleep length to be negligible and the variants of
option 1 (count all unknowns as misses or count all unknown as hits)
had significant regressions (as misses had lots of too shallow idle
state selections and as hits had terrible performance in
intercept-heavy workloads).

Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index cc7df59f488d..1e4b40474f49 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -231,8 +231,13 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
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
@@ -292,7 +297,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
-	bool alt_intercepts, alt_recent;
+	int prev_intercept_idx;
 	s64 duration_ns;
 	int i;
 
@@ -370,6 +375,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * all of the deeper states a shallower idle state is likely to be a
 	 * better choice.
 	 */
+	prev_intercept_idx = idx;
 	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
 		int first_suitable_idx = idx;
 
@@ -421,6 +427,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			first_suitable_idx = i;
 		}
 	}
+	if (!idx && prev_intercept_idx) {
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


