Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E98224801
	for <lists+linux-pm@lfdr.de>; Sat, 18 Jul 2020 04:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGRCNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgGRCNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 22:13:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8235C0619D3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 19:13:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n141so3261209yba.13
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SOXxnBtAJAVnqZoePWc8RRBmzHOqHDDfpXuIKqGg3Gs=;
        b=RmW3vila3F5dAm/LFcD8OwNQW3TcdIZFgwxucOjq3Oot1bmhRFa1WybVpoWqaqdQXB
         9KJXXyBtbGv+8FeljqYbXZLMyVAn3pSUQIF7rAkMS4MfPAf/U2gKPohgRI6Owa4GynJo
         W7fMxXIxhYZFOZayXoG8C0KWQDOkqTGIcnSOhZ8yeZd+DSVTq7JsfsFSlGzxwoUm2M1w
         Jh7amGe+qd8glR4xsIILiMXS8VRScf/E1t2j8TRzdZkEbXTdpRcNL7pDdVqkFkiEnnq3
         89CGWZ7oUryMOyHqR0wIB4WF3/QPheSU0YHkBX/hKnUDIlbcqlH95wUs5tFw5bzxBYmH
         w2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SOXxnBtAJAVnqZoePWc8RRBmzHOqHDDfpXuIKqGg3Gs=;
        b=bH0dZjBMYkG4DlsimSIFa2pYCuk5inLqZy/pI8HlmleQepieYyAUfoT0YY6RBWDztC
         QrDz80ZsjctjFl//gvFzYJNMiTTRTvyt0RSVgipX6+pi3oyXeFmK0X78tBJivwiJYM/1
         Lnmz6qJ5K66mW667mhqWsCIqrQbwdctechCDEhd4rhUXduWQYtolnMic5TNEMMadZsRz
         +OaoYi/E1hv0oKpZBKfLf4Y1Itzmjqkbov8M5LRKtdrx1GufDHwiONAZyXp2M2vL862q
         RGuQqnFNrUi2UJ4jlK8fB06+pdv7Tqrcoj4uA7FOXbsAeXw3dZIQtAhTgfYFPBsqpAvE
         RIGg==
X-Gm-Message-State: AOAM533XCMF825shr4B8hOQIR0gd8Bm4Xa2xgKy33AQq3cvGcc3RHtBs
        gKO4DQQE1STYyYORDISCfW/Ul2pY9luO
X-Google-Smtp-Source: ABdhPJx0d8pV6Yg1QbPWQD9s+A/lzUqNzOMosZuZQQUyPdF/CBpwGlAQaxA1HA013OPpYN9VePuYv0xxVUQe
X-Received: by 2002:a25:ab0e:: with SMTP id u14mr19144217ybi.181.1595038413840;
 Fri, 17 Jul 2020 19:13:33 -0700 (PDT)
Date:   Fri, 17 Jul 2020 19:13:31 -0700
Message-Id: <20200718021331.940659-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [RFC][PATCH] x86: optimization to avoid CAL+RES IPIs
From:   Josh Don <joshdon@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Venkatesh Pallipadi <venki@google.com>

smp_call_function_single and smp_send_reschedule send unconditional IPI
to target CPU. However, if the target CPU is in some form of poll based
idle, we can do IPI-less wakeups.

Doing this has certain advantages:
* Lower overhead on Async "no wait" IPI send path.
* Avoiding actual interrupts reduces system non-idle cycles.

Note that this only helps when target CPU is idle. When it is busy we
will still send an IPI as before.

*** RFC NOTE ***
This patch breaks idle time accounting (and to a lesser degree, softirq
accounting). This is because this patch violates the assumption that
softirq can only be run either on the tail of a hard IRQ or inline on
a non-idle thread via local_bh_enable(), since we can now process
softirq inline within the idle loop. These ssues can be resolved in a
later version of this patch.

