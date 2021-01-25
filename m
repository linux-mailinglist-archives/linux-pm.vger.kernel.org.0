Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E0303598
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 06:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbhAZFre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:47:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbhAYNH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 08:07:58 -0500
Received: from zn.tnic (p200300ec2f09db0060c9c38025ffa6e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:60c9:c380:25ff:a6e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00E081EC0575;
        Mon, 25 Jan 2021 14:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611579952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYKlKXjsX+oCUei5+F2hUw4wkcybLLJb43xcVpWhtGo=;
        b=QfNcpJYBmwuLm4TmKbBkNFY0/w2bM4KuIWqkDL7GILr9kpmfhjTeYJ59zAL/mv96e1LuTc
        /YuikTcDKFMF/r8p2WePkuC0LqssiloMLv0brxUJ1H83N6y+bKkdKqZpcbfrUCnIJZ6lLt
        /1GXUNTG2cen+pp7MPOIChU+jBHEdZI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] x86/mce: Get rid of mcheck_intel_therm_init()
Date:   Mon, 25 Jan 2021 14:05:32 +0100
Message-Id: <20210125130533.19938-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125130533.19938-1-bp@alien8.de>
References: <20210125130533.19938-1-bp@alien8.de>
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
 arch/x86/kernel/cpu/mce/therm_throt.c | 14 +++-----------
 3 files changed, 3 insertions(+), 18 deletions(-)

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
index a7cd2d203ced..5b1aa0f30655 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -633,23 +633,15 @@ static int intel_thermal_supported(struct cpuinfo_x86 *c)
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
 	int tm2 = 0;
 	u32 l, h;
 
+	if ((c == &boot_cpu_data) && intel_thermal_supported(c))
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+
 	if (!intel_thermal_supported(c))
 		return;
 
-- 
2.29.2

