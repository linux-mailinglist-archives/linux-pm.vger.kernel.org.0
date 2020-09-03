Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAD25C51D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgICPWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 11:22:34 -0400
Received: from foss.arm.com ([217.140.110.172]:59280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbgICLWk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 07:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4A14101E;
        Thu,  3 Sep 2020 04:20:51 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC4E23F66F;
        Thu,  3 Sep 2020 04:20:50 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH] cpufreq,cppc: fix issue when hotplugging out policy->cpu
Date:   Thu,  3 Sep 2020 12:19:55 +0100
Message-Id: <20200903111955.31029-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

An issue is observed in the cpufreq CPPC driver when having dependency
domains (PSD) and the policy->cpu is hotplugged out.

Considering a platform with 4 CPUs and 2 PSD domains (CPUs 0 and 1 in
PSD-1, CPUs 2 and 3 in PSD-2), cppc_cpufreq_cpu_init() will be called
for the two cpufreq policies that are created and it will set
all_cpu_data[policy->cpu]->cpu = policy->cpu.

Therefore all_cpu_data[0]->cpu=0, and all_cpu_data[2]->cpu=2. But for
CPUs 1 and 3, all_cpu_data[{1,3}]->cpu will remain 0 from the structure
allocation.

If CPU 2 is hotplugged out, CPU 3 will become policy->cpu. But its
all_cpu_data[3]->cpu will remain 0. Later, when the .target() function
is called for policy2, the cpu argument to cppc_set_perf() will be 0 and
therefore it will use the performance controls of CPU 0, which will
result in a performance level change for the wrong domain.

While the possibility of setting a correct CPU value in the per-cpu
cppc_cpudata structure is available, it can be noticed that this cpu value
is not used at all outside the .target() function, where it's not actually
necessary. Therefore, remove the cpu variable from the cppc_cpudata
structure and use policy->cpu in the .target() function as done for the
other CPPC cpufreq functions.

Fixes: 5477fb3bd1e8  ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---

Testing was done on a Juno R2 platform (with the proper ACPI/CPPC setup):
CPUs 0, 1, 2, 3 are in PSD-0 (policy0), CPUs 4 and 5 are in PSD-4
(policy4).

Before the fix:

root@sqwt-ubuntu:~# dmesg | grep address
[    2.165177] ACPI CPPC: ACPI desired perf address 0: - ffff80001004d200
[    2.174226] ACPI CPPC: ACPI desired perf address 1: - ffff800010055200
[    2.183231] ACPI CPPC: ACPI desired perf address 2: - ffff80001005d200
[    2.192234] ACPI CPPC: ACPI desired perf address 3: - ffff800010065200
[    2.201245] ACPI CPPC: ACPI desired perf address 4: - ffff80001006d218
[    2.210256] ACPI CPPC: ACPI desired perf address 5: - ffff800011ff1218
[..]
[    2.801940] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 38300
[    2.835286] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 102400
[..]
root@sqwt-ubuntu:~# cd /sys/devices/system/cpu/cpufreq/
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
[   72.098758] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 51200
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
[   85.430645] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 102400
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 0 > ../cpu4/online
[  102.606380] CPPC Cpufreq:CPPC: Calculate: (6285/261)*4266=102727.
[  102.612491] CPPC Cpufreq:CPPC: Core rate = 1203832, arch timer rate: 50000000
[  102.619659] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 102400
[  102.626898] CPU4: shutdown
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
[  141.116882] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 51200
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
[  159.288273] ACPI CPPC: Writing to address for CPU 0:ffff80001004d200: 102400


After the fix:

root@sqwt-ubuntu:~# cd /sys/devices/system/cpu/cpufreq/
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
[  139.903322] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 51200
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
[  147.279040] ACPI CPPC: Writing to address for CPU 4:ffff80001006d218: 102400
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 0 > ../cpu4/online
[  153.598686] CPPC Cpufreq:CPPC: Calculate: (6171/253)*4266=104053.
[  153.604797] CPPC Cpufreq:CPPC: Core rate = 1219371, arch timer rate: 50000000
[  153.611960] ACPI CPPC: Writing to address for CPU 5:ffff800011ff1218: 102400
[  153.619190] CPU4: shutdown
[  153.621911] psci: CPU4 killed (polled 0 ms)
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 600000 > policy4/scaling_setspeed
[  170.122495] ACPI CPPC: Writing to address for CPU 5:ffff800011ff1218: 51200
root@sqwt-ubuntu:/sys/devices/system/cpu/cpufreq# echo 1200000 > policy4/scaling_setspeed
[  177.206342] ACPI CPPC: Writing to address for CPU 5:ffff800011ff1218: 102400

Thanks,
Ionela.

 drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
 include/acpi/cppc_acpi.h       | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f29e8d0553a8..54457f5fe49e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -149,8 +149,9 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 		unsigned int target_freq,
 		unsigned int relation)
 {
-	struct cppc_cpudata *cpu;
 	struct cpufreq_freqs freqs;
+	int cpu_num = policy->cpu;
+	struct cppc_cpudata *cpu;
 	u32 desired_perf;
 	int ret = 0;
 
@@ -166,12 +167,12 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
-				cpu->cpu, ret);
+				cpu_num, ret);
 
 	return ret;
 }
@@ -247,7 +248,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = all_cpu_data[policy->cpu];
 
-	cpu->cpu = cpu_num;
 	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
 
 	if (ret) {
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a6a9373ab863..451132ec83c9 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -124,7 +124,6 @@ struct cppc_perf_fb_ctrs {
 
 /* Per CPU container for runtime CPPC management. */
 struct cppc_cpudata {
-	int cpu;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
-- 
2.17.1

