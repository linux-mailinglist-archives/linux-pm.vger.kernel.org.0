Return-Path: <linux-pm+bounces-10232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA44091CB9F
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 10:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808501F22718
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jun 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A902F874;
	Sat, 29 Jun 2024 08:22:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E13BBC9;
	Sat, 29 Jun 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719649376; cv=none; b=GFabQH4eSk1StHAd4ad5ia9TuktqtT21S4VJgi5ebCUMkPbDPsGV2TvI28081x4j4xN+oOU/YILbZBaddUB8G2IJ/s+5okkYkb9YlmwlshZD5cWLWs+PWFNpbWT+nYXUvyhLEq9r0JsJIP2NE9jK20n7t73fpi+wYRkDFoIcF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719649376; c=relaxed/simple;
	bh=P8MFF88WFe0wi+HNjE5Y0mEKeKHhp/3xlM7BHh0MSKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gq97fEIJGdStsrZbfipX64fVBdsyv3/2G8tpAS6SN8Se0+7T7sWAHd75/oYxdiwetjNYwLTSeVEDm3mCnw+deHp5pbDv2SDmIOv0Gb3YQRh8H111+r6Pj2Bz4mZuJMkvX+sPTHu5Z3u8U4OmQitysKo4oa2U2RPI8gXFk8eGw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7CD339;
	Sat, 29 Jun 2024 01:23:17 -0700 (PDT)
Received: from [10.1.33.10] (e127648.arm.com [10.1.33.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207403F766;
	Sat, 29 Jun 2024 01:22:49 -0700 (PDT)
Message-ID: <c40acf72-010f-4a8b-80e4-33f133ba266b@arm.com>
Date: Sat, 29 Jun 2024 09:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCHv4 3/3] cpuidle: teo: Don't count non-existent intercepts
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com,
 dietmar.eggemann@arm.com
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <20240628095955.34096-4-christian.loehle@arm.com>
 <CAJZ5v0jaEt2yo9OvYqpzfcbPtAvTk63tKXjm6QCi7zeKuU2SUA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0jaEt2yo9OvYqpzfcbPtAvTk63tKXjm6QCi7zeKuU2SUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When bailing out early, teo will not query the sleep length anymore
since commit 6da8f9ba5a87 ("cpuidle: teo:
Skip tick_nohz_get_sleep_length() call in some cases") with an
expected sleep_length_ns value of KTIME_MAX.
This lead to state0 accumulating lots of 'intercepts' because
the actually measured sleep length was < KTIME_MAX, so query the sleep
length instead for teo to recognize if it still is in an
intercept-likely scenario without alternating between the two modes.

Fundamentally we can only do one of the two:
1. Skip sleep_length_ns query when we think intercept is likely
2. Have accurate data if sleep_length_ns is actually intercepted when
we believe it is currently intercepted.

Previously teo did the former while this patch chooses the latter as
the additional time it takes to query the sleep length was found to be
negligible and the variants of option 1 (count all unknowns as misses
or count all unknown as hits) had significant regressions (as misses
had lots of too shallow idle state selections and as hits had terrible
performance in intercept-heavy workloads).

Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
v4: Skip constraint check if intercept logic selects state0

 drivers/cpuidle/governors/teo.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 200a3598cbcf..6dc44197a80e 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -287,6 +287,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
+	int prev_intercept_idx;
 	s64 duration_ns;
 	int i;
 
@@ -364,6 +365,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * all of the deeper states a shallower idle state is likely to be a
 	 * better choice.
 	 */
+	prev_intercept_idx = idx;
 	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
 		int first_suitable_idx = idx;
 
@@ -415,6 +417,15 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
+		goto out_tick;
+	}
 
 	/*
 	 * If there is a latency constraint, it may be necessary to select an
-- 
2.34.1



