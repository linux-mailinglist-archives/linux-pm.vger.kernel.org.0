Return-Path: <linux-pm+bounces-21179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69226A24049
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2C716842E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71F61EE7AA;
	Fri, 31 Jan 2025 16:25:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D81E570E;
	Fri, 31 Jan 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340703; cv=none; b=ZsAxuaSxwyuhlxZtG8Lr4Zcvs4ZqjNELo7pLCx7a5WJ3dtgm4yL1OIRRyQNQXxsUo/H53QqQTG5tK7zNy7w7AQmnDTrW/xrQqOKLnGpW1FDXu3FEx3nzqsp3/7PFX4H++cxTwB9/nIM/Pqa4dYvk/Ez4XtVTmbhuqKnXeiRdkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340703; c=relaxed/simple;
	bh=KG2C+n8LZSKgkEde1mwiF9rMP3fkTkx2m2iwVZe3kqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CECBSaIWZl4Lyi4C4QzFcyKT6Qf797r2jrwZWIz8eI4BV00+3dsECps9tcEg9SzwD3fpWADiPmo0tArLe9lb0Vdft6s8ZbEMi3/HwjC5iZhKbKA2+XnEVIfwx5MQvlN9xsPnc/EAgu8CiDqNIsol9cfFXQS0h0KwatxEkF7OMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A386FEC;
	Fri, 31 Jan 2025 08:25:26 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D04363F694;
	Fri, 31 Jan 2025 08:24:58 -0800 (PST)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com,
	zhanjie9@hisilicon.com,
	ptsm@linux.microsoft.com
Subject: [PATCH v10 1/4] cpufreq: Allow arch_freq_get_on_cpu to return an error
Date: Fri, 31 Jan 2025 16:24:36 +0000
Message-Id: <20250131162439.3843071-2-beata.michalska@arm.com>
In-Reply-To: <20250131162439.3843071-1-beata.michalska@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow arch_freq_get_on_cpu to return an error for cases when retrieving
current CPU frequency is not possible, whether that being due to lack of
required arch support or due to other circumstances when the current
frequency cannot be determined at given point of time.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 2 +-
 arch/x86/kernel/cpu/proc.c       | 7 +++++--
 drivers/cpufreq/cpufreq.c        | 8 ++++----
 include/linux/cpufreq.h          | 2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index f642de2ebdac..6cf31a1649c4 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -498,7 +498,7 @@ void arch_scale_freq_tick(void)
  */
 #define MAX_SAMPLE_AGE	((unsigned long)HZ / 50)
 
-unsigned int arch_freq_get_on_cpu(int cpu)
+int arch_freq_get_on_cpu(int cpu)
 {
 	struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
 	unsigned int seq, freq;
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 41ed01f46bd9..6571d432cbe3 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -86,9 +86,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
 
 	if (cpu_has(c, X86_FEATURE_TSC)) {
-		unsigned int freq = arch_freq_get_on_cpu(cpu);
+		int freq = arch_freq_get_on_cpu(cpu);
 
-		seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
+		if (freq < 0)
+			seq_puts(m, "cpu MHz\t\t: Unknown\n");
+		else
+			seq_printf(m, "cpu MHz\t\t: %u.%03u\n", freq / 1000, (freq % 1000));
 	}
 
 	/* Cache size */
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e0048856ecee..96b013ea177c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -729,18 +729,18 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
 show_one(scaling_min_freq, min);
 show_one(scaling_max_freq, max);
 
-__weak unsigned int arch_freq_get_on_cpu(int cpu)
+__weak int arch_freq_get_on_cpu(int cpu)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 {
 	ssize_t ret;
-	unsigned int freq;
+	int freq;
 
 	freq = arch_freq_get_on_cpu(policy->cpu);
-	if (freq)
+	if (freq > 0)
 		ret = sysfs_emit(buf, "%u\n", freq);
 	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
 		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7fe0981a7e46..02fd4746231d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1184,7 +1184,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 }
 #endif
 
-extern unsigned int arch_freq_get_on_cpu(int cpu);
+extern int arch_freq_get_on_cpu(int cpu);
 
 #ifndef arch_set_freq_scale
 static __always_inline
-- 
2.25.1