Signed-off-by: Josh Don <joshdon@google.com>
---
 arch/x86/include/asm/mwait.h       |  5 +-
 arch/x86/include/asm/processor.h   |  1 +
 arch/x86/include/asm/thread_info.h |  2 +
 arch/x86/kernel/apic/ipi.c         |  8 +++
 arch/x86/kernel/smpboot.c          |  4 ++
 drivers/cpuidle/poll_state.c       |  5 +-
 include/linux/ipiless_wake.h       | 93 ++++++++++++++++++++++++++++++
 kernel/sched/idle.c                | 10 +++-
 8 files changed, 124 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/ipiless_wake.h

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index e039a933aca3..aed393f38a39 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_MWAIT_H
 #define _ASM_X86_MWAIT_H
 
+#include <linux/ipiless_wake.h>
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 
@@ -109,6 +110,7 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
+		enter_ipiless_idle();
 		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
 			mb();
 			clflush((void *)&current_thread_info()->flags);
@@ -116,8 +118,9 @@ static inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
+		if (!is_ipiless_wakeup_pending())
 			__mwait(eax, ecx);
+		exit_ipiless_idle();
 	}
 	current_clr_polling();
 }
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 03b7c4ca425a..045fc9bbd095 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -568,6 +568,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
  * have to worry about atomic accesses.
  */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
+#define TS_IPILESS_WAKEUP	0x0010	/* pending IPI-work on idle exit */
 
 static inline void
 native_load_sp0(unsigned long sp0)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..b6d3fa3c1578 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -98,6 +98,7 @@ struct thread_info {
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_IN_IPILESS_IDLE	26	/* task in IPIless idle state */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -127,6 +128,7 @@ struct thread_info {
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
+#define _TIF_IN_IPILESS_IDLE	(1 << TIF_IN_IPILESS_IDLE)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 6ca0f91372fd..6739aea98aee 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/cpumask.h>
+#include <linux/ipiless_wake.h>
 #include <linux/smp.h>
 
 #include "local.h"
@@ -67,11 +68,18 @@ void native_smp_send_reschedule(int cpu)
 		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
 		return;
 	}
+
+	if (try_ipiless_wakeup(cpu))
+		return;
+
 	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
 }
 
 void native_send_call_func_single_ipi(int cpu)
 {
+	if (try_ipiless_wakeup(cpu))
+		return;
+
 	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
 }
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ffbd9a3d78d8..3e681f0359f7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -105,6 +105,8 @@ EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
 static unsigned int logical_die __read_mostly;
 
+DEFINE_PER_CPU(unsigned long *, idletask_ti_flags);
+
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads = 1;
 
@@ -1042,6 +1044,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	unsigned long timeout;
 
 	idle->thread.sp = (unsigned long)task_pt_regs(idle);
+	per_cpu(idletask_ti_flags, cpu) = &task_thread_info(idle)->flags;
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code = (unsigned long)start_secondary;
 	initial_stack  = idle->thread.sp;
@@ -1405,6 +1408,7 @@ void __init native_smp_prepare_boot_cpu(void)
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
 	native_pv_lock_init();
+	per_cpu(idletask_ti_flags, me) = &task_thread_info(current)->flags;
 }
 
 void __init calculate_max_logical_packages(void)
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index f7e83613ae94..e48cfa8fb15f 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/cpuidle.h>
+#include <linux/ipiless_wake.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
@@ -24,7 +25,8 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
+		enter_ipiless_idle();
+		while (!is_ipiless_wakeup_pending()) {
 			cpu_relax();
 			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
 				continue;
@@ -35,6 +37,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 				break;
 			}
 		}
+		exit_ipiless_idle();
 	}
 	current_clr_polling();
 
