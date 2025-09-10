Return-Path: <linux-pm+bounces-34337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02076B50EB0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE41164803
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 07:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE92C11F1;
	Wed, 10 Sep 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="FGTa1YfD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEC1798F;
	Wed, 10 Sep 2025 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487859; cv=none; b=hgxVeHzeFRtgVSjr5friIKSgZ7MBNvDRgl47p/DVvUVQuOqaT9rS71kuqSNcbe8s2H8kZNORsoYJIxUwWR+6yY9YOU7ielwnvMm5m4a1zpUgaW6trZMvaCWSouw9Vs5Cg8ZHGj4f7Qo8w9YuTcmp9Zy2v76zKc+zYv9HHdydyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487859; c=relaxed/simple;
	bh=zM3tYwg3Esfkyecquj5JgIVI41Ms90wXl7Y4pNYPqPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPD5byMNHJ5wkvYisn31o6lMTF4DmWWP9jxx3zdDQ0kqmRSl2guwwDfYvjAoZrl0LAZjbstM3qhuMBKxmOZIwkgG4YzJ7R1y4jY2rRAcRV5T4qbagr/TZjoJlmYKK/G5GPPvfiVVPmWXpnOY+vZVRTnD1DDdoVLKhJzZwi9KJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=FGTa1YfD; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5Z
	ZPzeDrpMYxgza36PsQIam3kvrpjmthexLESEAuMpY=; b=FGTa1YfDvwqofxGC2V
	Vu+jHroYvAKZp2+GibLSM6Xem2Ss/GVhEqNjQ0tF9rromIc03viww0F112QNTR5f
	6SBadZFv/OVvYtYr2wiSIDZIolm3ss3tF5+CZJcwZTjNsKq4KeMXq0SStY9DJcOi
	5D7F9Cm1DOiuV4eIaFuPxJ/to=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBHu3tdIMFoTs1DBA--.44176S2;
	Wed, 10 Sep 2025 14:53:18 +0800 (CST)
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: cap the default transition delay at 10 ms
Date: Wed, 10 Sep 2025 14:53:12 +0800
Message-ID: <20250910065312.176934-1-shawnguo2@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgBHu3tdIMFoTs1DBA--.44176S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4UKw48Aw4UZF4UWr13CFg_yoW8urykpF
	W5W3y2yr18Xa1ktws2vw48u34Fva1DA34akFyjkwnYv3y3J3ZYvF1UKFWUKrZ5Zr4DGan0
	qF1jy3ZrJF48Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtwIgUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgDEZWjA+a16GgAAsv

From: Shawn Guo <shawnguo@kernel.org>

A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
due to that platform's DT doesn't provide the optional property
'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
platforms, because that the 10 ms cap for transition_delay_us was
accidentally dropped by the commits below.

  commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
  commit a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
  commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")

It slows down dbs governor's reacting to CPU loading change
dramatically.  Also, as transition_delay_us is used by schedutil governor
as rate_limit_us, it shows a negative impact on device idle power
consumption, because the device gets slightly less time in the lowest OPP.

Fix the regressions by adding the 10 ms cap on transition delay back.

Cc: stable@vger.kernel.org
Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..36e0c85cb4e0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -551,8 +551,13 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 
 	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
 	if (latency)
-		/* Give a 50% breathing room between updates */
-		return latency + (latency >> 1);
+		/*
+		 * Give a 50% breathing room between updates.
+		 * And cap the transition delay to 10 ms for platforms
+		 * where the latency is too high to be reasonable for
+		 * reevaluating frequency.
+		 */
+		return min(latency + (latency >> 1), 10 * MSEC_PER_SEC);
 
 	return USEC_PER_MSEC;
 }
-- 
2.43.0


