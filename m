Return-Path: <linux-pm+bounces-35152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8306EB91475
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B223422ADF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB2309F08;
	Mon, 22 Sep 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="M+vrnbNT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC8288C24;
	Mon, 22 Sep 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546092; cv=none; b=SNUDwuHBcrBw1KKiw9Wn/Pz/wOr//Stv9HcIskmNXbLRkQwFv/+N9QuxfX0OdQhpwd9EBD4DX/UAacyq1gknKNKmM2sx0c5Svlyp4Xkt2ia12X4owa8WF1e9L92zvwsuTeEd4tzBb8MKNhhhP5gKF5frA68f24kyvO7O8m/pN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546092; c=relaxed/simple;
	bh=39MXPULtnQpLPowbOXB8BTSaKyc0RVXPG67R7milupw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSwPjEdSt3Z8M9cUQGPsyXH1XM4OFXQ7Ziya9qIeunHOTZKlGSbnJZY1KjzYkTfuGYhxgdQJnQS/HyhFsZ6vJY9kbwtxNdlea/vTjanR9t8lAk4UZ5qjFVENeswlvbuA3ioQWGLkxiwIJzqshwy/4tqiu47a38jNw0N8bCz07YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=M+vrnbNT; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mP
	L4dda7cCLCvc6M0sl4DX1CFnt3sTxBX7BsAwf8coI=; b=M+vrnbNTCWg2hXeJCG
	aH5DfOUOtqxbYNGAv2ot0Bx8jCK1WDaDw00TFTROXnyxLoH+cp9iDEXOiq96Ro+L
	6W5k5luCg+j3fOytsobUbp4YAQJRH1fUvqHKpuL1pm5rI+wMReeAzlFwU8YchLjy
	zmpn2PNisWXxkUh/A4F7UZoLo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3nyRMSNFo42AXBQ--.30063S2;
	Mon, 22 Sep 2025 20:59:56 +0800 (CST)
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default transition latency
Date: Mon, 22 Sep 2025 20:59:21 +0800
Message-ID: <20250922125929.453444-1-shawnguo2@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3nyRMSNFo42AXBQ--.30063S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr15GF13CF1fuF1xtrWUArb_yoW5XF4xpF
	W5uw42yw4kJayvqwnFka18u34Fqa1DAry2ka4UWwnYvw43A3ZYq3WDKrW5tFZ5Aw4kGa1U
	ZFyDA39rWF48ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcUUUUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhrQZWjRRUkGtwAAs5

From: Shawn Guo <shawnguo@kernel.org>

A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
due to that platform's DT doesn't provide the optional property
'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
platforms, because the default transition delay was dropped by the commits
below.

  commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
  commit a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
  commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")

It slows down dbs governor's reacting to CPU loading change
dramatically.  Also, as transition_delay_us is used by schedutil governor
as rate_limit_us, it shows a negative impact on device idle power
consumption, because the device gets slightly less time in the lowest OPP.

Fix the regressions by defining a default transition latency for
handling the case of CPUFREQ_ETERNAL.

Cc: stable@vger.kernel.org
Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
Changes for v2:
- Follow Rafael's suggestion to define a default transition latency for
  handling CPUFREQ_ETERNAL, and pave the way to get rid of
  CPUFREQ_ETERNAL completely later.

v1: https://lkml.org/lkml/2025/9/10/294

 drivers/cpufreq/cpufreq.c | 3 +++
 include/linux/cpufreq.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..c69d10f0e8ec 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -549,6 +549,9 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 	if (policy->transition_delay_us)
 		return policy->transition_delay_us;
 
+	if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
+		policy->cpuinfo.transition_latency = CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;
+
 	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
 	if (latency)
 		/* Give a 50% breathing room between updates */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f3807c8c55..935e9a660039 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -36,6 +36,8 @@
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
 
+#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 struct cpufreq_governor;
 
 enum cpufreq_table_sorting {
-- 
2.43.0


