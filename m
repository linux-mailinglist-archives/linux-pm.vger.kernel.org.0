Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671E3811A8
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhENUVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 16:21:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:16076 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232996AbhENUVw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 May 2021 16:21:52 -0400
IronPort-SDR: hXC4Znb3M/8x9nWoAtPK7hgxLjizphYTCkyDRdL30lgavj1qmTa+40+JNf6eDJg7JNEDLCHUB4
 y33zs9F13alA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="199921590"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="199921590"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 13:20:37 -0700
IronPort-SDR: 6rYghBLjw96bsgqcY8Lr2iCL9IAz5zvRh6BG48L0q9BNVq7ay38CyLqgg9CfXhobLAcvzI8zWE
 BnE9EaB87Ing==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="438147173"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2021 13:20:36 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 05/11] x86/power: Restore Key Locker internal key from the ACPI S3/4 sleep states
Date:   Fri, 14 May 2021 13:15:02 -0700
Message-Id: <20210514201508.27967-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514201508.27967-1-chang.seok.bae@intel.com>
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the system state switches to these sleep states, the internal key gets
reset. Since this system transition is transparent to userspace, the
internal key needs to be restored properly.

Key Locker provides a mechanism to back up the internal key in non-volatile
memory. The kernel requests a backup right after the key loaded at
boot-time and copies it later when the system wakes up.

The backup during the S5 sleep state is not trusted. It is overwritten by a
new key at the next boot.

On a system with the S3/4 states, enable the feature only when the backup
mechanism is supported.

Disable the feature when the copy fails (or the backup corrupts). The
shutdown is considered too noisy. A new key is considerable only when
threads can be synchronously suspended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
Changes from RFC v1:
* Folded the warning message into the if condition check. (Rafael Wysocki)
* Rebased on the changes of the previous patches.
* Added error code for key restoration failures.
* Moved the restore helper.
* Added function descriptions.
---
 arch/x86/include/asm/keylocker.h |   3 +
 arch/x86/kernel/keylocker.c      | 122 +++++++++++++++++++++++++++++--
 arch/x86/power/cpu.c             |   2 +
 3 files changed, 122 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 870832f007ec..74b806346bee 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -7,6 +7,7 @@
 
 #include <asm/processor.h>
 #include <linux/bits.h>
+#include <asm/msr.h>
 
 #define KEYLOCKER_CPUID			0x019
 #define KEYLOCKER_CPUID_EAX_SUPERVISOR	BIT(0)
@@ -18,9 +19,11 @@
 #ifdef CONFIG_X86_KEYLOCKER
 void setup_keylocker(struct cpuinfo_x86 *c);
 void flush_keylocker_data(void);
+void restore_keylocker(void);
 #else
 #define setup_keylocker(c) do { } while (0)
 #define flush_keylocker_data() do { } while (0)
+#define restore_keylocker() do { } while (0)
 #endif
 
 #endif /*__ASSEMBLY__ */
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index d590815de508..0f60350944fa 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/random.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
 
 #include <asm/cacheflush.h>
 #include <asm/fpu/api.h>
@@ -12,10 +14,13 @@
 #include <asm/keylocker.h>
 #include <asm/tlbflush.h>
 
+static bool keybackup_available;
+
 /* Internal (Wrapping) Key size fits in three 128-bit registers. */
 #define KEYSIZE_128BIT	3
 
 static struct _keydata {
+	bool valid;
 	struct reg_128_bit value[KEYSIZE_128BIT];
 } keydata;
 
@@ -30,6 +35,8 @@ static void make_keylocker_data(void)
 
 	for (i = 0; i < KEYSIZE_128BIT; i++)
 		get_random_bytes(&keydata.value[i], sizeof(struct reg_128_bit));
