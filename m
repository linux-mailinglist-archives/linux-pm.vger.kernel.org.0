Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A252BD7CA2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbfJORBs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43126 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfJORBr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so20998115ljj.10;
        Tue, 15 Oct 2019 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eECpiFF9wTtPr2LwNlsrUD4amLqqYnKM7iIn6ZGHPII=;
        b=kwZUSK2AHF5XXuF9T0dr1WolzR23G94rfTwUhS8A8PwzY6aIMSmnx2NjHesETQ+rOp
         bZLHacFq4qYP/L2zCETkQatplxn9bpun4WWuS2D+xY7uAmyZK5LFLqqVcJbS4hnygxFW
         jVmzsh2Ny2JU3g60nTgmCRJY46xKiDWHIQFL7hSdYBUAzDSsF7rjYBK4HhWsIBRTPBoH
         ktPqy1WyOIGWKWMoHSJ4BXNivkm0G/6YZEk+ecyOwglAIagAVoPDaxTL/BhgY56GRe7K
         IfnSTskXZG7ynrry9xmHnQMFCG2quPcZHSjyHkJPTaDkATWXWh1BC+xQZ6l3iaxoM6XJ
         kroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eECpiFF9wTtPr2LwNlsrUD4amLqqYnKM7iIn6ZGHPII=;
        b=dv0CSQDKfhYEMJTsxhExzmfSc4ARazpcNdTYUDk3l7CNn/KEbjZ0uvYoOJPb0dJo3r
         kM7idEyyilrD0RgwV9FMrNCFrZA0IBU452qk9RhMX4cUkj7eawU2qR27UCN0etDK9buZ
         f9nAO29iO+FPUL6bwcwalMnhR13eDDlHv3WvDa1StUdIpLuJOvbu4qspZuJA3oxOPQAL
         qV9jh/h1futpXGKOXU6rYheYJD4LO/ygVlT7IexN0Qzoh9oGP+vK6hQ9+SSUHXNLSTqQ
         DiM/1Jcck3nR14a8DCusCl4ofuc4ovYPup2l6oUV8kV6jKaQrPm+ABrodB3eARXF7WsY
         lC3w==
X-Gm-Message-State: APjAAAXIpcVKudPmOey79u2QHilxPMTCkU8MFd72Jl/Tth55xvXrED+h
        v/oRWClHfbkMm0R+RgEfP4o=
X-Google-Smtp-Source: APXvYqz3bLLVqAZwgbunjG7SnV2rEolMOLVYuCMWLrQ77yJG9PnzNFe2Pi5UgUknbW0zdpnlKC6lmg==
X-Received: by 2002:a2e:9693:: with SMTP id q19mr22436455lji.6.1571158903878;
        Tue, 15 Oct 2019 10:01:43 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/18] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Tue, 15 Oct 2019 20:00:02 +0300
Message-Id: <20191015170015.1135-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
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
index 4da5d72ae030..74ba37992259 100644
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
2.23.0

