Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643E61A5C5A
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLDhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:37:23 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55244 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDLDhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:37:22 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 8A55220D18;
        Sun, 12 Apr 2020 03:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586662022; bh=CwxSJACN9kfWOFrwE500WiFJJVxkNDeXPqXpee2bVhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKhi1J6xCqXtUnSfbyh3dYyalSndsb49LrD4EakclPIBDqIcBMl+470NUJakB1z84
         o9KVhJ4vvLiHhPuQpXtt3MX3mRBo62KA1tLbKt55kJ4C6JveY0+8XjM7gglXAez+6c
         vzuo4rbXuFg8WWWJcM4AwAayP2wu81WWVPcyjkgv/cnCEZUdgDGNlDVM1M8bdnLnnP
         BU/aorVLYwQvFoKR4yWB1msfyNAfCsV4ga0mUICzV1hhx9YmjRUZGhguZULecXp1xe
         PqCEnV8U+iDoxPgCjLF2riICs4zsC29ADSXDbBmBFvP1g2PohEt5pQbAOxHAciVDYD
         5rWu+wAwfMG8g==
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
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
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
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 05/11] MIPS: Switch to arch_topology
Date:   Sun, 12 Apr 2020 11:20:35 +0800
Message-Id: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Previously, MIPS is using self-defined "globalnumber" in struct
mips_cpuinfo to store topology information. However, it's not friendly
to DeviceTree based systems and lack of cpu_capacity related feature
which can take advantage of multi-cluster system.

Here, we enabled arch_topology for MIPS and adapted some functions
to fit arch_topology structure.
Also, we implmented smp_store_cpu_info to probe CPU's topology information
by "globalnumber" registers in VP ASE or Ebase.CPUNum for legacy systems.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

--
v2:
	- Squash header fix into this commit.
	- Provide dummy functions for no-SMP config, CM code requires them.
	  (Thanks to 0-day CI for discover this)
---
 arch/mips/Kconfig                          |  1 +
 arch/mips/include/asm/cpu-info.h           | 49 ----------------
 arch/mips/include/asm/mach-ip27/mmzone.h   |  2 +
 arch/mips/include/asm/mach-ip27/topology.h |  2 +
 arch/mips/include/asm/smp.h                |  2 -
 arch/mips/include/asm/sn/addrs.h           |  1 +
 arch/mips/include/asm/topology.h           | 68 ++++++++++++++++++++--
 arch/mips/kernel/cpu-probe.c               | 43 --------------
 arch/mips/kernel/setup.c                   |  1 +
 arch/mips/kernel/smp.c                     | 55 ++---------------
 arch/mips/kernel/topology.c                | 42 +++++++++++++
 11 files changed, 118 insertions(+), 148 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 690718b3701a..66b57e9f2b4d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -20,6 +20,7 @@ config MIPS
 	select CLONE_BACKWARDS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE
