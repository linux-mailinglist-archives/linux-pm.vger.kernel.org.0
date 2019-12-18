Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2912541B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLRVGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:46 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42382 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfLRVGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:44 -0500
Received: by mail-lf1-f41.google.com with SMTP id y19so2709669lfl.9;
        Wed, 18 Dec 2019 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipXDQ1pS/eo+638V06UZ4nlPYu5SgXkrCJ/PIHTnzg0=;
        b=q5wj/W0jk+M3MGo8Abr8kMtLqpDPoRXrLq/B5N8kimjUtsK2GDB//nOhlyBzPw25OO
         14kaLi1b3TPZGd5DpqCVETd21/EnZd3Eqj7s7UQMXX0pMPyEb6i76GlM82p5JzQA62zJ
         aNEdQgxdSKBzC6k86jHFflexV2DLbZ9AgSZ6XgreHSiofJOcoJWl6w3VYy8ntYgPXDAO
         18YwBQUyPJTFqltdIGccpnp51EcrBJ9Q2ZvOs6fBI41BgMmiPdnFc3C9nxqY+Ne4TMa4
         +5/nImxp43sUWFkiSklLq7A3D1TdjSn8QuLoldQHkOWCtPyyOU+Dm5Zyti2MZs5zeA/1
         JHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipXDQ1pS/eo+638V06UZ4nlPYu5SgXkrCJ/PIHTnzg0=;
        b=lIJFPeT2FxkjvEVxW1ioA4Vgztn/XWTVur7XjL5d4/FvxweeTXqH9eA0Yes2OGUeTG
         eU0Z7i70Zihu+zm8TsWCZWKEwNveJSsfr4RM0TxfK+eMRTmQyjEZKJga+QflcLqY37Na
         oPdwubAnebFEEDYO7sFvH/EYQIM5eqYk6GEaAJVy+F96Q7WWWSwY3v2QHp06IASH/f/u
         uF36WS7nAS+jE4Tdl7k5gDSLMUWob0/vf5WgsgflpSXoxhw+yGDp0CfWKLZiVx50M057
         8SGXUG68vDPDW0Fc1g9grWjXKjlcYctAsLo2WgqFkwlctqrBdr3ESd0B4he8wHgu9juj
         n34A==
X-Gm-Message-State: APjAAAULZrBdpchQGNYimUSk1KiZJ6dxIIVNFW5R8s/BKEXMlqwwhlXN
        yK4xQB7DSrLclAPjyBtxd0U=
X-Google-Smtp-Source: APXvYqzaRGZoz/ZtY375U1Y7nP+sliPLzeTvpPx4/WgwczeRBe0Y5mPfDKEbOo34/tgTIdz60m+4Aw==
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr3112356lfp.82.1576703201665;
        Wed, 18 Dec 2019 13:06:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/17] ARM: tegra: Remove pen-locking from cpuidle-tegra20
Date:   Thu, 19 Dec 2019 00:04:49 +0300
Message-Id: <20191218210503.6689-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pen-locking is meant to block CPU0 if CPU1 wakes up during of entering
into LP2 because of some interrupt firing up, preventing unnecessary LP2
enter that will be resumed immediately. Apparently this case doesn't
happen often in practice, I checked how often it takes place and found
that after ~20 hours of browsing web, managing email, watching videos and
idling (15+ hours) there is only a dozen of early LP2 entering abortions
and they all happened while device was idling. Thus let's remove the
pen-locking and make LP2 entering uninterruptible, simplifying code quite
a lot. This will also become very handy for the upcoming unified cpuidle
driver, allowing to have a common LP2 code-path across of different
hardware generations.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |  46 +------
 arch/arm/mach-tegra/pm.c              |   7 --
 arch/arm/mach-tegra/pm.h              |   1 -
 arch/arm/mach-tegra/reset-handler.S   |  11 --
 arch/arm/mach-tegra/reset.h           |   9 +-
 arch/arm/mach-tegra/sleep-tegra20.S   | 170 --------------------------
 arch/arm/mach-tegra/sleep.h           |  12 --
 7 files changed, 5 insertions(+), 251 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 69f3fa270fbe..f7d5041e73cc 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -15,6 +15,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 
 #include <soc/tegra/flowctrl.h>
