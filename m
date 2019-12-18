Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD8125448
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfLRVHn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:07:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45315 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfLRVGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so2695567lfa.12;
        Wed, 18 Dec 2019 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ie7vUFxW2Ogzx3gGmiNJ7SCVyu3klkVPTvK+1NNYhsY=;
        b=Dlg1lGJcFB7RKrMofLHxtVtCwGLyvfeqURUW0nowhndTF+NYBwc1FGEeBBZckqkXSC
         6Wrgwfu+oR9vGBEuvSofZAbPOR6BYEH9OSvLr+ageGr8FomC0qkWVwPFtkI5rPZkpiID
         Yur19FN7+LJ6acSPsB1C3gwRbwYmSj9fYqbrNV1ezFDVNCZMIK5QC1+CkZFmw6MwfuGH
         gfS6KrDajtFLr7mOZnkwplfpnR6+gdKHcqjOS/ecjtGS6xI9rJxTEk9mufxTnuiTzuur
         Jul3geFr9zw4xo2UFKnTLRxjxLGi0JBwutvOSPqjqxyhe84vTnUW7KuFZIEF0A/Q6Uyq
         BBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ie7vUFxW2Ogzx3gGmiNJ7SCVyu3klkVPTvK+1NNYhsY=;
        b=sQ92a7hGo1DZypZeK9oZ56IXzbaUTdJFStQiYBgXrUccIrll8QeIJ36CrNWP45aoj1
         0DW4dVViryaYDsWbv2CIMfG6u6onqIyoZKg0T6452DbicmtIrblyayuuyjh8f19AkYag
         j5WtTdwj+fraYSh7oYF4rD6YDQMFhTW58yDLqO6WuAXvbmgjt/LR+Z7yatHbVmysqWTt
         jxjgH4GqXy2DBWPPsClFReDiD0umGI9++aKPvohSbTdTPHiGtAaJvodhVmqbJ1qqZILk
         eFejasnicDHk7ALlXmpg7DDsOPYTq2jk4NfOs8wO1din8cvt4w+7oKGxnluQ3LJZfk6t
         4aBA==
X-Gm-Message-State: APjAAAWepNgPrJv89+QtB5W3YDLgQKA6/MJjdfzUzfEeW0c1QBchkTlf
        zb8ahxeP0ZAe8Mdn+LT+vHoIqbKP
X-Google-Smtp-Source: APXvYqyWBKYh3LVXtoLrN3/ps67bf5ndBhLb3GAyOXqkjUMqdMCNmoxW8dLIyXlZRKI0ct20JYWXKg==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr3052860lfy.11.1576703203529;
        Wed, 18 Dec 2019 13:06:43 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/17] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Thu, 19 Dec 2019 00:04:51 +0300
Message-Id: <20191218210503.6689-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Technically cpu_suspend() may fail and it's never good to lose information
about failure. For example things like cpuidle core could correctly sample
idling time in the case of failure.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
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

