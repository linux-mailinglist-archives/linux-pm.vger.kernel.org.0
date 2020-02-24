Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8716B475
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgBXWnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37351 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgBXWmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so11937862ljm.4;
        Mon, 24 Feb 2020 14:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WF2kj4FmDzbR0yv0Uxix1Kav9vk7hAtZjnTASK3L20=;
        b=u9qahEhuyzZK1qxWS3rrqcUpxI0x1J3vgCkStsFE6zDjpzCMzDIgTDq/8+wzzt4oGF
         koELwiTngAfQYjlcKNRivQMjNZ1jsJpB02SIv0xU2XzABWq18abPsxcDM8kgs2sGxgIP
         ZLlUp8WIVgNTgR2so8oF2awCiiA9/P71aXPms0Sct9HIzQXIJiq92qG+bIaj/i/sJf6v
         mgPyuL0KnkjbxSIjCrXx+W76wcIKfIwBKH12qxaPUh0iMjd1Mgsf6pphXZELo9GVywPQ
         mSbTAxiP/xJA2DjjG/nIxr7zPxknMVj8FsviKlRXry0qvUklFSSJYzKm0mGy1sk5bzoP
         BqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WF2kj4FmDzbR0yv0Uxix1Kav9vk7hAtZjnTASK3L20=;
        b=OQdjeMuQQ8lzW9mnVmmLBN0R5xs94V/6kFiKLQYZZQaStwKN2uzmxpBKhT5/KbDjRD
         QymKmWc4AmPc5FsuO+Lxm/IKRNiMmwI5AwCf/4TMJCI7X4XuryPwZM5BALOlS4Q6hOgE
         8gjGEM6ZB7nGQx3hi7HdruUIgkRn1AE7WIUCDzsZ3Ho3A0yc4RewkgFOI+uYnJuMPX+Y
         aIt/b/mg++Y3jRoWwy3XYBlfksQ1Wl5qYqeIb1agkxbZYnNGD6hjkJNfd6jgr4lJB/jG
         sm174jInYt4SPB+JcaCdRe3vvUOZmckT8jV/an5UCRDBnbxKxCxdhfMpwjzI+jPHku6c
         U+gw==
X-Gm-Message-State: APjAAAWd+B6Jht2ZiIkoK2ZwK6LLtzY9vwCkRZSfuN86BOlPJrPAh0lL
        OzAGd3NfQ1gZnc749PcWy0k=
X-Google-Smtp-Source: APXvYqw/bcXHavyh7GIdz3heqJp1Ag+JuHk6XPZ6WjMY7fScGd8Wx6wU0ebLLVkvXqwoWxEVdlyoKA==
X-Received: by 2002:a2e:9b5a:: with SMTP id o26mr31934749ljj.190.1582584161494;
        Mon, 24 Feb 2020 14:42:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 07/17] ARM: tegra: Rename some of the newly exposed PM functions
Date:   Tue, 25 Feb 2020 01:40:47 +0300
Message-Id: <20200224224057.21877-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename some of the recently exposed PM functions, prefixing them with
"tegra_pm_" in order to make the naming of the PM functions consistent.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
index aa54a76dbaa2..a5b7d4e68f43 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -91,7 +91,7 @@ static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 	while (!tegra_cpu_rail_off_ready())
 		cpu_relax();
 
-	ret = !tegra_idle_lp2_last();
+	ret = !tegra_pm_enter_lp2();
 
 	if (cpu_online(1))
 		tegra20_wake_cpu1_from_reset();
@@ -136,7 +136,7 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 	local_fiq_disable();
 
-	tegra_set_cpu_in_lp2();
+	tegra_pm_set_cpu_in_lp2();
 	cpu_pm_enter();
 
 	if (dev->cpu == 0)
@@ -145,7 +145,7 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
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
index c3946dbd0240..2667bcdb5dc6 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -265,11 +265,11 @@ ENTRY(tegra30_sleep_core_finish)
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
@@ -281,7 +281,7 @@ ENTRY(tegra30_sleep_cpu_secondary_finish)
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