+
+	keydata.valid = true;
 }
 
 /**
@@ -47,6 +54,8 @@ void flush_keylocker_data(void)
 
 	memset(keyaddr, 0, size);
 	clflush_cache_range(keyaddr, size);
+
+	keydata.valid = false;
 }
 
 #define KEYSRC_SWRAND		0
@@ -79,6 +88,40 @@ static int load_keylocker(void)
 	return err;
 }
 
+#define KEYRESTORE_RETRY	1
+
+/**
+ * copy_keylocker() - Copy the internal key from the backup.
+ *
+ * Request hardware to copy the key in non-volatile memory to the CPU state. Do this
+ * again if the copy fails. The key may not be ready when the precedent backup is
+ * still in progress.
+ *
+ * Returns:	-EBUSY if the copy fails, -ENODEV if no backup is available, or 0 if
+ *		successful.
+ */
+static int copy_keylocker(void)
+{
+	int i;
+
+	if (!keybackup_available)
+		return -ENODEV;
+
+	wrmsrl(MSR_IA32_COPY_PLATFORM_TO_LOCAL, 1);
+
+	for (i = 0; i <= KEYRESTORE_RETRY; i++) {
+		u64 status;
+
+		if (i)
+			udelay(1);
+
+		rdmsrl(MSR_IA32_COPY_STATUS, status);
+		if (status & BIT(0))
+			return 0;
+	}
+	return -EBUSY;
+}
+
 /**
  * setup_keylocker() - Enable the feature if supported.
  * @c:		A pointer to struct cpuinfo_x86
@@ -104,13 +147,43 @@ void setup_keylocker(struct cpuinfo_x86 *c)
 			goto disable;
 		}
 
+		keybackup_available = (ebx & KEYLOCKER_CPUID_EBX_BACKUP);
+		/* Internal key backup is essential with S3/4 states. */
+		if (!keybackup_available &&
+		    (acpi_sleep_state_supported(ACPI_STATE_S3) ||
+		     acpi_sleep_state_supported(ACPI_STATE_S4))) {
+			pr_debug("x86/keylocker: no key backup support with possible S3/4.\n");
+			goto disable;
+		}
+
 		make_keylocker_data();
-	}
 
-	err = load_keylocker();
-	if (err) {
-		pr_err_once("x86/keylocker: Failed to load internal key (rc: %d).\n", err);
-		goto disable;
+		err = load_keylocker();
+		if (err) {
+			pr_err_once("x86/keylocker: Failed to load internal key (rc: %d).\n", err);
+			goto disable;
+		}
+
+		/* Back up the internal key in non-volatile memory if supported. */
+		if (keybackup_available)
+			wrmsrl(MSR_IA32_COPY_LOCAL_TO_PLATFORM, 1);
+	} else {
+
+		/*
+		 * Load the internal key directly when available in memory, which is only
+		 * possible at boot-time.
+		 *
+		 * NB: When system wakes up, this path also recovers the internal key.
+		 */
+		if (keydata.valid)
+			err = load_keylocker();
+		else
+			err = copy_keylocker();
+		if (err) {
+			pr_err_once("x86/keylocker: Fail to %s internal key (rc: %d).\n",
+				    keydata.valid ? "load" : "copy", err);
+			goto disable;
+		}
 	}
 
 	pr_info_once("x86/keylocker: Enabled.\n");
@@ -123,3 +196,42 @@ void setup_keylocker(struct cpuinfo_x86 *c)
 	/* Make sure the feature disabled for kexec-reboot. */
 	cr4_clear_bits(X86_CR4_KEYLOCKER);
 }
+
+/**
+ * restore_keylocker() - Restore the internal key.
+ *
+ * The boot CPU executes this while other CPUs restore it through the setup function.
+ *
+ * Returns:	Nothing
+ */
+void restore_keylocker(void)
+{
+	u64 backup_status;
+	int err;
+
+	if (!boot_cpu_has(X86_FEATURE_KEYLOCKER))
+		return;
+
+	/*
+	 * IA32_IWKEYBACKUP_STATUS MSR contains a bitmap that indicates an invalid backup if bit 0
+	 * is set and a read (or write) error if bit 2 is set.
+	 */
+	rdmsrl(MSR_IA32_IWKEYBACKUP_STATUS, backup_status);
+	if (WARN(!(backup_status & BIT(0)),
+		 "x86/keylocker: Internal key backup access failed with %s.\n",
+		 (backup_status & BIT(2)) ? "read error" : "invalid status"))
+		goto disable_out;
+
+	err = copy_keylocker();
+	if (err) {
+		pr_err("x86/keylocker: Internal key restoration failed (rc: %d).\n", err);
+		goto disable_out;
+	}
+
+	return;
+
+disable_out:
+	pr_info("x86/keylocker: Disabled with internal key restoration failure.\n");
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	cr4_clear_bits(X86_CR4_KEYLOCKER);
+}
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 3a070e7cdb8b..ace94f07701a 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -25,6 +25,7 @@
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
+#include <asm/keylocker.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -261,6 +262,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	mtrr_bp_restore();
 	perf_restore_debug_store();
 	msr_restore_context(ctxt);
+	restore_keylocker();
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
-- 
2.17.1

