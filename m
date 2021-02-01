Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715D130A9BA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 15:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBAO17 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 09:27:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhBAO1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Feb 2021 09:27:54 -0500
Received: from zn.tnic (p200300ec2f06fe0090a9523b96ecdf55.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:fe00:90a9:523b:96ec:df55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B6701EC04A9;
        Mon,  1 Feb 2021 15:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612189630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkE/n25KVXZIk24zfUsRyQEcneh3cFqA5cV8YAU3+7o=;
        b=W8FNbXnhjawS9SUpKICTVjT3wii95KXdI5GPVOf10YJnRGzIAuLWRlo4E0jWVIid4TUNbp
        oLm6x3jvyK19nJnNT3xqHwc68YXYogeCMRLcddJ5YfyWmn34X5WVYLwBLipKcL+T3lcRyL
        QCOxtjCZpSYMCB3o5RsHzaOrJ6V8PR0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v3 1/2] x86/mce: Get rid of mcheck_intel_therm_init()
Date:   Mon,  1 Feb 2021 15:27:03 +0100
Message-Id: <20210201142704.12495-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201142704.12495-1-bp@alien8.de>
References: <20210201142704.12495-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Move the APIC_LVTTHMR read which needs to happen on the BSP, to
intel_init_thermal(). One less boot dependency.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mce.h            |  6 ------
 arch/x86/kernel/cpu/mce/core.c        |  1 -
 arch/x86/kernel/cpu/mce/therm_throt.c | 15 ++++-----------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 56cdeaac76a0..def9aa5e1fa4 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -304,12 +304,6 @@ extern int (*platform_thermal_package_notify)(__u64 msr_val);
  * callback has rate control */
 extern bool (*platform_thermal_package_rate_control)(void);
 
-#ifdef CONFIG_X86_THERMAL_VECTOR
-extern void mcheck_intel_therm_init(void);
-#else
-static inline void mcheck_intel_therm_init(void) { }
-#endif
-
 /*
  * Used by APEI to report memory error via /dev/mcelog
  */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e133ce1e562b..c68e21b4ea0d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2178,7 +2178,6 @@ __setup("mce", mcheck_enable);
 
 int __init mcheck_init(void)
 {
-	mcheck_intel_therm_init();
 	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index a7cd2d203ced..5b15d7cef1d1 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -633,17 +633,6 @@ static int intel_thermal_supported(struct cpuinfo_x86 *c)
 	return 1;
 }
 
-void __init mcheck_intel_therm_init(void)
-{
-	/*
-	 * This function is only called on boot CPU. Save the init thermal
-	 * LVT value on BSP and use that value to restore APs' thermal LVT
-	 * entry BIOS programmed later
-	 */
-	if (intel_thermal_supported(&boot_cpu_data))
-		lvtthmr_init = apic_read(APIC_LVTTHMR);
-}
-
 void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
@@ -653,6 +642,10 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	if (!intel_thermal_supported(c))
 		return;
 
+	/* On the BSP? */
+	if (c == &boot_cpu_data)
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+
 	/*
 	 * First check if its enabled already, in which case there might
 	 * be some SMM goo which handles it, so we can't even put a handler
-- 
2.29.2

