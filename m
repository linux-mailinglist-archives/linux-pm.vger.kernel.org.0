Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254D461884
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 01:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfGGXjC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 19:39:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45749 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfGGXjB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 19:39:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so14000358lje.12;
        Sun, 07 Jul 2019 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4puCheAbFkEIrSTvCDaV3kdeBokNA6IJcJ6luNaM2A=;
        b=SqTw3JDmfXvlMW3J6Mrx/7YeBADATjgfqTYZdL1SRSuJw0d4MJ9jGNg2axoITm19ko
         7dUZGe/LhXrXg7ivzPyzDc4MPLhni7AEp5/CbUCOnP28cg/sJebKatHs0qiAHhfhuKhE
         xd10QJV2V3E/A3B8a09InX7O8JGA/cPBXQ6/V0LoNNpsbzt8KWdT6Ck1mK8dvHYbsB5k
         iI25YaNgexYRT/VOIVpaZQpjpH18R7aOxaKJDyYMihnfH0YgL7BBOg752ekcDagptOSa
         SBS7uXmfKqWX0AsYuTzFfkIAXjpp0jnVNau/EHmKEjHeOArUAtCO1Pr++OfAsBIugHRa
         mzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4puCheAbFkEIrSTvCDaV3kdeBokNA6IJcJ6luNaM2A=;
        b=o/oGalV5tDm8UdBe6j8ssHAVvnCRGwRg9WEp/SO1e0+zuS6Z71zbpN2SabdbdnvmzW
         e+TTuJ8llh1fgKyGYZYVNCmZf14TGjGPmR+kJMJ2Y1mcZC9loyeBpGWfAH7tDdq0IllF
         aZ+S9Cjz/r/HRXkfIY1KMYdokCKvkZ6rdsCZYbebn+fZPbwnemKN17xPM4nXaco59PRf
         OlzznBUNfZgdAhj3VuYp2+6FEkAZfooP0YcIzu/M0uttPrBChAm2KN11Wz2/7m60vFfJ
         OLDTAQrASPRTXJajpvUdTGRxkMtaIDrHZd0puwdLgYjxg9sqAWKaHYSKZBU1UgAMLUQ3
         KErA==
X-Gm-Message-State: APjAAAUKSGBkcAUibEL67/c2nFDKhC8XTdXvMXNzo4WE5FQ88SNuzRjO
        OjEjPO5C797C9jdmkBLsu1DZCwP+
X-Google-Smtp-Source: APXvYqzymWtAArIFaYtLO3m5j3uCA2Ffc+LtomKs+ldTlKwFRUfk98oV1BB6SrYdDwPFbOYFYknrWA==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr8515380lja.230.1562542739371;
        Sun, 07 Jul 2019 16:38:59 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y5sm3246520ljj.5.2019.07.07.16.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:38:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] ARM: tegra: Expose functions required for cpuidle driver
Date:   Mon,  8 Jul 2019 02:38:05 +0300
Message-Id: <20190707233809.14400-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707233809.14400-1-digetx@gmail.com>
References: <20190707233809.14400-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The upcoming unified CPUIDLE driver will be added to the drivers/cpuidle/
directory and it will require all these Tegra PM-core functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile  |  2 +-
 arch/arm/mach-tegra/platsmp.c |  2 --
 arch/arm/mach-tegra/pm.c      | 16 +++++++---------
 arch/arm/mach-tegra/pm.h      |  3 ---
 arch/arm/mach-tegra/sleep.h   |  1 -
 include/linux/clk/tegra.h     | 13 +++++++++++++
 include/soc/tegra/pm.h        | 28 ++++++++++++++++++++++++++++
 7 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 5d93a0b36866..27bd5d9865e3 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 obj-$(CONFIG_SMP)			+= platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
