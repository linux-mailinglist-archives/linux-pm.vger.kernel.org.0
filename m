Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1315110F426
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCAnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:43:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34453 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfLCAmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so1718548ljc.1;
        Mon, 02 Dec 2019 16:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7l0r4bTRWBpFt6PewqwjEw8TsFxPLheHYvKsASQ9K3g=;
        b=M8LSSJW2Uw6JUYm3suu9jGhdrjBT/2FXbLuyyHC2Ei5uFD1uby5gn/OF8xlb/BxafZ
         Q2hGs9EoxAvECDVLf9czllZPogYEr0TfAzNjyC/oNfp1+N3bkGwnZvFeQUc2MyJvf5bC
         rs69VbhuNYCGJ+WpXf016rBk2yt5snxRRF/ufJHSngLwdPJkLN7uUw6ra3XcmNbilG/0
         xcrV2Wh9oHo9brkhQfVChCtN0prh8dZgSCua4tmsXmVhumGrxnZA84dEI77GSyinQ30v
         b6GCrw1WV0FDrThFHSeyZ6M/D5cJAaPIn23xqeTEuzanU2VmddPhL2LH967NSet8ggpM
         MbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7l0r4bTRWBpFt6PewqwjEw8TsFxPLheHYvKsASQ9K3g=;
        b=PBjPbbc9QT4BQ1WHbGfZsINdUkmOAITd6ZHbhBQiB0kT1zCkcPGXjwnyakCUDxwmuQ
         5/l2/wCPHm6CskAJRI+Se94RFLhcoZcfWLncT5kpn1SVllz4bq0iYtic5ArajJV87tzw
         +d4zKQeHX1P+P5pr7FJ+EIbccELukgT8tVn8cI/EyDlqqFkCOhrKeX/w7K9SERoP/PLF
         huQbsyCBLiZ1sXtDyxDg4FdHL3Gz/wIm7enUuofV5XSY1soMPrXsEq6x2IhbcJuZ1XwT
         uLPZE03G8pmEptEltC4Wsa7V+qJ5iJjWkvHp6zCr78M3brsLAL8sjWMctprT7/qJo4qk
         sdvQ==
X-Gm-Message-State: APjAAAWGn7ks3V7O3/ZXarbWOzpNRBMAy4BIzLcy+Otm+l73IdJ8phIw
        Uzo8nZ0QEFJGTjPfHrI5AK/FqKDr
X-Google-Smtp-Source: APXvYqwc02wIGwef/Bk9nH2aNaLXu30N6RCvcrkBGh7q8i/zFQKcjjkhR0KdUdf6poKZVhM+94Uy4Q==
X-Received: by 2002:a2e:b537:: with SMTP id z23mr871541ljm.129.1575333728865;
        Mon, 02 Dec 2019 16:42:08 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 07/19] ARM: tegra: Rename some of the newly exposed PM functions
Date:   Tue,  3 Dec 2019 03:41:04 +0300
Message-Id: <20191203004116.11771-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename some of the recently exposed PM functions, prefixing them with
"tegra_pm_" in order to make the naming of the PM functions consistent.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c |  6 +++---
 arch/arm/mach-tegra/cpuidle-tegra20.c  |  6 +++---
 arch/arm/mach-tegra/cpuidle-tegra30.c  |  8 ++++----
 arch/arm/mach-tegra/pm.c               | 10 +++++-----
 arch/arm/mach-tegra/sleep-tegra30.S    |  6 +++---
 include/soc/tegra/pm.h                 | 16 ++++++++--------
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 2d8527837aeb..858c30cc5dc7 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -35,17 +35,17 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 {
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2();
+	tegra_pm_set_cpu_in_lp2();
 	cpu_pm_enter();
 
 	call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
-		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+		cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
 
 	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
+	tegra_pm_clear_cpu_in_lp2();
 
 	local_fiq_enable();
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index fdfe92068e38..9672c619f4bc 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -92,7 +92,7 @@ static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 	while (!tegra_cpu_rail_off_ready())
 		cpu_relax();
 
-	ret = !tegra_idle_lp2_last();
+	ret = !tegra_pm_enter_lp2();
 
 	if (cpu_online(1))
 		tegra20_wake_cpu1_from_reset();
@@ -137,7 +137,7 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2();
+	tegra_pm_set_cpu_in_lp2();
 	cpu_pm_enter();
 
 	if (dev->cpu == 0)
@@ -146,7 +146,7 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
 
 	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
+	tegra_pm_clear_cpu_in_lp2();
 
 	local_fiq_enable();
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 3e91c29891f7..a4f0add46a27 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -69,7 +69,7 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 		return false;
 	}
 
-	return !tegra_idle_lp2_last();
+	return !tegra_pm_enter_lp2();
 }
 
 #ifdef CONFIG_SMP
