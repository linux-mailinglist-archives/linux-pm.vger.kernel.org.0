Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0EF821A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKKVQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41636 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfKKVQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so10989329lfb.8;
        Mon, 11 Nov 2019 13:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eECpiFF9wTtPr2LwNlsrUD4amLqqYnKM7iIn6ZGHPII=;
        b=Y9jfVczB5BNCr3VFkW1PLWqrBnOL8FLlMvT1JaMXc/mMhaJut8dA7pykjgW2zcXBTL
         8PcBMQ9/JUrPQwdRBCs8dyF/WIF+6eS8G9w88uhG6crMPDEckjWU/twSstHtlHaYt4+h
         Ztn7htOQgfD0T8s+aaLfm4HlrnS7Wus2YbLxQi9XZwEvl1VVbdqVHo6cfwxNWc5ezOgZ
         Tp26DMzBP21rLEC+3oJAoknvOE7sgQpr6XsHjpkj3lJaBja24HBVGuETtS2ZKpb1b6Rt
         d3XPxMGVtMdo8wJM7srkpIsPxAar25qxmAu5k2vwj90tLq7aMTY144gSLLKBKflkgD70
         N5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eECpiFF9wTtPr2LwNlsrUD4amLqqYnKM7iIn6ZGHPII=;
        b=fkgbyL9rnSIr28TKIdOMXyIqkkrFvnQpUDyo8YQcvy9uDkG443a62P+5atAcawy3A/
         LCvt6sW4x7ozZE69FBTYrxAzeQ8kItPNQbXpq3QJTXQmPM+UCGCRUDPZsB+L/svZWsic
         gRZ93scVwog8zjT7xIZmJ8Apw1Fdu/uQjeMw5GLO3aUDP1gi2EW9a32mMz2H8dEc5ysa
         Whti4TBKQgomQGO1mB/VFxyMkVrnM/kfxJ7Fbnugz+tP1+2chyDwvIvql1YCIShpct+w
         gZfzxr3+KZwJLkUhcJlGFDfORfQxWZXrlpnCgwo0bVl8I/NF79h7xJGKVmMzk7uaHZJ8
         KVtA==
X-Gm-Message-State: APjAAAWJmQS0sqAXZsyfOaw9m+gOXsj72FYBTNPeYw+YVW8pETviTbCa
        b4jjFrPS9YOBBHSmiMUhXTY=
X-Google-Smtp-Source: APXvYqwZY4PxHqoJQzXQLxUzKbWSkYKBR5WeOcpzc5qULr616/tX7sJJn7DKjF7yFGKUvwXc+Tbrpg==
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr6621737lfo.76.1573506989681;
        Mon, 11 Nov 2019 13:16:29 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/17] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Tue, 12 Nov 2019 00:15:44 +0300
Message-Id: <20191111211556.20723-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
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

