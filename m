Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2E1A5C5B
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDLDhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:37:23 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55256 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgDLDhX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:37:23 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id DFA4B20D1B;
        Sun, 12 Apr 2020 03:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586662072; bh=xGkPNlgr7Ak8PcW00iiNq2U+pg1E5SuUcmDpJ31y/7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYvvpezAgid/leO+E9vgarN3GliOnBJ4LcCJBK80V6FAm2IYmkrMtHHU367h6LCfp
         MpSWJdU5wstbTTXrnyVltvXSnXIt+JNI+dBj0jRhHpO+L7s2iG5vdb7Rh4FfnWJbNK
         MVcy4gbZJQqkBzz7v6YhLXSMw5CyC/BQBB8zChXhARK7emDEmXujV3cy/3I7Svlxsq
         jG/Ca4VvZKNGKqaIDyzc9L+NWjvvfqYCBH21J8bMMbcyU1E9Owm7JOZvmnklM5gsXM
         HOGEt4eLcxjjI9EUxyoOqCSlSpU7YqlgC9HM0Ir3cyUBanGBzFEa9diLtHLF57samG
         JMyoPAd9rYe3Q==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 06/11] MIPS: Kernel: Switch to new topology interface
Date:   Sun, 12 Apr 2020 11:20:36 +0800
Message-Id: <20200412032123.3896114-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adapt topology functions to new interface in various of kernel
parts like perf, proc.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/cacheinfo.c         | 19 ++++++-------------
 arch/mips/kernel/perf_event_mipsxx.c |  4 ++--
 arch/mips/kernel/proc.c              |  8 ++++----
 arch/mips/mm/c-r4k.c                 |  4 ++--
 arch/mips/mm/context.c               |  4 ++--
 arch/mips/oprofile/op_model_mipsxx.c |  4 ++--
 6 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index 47312c529410..9a5f12830440 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -3,6 +3,7 @@
  * MIPS cacheinfo support
  */
 #include <linux/cacheinfo.h>
+#include <linux/topology.h>
 
 /* Populates leaf and increments to next leaf */
 #define populate_cache(cache, leaf, c_level, c_type)		\
@@ -50,22 +51,12 @@ static int __init_cache_level(unsigned int cpu)
 	return 0;
 }
 
-static void fill_cpumask_siblings(int cpu, cpumask_t *cpu_map)
-{
-	int cpu1;
-
-	for_each_possible_cpu(cpu1)
-		if (cpus_are_siblings(cpu, cpu1))
-			cpumask_set_cpu(cpu1, cpu_map);
-}
-
 static void fill_cpumask_cluster(int cpu, cpumask_t *cpu_map)
 {
 	int cpu1;
-	int cluster = cpu_cluster(&cpu_data[cpu]);
 
 	for_each_possible_cpu(cpu1)
-		if (cpu_cluster(&cpu_data[cpu1]) == cluster)
+		if (cpu_cluster(cpu1) == cpu_cluster(cpu))
 			cpumask_set_cpu(cpu1, cpu_map);
 }
 
@@ -77,9 +68,11 @@ static int __populate_cache_leaves(unsigned int cpu)
 
 	if (c->icache.waysize) {
 		/* L1 caches are per core */
-		fill_cpumask_siblings(cpu, &this_leaf->shared_cpu_map);
+		cpumask_copy(&this_leaf->shared_cpu_map,
+				topology_sibling_cpumask(cpu));
 		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_DATA);
-		fill_cpumask_siblings(cpu, &this_leaf->shared_cpu_map);
+		cpumask_copy(&this_leaf->shared_cpu_map,
+				topology_sibling_cpumask(cpu));
 		populate_cache(icache, this_leaf, 1, CACHE_TYPE_INST);
 	} else {
 		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_UNIFIED);
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 128fc9999c56..e9ed3526bad0 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -127,7 +127,7 @@ static DEFINE_RWLOCK(pmuint_rwlock);
 			 0 : (smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK))
 #else
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			 0 : cpu_vpe_id(&current_cpu_data))
+			 0 : cpu_vpe_id(smp_processor_id()))
 #endif
 
 /* Copied from op_model_mipsxx.c */
