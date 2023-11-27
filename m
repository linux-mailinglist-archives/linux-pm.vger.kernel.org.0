Return-Path: <linux-pm+bounces-295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23607FA5B9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970BE2818E5
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075FE3589F;
	Mon, 27 Nov 2023 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 091F599;
	Mon, 27 Nov 2023 08:09:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77779165C;
	Mon, 27 Nov 2023 08:09:54 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26D123F6C4;
	Mon, 27 Nov 2023 08:09:05 -0800 (PST)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	sumitg@nvidia.com
Cc: sudeep.holla@arm.covm,
	will@kernel.org,
	catalin.marinas@arm.com,
	viresh.kumar@linaro.org,
	rafael@kernel.org,
	ionela.voinescu@arm.com,
	yang@os.amperecomputing.com,
	linux-tegra@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 1/2] arm64: Provide an AMU-based version of arch_freq_get_on_cpu
Date: Mon, 27 Nov 2023 16:08:37 +0000
Message-Id: <20231127160838.1403404-2-beata.michalska@arm.com>
In-Reply-To: <20231127160838.1403404-1-beata.michalska@arm.com>
References: <20231127160838.1403404-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the Frequency Invariance Engine (FIE) being already wired up with
sched tick and making use of relevant (core counter and constant
counter) AMU counters, getting the current frequency for a given CPU
on supported platforms, can be achieved by utilizing the frequency scale
factor which reflects an average CPU frequency for the last tick period
length.

Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Notes:
    Due to [1], if merged, there might be a need to modify the patch to
    accommodate changes [1] introduces:
    
    	freq = cpufreq_get_hw_max_freq(cpu) >> SCHED_CAPACITY_SHIFT
    	to
    	freq = per_cpu(capacity_freq_ref, cpu); >> SCHED_CAPACITY_SHIFT
    [1]
    https://lore.kernel.org/linux-arm-kernel/20231121154349.GA1938@willie-the-truck/T/#mcb018d076dbce6f60ed2779634a9b6ffe622641e

 arch/arm64/kernel/topology.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 615c1a20129f..ae2445f6e7da 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -186,6 +187,44 @@ static void amu_scale_freq_tick(void)
 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
 }
 
+unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	unsigned int freq;
+	u64 scale;
+
+	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
+		return 0;
+
+	/*
+	 * For those CPUs that are in full dynticks mode, try an alternative
+	 * source for the counters (and thus freq scale),
+	 * if available for given policy
+	 */
+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK)) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		int ref_cpu = nr_cpu_ids;
+
+		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
+				       policy->cpus))
+			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
+						  housekeeping_cpumask(HK_TYPE_TICK));
+		cpufreq_cpu_put(policy);
+		if (ref_cpu >= nr_cpu_ids)
+			return 0;
+		cpu = ref_cpu;
+	}
+
+	/*
+	 * Reversed computation to the one used to determine
+	 * the arch_freq_scale value
+	 * (see amu_scale_freq_tick for details)
+	 */
+	scale = per_cpu(arch_freq_scale, cpu);
+	freq = cpufreq_get_hw_max_freq(cpu) >> SCHED_CAPACITY_SHIFT;
+	freq *= scale;
+	return freq;
+}
+
 static struct scale_freq_data amu_sfd = {
 	.source = SCALE_FREQ_SOURCE_ARCH,
 	.set_freq_scale = amu_scale_freq_tick,
-- 
2.25.1