diff --git a/include/linux/ipiless_wake.h b/include/linux/ipiless_wake.h
new file mode 100644
index 000000000000..3854845a25a0
--- /dev/null
+++ b/include/linux/ipiless_wake.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IPILESS_WAKE_H
+#define _LINUX_IPILESS_WAKE_H
+
+#include <linux/hardirq.h>
+#include <linux/sched.h>
+#include <linux/thread_info.h>
+
+#if defined(CONFIG_SMP) && defined(TIF_IN_IPILESS_IDLE)
+
+DECLARE_PER_CPU(unsigned long *, idletask_ti_flags);
+/*
+ * TIF_IN_IPILESS_IDLE CPU being in a idle state with ipiless wakeup
+ * capability, without any pending IPIs.
+ * It is conditionally reset by an IPI source CPU and the reset automatically
+ * brings the target CPU out of its idle state.
+ *
+ * TS_IPILESS_WAKEUP is only changed by local CPU and is a place to store
+ * the info that there is a pending IPI work needed after complete idle exit.
+ */
+
+static inline void enter_ipiless_idle(void)
+{
+	set_thread_flag(TIF_IN_IPILESS_IDLE);
+}
+
+static inline void exit_ipiless_idle(void)
+{
+	if (!test_and_clear_thread_flag(TIF_IN_IPILESS_IDLE)) {
+		/*
+		 * Flag was already cleared, indicating that there is
+		 * a pending IPIless wakeup.
+		 * Save that info in status for later use.
+		 */
+		current_thread_info()->status |= TS_IPILESS_WAKEUP;
+	}
+}
+
+static inline int is_ipiless_wakeup_pending(void)
+{
+	return need_resched() ||
+		unlikely(!test_thread_flag(TIF_IN_IPILESS_IDLE));
+}
+
+static inline void do_ipiless_pending_work(void)
+{
+	if (unlikely(current_thread_info()->status & TS_IPILESS_WAKEUP)) {
+		current_thread_info()->status &= ~TS_IPILESS_WAKEUP;
+
+		local_bh_disable();
+		local_irq_disable();
+
+		/*
+		 * Note: we must be in some form of idle, so no need to perform
+		 * a kvm_set_cpu_l1tf_flush_l1d().
+		 */
+
+		/* CALL_FUNCTION_SINGLE_VECTOR */
+		irq_enter();
+		generic_smp_call_function_single_interrupt();
+		irq_exit();
+
+		/* RESCHEDULE_VECTOR */
+		scheduler_ipi();
+
+		local_irq_enable();
+		local_bh_enable();
+	}
+}
+
+static inline int try_ipiless_wakeup(int cpu)
+{
+	unsigned long *ti_flags = per_cpu(idletask_ti_flags, cpu);
+
+	if (!(*ti_flags & _TIF_IN_IPILESS_IDLE))
+		return 0;
+
+	return test_and_clear_bit(TIF_IN_IPILESS_IDLE,
+					(unsigned long *)ti_flags);
+}
+
+#else
+static inline void do_ipiless_pending_work(void) { }
+static inline void enter_ipiless_idle(void) { }
+static inline void exit_ipiless_idle(void) { }
+
+static inline int is_ipiless_wakeup_pending(void)
+{
+	return need_resched();
+}
+#endif
+
+#endif /* _LINUX_IPILESS_WAKE_H */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1ae95b9150d3..8897721816d5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -8,6 +8,8 @@
  */
 #include "sched.h"
 
+#include <linux/ipiless_wake.h>
+
 #include <trace/events/power.h>
 
 /* Linker adds these: start and end of __cpuidle functions */
@@ -58,10 +60,12 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
 	stop_critical_timings();
-
-	while (!tif_need_resched() &&
+	/* caller will process ipiless work */
+	enter_ipiless_idle();
+	while (!is_ipiless_wakeup_pending() &&
 		(cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
+	exit_ipiless_idle();
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
@@ -276,6 +280,8 @@ static void do_idle(void)
 			cpuidle_idle_call();
 		}
 		arch_cpu_idle_exit();
+
+		do_ipiless_pending_work();
 	}
 
 	/*
-- 
2.28.0.rc0.105.gf9edc3c819-goog