@@ -343,7 +343,7 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 		 */
 		cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
 
-		ctrl = M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
+		ctrl = M_PERFCTL_VPEID(cpu_vpe_id(smp_processor_id()));
 		ctrl |= M_TC_EN_VPE;
 		cpuc->saved_ctrl[idx] |= ctrl;
 		pr_debug("Enabling perf counter for CPU%d\n", cpu);
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index f8d36710cd58..e8795b262ca2 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -138,14 +138,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
 		      hweight8(cpu_data[n].kscratch_mask));
-	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
-	seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
+	seq_printf(m, "package\t\t\t: %d\n", cpu_cluster(n));
+	seq_printf(m, "core\t\t\t: %d\n", cpu_core(n));
 
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_has_mipsmt)
-		seq_printf(m, "VPE\t\t\t: %d\n", cpu_vpe_id(&cpu_data[n]));
+		seq_printf(m, "VPE\t\t\t: %d\n", cpu_vpe_id(n));
 	else if (cpu_has_vp)
-		seq_printf(m, "VP\t\t\t: %d\n", cpu_vpe_id(&cpu_data[n]));
+		seq_printf(m, "VP\t\t\t: %d\n", cpu_vpe_id(n));
 #endif
 
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 36a311348739..851559ef0bc3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -547,7 +547,7 @@ static inline int has_valid_asid(const struct mm_struct *mm, unsigned int type)
 	if (cpu_has_mmid)
 		return cpu_context(0, mm) != 0;
 
-	/* cpu_sibling_map[] undeclared when !CONFIG_SMP */
+	/* topology_sibling_cpumask undeclared when !CONFIG_SMP */
 #ifdef CONFIG_SMP
 	/*
 	 * If r4k_on_each_cpu does SMP calls, it does them to a single VPE in
@@ -555,7 +555,7 @@ static inline int has_valid_asid(const struct mm_struct *mm, unsigned int type)
 	 * Otherwise we need to worry about all present CPUs.
 	 */
 	if (r4k_op_needs_ipi(type))
-		mask = &cpu_sibling_map[smp_processor_id()];
+		mask = topology_sibling_cpumask(smp_processor_id());
 #endif
 	for_each_cpu(i, mask)
 		if (cpu_context(i, mm))
diff --git a/arch/mips/mm/context.c b/arch/mips/mm/context.c
index b25564090939..ad2d8b7f464b 100644
--- a/arch/mips/mm/context.c
+++ b/arch/mips/mm/context.c
@@ -241,12 +241,12 @@ void check_switch_mmu_context(struct mm_struct *mm)
 	 * increase then we need to invalidate any TLB entries for our MMID
 	 * that we might otherwise pick up from a sibling.
 	 *
-	 * We ifdef on CONFIG_SMP because cpu_sibling_map isn't defined in
+	 * We ifdef on CONFIG_SMP because topology_sibling_cpumask isn't defined in
 	 * CONFIG_SMP=n kernels.
 	 */
 #ifdef CONFIG_SMP
 	if (cpu_has_shared_ftlb_entries &&
-	    cpumask_intersects(&tlb_flush_pending, &cpu_sibling_map[cpu])) {
+	    cpumask_intersects(&tlb_flush_pending, topology_sibling_cpumask(cpu))) {
 		/* Ensure we operate on the new MMID */
 		mtc0_tlbw_hazard();
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index a537bf98912c..0129dfcf5d55 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -37,9 +37,9 @@ static int perfcount_irq;
 
 #ifdef CONFIG_MIPS_MT_SMP
 #define WHAT		(MIPS_PERFCTRL_MT_EN_VPE | \
-			 M_PERFCTL_VPEID(cpu_vpe_id(&current_cpu_data)))
+			 M_PERFCTL_VPEID(cpu_vpe_id(smp_processor_id())))
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : cpu_vpe_id(&current_cpu_data))
+			0 : cpu_vpe_id(smp_processor_id()))
 
 /*
  * The number of bits to shift to convert between counters per core and
-- 
2.26.0.rc2