+	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index ed7ffe4e63a3..7140a3e61ce3 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -78,8 +78,6 @@ struct cpuinfo_mips {
 	struct cache_desc	scache; /* Secondary cache */
 	struct cache_desc	tcache; /* Tertiary/split secondary cache */
 	int			srsets; /* Shadow register sets */
-	int			package;/* physical package number */
-	unsigned int		globalnumber;
 #ifdef CONFIG_64BIT
 	int			vmbits; /* Virtual memory size in bits */
 #endif
@@ -139,53 +137,6 @@ struct proc_cpuinfo_notifier_args {
 	unsigned long n;
 };
 
-static inline unsigned int cpu_cluster(struct cpuinfo_mips *cpuinfo)
-{
-	/* Optimisation for systems where multiple clusters aren't used */
-	if (!IS_ENABLED(CONFIG_CPU_MIPSR6))
-		return 0;
-
-	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_CLUSTER) >>
-		MIPS_GLOBALNUMBER_CLUSTER_SHF;
-}
-
-static inline unsigned int cpu_core(struct cpuinfo_mips *cpuinfo)
-{
-	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_CORE) >>
-		MIPS_GLOBALNUMBER_CORE_SHF;
-}
-
-static inline unsigned int cpu_vpe_id(struct cpuinfo_mips *cpuinfo)
-{
-	/* Optimisation for systems where VP(E)s aren't used */
-	if (!IS_ENABLED(CONFIG_MIPS_MT_SMP) && !IS_ENABLED(CONFIG_CPU_MIPSR6))
-		return 0;
-
-	return (cpuinfo->globalnumber & MIPS_GLOBALNUMBER_VP) >>
-		MIPS_GLOBALNUMBER_VP_SHF;
-}
-
-extern void cpu_set_cluster(struct cpuinfo_mips *cpuinfo, unsigned int cluster);
-extern void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core);
-extern void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo, unsigned int vpe);
-
-static inline bool cpus_are_siblings(int cpua, int cpub)
-{
-	struct cpuinfo_mips *infoa = &cpu_data[cpua];
-	struct cpuinfo_mips *infob = &cpu_data[cpub];
-	unsigned int gnuma, gnumb;
-
-	if (infoa->package != infob->package)
-		return false;
-
-	gnuma = infoa->globalnumber & ~MIPS_GLOBALNUMBER_VP;
-	gnumb = infob->globalnumber & ~MIPS_GLOBALNUMBER_VP;
-	if (gnuma != gnumb)
-		return false;
-
-	return true;
-}
-
 static inline unsigned long cpu_asid_inc(void)
 {
 	return 1 << CONFIG_MIPS_ASID_SHIFT;
diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
index 08c36e50a860..e0a53b97b4a8 100644
--- a/arch/mips/include/asm/mach-ip27/mmzone.h
+++ b/arch/mips/include/asm/mach-ip27/mmzone.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_MACH_MMZONE_H
 #define _ASM_MACH_MMZONE_H
 
+#include <linux/mmzone.h>
+
 #include <asm/sn/addrs.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/agent.h>
diff --git a/arch/mips/include/asm/mach-ip27/topology.h b/arch/mips/include/asm/mach-ip27/topology.h
index d66cc53feab8..601e350908f7 100644
--- a/arch/mips/include/asm/mach-ip27/topology.h
+++ b/arch/mips/include/asm/mach-ip27/topology.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_MACH_TOPOLOGY_H
 #define _ASM_MACH_TOPOLOGY_H	1
 
+#include <linux/numa.h>
+
 #include <asm/sn/types.h>
 #include <asm/mmzone.h>
 
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 7990c1c70471..538e73f6bab0 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -21,8 +21,6 @@
 #include <asm/smp-ops.h>
 
 extern int smp_num_siblings;
-extern cpumask_t cpu_sibling_map[];
-extern cpumask_t cpu_core_map[];
 extern cpumask_t cpu_foreign_map[];
 
 static inline int raw_smp_processor_id(void)
diff --git a/arch/mips/include/asm/sn/addrs.h b/arch/mips/include/asm/sn/addrs.h
index 837d23e24976..1d3945ef2ca4 100644
--- a/arch/mips/include/asm/sn/addrs.h
+++ b/arch/mips/include/asm/sn/addrs.h
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/smp.h>
 #include <linux/types.h>
+#include <asm/io.h>
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/addrspace.h>
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 0673d2d0f2e6..0f27a00df56d 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -9,13 +9,71 @@
 #define __ASM_TOPOLOGY_H
 
 #include <topology.h>
+#include <linux/arch_topology.h>
 #include <linux/smp.h>
 
-#ifdef CONFIG_SMP
-#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
-#define topology_core_id(cpu)			(cpu_core(&cpu_data[cpu]))
-#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
-#define topology_sibling_cpumask(cpu)		(&cpu_sibling_map[cpu])
+#if defined(CONFIG_SMP)
+static inline bool cpus_are_siblings(int cpua, int cpub)
+{
+	return cpumask_test_cpu(cpua, topology_sibling_cpumask(cpub));
+}
+
+static inline unsigned int cpu_cluster(int cpu)
+{
+	return cpu_topology[cpu].package_id;
+}
+
+static inline unsigned int cpu_core(int cpu)
+{
+	return cpu_topology[cpu].core_id;
+}
+
+static inline unsigned int cpu_vpe_id(int cpu)
+{
+	int id = cpu_topology[cpu].thread_id;
+
+	/* Uniprocessor system may get -1, but for hardware it's 0 */
+	if (id == -1)
+		return 0;
+
+	return id;
+}
+
+static inline void cpu_set_cluster(int cpu, unsigned int cluster)
+{
+	cpu_topology[cpu].package_id = cluster;
+}
+
+static inline void cpu_set_core(int cpu, unsigned int core)
+{
+	cpu_topology[cpu].core_id = core;
+}
+
+static inline void cpu_set_vpe_id(int cpu, unsigned int vpe)
+{
+	cpu_topology[cpu].thread_id = vpe;
+}
+#else
+static inline void init_cpu_topology(void) { }
+static inline bool cpus_are_siblings(int cpua, int cpub)
+{
+	return false;
+}
+
+static inline unsigned int cpu_cluster(int cpu)
+{
+	return 0;
+}
+
+static inline unsigned int cpu_core(int cpu)
+{
+	return 0;
+}
+
+static inline unsigned int cpu_vpe_id(int cpu)
+{
+	return 0;
+}
 #endif
 
 #endif /* __ASM_TOPOLOGY_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f21a2304401f..eead35e5dbfd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1042,17 +1042,6 @@ static void decode_configs(struct cpuinfo_mips *c)
 	set_ftlb_enable(c, (mips_ftlb_disabled ? 0 : FTLB_EN) | FTLB_SET_PROB);
 
 	mips_probe_watch_registers(c);
-
-#ifndef CONFIG_MIPS_CPS
-	if (cpu_has_mips_r2_r6) {
-		unsigned int core;
-
-		core = get_ebase_cpunum();
-		if (cpu_has_mipsmt)
-			core >>= fls(core_nvpes()) - 1;
-		cpu_set_core(c, core);
-	}
-#endif
 }
 
 /*
@@ -2303,35 +2292,3 @@ void cpu_report(void)
 	if (cpu_has_msa)
 		pr_info("MSA revision is: %08x\n", c->msa_id);
 }
-
-void cpu_set_cluster(struct cpuinfo_mips *cpuinfo, unsigned int cluster)
-{
-	/* Ensure the core number fits in the field */
-	WARN_ON(cluster > (MIPS_GLOBALNUMBER_CLUSTER >>
-			   MIPS_GLOBALNUMBER_CLUSTER_SHF));
-
-	cpuinfo->globalnumber &= ~MIPS_GLOBALNUMBER_CLUSTER;
-	cpuinfo->globalnumber |= cluster << MIPS_GLOBALNUMBER_CLUSTER_SHF;
-}
-
-void cpu_set_core(struct cpuinfo_mips *cpuinfo, unsigned int core)
-{
-	/* Ensure the core number fits in the field */
-	WARN_ON(core > (MIPS_GLOBALNUMBER_CORE >> MIPS_GLOBALNUMBER_CORE_SHF));
-
-	cpuinfo->globalnumber &= ~MIPS_GLOBALNUMBER_CORE;
-	cpuinfo->globalnumber |= core << MIPS_GLOBALNUMBER_CORE_SHF;
-}
-
-void cpu_set_vpe_id(struct cpuinfo_mips *cpuinfo, unsigned int vpe)
-{
-	/* Ensure the VP(E) ID fits in the field */
-	WARN_ON(vpe > (MIPS_GLOBALNUMBER_VP >> MIPS_GLOBALNUMBER_VP_SHF));
-
-	/* Ensure we're not using VP(E)s without support */
-	WARN_ON(vpe && !IS_ENABLED(CONFIG_MIPS_MT_SMP) &&
-		!IS_ENABLED(CONFIG_CPU_MIPSR6));
-
-	cpuinfo->globalnumber &= ~MIPS_GLOBALNUMBER_VP;
-	cpuinfo->globalnumber |= vpe << MIPS_GLOBALNUMBER_VP_SHF;
-}
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8a418783a6bb..b9fefc5dc702 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -784,6 +784,7 @@ void __init setup_arch(char **cmdline_p)
 	dmi_setup();
 
 	resource_init();
