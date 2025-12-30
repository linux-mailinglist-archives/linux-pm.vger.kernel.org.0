Return-Path: <linux-pm+bounces-40028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8ECE8F5D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BBB1301AD03
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F122DCF45;
	Tue, 30 Dec 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="n8SuKZUh"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F11AA1F4
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081713; cv=none; b=NrCFHobWfWWJNTdKPfHCFyKNKWuqg8S/veNPaB/Qe8ySKl1vFtAUDeMWnQaqQd/ZrVodj0+sXZrP0EmtzXuPRZiD+7LNQsJUGoQmG2AuZxs+v5NNZRZb/rSbPMPxfQGVmqkxTx5p5h0y+GI6JJyXDzHj2WTTEV0IacTU5g1LDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081713; c=relaxed/simple;
	bh=NVxw9tzSbqx7Fnx+fwrVsx/w+Vvhvte292GqHHgXpsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agqXwEU4Z7YiVZFJ+k1uGKWzRkvWWYfipu7y55C/N0Oz4SqIiCt67+3pthZAej4ef83HVMx+ME5BqwhVXUK4gZPU0l6CH3xyaSEJ467/u6eSl2Bkz2b6rLTMH/RjrO7HsmpzElzYf6nzuPmIjD5ou3rTpq2Yrt8TR7yWN7FcvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n8SuKZUh; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rSSgS4Owu7apQQ6F3BIp5jGRa84w3hOg76VfO/jrTmw=;
	b=n8SuKZUhk8irlpoy7u+eoWhElMiDgO6/PbR0Z22LKXRi/+4eI/vglekMkORpqxAndxcX6Asv4
	kcquYVAypwDR5xu5iTJ932y8InLeW7jfAcsE/+mDyZZ9Dn5r0///7zkcKj0kKazy89cGqBFLgyq
	rj8UkrN2JqvmpzEVV+T4ryM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dgQTW653bz1T4H8;
	Tue, 30 Dec 2025 15:59:11 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 30EE52016A;
	Tue, 30 Dec 2025 16:01:42 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 16:01:41 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <beata.michalska@arm.com>,
	<ionela.voinescu@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<vincent.guittot@linaro.org>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [REPOST PATCH v6 3/3] arm64: topology: Handle AMU FIE setup on CPU hotplug
Date: Tue, 30 Dec 2025 16:01:15 +0800
Message-ID: <20251230080115.2120612-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Currently, when a cpufreq policy is created, the AMU FIE setup process
checks all CPUs in the policy -- including those that are offline. If any
of these CPUs are offline at that time, their AMU capability flag hasn't
been verified yet, leading the check fail. As a result, AMU FIE is not
enabled, even if the CPUs that are online do support it.

Later, when the previously offline CPUs come online and report AMU support,
there's no mechanism in place to re-enable AMU FIE for the policy. This
leaves the entire frequency domain without AMU FIE, despite being eligible.

Restrict the initial AMU FIE check to only those CPUs that are online at
the time the policy is created, and allow CPUs that come online later to
join the policy with AMU FIE enabled.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Acked-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 65 ++++++++++++++++++++++++++++++++++--
 drivers/base/arch_topology.c |  9 ++++-
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index cf9bb761af3a..539b38935182 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -284,7 +284,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
 	struct cpufreq_policy *policy = data;
 
 	if (val == CPUFREQ_CREATE_POLICY)
-		amu_fie_setup(policy->related_cpus);
+		amu_fie_setup(policy->cpus);
 
 	/*
 	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
@@ -303,10 +303,71 @@ static struct notifier_block init_amu_fie_notifier = {
 	.notifier_call = init_amu_fie_callback,
 };
 
+static int cpuhp_topology_online(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
+
+	/* Those are cheap checks */
+
+	/*
+	 * Skip this CPU if:
+	 *  - it has no cpufreq policy assigned yet,
+	 *  - no policy exists that spans CPUs with AMU counters, or
+	 *  - it was already handled.
+	 */
+	if (unlikely(!policy) || !cpumask_available(amu_fie_cpus) ||
+	    cpumask_test_cpu(cpu, amu_fie_cpus))
+		return 0;
+
+	/*
+	 * Only proceed if all already-online CPUs in this policy
+	 * support AMU counters.
+	 */
+	if (unlikely(!cpumask_subset(policy->cpus, amu_fie_cpus)))
+		return 0;
+
+	/*
+	 * If the new online CPU cannot pass this check, all the CPUs related to
+	 * the same policy should be clear from amu_fie_cpus mask, otherwise they
+	 * may use different source of the freq scale.
+	 */
+	if (!freq_counters_valid(cpu)) {
+		pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
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
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 84ec92bff642..c0ef6ea9c111 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -34,7 +34,14 @@ EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
-	return cpumask_subset(cpus, &scale_freq_counters_mask);
+	int i;
+
+	for_each_cpu(i, cpus) {
+		if (cpumask_test_cpu(i, &scale_freq_counters_mask))
+			return true;
+	}
+
+	return false;
 }
 
 bool topology_scale_freq_invariant(void)
-- 
2.33.0


