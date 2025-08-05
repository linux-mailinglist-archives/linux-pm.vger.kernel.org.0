Return-Path: <linux-pm+bounces-31955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF3B1B13D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E417268B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B276276051;
	Tue,  5 Aug 2025 09:34:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA11275AE4;
	Tue,  5 Aug 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386440; cv=none; b=udrJt/A8qNsu/RMPoIZZCX4gLUkFdMTO+surPIWwpQ9+Xrkpz4pPLPAR4Zy2ERRGpd3XiH2xNoMSukWoupEilSBexQwhXkI/DXkqwii3PW/hmJG9JH7mYOh0xbimUyzZxNq0zO45NUNKYNbaHQMoEQImcF1ZGiEwXSQjwxSWKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386440; c=relaxed/simple;
	bh=Eb3zE1SSn6G9eqw7OXG6AQfEBTShxrMQqk15ZC6DN+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIuaYba7ZqeyCI8BqvyhfOF1qnY8i6e84tM1I97OOjQaU3GhMHiZZTcILCbQIx+gsr6Wz4VGC5Jb+xCO+qktiKiUlulpH1prJN0fGsreb1Qj4ecOjG98itRKz6+Z1PLdt9QnnHIaWorqmhi9m9hBwmZzjagCz+dM6gCnGLWUC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bx7R04JPTz14LrS;
	Tue,  5 Aug 2025 17:29:00 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 6190B1401F3;
	Tue,  5 Aug 2025 17:33:56 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 17:33:55 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v3 3/3] arm64: topology: Setup AMU FIE for online CPUs only
Date: Tue, 5 Aug 2025 17:33:30 +0800
Message-ID: <20250805093330.3715444-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250805093330.3715444-1-zhenglifeng1@huawei.com>
References: <20250805093330.3715444-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

When boot with maxcpu=1 restrict, and LPI(Low Power Idle States) is on,
only CPU0 will go online. The support AMU flag of CPU0 will be set but the
flags of other CPUs will not. This will cause AMU FIE set up fail for CPU0
when it shares a cpufreq policy with other CPU(s). After that, when other
CPUs are finally online and the support AMU flags of them are set, they'll
never have a chance to set up AMU FIE, even though they're eligible.

To solve this problem, the process of setting up AMU FIE needs to be
modified as follows:

1. Set up AMU FIE only for the online CPUs.

2. Try to set up AMU FIE each time a CPU goes online and do the
freq_counters_valid() check. If this check fails, clear scale freq source
of all the CPUs related to the same policy, in case they use different
source of the freq scale.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 arch/arm64/kernel/topology.c | 54 ++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 9317a618bb87..b68621b3c071 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -385,7 +385,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
 	struct cpufreq_policy *policy = data;
 
 	if (val == CPUFREQ_CREATE_POLICY)
-		amu_fie_setup(policy->related_cpus);
+		amu_fie_setup(policy->cpus);
 
 	/*
 	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
@@ -404,10 +404,60 @@ static struct notifier_block init_amu_fie_notifier = {
 	.notifier_call = init_amu_fie_callback,
 };
 
+static int cpuhp_topology_online(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw_no_check(cpu);
+
+	/*
+	 * If the online CPUs are not all AMU FIE CPUs or the new one is already
+	 * an AMU FIE one, no need to set it.
+	 */
+	if (!policy || !cpumask_available(amu_fie_cpus) ||
+	    !cpumask_subset(policy->cpus, amu_fie_cpus) ||
+	    cpumask_test_cpu(cpu, amu_fie_cpus))
+		return 0;
+
+	/*
+	 * If the new online CPU cannot pass this check, all the CPUs related to
+	 * the same policy should be clear from amu_fie_cpus mask, otherwise they
+	 * may use different source of the freq scale.
+	 */
+	if (!freq_counters_valid(cpu)) {
+		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
+						 policy->related_cpus);
+		cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
+		return 0;
+	}
+
+	cpumask_set_cpu(cpu, amu_fie_cpus);
+
+	topology_set_scale_freq_source(&amu_sfd, cpumask_of(cpu));
+
+	pr_debug("CPU[%u]: counter will be used for FIE.", cpu);
+
+	return 0;
+}
+
 static int __init init_amu_fie(void)
 {
-	return cpufreq_register_notifier(&init_amu_fie_notifier,
+	int ret;
+
+	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
 					CPUFREQ_POLICY_NOTIFIER);
+	if (ret)
+		return ret;
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"arm64/topology:online",
+					cpuhp_topology_online,
+					NULL);
+	if (ret < 0) {
+		cpufreq_unregister_notifier(&init_amu_fie_notifier,
+					    CPUFREQ_POLICY_NOTIFIER);
+		return ret;
+	}
+
+	return 0;
 }
 core_initcall(init_amu_fie);
 
-- 
2.33.0


