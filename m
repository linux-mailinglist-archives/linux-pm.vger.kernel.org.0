Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456E51A5C21
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 05:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDLD2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Apr 2020 23:28:41 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:54914 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgDLD2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2020 23:28:41 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Apr 2020 23:28:41 EDT
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 468A020D1E;
        Sun, 12 Apr 2020 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586662121; bh=uOA8RJFYDJP4ygAxESVEFf6smkqdOqPAglIw4clSFWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceaT4W7EigAurZnFtzPC1J2kwnJk1ll0Xv8uyh1dsEY24WINdFp1JcHpSkrxPSRhq
         G5/JGvozB3MGUMKNMxYVYOdpGb8X36477IcTYGole79ZIbt5S73dqcbFiZnn9oPuie
         FR17fzqMWX2TMtb+7VttBliQiQjIVYchQqoApD4Nk4il7LtGjf9J/iwGdYsBLyQ0WM
         U3ZlzZAJz/1C7ilSrd3DOUAJdk0Vdra+duK7S5PjtLDM4QoUm1ndB4x38GkvMpdIu9
         em9ZnLDLU1yPzSpkkRJnP0ILm7drnwSgBr5NEgLrBR9nZIZAGLTH2G+08AqZ/Dz5nZ
         hNyh6n5FJFCEA==
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
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steve Winslow <swinslow@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 07/11] MIPS: CPS & MT: Switch to new topology interface
Date:   Sun, 12 Apr 2020 11:20:37 +0800
Message-Id: <20200412032123.3896114-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the parameter of get/set topology ID functions from cpudata
to cpuid.

Also adjust include relationship to prevent conflictions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mips-cm.h  |  9 ++++---
 arch/mips/include/asm/mips-cps.h |  2 ++
 arch/mips/include/asm/smp-ops.h  |  2 --
 arch/mips/kernel/mips-cm.c       |  4 ++--
 arch/mips/kernel/mips-cpc.c      |  4 ++--
 arch/mips/kernel/pm-cps.c        | 12 +++++-----
 arch/mips/kernel/setup.c         |  1 +
 arch/mips/kernel/smp-cmp.c       |  5 ++--
 arch/mips/kernel/smp-cps.c       | 41 ++++++++++++++++----------------
 arch/mips/kernel/smp-mt.c        |  3 ++-
 drivers/cpuidle/cpuidle-cps.c    |  3 ++-
 11 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index aeae2effa123..6bab8f485bcd 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -395,8 +395,8 @@ static inline unsigned int mips_cm_max_vp_width(void)
  */
 static inline unsigned int mips_cm_vp_id(unsigned int cpu)
 {
-	unsigned int core = cpu_core(&cpu_data[cpu]);
-	unsigned int vp = cpu_vpe_id(&cpu_data[cpu]);
+	unsigned int core = cpu_core(cpu);
+	unsigned int vp = cpu_vpe_id(cpu);
 
 	return (core * mips_cm_max_vp_width()) + vp;
 }
@@ -451,9 +451,8 @@ static inline void mips_cm_unlock_other(void) { }
  */
 static inline void mips_cm_lock_other_cpu(unsigned int cpu, unsigned int block)
 {
-	struct cpuinfo_mips *d = &cpu_data[cpu];
-
-	mips_cm_lock_other(cpu_cluster(d), cpu_core(d), cpu_vpe_id(d), block);
+	mips_cm_lock_other(cpu_cluster(cpu), cpu_core(cpu),
+				cpu_vpe_id(cpu), block);
 }
 
 #endif /* __MIPS_ASM_MIPS_CM_H__ */
diff --git a/arch/mips/include/asm/mips-cps.h b/arch/mips/include/asm/mips-cps.h
index fd43d876892e..340e367fcf07 100644
--- a/arch/mips/include/asm/mips-cps.h
+++ b/arch/mips/include/asm/mips-cps.h
@@ -9,6 +9,8 @@
 
 #include <linux/io.h>
 #include <linux/types.h>
