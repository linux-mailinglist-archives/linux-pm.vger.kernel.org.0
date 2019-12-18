Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603C8125442
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfLRVHf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:07:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45317 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRVGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so2695716lfa.12;
        Wed, 18 Dec 2019 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBP48l4byiBlZqsnmroWnBjpQOL0lJ3WnnZsntljvo8=;
        b=XcAuezCHuo8SwUTi8kZiufEqorOLRH8wYBNY68RRHMXnzK5yNlV5y5uNQHjJWfc7de
         v31k6EvBQZvGDEzEpthzfS/0PsK+kuWaV3MqQ54i5VgPXnGtUM88mZD6Cuom8qTLS8Ot
         YYu94yTsgw4GEHM24w9+pTOx0WHPOoQhcxDAglOS/keJu2Wm/afmQIklHAW1XVQ8M5kC
         UP+VOb0brjfVVQHOpqs09l2weIgN7xd26kms9itp1UywR0RwJSSrnawEzOUprIbCDwgN
         4Ft2Pwb8yMm3N1Hw5AwFk3rICCrKwF2wuKP6mF9s1UduypC8P8BCGnTMjcJokNHJqqPX
         H+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBP48l4byiBlZqsnmroWnBjpQOL0lJ3WnnZsntljvo8=;
        b=fTp2C9h0c5PxgK08HTOyzECiZP3Skxzh1hQGzlnWQtumOGmQNBuf+9U/r+5gzp7Fpt
         zS9e42rUNKte0QBkEHk/hU/iqTJ8tDAz+SInWZpDRBgvCW2NKgOiSDcojwZDBVJjvaXX
         pXk8mSiIXbhgun5MpS2pnSG6+AbiFq7jF08vVSETugn4Ei6zItXSLoEp19Xp+odWa2Tz
         GTyO6SCjKSXkiPI2uiKmNm3IvYe/IB05s36KR/iyCsiW9HECXh/2aI0MfzhUsrh+wL6M
         Hv5FdYbpmlmY0dW22kHnHEHHZ3NAda/ncRoUi2LVNEz8wS+cihoF9uD+4DKfCfXU0cLf
         RFGA==
X-Gm-Message-State: APjAAAVYpb4UX9bEveMOanT97EJzh09xcYfR2jkzGlJ8TvUvxz5zOVGH
        sSeH/09hx4ya+sGbrjDW2D8=
X-Google-Smtp-Source: APXvYqy3XK0vi8/jqzuAxXi/vHRnPzhajaysuW7DEmjpHREVM11rk0IdAVba9NDTEAaLNpFut+Ufsw==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr3047228lfp.190.1576703206836;
        Wed, 18 Dec 2019 13:06:46 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/17] ARM: tegra: Rename some of the newly exposed PM functions
Date:   Thu, 19 Dec 2019 00:04:53 +0300
Message-Id: <20191218210503.6689-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename some of the recently exposed PM functions, prefixing them with
"tegra_pm_" in order to make the naming of the PM functions consistent.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
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
index 4f073869b8ac..3caae60a75a0 100644
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

