Return-Path: <linux-pm+bounces-20477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F2A11EC7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 11:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1171622B4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE391F9A9F;
	Wed, 15 Jan 2025 10:01:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B8248169;
	Wed, 15 Jan 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935290; cv=none; b=NDiFkkGkQA9QvU2DhoXGFuuREK7WjIi9YTwqnOcGhnW5rif4FtCps1enVh/656I28ezBje47ABthVLaYjiBKCyQa+Qk2uyNsM5oQFmCIE8xmG8S6rlfpzqtTnwcYv86WAZr8maGIGHlOUHU7ouq+veFd0UBXksFEbL/Tb5JbbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935290; c=relaxed/simple;
	bh=VA0netJc+k/lvvdFyG1QlH9IhzP4KpqVzmPKZJ/c2bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju/EZPDArRl7oNmVfuGdj4RBj/lKPSH4lNrogSQO1Koe2VDE1b2QpkWf9hjp0XWE2W8guXK2YRLdp/j6o33mQgEpuLWPyjBsuXDUt6rA6y5SmV/SDBIKv6XDRT09HAidaq+0thEYA7PRjBvJQwZqcuMEuHb6aBEM4MZrrSvJhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YY1dz2GS8z2Dkbx;
	Wed, 15 Jan 2025 17:58:15 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 928561A0188;
	Wed, 15 Jan 2025 18:01:25 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Jan 2025 18:01:24 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH 2/2] cpufreq: Introduce a more generic way to set default per-policy boost flag
Date: Wed, 15 Jan 2025 18:01:23 +0800
Message-ID: <20250115100123.241110-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250115100123.241110-1-zhenglifeng1@huawei.com>
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

In cpufreq_online() of cpufreq.c, the per-policy boost flag is already set
to mirror the cpufreq_driver boost during init but using freq_table to
judge if the policy has boost frequency. There are two drawbacks to this
approach:

1. It doesn't work for the cpufreq drivers that do not use a frequency
table. For now, acpi-cpufreq and amd-pstate have to enable boost in policy
initialization. And cppc_cpufreq never set policy to boost when going
online no matter what the cpufreq_driver boost flag is.

2. If the cpu goes offline when cpufreq_driver boost enabled and then goes
online when cpufreq_driver boost disabled, the per-policy boost flag will
unreasonably remain true.

Running set_boost at the end of the online process is a more generic way
for all cpufreq drivers.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 03ae879d50b9..867bda3decfd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1409,10 +1409,6 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_free_policy;
 		}
 
-		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-		if (cpufreq_boost_enabled() && policy_has_boost_freq(policy))
-			policy->boost_enabled = true;
-
 		/*
 		 * The initialization has succeeded and the policy is online.
 		 * If there is a problem with its frequency table, take it
@@ -1576,6 +1572,18 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
+	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+	if (cpufreq_boost_supported()) {
+		policy->boost_enabled = cpufreq_boost_enabled();
+		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
+		if (ret) {
+			/* If the set_boost fails, the online operation is not affected */
+			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
+				policy->boost_enabled ? "enable" : "disable");
+			policy->boost_enabled = !policy->boost_enabled;
+		}
+	}
+
 	pr_debug("initialization complete\n");
 
 	return 0;
-- 
2.33.0


