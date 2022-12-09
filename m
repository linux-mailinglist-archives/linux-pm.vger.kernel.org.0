Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0D648560
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLIP1h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiLIP0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F08F0A8
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:40 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vnJwn1ai4Jmm+ebM8ZKZAqwIEEvLO5fo8/e/hdYj34M=;
        b=VZKmUx2bB/8PY9uQcGRpf0hit6LOUnvGDp8UCLvvEizfRQKTCtikgVT4n4m3/zvRr2RXXo
        lH6N+xteDeQ2HTOVm91bBaG51n7cNXQlQ3fLCnD5D/Dcwx0NIjvCMPa0G+b7mjfk+BSvwu
        fqC+n8bRZBCe1BjF+UJ91hy8SW1NmVpGrf6P3RvhH0qMy2JM4CixZlHQTkBfGvEh9MZVQQ
        vbvgmiNxtO8w8rt1ngTnnl+5utmoIIQjepbxbxEiKIZccTkmpBt4NmljVDUoL0+0N152KV
        irIOoU309xudiuUrLKmOHSI2U43q//BBaq5SkBtT1FdINhsFKdsLVrCG8oC7Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599597;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vnJwn1ai4Jmm+ebM8ZKZAqwIEEvLO5fo8/e/hdYj34M=;
        b=A75qOlPKy/9kEHFynXgAXVgoZt52k7C+r4QLpR0qjemLaDiRl41blGkVLozOYFPbYckZ3v
        IREsRJ+HcS0qh2Ag==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: Protect clearing of thermal
 status bits
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959704.4906.15904260726349125512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     930d06bf071aa746db11d68d2d75660b449deff3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//930d06bf071aa746db11d68d2d75660b449deff3
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Tue, 15 Nov 2022 18:54:17 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 23 Nov 2022 20:09:06 +01:00

thermal: intel: Protect clearing of thermal status bits

The clearing of the package thermal status is done by Read-Modify-Write
operation. This may result in clearing of some new status bits which are
being or about to be processed.

For example, while clearing of HFI status, after read of thermal status
register, a new thermal status bit is set by the hardware. But during
write back, the newly generated status bit will be set to 0 or cleared.
So, it is not safe to do read-modify-write.

Since thermal status Read-Write bits can be set to only 0 not 1, it is
safe to set all other bits to 1 which are not getting cleared.

Create a common interface for clearing package thermal status bits. Use
this interface to replace existing code to clear thermal package status
bits.

It is safe to call from different CPUs without protection as there is no
read-modify-write. Also wrmsrl results in just single instruction. For
example while CPU 0 and CPU 3 are clearing bit 1 and 3 respectively. If
CPU 3 wins the race, it will write 0x4000aa2, then CPU 1 will write
0x4000aa8. The bits which are not part of clear are set to 1. The default
mask for bits, which can be written here is 0x4000aaa.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_hfi.c            |  8 +------
 drivers/thermal/intel/therm_throt.c          | 23 +++++++++----------
 drivers/thermal/intel/thermal_interrupt.h    |  6 +++++-
 drivers/thermal/intel/x86_pkg_temp_thermal.c |  9 +------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 239afe0..65b9029 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -42,9 +42,7 @@
 
 #include "../thermal_core.h"
 #include "intel_hfi.h"
-
-#define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
-				     BIT(9) | BIT(11) | BIT(26))
+#include "thermal_interrupt.h"
 
 /* Hardware Feedback Interface MSR configuration bits */
 #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
@@ -304,9 +302,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	 * Let hardware know that we are done reading the HFI table and it is
 	 * free to update it again.
 	 */