+	init_cpu_topology();
 	plat_smp_setup();
 
 	cpu_cache_init();
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 48d84d5fcc36..4896d6ecc719 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -34,6 +34,7 @@
 #include <asm/mips-cps.h>
 #include <asm/mmu_context.h>
 #include <asm/time.h>
+#include <asm/topology.h>
 #include <asm/setup.h>
 #include <asm/maar.h>
 
@@ -47,10 +48,6 @@ EXPORT_SYMBOL(__cpu_logical_map);
 int smp_num_siblings = 1;
 EXPORT_SYMBOL(smp_num_siblings);
 
-/* representing the TCs (or siblings in Intel speak) of each logical CPU */
-cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
-EXPORT_SYMBOL(cpu_sibling_map);
-
 /* representing the core map of multi-core chips of each logical CPU */
 cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
@@ -65,12 +62,6 @@ static DECLARE_COMPLETION(cpu_running);
 cpumask_t cpu_foreign_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_foreign_map);
 
-/* representing cpus for which sibling maps can be computed */
-static cpumask_t cpu_sibling_setup_map;
-
-/* representing cpus for which core maps can be computed */
-static cpumask_t cpu_core_setup_map;
-
 cpumask_t cpu_coherent_mask;
 
 #ifdef CONFIG_GENERIC_IRQ_IPI
@@ -78,37 +69,6 @@ static struct irq_desc *call_desc;
 static struct irq_desc *sched_desc;
 #endif
 