@@ -65,28 +66,8 @@ static struct cpuidle_driver tegra_idle_driver = {
 
 #ifdef CONFIG_PM_SLEEP
 #ifdef CONFIG_SMP
-static int tegra20_reset_sleeping_cpu_1(void)
-{
-	int ret = 0;
-
-	tegra_pen_lock();
-
-	if (readb(tegra20_cpu1_resettable_status) == CPU_RESETTABLE)
-		tegra20_cpu_shutdown(1);
-	else
-		ret = -EINVAL;
-
-	tegra_pen_unlock();
-
-	return ret;
-}
-
 static void tegra20_wake_cpu1_from_reset(void)
 {
-	tegra_pen_lock();
-
-	tegra20_cpu_clear_resettable();
-
 	/* enable cpu clock on cpu */
 	tegra_enable_cpu_clock(1);
 
@@ -95,39 +76,20 @@ static void tegra20_wake_cpu1_from_reset(void)
 
 	/* unhalt the cpu */
 	flowctrl_write_cpu_halt(1, 0);
-
-	tegra_pen_unlock();
-}
-
-static int tegra20_reset_cpu_1(void)
-{
-	if (!cpu_online(1) || !tegra20_reset_sleeping_cpu_1())
-		return 0;
-
-	tegra20_wake_cpu1_from_reset();
-	return -EBUSY;
 }
 #else
 static inline void tegra20_wake_cpu1_from_reset(void)
 {
 }
-
-static inline int tegra20_reset_cpu_1(void)
-{
-	return 0;
-}
 #endif
 
 static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
-	while (tegra20_cpu_is_resettable_soon())
+	while (!tegra_cpu_rail_off_ready())
 		cpu_relax();
 
-	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
-		return false;
-
 	tegra_idle_lp2_last();
 
 	if (cpu_online(1))
@@ -141,9 +103,7 @@ static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
 					 struct cpuidle_driver *drv,
 					 int index)
 {
-	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
-
-	tegra20_cpu_clear_resettable();
+	cpu_suspend(dev->cpu, tegra_pm_park_secondary_cpu);
 
 	return true;
 }
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index f5ff3dd1dd81..1ff499068bb1 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -137,18 +137,11 @@ bool tegra_set_cpu_in_lp2(void)
 
 	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
 		last_cpu = true;
-	else if (tegra_get_chip_id() == TEGRA20 && phy_cpu_id == 1)
-		tegra20_cpu_set_resettable_soon();
 
 	spin_unlock(&tegra_lp2_lock);
 	return last_cpu;
 }
 
-int tegra_cpu_do_idle(void)
-{
-	return cpu_do_idle();
-}
-
 static int tegra_sleep_cpu(unsigned long v2p)
 {
 	/*
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 9a790f00237f..b9cc12222bb1 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -25,7 +25,6 @@ void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
 bool tegra_set_cpu_in_lp2(void);
-int tegra_cpu_do_idle(void);
 void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index e3f34815c9da..53123ae4ac3b 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -183,17 +183,6 @@ after_errata:
 	bleq	__die				@ CPU not present (to OS)
 #endif
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	/* Are we on Tegra20? */
-	cmp	r6, #TEGRA20
-	bne	1f
-	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
-	mov	r0, #CPU_NOT_RESETTABLE
-	cmp	r10, #0
-	strbne	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
-1:
-#endif
-
 	/* Waking up from LP1? */
 	ldr	r8, [r12, #RESET_DATA(MASK_LP1)]
 	tst	r8, r11				@ if in_lp1
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index a4cfc08159f6..51265592cb1a 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -16,9 +16,8 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_RESETTABLE_STATUS	6
-#define TEGRA_RESET_TF_PRESENT		7
-#define TEGRA_RESET_DATA_SIZE		8
+#define TEGRA_RESET_TF_PRESENT		6
+#define TEGRA_RESET_DATA_SIZE		7
 
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
@@ -42,10 +41,6 @@ void __tegra_cpu_reset_handler_end(void);
 	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
 	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_LP2] - \
 	 (u32)__tegra_cpu_reset_handler_start)))