+#include <linux/smp.h>
+#include <asm/topology.h>
 
 extern unsigned long __cps_access_bad_size(void)
 	__compiletime_error("Bad size for CPS accessor");
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 65618ff1280c..a58f5b019eb7 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -13,8 +13,6 @@
 
 #include <linux/errno.h>
 
-#include <asm/mips-cps.h>
-
 #ifdef CONFIG_SMP
 
 #include <linux/cpumask.h>
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index cdb93ed91cde..7dd3b6fd9c1c 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -295,7 +295,7 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
 		 * CM 2.5 & older, so have to ensure other VP(E)s don't
 		 * race with us.
 		 */
-		curr_core = cpu_core(&current_cpu_data);
+		curr_core = cpu_core(smp_processor_id());
 		spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
 				  per_cpu(cm_core_lock_flags, curr_core));
 
@@ -316,7 +316,7 @@ void mips_cm_unlock_other(void)
 	unsigned int curr_core;
 
 	if (mips_cm_revision() < CM_REV_CM3) {
-		curr_core = cpu_core(&current_cpu_data);
+		curr_core = cpu_core(smp_processor_id());
 		spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
 				       per_cpu(cm_core_lock_flags, curr_core));
 	} else {
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 8d2535123f11..13f6f813e82a 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -94,7 +94,7 @@ void mips_cpc_lock_other(unsigned int core)
 		return;
 
 	preempt_disable();
-	curr_core = cpu_core(&current_cpu_data);
+	curr_core = cpu_core(smp_processor_id());
 	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
 			  per_cpu(cpc_core_lock_flags, curr_core));
 	write_cpc_cl_other(core << __ffs(CPC_Cx_OTHER_CORENUM));
@@ -114,7 +114,7 @@ void mips_cpc_unlock_other(void)
 		/* Systems with CM >= 3 lock the CPC via mips_cm_lock_other */
 		return;
 
-	curr_core = cpu_core(&current_cpu_data);
+	curr_core = cpu_core(smp_processor_id());
 	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
 			       per_cpu(cpc_core_lock_flags, curr_core));
 	preempt_enable();
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 9bf60d7d44d3..cd4401bc79d2 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -110,7 +110,7 @@ static void coupled_barrier(atomic_t *a, unsigned online)
 int cps_pm_enter_state(enum cps_pm_state state)
 {
 	unsigned cpu = smp_processor_id();
-	unsigned core = cpu_core(&current_cpu_data);
+	unsigned int core = cpu_core(cpu);
 	unsigned online, left;
 	cpumask_t *coupled_mask = this_cpu_ptr(&online_coupled);
 	u32 *core_ready_count, *nc_core_ready_count;
@@ -128,7 +128,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 #if defined(CONFIG_MIPS_MT) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_online(cpu)) {
 		cpumask_and(coupled_mask, cpu_online_mask,
-			    &cpu_sibling_map[cpu]);
+			    topology_sibling_cpumask(cpu));
 		online = cpumask_weight(coupled_mask);
 		cpumask_clear_cpu(cpu, coupled_mask);
 	} else
@@ -145,7 +145,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 			return -EINVAL;
 
 		core_cfg = &mips_cps_core_bootcfg[core];
-		vpe_cfg = &core_cfg->vpe_config[cpu_vpe_id(&current_cpu_data)];
+		vpe_cfg = &core_cfg->vpe_config[cpu_vpe_id(smp_processor_id())];
 		vpe_cfg->pc = (unsigned long)mips_cps_pm_restore;
 		vpe_cfg->gp = (unsigned long)current_thread_info();
 		vpe_cfg->sp = 0;
@@ -444,7 +444,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 				/* Halt the VP via the CPC VP_STOP register */
 				unsigned int vpe_id;
 
-				vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+				vpe_id = cpu_vpe_id(cpu);
 				uasm_i_addiu(&p, t0, zero, 1 << vpe_id);
 				UASM_i_LA(&p, t1, (long)addr_cpc_cl_vp_stop());
 				uasm_i_sw(&p, t0, 0, t1);
@@ -482,7 +482,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 		* defined by the interAptiv & proAptiv SUMs as ensuring that the
 		*  operation resulting from the preceding store is complete.
 		*/
