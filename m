Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2499D7CD0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfJORBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42130 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbfJORBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so15062017lfg.9;
        Tue, 15 Oct 2019 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5moJgPZ2Xa4K5tgWm4Nx1p1i/obHq7JljyrRhB5JMRE=;
        b=ql+EZ+qsgNkTj1l6uuRBk+HDu7XEubMfue2+p4/Rh98xlRRW78lzDTEz2PPRzTMCQT
         Nr4TimyF7bV2AuR2ulo+H+XbXH2szOfq7qWu5geaJuWtgr4WlkCIjLe84Mthud+GF2B9
         F7dyUkMR0DVPiVI4aB/rCYvsahJzCEtyMklv4eFddBS2RQHVpqqgyk9DsaRieTw7GqAw
         re/W1bEMuX1gfk0N73HiqMUmTBaIzaW85AvMTUzF2Wr9PXZ4Yjx8v5JsYuqJn3hahmHm
         BiRzQTwrYjR4MThNOBBm+vW03p/9jrZpL7RxACCuDFSVh9/kiyK3CpYPm5nrSFeQiqv9
         cJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5moJgPZ2Xa4K5tgWm4Nx1p1i/obHq7JljyrRhB5JMRE=;
        b=aDF9nMk9DNM4fpSgb4ycELOFnLpF2kZ5jFyQAryIE6oYT+SKyCxiVc5hOLHJ1s1Qwd
         kVJVTwC0vZjPOaeMsHnwgu4pMy2+xtmqw1h7+St+Gzz0oyg/HCzeKUYOQQjc84Msr3gw
         pckkc2rBlCz+F+lq2XGPIGtgHuzfCbkCt46q5EhRBG6+PNpq1fKDdl8fJOmLYUyTutio
         ftRe+gAInTeVDlobH13yXQUE8Q40L+zbSYnuCZfLStNckd8kGlf6Np5EEtyiX2XwYtK1
         yrMVGaPThRP0PJvJxVdKqmpjnU22Hdrg9/AX4r4h9M/wlqm2piiSEHd9a7RmXWBLzNVJ
         ig1A==
X-Gm-Message-State: APjAAAVlziFuKAn7KN/3mAFZyTM4wpjird9JD/CZvXRmZb92bAyz9mFt
        gVc+OHRmieKpQqHL9Da9K7Q=
X-Google-Smtp-Source: APXvYqz0N13dp4HmI2iWqx0gr7F7VoN8nEQp2x/hUAylnur/3lhCKlEWxfmQYlsIE6m16rfoWjbfGw==
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr20793012lfm.109.1571158902982;
        Tue, 15 Oct 2019 10:01:42 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/18] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Tue, 15 Oct 2019 20:00:01 +0300
Message-Id: <20191015170015.1135-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
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
2.23.0