-static inline void set_cpu_sibling_map(int cpu)
-{
-	int i;
-
-	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
-
-	if (smp_num_siblings > 1) {
-		for_each_cpu(i, &cpu_sibling_setup_map) {
-			if (cpus_are_siblings(cpu, i)) {
-				cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
-				cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
-			}
-		}
-	} else
-		cpumask_set_cpu(cpu, &cpu_sibling_map[cpu]);
-}
-
-static inline void set_cpu_core_map(int cpu)
-{
-	int i;
-
-	cpumask_set_cpu(cpu, &cpu_core_setup_map);
-
-	for_each_cpu(i, &cpu_core_setup_map) {
-		if (cpu_data[cpu].package == cpu_data[i].package) {
-			cpumask_set_cpu(i, &cpu_core_map[cpu]);
-			cpumask_set_cpu(cpu, &cpu_core_map[i]);
-		}
-	}
-}
-
 /*
  * Calculate a new cpu_foreign_map mask whenever a
  * new cpu appears or disappears.
@@ -131,7 +91,7 @@ void calculate_cpu_foreign_map(void)
 
 	for_each_online_cpu(i)
 		cpumask_andnot(&cpu_foreign_map[i],
-			       &temp_foreign_map, &cpu_sibling_map[i]);
+			       &temp_foreign_map, topology_sibling_cpumask(i));
 }
 
 const struct plat_smp_ops *mp_ops;
@@ -177,7 +137,7 @@ void mips_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 			if (cpus_are_siblings(cpu, smp_processor_id()))
 				continue;
 
-			core = cpu_core(&cpu_data[cpu]);
+			core = cpu_core(cpu);
 
 			while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
 				mips_cm_lock_other_cpu(cpu, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
@@ -340,6 +300,8 @@ asmlinkage void start_secondary(void)
 	mips_clockevent_init();
 	mp_ops->init_secondary();
 	cpu_report();
+	cpu = smp_processor_id();
+	store_cpu_topology(cpu);
 	maar_init();
 
 	/*
@@ -349,7 +311,6 @@ asmlinkage void start_secondary(void)
 
 	calibrate_delay();
 	preempt_disable();
-	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
@@ -363,9 +324,6 @@ asmlinkage void start_secondary(void)
 	/* The CPU is running and counters synchronised, now mark it online */
 	set_cpu_online(cpu, true);
 
-	set_cpu_sibling_map(cpu);
-	set_cpu_core_map(cpu);
-
 	calculate_cpu_foreign_map();
 
 	/*
@@ -411,8 +369,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
 	mp_ops->prepare_cpus(max_cpus);
-	set_cpu_sibling_map(0);
-	set_cpu_core_map(0);
+	store_cpu_topology(0);
 	calculate_cpu_foreign_map();
 #ifndef CONFIG_HOTPLUG_CPU
 	init_cpu_present(cpu_possible_mask);
diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
index cd3e1f82e1a5..112482de8187 100644
--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -31,3 +31,45 @@ static int __init topology_init(void)
 }
 
 subsys_initcall(topology_init);
+
+#if defined(CONFIG_SMP)
+void store_cpu_topology(unsigned int cpuid)
+{
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
+
+	if (cpuid_topo->package_id != -1)
+		goto topology_populated;
+
+	if (cpu_has_vp) {
+		u32 gn = read_c0_globalnumber();
+
+		cpuid_topo->thread_id = (gn & MIPS_GLOBALNUMBER_VP) >>
+					MIPS_GLOBALNUMBER_VP_SHF;
+		cpuid_topo->core_id = (gn & MIPS_GLOBALNUMBER_CORE) >>
+					MIPS_GLOBALNUMBER_CORE_SHF;
+		cpuid_topo->package_id = (gn & MIPS_GLOBALNUMBER_CLUSTER) >>
+					MIPS_GLOBALNUMBER_CLUSTER_SHF;
+	} else {
+		int hwid;
+
+		if (cpu_has_mips_r2_r6)
+			hwid = get_ebase_cpunum();
+		else
+			hwid = cpuid; /* Assume hwid = cpuid */
+
+		if (smp_num_siblings == 1)
+			cpuid_topo->thread_id = -1;
+		else
+			cpuid_topo->thread_id = hwid % smp_num_siblings;
+
+		cpuid_topo->core_id = hwid / smp_num_siblings;
+		/* Platform code will handle multi-cluster case */
+		cpuid_topo->package_id = 0;
+	}
+
+topology_populated:
+	update_siblings_masks(cpuid);
+	pr_info("Topology: CPU %d: cluster: %d, core: %d, vpe: %d\n", cpuid,
+		cpu_cluster(cpuid), cpu_core(cpuid), cpu_vpe_id(cpuid));
+}
+#endif
-- 
2.26.0.rc2