@@ -79,7 +79,7 @@ static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
 {
 	smp_wmb();
 
-	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+	cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
 
 	return true;
 }
@@ -100,7 +100,7 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2();
+	tegra_pm_set_cpu_in_lp2();
 	cpu_pm_enter();
 
 	if (dev->cpu == 0)
@@ -109,7 +109,7 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
 
 	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
+	tegra_pm_clear_cpu_in_lp2();
 
 	local_fiq_enable();
 
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index a094acaca307..7d9ef26e52a7 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -110,7 +110,7 @@ static void suspend_cpu_complex(void)
 	flowctrl_cpu_suspend_enter(cpu);
 }
 
-void tegra_clear_cpu_in_lp2(void)
+void tegra_pm_clear_cpu_in_lp2(void)
 {
 	int phy_cpu_id = cpu_logical_map(smp_processor_id());
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
@@ -123,7 +123,7 @@ void tegra_clear_cpu_in_lp2(void)
 	spin_unlock(&tegra_lp2_lock);
 }
 
-void tegra_set_cpu_in_lp2(void)
+void tegra_pm_set_cpu_in_lp2(void)
 {
 	int phy_cpu_id = cpu_logical_map(smp_processor_id());
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
@@ -189,7 +189,7 @@ static void tegra_pm_set(enum tegra_suspend_mode mode)
 	tegra_pmc_enter_suspend_mode(mode);
 }
 
-int tegra_idle_lp2_last(void)
+int tegra_pm_enter_lp2(void)
 {
 	int err;
 
@@ -356,7 +356,7 @@ static int tegra_suspend_enter(suspend_state_t state)
 		tegra_suspend_enter_lp1();
 		break;
 	case TEGRA_SUSPEND_LP2:
-		tegra_set_cpu_in_lp2();
+		tegra_pm_set_cpu_in_lp2();
 		break;
 	default:
 		break;
@@ -377,7 +377,7 @@ static int tegra_suspend_enter(suspend_state_t state)
 		tegra_suspend_exit_lp1();
 		break;
 	case TEGRA_SUSPEND_LP2:
-		tegra_clear_cpu_in_lp2();
+		tegra_pm_clear_cpu_in_lp2();
 		break;
 	default:
 		break;
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 3341a12bbb9c..5942cec9b6ef 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -262,11 +262,11 @@ ENTRY(tegra30_sleep_core_finish)
 ENDPROC(tegra30_sleep_core_finish)
 
 /*
- * tegra30_sleep_cpu_secondary_finish(unsigned long v2p)
+ * tegra30_pm_secondary_cpu_suspend(unsigned long unused_arg)
  *
  * Enters LP2 on secondary CPU by exiting coherency and powergating the CPU.
  */
-ENTRY(tegra30_sleep_cpu_secondary_finish)
+ENTRY(tegra30_pm_secondary_cpu_suspend)
 	mov	r7, lr
 
 	/* Flush and disable the L1 data cache */
@@ -278,7 +278,7 @@ ENTRY(tegra30_sleep_cpu_secondary_finish)
 	bl	tegra30_cpu_shutdown
 	mov	r0, #1                          @ never return here
 	ret	r7
-ENDPROC(tegra30_sleep_cpu_secondary_finish)
+ENDPROC(tegra30_pm_secondary_cpu_suspend)
 
 /*
  * tegra30_tear_down_cpu
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 1974e8405098..08477d7bfab9 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -23,10 +23,10 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 /* low-level resume entry point */
 void tegra_resume(void);
 
-int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
-void tegra_clear_cpu_in_lp2(void);
-void tegra_set_cpu_in_lp2(void);
-int tegra_idle_lp2_last(void);
+int tegra30_pm_secondary_cpu_suspend(unsigned long arg);
+void tegra_pm_clear_cpu_in_lp2(void);
+void tegra_pm_set_cpu_in_lp2(void);
+int tegra_pm_enter_lp2(void);
 int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline enum tegra_suspend_mode
@@ -39,20 +39,20 @@ static inline void tegra_resume(void)
 {
 }
 
-static inline int tegra30_sleep_cpu_secondary_finish(unsigned long arg)
+static inline int tegra30_pm_secondary_cpu_suspend(unsigned long arg)
 {
 	return -ENOTSUPP;
 }
 
-static inline void tegra_clear_cpu_in_lp2(void)
+static inline void tegra_pm_clear_cpu_in_lp2(void)
 {
 }
 
-static inline void tegra_set_cpu_in_lp2(void)
+static inline void tegra_pm_set_cpu_in_lp2(void)
 {
 }
 
-static inline int tegra_idle_lp2_last(void)
+static inline int tegra_pm_enter_lp2(void)
 {
 	return -ENOTSUPP;
 }
-- 
2.24.0

