Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75A16508C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 05:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfGKDNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 23:13:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39298 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDNj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 23:13:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so4177321ljh.6;
        Wed, 10 Jul 2019 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4puCheAbFkEIrSTvCDaV3kdeBokNA6IJcJ6luNaM2A=;
        b=hcaryap8+uH9ppIZOfDAj3yeQze4MnaMMKI5B8pgWQQ/LRGBO7LZNv834Sjht2srT+
         40B4k0i0fqWZpsWx1V9ygQWSup8NRYvTBdBU2o2H+MwRUCN/gbkscE5Sz7f0gr+m+Weo
         H+3qwVY1Akn0r5q2Qmq3RQhaseiKP6MHMMptChUtDQDQm1J2sWPV4HwadpJyI3tjjFu5
         xrpdZ79J+VR8noFKxlNRFCDqqqrYgOQXdADgTXIpxv/M8liXjBPl3koI5pOyE2vl3lBq
         Jzhh1W8OUA6Q5nwts9PHwcTJQk44gRGnLNx9qPGqT1NMnGWOx8XrhXb0XAqicMulmGIX
         4T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4puCheAbFkEIrSTvCDaV3kdeBokNA6IJcJ6luNaM2A=;
        b=uZD8lKGK9lxWp69XCyIZZ3G09k4PRgxo+vOohDoCfhkzgjyQR45WXEvQfw2KtGdFSb
         KKXAYZlutzSyEwNGcun3fb+pE6a1PijVTspiFYdB/Mp84R+7f2uDbeYyKJEA+66wZSbn
         wzAkgPp9Cg86kcOXA/bTX6YNNyDigQPZS6zWq70yTQQ+yxDEl+njnuGzPbWM+kfoImW2
         33IRbyaJpcIfFhGGrOb8rllxqK8sYmf7lgwpdMvWF/agDtvNbgo0fPwNhR5Rie9xtSIl
         WBSmg6wsfVKN4Bv0b1jMiYXqo8jLK3eeUwuLv1Lf+Z2lnLNcDHO8SByzoARMNTs6I1Kz
         JKuQ==
X-Gm-Message-State: APjAAAUusd9Nwj8/8Ha0/kMdQaG1HgQQ1yQ/zDuw3crFSt9nfodVaHfX
        w/twr7Sx9pZcapqh4Ro6HdX97gBo
X-Google-Smtp-Source: APXvYqzczpcl7m3Blb0GbYqejC6fAXXDR6ekaivFmz5hG2GdvhNiJKaDiLb7TcW+DzsbGjLimGsWow==
X-Received: by 2002:a2e:898b:: with SMTP id c11mr883788lji.241.1562814816866;
        Wed, 10 Jul 2019 20:13:36 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id h84sm753915ljf.42.2019.07.10.20.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:13:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ARM: tegra: Expose functions required for cpuidle driver
Date:   Thu, 11 Jul 2019 06:13:08 +0300
Message-Id: <20190711031312.10038-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711031312.10038-1-digetx@gmail.com>
References: <20190711031312.10038-1-digetx@gmail.com>
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

