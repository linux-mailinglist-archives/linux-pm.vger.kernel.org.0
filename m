Return-Path: <linux-pm+bounces-32604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B9B2BAC1
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285886260FF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5863101C4;
	Tue, 19 Aug 2025 07:30:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F32848BF;
	Tue, 19 Aug 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588612; cv=none; b=nTEqZ8o8uDehah5v31kJByW64mwi628wQJbIzD9NxXMbmwMmzNs96Ku6E13iniYKujecBQvTCvK5cTEPkA7ocTcpU5xdC3U//xhjNaWf9KkZfIXz4XWBGYGshPP8WsFYzEPNJa9f2T0btfswgTuZE69X2cJNeXgHM0dHG0y/uyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588612; c=relaxed/simple;
	bh=MdGDFOp63pOxhwYv/QqVxRQ/ITwQrV9I93hd7KuGVNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqFti2/oKd6nF3jJDnoizz//8lRsA/Ur9Gk2737wf2JEltLJHWj9Dok2zmfjl9Q3f9DsDwcmS+9HtMjvMab6MNX92h3LRQoljwdfo+qF023OA6iEn+F0F6dvxYok4OwvYAapadd8XXFi37VTQTyvC/NLTDy+MNhzlMhp3FcDviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c5h2C0TtbzdcPD;
	Tue, 19 Aug 2025 15:25:39 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E515140275;
	Tue, 19 Aug 2025 15:30:01 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 15:30:00 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v5 3/3] arm64: topology: Setup AMU FIE for online CPUs only
Date: Tue, 19 Aug 2025 15:29:31 +0800
Message-ID: <20250819072931.1647431-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
References: <20250819072931.1647431-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

At the same time, this change also be applied to cpufreq when calling
arch_set_freq_scale.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 arch/arm64/kernel/topology.c | 54 ++++++++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c    |  4 +--
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 9317a618bb87..a9d9e9969cea 100644
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
+	struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
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
+	if (WARN_ON(!freq_counters_valid(cpu))) {
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
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 78ca68ea754d..d1890a2af1af 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -417,7 +417,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	cpufreq_notify_post_transition(policy, freqs, transition_failed);
 
-	arch_set_freq_scale(policy->related_cpus,
+	arch_set_freq_scale(policy->cpus,
 			    policy->cur,
 			    arch_scale_freq_ref(policy->cpu));
 
@@ -2219,7 +2219,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 		return 0;
 
 	policy->cur = freq;
-	arch_set_freq_scale(policy->related_cpus, freq,
+	arch_set_freq_scale(policy->cpus, freq,
 			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
-- 
2.33.0


