Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A186242083
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgHKTne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 15:43:34 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4628 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgHKTnd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 15:43:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f32f4d60002>; Tue, 11 Aug 2020 12:43:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 11 Aug 2020 12:43:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 11 Aug 2020 12:43:32 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Aug
 2020 19:43:24 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Aug 2020 19:43:24 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f32f4d80006>; Tue, 11 Aug 2020 12:43:23 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <sudeep.holla@arm.com>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <catalin.marinas@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>,
        <wangkefeng.wang@huawei.com>
Subject: [Patch] cpufreq: replace cpu_logical_map with read_cpuid_mpir
Date:   Wed, 12 Aug 2020 01:13:17 +0530
Message-ID: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597174999; bh=bRBbhMbs7h3ckPB8wW+c1VeSnD+Qsd3GDY3eazmuf7I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=n3To+SbS9L60gDx7dJi8lFE0LLYkF5biIwcWZi/gBrfsQupp24FCSJrrpyCCZIypu
         uCxy/y5zqG9nYtpfeeAVETttRAmGC3k+PWS4G3IW6z6kmP54u53o5ag3YsIK8dEUGN
         9EuYiZ9wHVH1sCzJAlhBYdPB5XBEhDCwOBumKYhqi/I2jKa+DIv4aJnT3TeTuZN4kL
         jcmhhJ8DbgeT4otQm0mFjAlFK04Xxe0/OuY3RY5C02VntwvssqPQ8tbZPPNvnms4BQ
         wVOOecuQkvleVlrvWlJ0joA3QkK/do4CUkJLBU2nVX0zgep+pGmgkdAX4X+CfLf5p6
         aYiaJPYYmwLpA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
fixes the issue with building tegra194 cpufreq driver as module. But
the fix might cause problem while supporting physical cpu hotplug[1].

This patch fixes the original problem by avoiding use of cpu_logical_map().
Instead calling read_cpuid_mpidr() to get MPIDR on target cpu.

[1] https://lore.kernel.org/linux-arm-kernel/20200724131059.GB6521@bogus/

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index bae527e..e1d931c 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -56,9 +56,11 @@ struct read_counters_work {
 
 static struct workqueue_struct *read_counters_wq;
 
-static enum cluster get_cpu_cluster(u8 cpu)
+static void get_cpu_cluster(void *cluster)
 {
-	return MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
+	u64 mpidr = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
+
+	*((uint32_t *)cluster) = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 }
 
 /*
@@ -186,8 +188,10 @@ static unsigned int tegra194_get_speed(u32 cpu)
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	int cl = get_cpu_cluster(policy->cpu);
 	u32 cpu;
+	u32 cl;
+
+	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
 
 	if (cl >= data->num_clusters)
 		return -EINVAL;
-- 
2.7.4

