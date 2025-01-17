Return-Path: <linux-pm+bounces-20610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A25A14D56
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E641667BA
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09F1FCFD2;
	Fri, 17 Jan 2025 10:15:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90381FCD11;
	Fri, 17 Jan 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108909; cv=none; b=mHVLzn0FhBhULJuqCdOBYDqMZHVOH65aWlhTQjMRROkABFaZuajMJM18xz84G0dB+2s4CPgeQQ3yEdu8JkRSO7F0Df//Yedt0m2LdRRvV0drWBF4rJ1TNn7GlZLznVFlGEP7eYpgR2Ml3SVq8InWR4p4thonC02PIXW7E+xqAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108909; c=relaxed/simple;
	bh=e3Gcz27LdmiI7DW4QRsg50MJZkXwaZaZET+S8ToWnm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biSH25skAt0ik8xNN/eGYYhRhL65xcpcJ+k4XsqdHdmLb4Wjrnup1j+i3aotvwb9/Lp6o9kluouKEC4hWXCHvzEpW2nq1WgX90DW48U3oh2rcyPY55PVLs/ti5XFTzpm7kCZOw27FMnw7+hH9y/VbUQmDf9KX4yi3c/d3t08gTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YZFtR56tczrRhc;
	Fri, 17 Jan 2025 18:13:19 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 87082140257;
	Fri, 17 Jan 2025 18:14:59 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 18:14:58 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v2 2/4] cpufreq: Introduce a more generic way to set default per-policy boost flag
Date: Fri, 17 Jan 2025 18:14:55 +0800
Message-ID: <20250117101457.1530653-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
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
index 5882d7f5e3c1..5a3566c2eb8d 100644
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
@@ -1573,6 +1569,18 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
+	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
+	if (policy->boost_enabled != cpufreq_boost_enabled()) {
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


