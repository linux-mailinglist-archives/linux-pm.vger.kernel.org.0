Return-Path: <linux-pm+bounces-8687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EE78FE205
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05C21F27B5F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0114E2F7;
	Thu,  6 Jun 2024 09:01:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F713D2A0;
	Thu,  6 Jun 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664478; cv=none; b=cHC0fo7mqU9czQcbTTWj/zd2VPPeDwGyhzPriKTwXKfI4kjheISjSECp+xs57EdJWKaLLaQfpSaKcbo+bKnJ2MJwbp6SR4XX7xkU7gh1CxM8GVPRJqDFRt8ChR1cY9pRZwsjPWt2pH8Ddni7zIEAHooXAGJQWYMSbJnhm3YubPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664478; c=relaxed/simple;
	bh=gPB/hPlo8TMgrOoFRBHzJovmHAJH3zJeXXoyccgpjsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0pRyPRTPCSbtEk5w88fX/InWjhK/ecHWed8ICe55RzCpmng0UQJ223lAtURh9lb4/Ht9/5JwD/akRnMf2EO480jN3edRvOWz9fcgdi63knWvEit0B6h9+slY6bx7QQ3/PWP1C0AnLNhhEH7r0KFqrH9EhGbhwF/CeHAP8XC6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602CC339;
	Thu,  6 Jun 2024 02:01:40 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.71.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D6D73F762;
	Thu,  6 Jun 2024 02:01:13 -0700 (PDT)
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
Subject: [PATCH 1/6] cpuidle: teo: Increase util-threshold
Date: Thu,  6 Jun 2024 10:00:45 +0100
Message-Id: <20240606090050.327614-2-christian.loehle@arm.com>
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

Increase the util-threshold by a lot as it was low enough for some
minor load to always be active, especially on smaller CPUs.

For small cap CPUs (Pixel6) the util threshold is as low as 1.
For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.

Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
Reported-by: Qais Yousef <qyousef@layalina.io>
Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7244f71c59c5..45f43e2ee02d 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -146,13 +146,11 @@
  * The number of bits to shift the CPU's capacity by in order to determine
  * the utilized threshold.
  *
- * 6 was chosen based on testing as the number that achieved the best balance
- * of power and performance on average.
- *
  * The resulting threshold is high enough to not be triggered by background
- * noise and low enough to react quickly when activity starts to ramp up.
+ * noise.
  */
-#define UTIL_THRESHOLD_SHIFT 6
+#define UTIL_THRESHOLD_SHIFT 2
+#define UTIL_THRESHOLD_MIN 50
 
 /*
  * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
@@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
 	int i;
 
 	memset(cpu_data, 0, sizeof(*cpu_data));
-	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
+	cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
+				max_capacity >> UTIL_THRESHOLD_SHIFT);
 
 	for (i = 0; i < NR_RECENT; i++)
 		cpu_data->recent_idx[i] = -1;
-- 
2.34.1


