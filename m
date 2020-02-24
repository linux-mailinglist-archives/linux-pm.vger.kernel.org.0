Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8516B441
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgBXWmp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:42:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40590 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgBXWml (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so11912169ljo.7;
        Mon, 24 Feb 2020 14:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzb7X22illlIkju4bJ0sIfeS5WftdhpmfPjs+AMAHow=;
        b=I5uPYDppjA9/zyA3J3PL3y/rsEiL2v1Sdb3iScd6Y7bzMifw29aYoUYRLSjIa94ifC
         EtOIvw61OfUCRLFuyh30Ga2G68OfR19HhYfkjyl36GjzB/f28DUkFV6lem1HEpSfuNH2
         A10TCHEw/yZwYlsb/pnza7u7oBcKgXpx3vRB0PtY2pXIoiUSRIwGQAWBHe4kvdg+mcOg
         NOVCSe9c0sqk5kwdOhIgumdSs1B7rmaPambx9XZZ6n4/FLclXfbeoD/bCP9hLzdix6E8
         hzVid6SDQba66V1PEQZjRYNNNI08Wbh5muo1azq9mHTu6Co+0aeBNVbOp615qAs6tHub
         XPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzb7X22illlIkju4bJ0sIfeS5WftdhpmfPjs+AMAHow=;
        b=VKNTMQU2segN3Fhzum02KHfPHpExRoGO4ehD5c/UUOy5ofcfK5nlVccsiFKU5RNwX/
         gZY97qUrXuKpyTdpyZOmrZzdwmSaR1Yzqo4Db9GJRYuwuMCml+no2MaApj5bIuD+fU3Z
         dts1ex+tpz9sa+5eJALj8hh6BNIaApg2IUcevOd3eF9Qt3O+TVYc1pVAF0ijsjdzuq0i
         gpFBmHKHl0xXPzJ2EtWKqe/XR7TCnlUidaHjprXe4YTSdu6pT8/VAkRqNt+u12gjLt6E
         3xdtCNPCddVWOtAl1w319f7u4Rgq06D/A6MMbyPGIevrR1bAB/7LXkDEVKrKdSch57XI
         +8CQ==
X-Gm-Message-State: APjAAAWCgd7mc6krEA360Bo9pNBLj8pF7sUMmPsR2vrJVC7t6eG3ymPN
        c6ufnBlWluoxOSF0QgEKyaU=
X-Google-Smtp-Source: APXvYqz00pGKlK71RLFRjPhRaguvsSX05mJG5vChPsrF3TYAU6uQj297KcuJSYpgapmCeICOnXWYdw==
X-Received: by 2002:a2e:9587:: with SMTP id w7mr31341311ljh.42.1582584158316;
        Mon, 24 Feb 2020 14:42:38 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:37 -0800 (PST)
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
Subject: [PATCH v11 04/17] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Tue, 25 Feb 2020 01:40:44 +0300
Message-Id: <20200224224057.21877-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra30 CPUIDLE driver has intention to check whether primary CPU was
the last CPU that entered LP2 (CC6) idle-state, but that functionality
never got utilized because driver never supported the CC6 state for the
case where any secondary CPU is online. The new cpuidle driver will
properly support CC6 on Tegra30, including the case where secondary CPUs
are online, and that knowledge about what CPUs entered into CC6 won't be
needed at all because new driver will use different approach by making use
of the coupled idle-state and explicitly parking secondary CPUs before
entering into CC6. Thus this patch is just a minor cleanup change.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra30.c | 14 ++++----------
 arch/arm/mach-tegra/pm.c              |  8 +-------
 arch/arm/mach-tegra/pm.h              |  2 +-
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index c6128526877d..a3ce8dabfe18 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -98,22 +98,16 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 			    int index)
 {
 	bool entered_lp2 = false;
-	bool last_cpu;
 
 	local_fiq_disable();
 
-	last_cpu = tegra_set_cpu_in_lp2();
+	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	if (dev->cpu == 0) {
-		if (last_cpu)
-			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
-								     index);
-		else
-			cpu_do_idle();
-	} else {
+	if (dev->cpu == 0)
+		entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv, index);
+	else
 		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
-	}
 
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2();
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ff499068bb1..a72f9a2d3cb7 100644
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
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index b9cc12222bb1..2c294f6365c0 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -24,7 +24,7 @@ void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
-bool tegra_set_cpu_in_lp2(void);
+void tegra_set_cpu_in_lp2(void);
 void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
-- 
2.24.0

