Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B81A332F
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDIL2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 07:28:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgDIL2Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Apr 2020 07:28:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7493431B;
        Thu,  9 Apr 2020 04:28:16 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48A93F73D;
        Thu,  9 Apr 2020 04:28:14 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cpu/hotplug: Rename enable_nonboot_cpus()
Date:   Thu,  9 Apr 2020 12:27:42 +0100
Message-Id: <20200409112742.3581-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409112742.3581-1-qais.yousef@arm.com>
References: <20200409112742.3581-1-qais.yousef@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that disable_nonboot_cpus was removed in favour of
freeze_secondary_cpus(), rename enable_nonboot_cpus() to
thaw_secondary_cpus() to preserve the naming symmetry.

Done automatically via:

	git grep -l enable_nonboot_cpus | xargs sed -i 's/enable_nonboot_cpus/thaw_secondary_cpus/g'

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Len Brown <len.brown@intel.com>
CC: Pavel Machek <pavel@ucw.cz>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: Todd E Brandt <todd.e.brandt@linux.intel.com>
CC: linux-pm@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/power/suspend-and-cpuhotplug.rst       |  2 +-
 arch/x86/kernel/smpboot.c                            |  4 ++--
 include/linux/cpu.h                                  |  6 +++---
 include/linux/smp.h                                  |  4 ++--
 kernel/cpu.c                                         | 12 ++++++------
 .../pm-graph/config/custom-timeline-functions.cfg    |  2 +-
 tools/power/pm-graph/sleepgraph.py                   |  2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index 79f7610a6f6f..ebedb6c75db9 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -93,7 +93,7 @@ More details follow::
 Resuming back is likewise, with the counterparts being (in the order of
 execution during resume):
 
-* enable_nonboot_cpus() which involves::
+* thaw_secondary_cpus() which involves::
 
    |  Acquire cpu_add_remove_lock
    |  Decrease cpu_hotplug_disabled, thereby enabling regular cpu hotplug
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2d446c..9c31685af55a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1372,12 +1372,12 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	speculative_store_bypass_ht_init();
 }
 
-void arch_enable_nonboot_cpus_begin(void)
+void arch_thaw_secondary_cpus_begin(void)
 {
 	set_mtrr_aps_delayed_init();
 }
 
-void arch_enable_nonboot_cpus_end(void)
+void arch_thaw_secondary_cpus_end(void)
 {
 	mtrr_aps_init();
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index a00941c7828b..52692587f7fe 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -145,7 +145,7 @@ static inline void put_online_cpus(void) { cpus_read_unlock(); }
 
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
-extern void enable_nonboot_cpus(void);
+extern void thaw_secondary_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
@@ -158,11 +158,11 @@ static inline int suspend_disable_secondary_cpus(void)
 }
 static inline void suspend_enable_secondary_cpus(void)
 {
-	return enable_nonboot_cpus();
+	return thaw_secondary_cpus();
 }
 
 #else /* !CONFIG_PM_SLEEP_SMP */
-static inline void enable_nonboot_cpus(void) {}
+static inline void thaw_secondary_cpus(void) {}
 static inline int suspend_disable_secondary_cpus(void) { return 0; }
 static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
diff --git a/include/linux/smp.h b/include/linux/smp.h
index cbc9162689d0..04019872c7bc 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -227,8 +227,8 @@ static inline int get_boot_cpu_id(void)
  */
 extern void arch_disable_smp_support(void);
 
-extern void arch_enable_nonboot_cpus_begin(void);
-extern void arch_enable_nonboot_cpus_end(void);
+extern void arch_thaw_secondary_cpus_begin(void);
+extern void arch_thaw_secondary_cpus_end(void);
 
 void smp_setup_processor_id(void);
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d6d2c829561e..8d57c3cfe862 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1377,7 +1377,7 @@ int freeze_secondary_cpus(int primary)
 	/*
 	 * Make sure the CPUs won't be enabled by someone else. We need to do
 	 * this even in case of failure as all freeze_secondary_cpus() users are
-	 * supposed to do enable_nonboot_cpus() on the failure path.
+	 * supposed to do thaw_secondary_cpus() on the failure path.
 	 */
 	cpu_hotplug_disabled++;
 
@@ -1385,15 +1385,15 @@ int freeze_secondary_cpus(int primary)
 	return error;
 }
 
-void __weak arch_enable_nonboot_cpus_begin(void)
+void __weak arch_thaw_secondary_cpus_begin(void)
 {
 }
 
-void __weak arch_enable_nonboot_cpus_end(void)
+void __weak arch_thaw_secondary_cpus_end(void)
 {
 }
 
-void enable_nonboot_cpus(void)
+void thaw_secondary_cpus(void)
 {
 	int cpu, error;
 
@@ -1405,7 +1405,7 @@ void enable_nonboot_cpus(void)
 
 	pr_info("Enabling non-boot CPUs ...\n");
 
-	arch_enable_nonboot_cpus_begin();
+	arch_thaw_secondary_cpus_begin();
 
 	for_each_cpu(cpu, frozen_cpus) {
 		trace_suspend_resume(TPS("CPU_ON"), cpu, true);
@@ -1418,7 +1418,7 @@ void enable_nonboot_cpus(void)
 		pr_warn("Error taking CPU%d up: %d\n", cpu, error);
 	}
 
-	arch_enable_nonboot_cpus_end();
+	arch_thaw_secondary_cpus_end();
 
 	cpumask_clear(frozen_cpus);
 out:
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 4f80ad7d7275..962e5768681c 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -125,7 +125,7 @@ acpi_suspend_begin:
 suspend_console:
 acpi_pm_prepare:
 syscore_suspend:
-arch_enable_nonboot_cpus_end:
+arch_thaw_secondary_cpus_end:
 syscore_resume:
 acpi_pm_finish:
 resume_console:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index f7d1c1f62f86..530a9f681410 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -192,7 +192,7 @@ class SystemValues:
 		'suspend_console': {},
 		'acpi_pm_prepare': {},
 		'syscore_suspend': {},
-		'arch_enable_nonboot_cpus_end': {},
+		'arch_thaw_secondary_cpus_end': {},
 		'syscore_resume': {},
 		'acpi_pm_finish': {},
 		'resume_console': {},
-- 
2.17.1

