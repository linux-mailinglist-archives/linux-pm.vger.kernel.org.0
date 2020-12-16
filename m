Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA12DC59C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgLPRrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 12:47:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:21277 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbgLPRrG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Dec 2020 12:47:06 -0500
IronPort-SDR: 5+j0WtlbCDnvv+CerGX/D1+/WIvC+4XOMxkHRDgp8ZDf5sW9VsCc+JQPgeRNDRByOCuPwjzvSe
 Ec7BgR/Yhxqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="171593419"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="171593419"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 09:46:11 -0800
IronPort-SDR: tJMQXqgSTx46jc7Phntu/p82oYkqENqqSLs/wotaRKjVcXvIoShxsBh+u7l2XT5hiWnKfF818+
 l+Pvpae+F1+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="391854198"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2020 09:46:11 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, ning.sun@intel.com,
        kumar.n.dwarakanath@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 4/8] x86/power: Restore Key Locker internal key from the ACPI S3/4 sleep states
Date:   Wed, 16 Dec 2020 09:41:42 -0800
Message-Id: <20201216174146.10446-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216174146.10446-1-chang.seok.bae@intel.com>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
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
 arch/x86/include/asm/keylocker.h | 12 ++++++++
 arch/x86/kernel/cpu/common.c     | 25 +++++++++++-----
 arch/x86/kernel/keylocker.c      | 51 ++++++++++++++++++++++++++++++++
 arch/x86/power/cpu.c             | 34 +++++++++++++++++++++
 4 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index daf0734a4095..722574c305c2 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -6,6 +6,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/bits.h>
+#include <asm/msr.h>
 
 #define KEYLOCKER_CPUID                0x019
 #define KEYLOCKER_CPUID_EAX_SUPERVISOR BIT(0)
@@ -25,5 +26,16 @@ void invalidate_keylocker_data(void);
 #define invalidate_keylocker_data() do { } while (0)
 #endif
 
+static inline u64 read_keylocker_backup_status(void)
+{
+	u64 status;
+
+	rdmsrl(MSR_IA32_IWKEYBACKUP_STATUS, status);
+	return status;
+}
+
+void backup_keylocker(void);
+bool copy_keylocker(void);
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d675075848bb..a446d5aff08f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -463,24 +463,35 @@ __setup("nofsgsbase", x86_nofsgsbase_setup);
 
 static __always_inline void setup_keylocker(struct cpuinfo_x86 *c)
 {
-	bool keyloaded;
-
 	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
 		goto out;
 
 	cr4_set_bits(X86_CR4_KEYLOCKER);
 
 	if (c == &boot_cpu_data) {
+		bool keyloaded;
+
 		if (!check_keylocker_readiness())
 			goto disable_keylocker;
 
 		make_keylocker_data();
-	}
 
-	keyloaded = load_keylocker();
-	if (!keyloaded) {
-		pr_err_once("x86/keylocker: Failed to load internal key\n");
-		goto disable_keylocker;
+		keyloaded = load_keylocker();
+		if (!keyloaded) {
+			pr_err("x86/keylocker: Fail to load internal key\n");
+			goto disable_keylocker;
+		}
+
+		backup_keylocker();
+	} else {
+		bool keycopied;
+
+		/* NB: When system wakes up, this path recovers the internal key. */
+		keycopied = copy_keylocker();
+		if (!keycopied) {
+			pr_err_once("x86/keylocker: Fail to copy internal key\n");
+			goto disable_keylocker;
+		}
 	}
 
 	pr_info_once("x86/keylocker: Activated\n");
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index e455d806b80c..229875ac80d5 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -5,11 +5,15 @@
  */
 
 #include <linux/random.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
 
 #include <asm/keylocker.h>
 #include <asm/fpu/types.h>
 #include <asm/fpu/api.h>
 
+static bool keybackup_available;
+
 bool check_keylocker_readiness(void)
 {
 	u32 eax, ebx, ecx, edx;
@@ -21,6 +25,14 @@ bool check_keylocker_readiness(void)
 		return false;
 	}
 
+	keybackup_available = (ebx & KEYLOCKER_CPUID_EBX_BACKUP);
+	/* Internal Key backup is essential with S3/4 states */
+	if (!keybackup_available &&
+	    (acpi_sleep_state_supported(ACPI_STATE_S3) ||
+	     acpi_sleep_state_supported(ACPI_STATE_S4))) {
+		pr_debug("x86/keylocker: no key backup support with possible S3/4\n");
+		return false;
+	}
 	return true;
 }
 