-	pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
-				    ~PACKAGE_THERM_STATUS_HFI_UPDATED;
-	wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
+	thermal_clear_package_intr_status(PACKAGE_LEVEL, PACKAGE_THERM_STATUS_HFI_UPDATED);
 
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
 			   HFI_UPDATE_INTERVAL);
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 9e8ab31..4bb7fdd 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -190,32 +190,33 @@ static const struct attribute_group thermal_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
-#define CORE_LEVEL	0
-#define PACKAGE_LEVEL	1
-
 #define THERM_THROT_POLL_INTERVAL	HZ
 #define THERM_STATUS_PROCHOT_LOG	BIT(1)
 
 #define THERM_STATUS_CLEAR_CORE_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(13) | BIT(15))
 #define THERM_STATUS_CLEAR_PKG_MASK  (BIT(1) | BIT(3) | BIT(5) | BIT(7) | BIT(9) | BIT(11) | BIT(26))
 
-static void clear_therm_status_log(int level)
+/*
+ * Clear the bits in package thermal status register for bit = 1
+ * in bitmask
+ */
+void thermal_clear_package_intr_status(int level, u64 bit_mask)
 {
+	u64 msr_val;
 	int msr;
-	u64 mask, msr_val;
 
 	if (level == CORE_LEVEL) {
 		msr  = MSR_IA32_THERM_STATUS;
-		mask = THERM_STATUS_CLEAR_CORE_MASK;
+		msr_val = THERM_STATUS_CLEAR_CORE_MASK;
 	} else {
 		msr  = MSR_IA32_PACKAGE_THERM_STATUS;
-		mask = THERM_STATUS_CLEAR_PKG_MASK;
+		msr_val = THERM_STATUS_CLEAR_PKG_MASK;
 	}
 
-	rdmsrl(msr, msr_val);
-	msr_val &= mask;
-	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
+	msr_val &= ~bit_mask;
+	wrmsrl(msr, msr_val);
 }
+EXPORT_SYMBOL_GPL(thermal_clear_package_intr_status);
 
 static void get_therm_status(int level, bool *proc_hot, u8 *temp)
 {
@@ -295,7 +296,7 @@ static void __maybe_unused throttle_active_work(struct work_struct *work)
 	state->average = avg;
 
 re_arm:
-	clear_therm_status_log(state->level);
+	thermal_clear_package_intr_status(state->level, THERM_STATUS_PROCHOT_LOG);
 	schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
 }
 
diff --git a/drivers/thermal/intel/thermal_interrupt.h b/drivers/thermal/intel/thermal_interrupt.h
index 01e7bed..01dfd4c 100644
--- a/drivers/thermal/intel/thermal_interrupt.h
+++ b/drivers/thermal/intel/thermal_interrupt.h
@@ -2,6 +2,9 @@
 #ifndef _INTEL_THERMAL_INTERRUPT_H
 #define _INTEL_THERMAL_INTERRUPT_H
 
+#define CORE_LEVEL	0
+#define PACKAGE_LEVEL	1
+
 /* Interrupt Handler for package thermal thresholds */
 extern int (*platform_thermal_package_notify)(__u64 msr_val);
 
@@ -15,4 +18,7 @@ extern bool (*platform_thermal_package_rate_control)(void);
 /* Handle HWP interrupt */
 extern void notify_hwp_interrupt(void);
 
+/* Common function to clear Package thermal status register */
+extern void thermal_clear_package_intr_status(int level, u64 bit_mask);
+
 #endif /* _INTEL_THERMAL_INTERRUPT_H */
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index a0e234f..84c3a11 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -265,7 +265,6 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	struct thermal_zone_device *tzone = NULL;
 	int cpu = smp_processor_id();
 	struct zone_device *zonedev;
-	u64 msr_val, wr_val;
 
 	mutex_lock(&thermal_zone_mutex);
 	raw_spin_lock_irq(&pkg_temp_lock);
@@ -279,12 +278,8 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
 	}
 	zonedev->work_scheduled = false;
 
-	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
-	wr_val = msr_val & ~(THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
-	if (wr_val != msr_val) {
-		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, wr_val);
-		tzone = zonedev->tzone;
-	}
+	thermal_clear_package_intr_status(PACKAGE_LEVEL, THERM_LOG_THRESHOLD0 | THERM_LOG_THRESHOLD1);
+	tzone = zonedev->tzone;
 
 	enable_pkg_thres_interrupt();
 	raw_spin_unlock_irq(&pkg_temp_lock);