-#define tegra20_cpu1_resettable_status \
-	(IO_ADDRESS(TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET + \
-	((u32)&__tegra_cpu_reset_handler_data[TEGRA_RESET_RESETTABLE_STATUS] - \
-	 (u32)__tegra_cpu_reset_handler_start)))
 #endif
 
 #define tegra_cpu_reset_handler_offset \
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 9a89f30d53ca..0e00ba8cf646 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -43,9 +43,6 @@
 #define APB_MISC_XM2CFGCPADCTRL2	0x8e4
 #define APB_MISC_XM2CFGDPADCTRL2	0x8e8
 
-#define __tegra20_cpu1_resettable_status_offset \
-	(__tegra_cpu_reset_handler_data_offset + RESET_DATA(RESETTABLE_STATUS))
-
 .macro pll_enable, rd, r_car_base, pll_base
 	ldr	\rd, [\r_car_base, #\pll_base]
 	tst	\rd, #(1 << 30)
@@ -90,10 +87,6 @@ ENDPROC(tegra20_hotplug_shutdown)
 ENTRY(tegra20_cpu_shutdown)
 	cmp	r0, #0
 	reteq	lr			@ must not be called for CPU 0
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	mov	r12, #CPU_RESETTABLE
-	strb	r12, [r1, r2]
 
 	cpu_to_halt_reg r1, r0
 	ldr	r3, =TEGRA_FLOW_CTRL_VIRT
@@ -116,107 +109,6 @@ ENDPROC(tegra20_cpu_shutdown)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-/*
- * tegra_pen_lock
- *
- * spinlock implementation with no atomic test-and-set and no coherence
- * using Peterson's algorithm on strongly-ordered registers
- * used to synchronize a cpu waking up from wfi with entering lp2 on idle
- *
- * The reference link of Peterson's algorithm:
- * http://en.wikipedia.org/wiki/Peterson's_algorithm
- *
- * SCRATCH37 = r1 = !turn (inverted from Peterson's algorithm)
- * on cpu 0:
- * r2 = flag[0] (in SCRATCH38)
- * r3 = flag[1] (in SCRATCH39)
- * on cpu1:
- * r2 = flag[1] (in SCRATCH39)
- * r3 = flag[0] (in SCRATCH38)
- *
- * must be called with MMU on
- * corrupts r0-r3, r12
- */
-ENTRY(tegra_pen_lock)
-	mov32	r3, TEGRA_PMC_VIRT
-	cpu_id	r0
-	add	r1, r3, #PMC_SCRATCH37
-	cmp	r0, #0
-	addeq	r2, r3, #PMC_SCRATCH38
-	addeq	r3, r3, #PMC_SCRATCH39
-	addne	r2, r3, #PMC_SCRATCH39
-	addne	r3, r3, #PMC_SCRATCH38
-
-	mov	r12, #1
-	str	r12, [r2]		@ flag[cpu] = 1
-	dsb
-	str	r12, [r1]		@ !turn = cpu
-1:	dsb
-	ldr	r12, [r3]
-	cmp	r12, #1			@ flag[!cpu] == 1?
-	ldreq	r12, [r1]
-	cmpeq	r12, r0			@ !turn == cpu?
-	beq	1b			@ while !turn == cpu && flag[!cpu] == 1
-
-	ret	lr			@ locked
-ENDPROC(tegra_pen_lock)
-
-ENTRY(tegra_pen_unlock)
-	dsb
-	mov32	r3, TEGRA_PMC_VIRT
-	cpu_id	r0
-	cmp	r0, #0
-	addeq	r2, r3, #PMC_SCRATCH38
-	addne	r2, r3, #PMC_SCRATCH39
-	mov	r12, #0
-	str	r12, [r2]
-	ret     lr
-ENDPROC(tegra_pen_unlock)
-
-/*
- * tegra20_cpu_clear_resettable(void)
- *
- * Called to clear the "resettable soon" flag in IRAM variable when
- * it is expected that the secondary CPU will be idle soon.
- */
-ENTRY(tegra20_cpu_clear_resettable)
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	mov	r12, #CPU_NOT_RESETTABLE
-	strb	r12, [r1, r2]
-	ret	lr
-ENDPROC(tegra20_cpu_clear_resettable)
-
-/*
- * tegra20_cpu_set_resettable_soon(void)
- *
- * Called to set the "resettable soon" flag in IRAM variable when
- * it is expected that the secondary CPU will be idle soon.
- */
-ENTRY(tegra20_cpu_set_resettable_soon)
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	mov	r12, #CPU_RESETTABLE_SOON
-	strb	r12, [r1, r2]
-	ret	lr
-ENDPROC(tegra20_cpu_set_resettable_soon)
-
-/*
- * tegra20_cpu_is_resettable_soon(void)
- *
- * Returns true if the "resettable soon" flag in IRAM variable has been
- * set because it is expected that the secondary CPU will be idle soon.
- */
-ENTRY(tegra20_cpu_is_resettable_soon)
-	mov32	r1, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r2, =__tegra20_cpu1_resettable_status_offset
-	ldrb	r12, [r1, r2]
-	cmp	r12, #CPU_RESETTABLE_SOON
-	moveq	r0, #1
-	movne	r0, #0
-	ret	lr
-ENDPROC(tegra20_cpu_is_resettable_soon)
-
 /*
  * tegra20_sleep_core_finish(unsigned long v2p)
  *
@@ -242,68 +134,6 @@ ENTRY(tegra20_sleep_core_finish)
 	ret	r3
 ENDPROC(tegra20_sleep_core_finish)
 
-/*
- * tegra20_sleep_cpu_secondary_finish(unsigned long v2p)
- *
- * Enters WFI on secondary CPU by exiting coherency.
- */
-ENTRY(tegra20_sleep_cpu_secondary_finish)
-	stmfd	sp!, {r4-r11, lr}
-
-	mrc	p15, 0, r11, c1, c0, 1  @ save actlr before exiting coherency
-
-	/* Flush and disable the L1 data cache */
-	mov	r0, #TEGRA_FLUSH_CACHE_LOUIS
-	bl	tegra_disable_clean_inv_dcache
-
-	mov32	r0, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r4, =__tegra20_cpu1_resettable_status_offset
-	mov	r3, #CPU_RESETTABLE
-	strb	r3, [r0, r4]
-
-	bl	tegra_cpu_do_idle
-
-	/*
-	 * cpu may be reset while in wfi, which will return through
-	 * tegra_resume to cpu_resume
-	 * or interrupt may wake wfi, which will return here
-	 * cpu state is unchanged - MMU is on, cache is on, coherency
-	 * is off, and the data cache is off
-	 *
-	 * r11 contains the original actlr
-	 */
-
-	bl	tegra_pen_lock
-
-	mov32	r0, TEGRA_IRAM_RESET_BASE_VIRT
-	ldr	r4, =__tegra20_cpu1_resettable_status_offset
-	mov	r3, #CPU_NOT_RESETTABLE
-	strb	r3, [r0, r4]
-
-	bl	tegra_pen_unlock
-
-	/* Re-enable the data cache */
-	mrc	p15, 0, r10, c1, c0, 0
-	orr	r10, r10, #CR_C
-	mcr	p15, 0, r10, c1, c0, 0
-	isb
-
-	mcr	p15, 0, r11, c1, c0, 1	@ reenable coherency
-
-	/* Invalidate the TLBs & BTAC */
-	mov	r1, #0
-	mcr	p15, 0, r1, c8, c3, 0	@ invalidate shared TLBs
-	mcr	p15, 0, r1, c7, c1, 6	@ invalidate shared BTAC
-	dsb
-	isb
-
-	/* the cpu was running with coherency disabled,
-	 * caches may be out of date */
-	bl	v7_flush_kern_cache_louis
-
-	ldmfd	sp!, {r4 - r11, pc}
-ENDPROC(tegra20_sleep_cpu_secondary_finish)
-
 /*
  * tegra20_tear_down_cpu
  *
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 63e2205cbc82..4978def9db46 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -114,8 +114,6 @@
 .endm
 
 #else
-void tegra_pen_lock(void);
-void tegra_pen_unlock(void);
 void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
 void tegra_disable_clean_inv_dcache(u32 flag);
@@ -123,16 +121,6 @@ void tegra_disable_clean_inv_dcache(u32 flag);
 void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
 
-void tegra20_cpu_shutdown(int cpu);
-int tegra20_cpu_is_resettable_soon(void);
-void tegra20_cpu_clear_resettable(void);
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
-void tegra20_cpu_set_resettable_soon(void);
-#else
-static inline void tegra20_cpu_set_resettable_soon(void) {}
-#endif
-
-int tegra20_sleep_cpu_secondary_finish(unsigned long);
 void tegra20_tear_down_cpu(void);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
-- 
2.24.0

