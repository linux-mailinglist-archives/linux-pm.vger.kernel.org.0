Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752932EEED9
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbhAHIzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 03:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhAHIzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 03:55:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A26C0612F6;
        Fri,  8 Jan 2021 00:54:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a3100e3d4b1ce3b15cc26.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3100:e3d4:b1ce:3b15:cc26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 551061EC04A9;
        Fri,  8 Jan 2021 09:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610096074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0ZH249XevcPnAX9LUW3Q//HXU6gC9lKFrkoX/QdQMM=;
        b=jj7ZweydP50eqX0H+wD1EQo47hgfj/tTSY2He1vMRVPZcfA71FPfS8PDKwXYHrEmql4Lr4
        RUVrKQcztJsoUjv8UluB84355e61oLQJzVESPYY6Wi7DNeOrbdcvPHQ1Dioz/Gc3/Tecoe
        3qRR6TzyLQc/1TsykC2zSxWBcyq6xDQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] x86/mce: Get rid of mcheck_intel_therm_init()
Date:   Fri,  8 Jan 2021 09:54:29 +0100
Message-Id: <20210108085430.13449-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108085430.13449-1-bp@alien8.de>
References: <20210108085430.13449-1-bp@alien8.de>
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
index 13d3f1cbda17..7b1bed514be1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2177,7 +2177,6 @@ __setup("mce", mcheck_enable);
 
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

