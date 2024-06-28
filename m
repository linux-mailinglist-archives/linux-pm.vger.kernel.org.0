Return-Path: <linux-pm+bounces-10185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6191BC1E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69783284408
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779D154434;
	Fri, 28 Jun 2024 10:02:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBA4155A56;
	Fri, 28 Jun 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568941; cv=none; b=q4WW5lulrjVZbPmNmUHghcsvIZ3wxZ4gpbsjytHKmTPCmvH98oB/QugWg7Tc4RmEQoSUTEvkU5Lb3rukbBTp6Bgo9LtUbJK18mYmhfQUvv4aDo6s7fYbaOpyMnOAZlI2Y1da/6pQYcnlhdpIslURnzsPN773bxkgAiXto8Xhbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568941; c=relaxed/simple;
	bh=29kCV+CJLP8fntZRWSEc1dp7bszj8uq+wEEOZDlnIhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOFxUiYcgGoGyMnfBTlElVObqHVd8ldBfRvwlLZnbALGoS2lLvrbTtpSTJWcHS8ZrmhbZ0+PmwhA/HfsJ0Xv5gzyR4ZHM7bYPQK0g+IjvKBAu7kcrfqJGmhx53vPhGexXTY/9b4SAz+ZDuxocV4j/2HdvqpQ/bTXn/2OLFw0nhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4A0106F;
	Fri, 28 Jun 2024 03:02:44 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.30.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BE753F6A8;
	Fri, 28 Jun 2024 03:02:15 -0700 (PDT)
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
	dsmythies@telus.net,
	kajetan.puchalski@arm.com,
	lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 3/3] cpuidle: teo: Don't count non-existent intercepts
Date: Fri, 28 Jun 2024 10:59:55 +0100
Message-Id: <20240628095955.34096-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628095955.34096-1-christian.loehle@arm.com>
References: <20240628095955.34096-1-christian.loehle@arm.com>
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
v3:
Drop counting KTIME_MAX as hit and reword commit accordingly

 drivers/cpuidle/governors/teo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 200a3598cbcf..c2d73507d23b 100644
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

@@ -415,6 +417,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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