@@ -29,6 +41,7 @@ bool check_keylocker_readiness(void)
 #define LOADIWKEY_NUM_OPERANDS	3
 
 static struct key {
+	bool valid;
 	struct reg_128_bit value[LOADIWKEY_NUM_OPERANDS];
 } keydata;
 
@@ -38,11 +51,15 @@ void make_keylocker_data(void)
 
 	for (i = 0; i < LOADIWKEY_NUM_OPERANDS; i++)
 		get_random_bytes(&keydata.value[i], sizeof(struct reg_128_bit));
+
+	keydata.valid = true;
 }
 
 void invalidate_keylocker_data(void)
 {
 	memset(&keydata.value, 0, sizeof(struct reg_128_bit) * LOADIWKEY_NUM_OPERANDS);
+
+	keydata.valid = false;
 }
 
 #define USE_SWKEY	0
@@ -69,3 +86,37 @@ bool load_keylocker(void)
 
 	return err ? false : true;
 }
+
+void backup_keylocker(void)
+{
+	if (keybackup_available)
+		wrmsrl(MSR_IA32_COPY_LOCAL_TO_PLATFORM, 1);
+}
+
+#define KEYRESTORE_RETRY	1
+
+bool copy_keylocker(void)
+{
+	bool copied = false;
+	int i;
+
+	/* Use valid key data when available */
+	if (keydata.valid)
+		return load_keylocker();
+
+	if (!keybackup_available)
+		return copied;
+
+	wrmsrl(MSR_IA32_COPY_PLATFORM_TO_LOCAL, 1);
+
+	for (i = 0; (i <= KEYRESTORE_RETRY) && !copied; i++) {
+		u64 status;
+
+		if (i)
+			udelay(1);
+		rdmsrl(MSR_IA32_COPY_STATUS, status);
+		copied = status & BIT(0) ? true : false;
+	}
+
+	return copied;
+}
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index db1378c6ff26..5412440e7c5c 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -25,6 +25,7 @@
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
+#include <asm/keylocker.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -57,6 +58,38 @@ static void msr_restore_context(struct saved_context *ctxt)
 	}
 }
 
+/*
+ * The boot CPU executes this function, while other CPUs restore the key
+ * through the setup path in setup_keylocker().
+ */
+static void restore_keylocker(void)
+{
+	u64 keybackup_status;
+	bool keycopied;
+
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		return;
+
+	keybackup_status = read_keylocker_backup_status();
+	if (!(keybackup_status & BIT(0))) {
+		pr_err("x86/keylocker: internal key restoration failed with %s\n",
+		       (keybackup_status & BIT(2)) ? "read error" : "invalid status");
+		WARN_ON(1);
+		goto disable_keylocker;
+	}
+
+	keycopied = copy_keylocker();
+	if (keycopied)
+		return;
+
+	pr_err("x86/keylocker: internal key copy failure\n");
+
+disable_keylocker:
+	pr_info("x86/keylocker: Disabled with internal key restoration failure\n");
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	cr4_clear_bits(X86_CR4_KEYLOCKER);
+}
+
 /**
  *	__save_processor_state - save CPU registers before creating a
  *		hibernation image and before restoring the memory state from it
@@ -265,6 +298,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	mtrr_bp_restore();
 	perf_restore_debug_store();
 	msr_restore_context(ctxt);
+	restore_keylocker();
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
-- 
2.17.1