+obj-y					+= hotplug.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index e6911a14c096..c8a63719a143 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -183,8 +183,6 @@ const struct smp_operations tegra_smp_ops __initconst = {
 	.smp_prepare_cpus	= tegra_smp_prepare_cpus,
 	.smp_secondary_init	= tegra_secondary_init,
 	.smp_boot_secondary	= tegra_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= tegra_cpu_kill,
 	.cpu_die		= tegra_cpu_die,
-#endif
 };
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 6aaacb5757e1..f9c9bce9e15d 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -123,11 +123,9 @@ void tegra_clear_cpu_in_lp2(void)
 	spin_unlock(&tegra_lp2_lock);
 }
 
-bool tegra_set_cpu_in_lp2(void)
+void tegra_set_cpu_in_lp2(void)
 {
 	int phy_cpu_id = cpu_logical_map(smp_processor_id());
-	bool last_cpu = false;
-	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
 
 	spin_lock(&tegra_lp2_lock);
@@ -135,11 +133,7 @@ bool tegra_set_cpu_in_lp2(void)
 	BUG_ON((*cpu_in_lp2 & BIT(phy_cpu_id)));
 	*cpu_in_lp2 |= BIT(phy_cpu_id);
 
-	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
-		last_cpu = true;
-
 	spin_unlock(&tegra_lp2_lock);
-	return last_cpu;
 }
 
 static int tegra_sleep_cpu(unsigned long v2p)
@@ -195,14 +189,16 @@ static void tegra_pm_set(enum tegra_suspend_mode mode)
 	tegra_pmc_enter_suspend_mode(mode);
 }
 
-void tegra_idle_lp2_last(void)
+int tegra_idle_lp2_last(void)
 {
+	int err;
+
 	tegra_pm_set(TEGRA_SUSPEND_LP2);
 
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
-	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
 	/*
 	 * Resume L2 cache if it wasn't re-enabled early during resume,
@@ -214,6 +210,8 @@ void tegra_idle_lp2_last(void)
 
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
+
+	return err;
 }
 
 enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 1e51a9b636eb..81525f5f4a44 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -23,9 +23,6 @@ void tegra20_sleep_core_init(void);
 void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
-void tegra_clear_cpu_in_lp2(void);
-bool tegra_set_cpu_in_lp2(void);
-void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index d219872b7546..0d9956e9a8ea 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -124,7 +124,6 @@ void tegra30_hotplug_shutdown(void);
 #endif
 
 void tegra20_tear_down_cpu(void);
-int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
 
 #endif
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index b8aef62cc3f5..cf0f2cb5e109 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -108,6 +108,19 @@ static inline void tegra_cpu_clock_resume(void)
 
 	tegra_cpu_car_ops->resume();
 }
+#else
+static inline bool tegra_cpu_rail_off_ready(void)
+{
+	return false;
+}
+
+static inline void tegra_cpu_clock_suspend(void)
+{
+}
+
+static inline void tegra_cpu_clock_resume(void)
+{
+}
 #endif
 
 extern void tegra210_xusb_pll_hw_control_enable(void);
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 951fcd738d55..fa18c2df5028 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -20,6 +20,12 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 
 /* low-level resume entry point */
 void tegra_resume(void);
+
+int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
+void tegra_clear_cpu_in_lp2(void);
+void tegra_set_cpu_in_lp2(void);
+int tegra_idle_lp2_last(void);
+void tegra_cpu_die(unsigned int cpu);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -30,6 +36,28 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
 static inline void tegra_resume(void)
 {
 }
+
+static inline int tegra30_sleep_cpu_secondary_finish(unsigned long arg)
+{
+	return -1;
+}
+
+static inline void tegra_clear_cpu_in_lp2(void)
+{
+}
+
+static inline void tegra_set_cpu_in_lp2(void)
+{
+}
+
+static inline int tegra_idle_lp2_last(void)
+{
+	return -1;
+}
+
+static inline void tegra_cpu_die(unsigned int cpu)
+{
+}
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.22.0