-		uasm_i_addiu(&p, t0, zero, 1 << cpu_core(&cpu_data[cpu]));
+		uasm_i_addiu(&p, t0, zero, 1 << cpu_core(cpu));
 		uasm_i_sw(&p, t0, 0, r_pcohctl);
 		uasm_i_lw(&p, t0, 0, r_pcohctl);
 
@@ -636,7 +636,7 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 static int cps_pm_online_cpu(unsigned int cpu)
 {
 	enum cps_pm_state state;
-	unsigned core = cpu_core(&cpu_data[cpu]);
+	unsigned int core = cpu_core(cpu);
 	void *entry_fn, *core_rc;
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index b9fefc5dc702..92739120cb09 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -38,6 +38,7 @@
 #include <asm/cpu.h>
 #include <asm/debug.h>
 #include <asm/dma-coherence.h>
+#include <asm/mips-cps.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index 76f5824cdb00..9f775195fe0d 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -21,6 +21,7 @@
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
+#include <asm/mips-cps.h>
 #include <asm/time.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
@@ -29,8 +30,6 @@
 
 static void cmp_init_secondary(void)
 {
-	struct cpuinfo_mips *c __maybe_unused = &current_cpu_data;
-
 	/* Assume GIC is present */
 	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
 				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
@@ -39,7 +38,7 @@ static void cmp_init_secondary(void)
 
 #ifdef CONFIG_MIPS_MT_SMP
 	if (cpu_has_mipsmt)
-		cpu_set_vpe_id(c, (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
+		cpu_set_vpe_id(smp_processor_id(), (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) &
 				  TCBIND_CURVPE);
 #endif
 }
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index dbb3f1fc71ab..cf5875487d71 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -71,9 +71,10 @@ static void __init cps_smp_setup(void)
 				smp_num_siblings = core_vpes;
 
 			for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
-				cpu_set_cluster(&cpu_data[nvpes + v], cl);
-				cpu_set_core(&cpu_data[nvpes + v], c);
-				cpu_set_vpe_id(&cpu_data[nvpes + v], v);
+				cpu_set_cluster(nvpes + v, cl);
+				cpu_set_core(nvpes + v, c);
+				cpu_set_vpe_id(nvpes + v, v);
+				update_siblings_masks(nvpes + v);
 			}
 
 			nvpes += core_vpes;
@@ -85,8 +86,8 @@ static void __init cps_smp_setup(void)
 
 	/* Indicate present CPUs (CPU being synonymous with VPE) */
 	for (v = 0; v < min_t(unsigned, nvpes, NR_CPUS); v++) {
-		set_cpu_possible(v, cpu_cluster(&cpu_data[v]) == 0);
-		set_cpu_present(v, cpu_cluster(&cpu_data[v]) == 0);
+		set_cpu_possible(v, cpu_cluster(v) == 0);
+		set_cpu_present(v, cpu_cluster(v) == 0);
 		__cpu_number_map[v] = v;
 		__cpu_logical_map[v] = v;
 	}
@@ -190,8 +191,8 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	}
 
 	/* Mark this CPU as booted */
-	atomic_set(&mips_cps_core_bootcfg[cpu_core(&current_cpu_data)].vpe_mask,
-		   1 << cpu_vpe_id(&current_cpu_data));
+	atomic_set(&mips_cps_core_bootcfg[cpu_core(smp_processor_id())].vpe_mask,
+		   1 << cpu_vpe_id(smp_processor_id()));
 
 	return;
 err_out:
@@ -285,16 +286,16 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 
 static void remote_vpe_boot(void *dummy)
 {
-	unsigned core = cpu_core(&current_cpu_data);
+	unsigned int core = cpu_core(smp_processor_id());
 	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
 
-	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(&current_cpu_data));
+	mips_cps_boot_vpes(core_cfg, cpu_vpe_id(smp_processor_id()));
 }
 
 static int cps_boot_secondary(int cpu, struct task_struct *idle)
 {
-	unsigned core = cpu_core(&cpu_data[cpu]);
-	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+	unsigned int core = cpu_core(cpu);
+	unsigned int vpe_id = cpu_vpe_id(cpu);
 	struct core_boot_config *core_cfg = &mips_cps_core_bootcfg[core];
 	struct vpe_boot_config *vpe_cfg = &core_cfg->vpe_config[vpe_id];
 	unsigned long core_entry;
@@ -302,14 +303,14 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 	int err;
 
 	/* We don't yet support booting CPUs in other clusters */
-	if (cpu_cluster(&cpu_data[cpu]) != cpu_cluster(&raw_current_cpu_data))
+	if (cpu_cluster(cpu) != cpu_cluster(smp_processor_id()))
 		return -ENOSYS;
 
 	vpe_cfg->pc = (unsigned long)&smp_bootstrap;
 	vpe_cfg->sp = __KSTK_TOS(idle);
 	vpe_cfg->gp = (unsigned long)task_thread_info(idle);
 
-	atomic_or(1 << cpu_vpe_id(&cpu_data[cpu]), &core_cfg->vpe_mask);
+	atomic_or(1 << cpu_vpe_id(cpu), &core_cfg->vpe_mask);
 
 	preempt_disable();
 
@@ -406,10 +407,10 @@ static void cps_shutdown_this_cpu(enum cpu_death death)
 	unsigned int cpu, core, vpe_id;
 
 	cpu = smp_processor_id();
-	core = cpu_core(&cpu_data[cpu]);
+	core = cpu_core(cpu);
 
 	if (death == CPU_DEATH_HALT) {
-		vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+		vpe_id = cpu_vpe_id(cpu);
 
 		pr_debug("Halting core %d VP%d\n", core, vpe_id);
 		if (cpu_has_mipsmt) {
@@ -456,8 +457,8 @@ static int cps_cpu_disable(void)
 	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
 		return -EINVAL;
 
-	core_cfg = &mips_cps_core_bootcfg[cpu_core(&current_cpu_data)];
-	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
+	core_cfg = &mips_cps_core_bootcfg[cpu_core(smp_processor_id())];
+	atomic_sub(1 << cpu_vpe_id(smp_processor_id()), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
@@ -506,7 +507,7 @@ void play_dead(void)
 static void wait_for_sibling_halt(void *ptr_cpu)
 {
 	unsigned cpu = (unsigned long)ptr_cpu;
-	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+	unsigned int vpe_id = cpu_vpe_id(cpu);
 	unsigned halted;
 	unsigned long flags;
 
@@ -520,8 +521,8 @@ static void wait_for_sibling_halt(void *ptr_cpu)
 
 static void cps_cpu_die(unsigned int cpu)
 {
-	unsigned core = cpu_core(&cpu_data[cpu]);
-	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+	unsigned int core = cpu_core(cpu);
+	unsigned int vpe_id = cpu_vpe_id(cpu);
 	ktime_t fail_time;
 	unsigned stat;
 	int err;
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 5f04a0141068..5eb31b8c8ea0 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -21,6 +21,7 @@
 #include <asm/hardirq.h>
 #include <asm/mmu_context.h>
 #include <asm/time.h>
+#include <asm/topology.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/mips_mt.h>
@@ -72,7 +73,7 @@ static unsigned int __init smvp_vpe_init(unsigned int tc, unsigned int mvpconf0,
 	if (tc != 0)
 		smvp_copy_vpe_config();
 
-	cpu_set_vpe_id(&cpu_data[ncpu], tc);
+	cpu_set_vpe_id(ncpu, tc);
 
 	return ncpu;
 }
diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
index dff0ff4cc218..e6ce01751940 100644
--- a/drivers/cpuidle/cpuidle-cps.c
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -10,6 +10,7 @@
 
 #include <asm/idle.h>
 #include <asm/pm-cps.h>
+#include <asm/topology.h>
 
 /* Enumeration of the various idle states this driver may enter */
 enum cps_idle_state {
@@ -159,7 +160,7 @@ static int __init cps_cpuidle_init(void)
 		device = &per_cpu(cpuidle_dev, cpu);
 		device->cpu = cpu;
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
+		cpumask_copy(&device->coupled_cpus, topology_sibling_cpumask(cpu));
 #endif
 
 		err = cpuidle_register_device(device);
-- 
2.26.0.rc2

