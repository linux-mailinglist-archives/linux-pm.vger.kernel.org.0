Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C377710F42C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLCAnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:43:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41444 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfLCAmJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so1651442ljc.8;
        Mon, 02 Dec 2019 16:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DMFC/TKshEjchnH9K9TM7efWfj5kMXwrSGDV4MlU4Y=;
        b=n3LLOHE1XGTBJhAl+hnm2O7bkvpmae1oWJspfu5Fp8zbjDkiD/Lvj/ktCgscgnvy5l
         1t6Y7SNESeIr0I9ugKqc5R4WrTx+M3JBWyHGvrLnWZLI5A3/WtuEO29Mxjgc5btLre+D
         nCv8GzH4uPKm1EFooV8B9NVpwnIDpCqoqikX6TW+KimrVNe1mtsaIxI0MKB681sglers
         agdtjpFI5nAUPgggoRpwEyjBePSqFquVpJhKGdkf/9e7SeGNgLTXRFhHm+zG8NTusAT7
         OtEc16z8naQzT5MJwyzS+GmNumjtgx7x9qlS0qs6XsCNuqAOIsAQTq1ZpunocYDuwL3l
         ispg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DMFC/TKshEjchnH9K9TM7efWfj5kMXwrSGDV4MlU4Y=;
        b=ce4T7KtKU9oqIPs9o5WGqSXcGSa0V0IHeMKpvsMqAwWeL+y6UcfZoZrxB+Da/Nkt3M
         v7R+IFOYjTZWfkBZ861+VGz3dSZbN9oECJueQKMROH5Gya1P4sa8BIw+oo2CViiuV8ws
         i4UyeR4i/VE50VtQEenKSN2uCMvuGfSNa7kD9Hfl6YTBgAQEyWEI4DqrOe5uIBGXLccn
         wCMZFf+qdlSY40a5Dt9O45Mh28zfEXYTto4akZjgrFQ53kJgrAYyyZY4etAlbVcqyl5D
         JY1VSHpHmwLTZkggI0hjrG7pKeg/66/wmLs0H5nQD8n3Sxw2nrDIxeE3YF3XzrizSH/U
         xr/A==
X-Gm-Message-State: APjAAAXgh9BCBoXrHWIDRqrYECG7fzymJfVXN2dZt/if6pO2f2epzkpZ
        Rro3rKMYBpIKYWC/GY8fOUk=
X-Google-Smtp-Source: APXvYqwbneEmhey2S1vYkJZiB4v6pwV3qlHLdmY9aMKVT714fNtql+ZsCiHWnmHuN/eYc41IqKmH6A==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr880196ljo.169.1575333726868;
        Mon, 02 Dec 2019 16:42:06 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/19] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Tue,  3 Dec 2019 03:41:02 +0300
Message-Id: <20191203004116.11771-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Technically cpu_suspend() may fail and it's never good to lose information
about failure. For example things like cpuidle core could correctly sample
idling time in the case of failure.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 6 ++++--
 arch/arm/mach-tegra/cpuidle-tegra30.c | 4 +---
 arch/arm/mach-tegra/pm.c              | 8 ++++++--
 arch/arm/mach-tegra/pm.h              | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index f7d5041e73cc..9789541adb7d 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -87,15 +87,17 @@ static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
 					   struct cpuidle_driver *drv,
 					   int index)
 {
+	bool ret;
+
 	while (!tegra_cpu_rail_off_ready())
 		cpu_relax();
 
-	tegra_idle_lp2_last();
+	ret = !tegra_idle_lp2_last();
 
 	if (cpu_online(1))
 		tegra20_wake_cpu1_from_reset();
 
-	return true;
+	return ret;
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index a3ce8dabfe18..17cbd118abee 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -68,9 +68,7 @@ static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
 		return false;
 	}
 
-	tegra_idle_lp2_last();
-
-	return true;
+	return !tegra_idle_lp2_last();
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index a72f9a2d3cb7..a094acaca307 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -189,14 +189,16 @@ static void tegra_pm_set(enum tegra_suspend_mode mode)
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
@@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
 
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
+
+	return err;
 }
 
 enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 2c294f6365c0..7d72f31dee77 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -25,7 +25,7 @@ void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
 void tegra_set_cpu_in_lp2(void);
-void tegra_idle_lp2_last(void);
+int tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.24.0

