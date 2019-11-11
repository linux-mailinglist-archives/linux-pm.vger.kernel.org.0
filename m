Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160C7F8222
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKKVQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38337 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKKVQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so11015254lfa.5;
        Mon, 11 Nov 2019 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5moJgPZ2Xa4K5tgWm4Nx1p1i/obHq7JljyrRhB5JMRE=;
        b=ZttzkA9mYI7pr7d8MVapjBlUN4ytR4AA4H3Q/4rWJfE0yaQz/rqPdKI5ikrw30t52r
         /5IwpSWCt3vvE9Q/hFVLe4DU2t0x184byvq3wVrPpxiiGiCzyDrxZnH/PmCTkzUw0D7a
         pQyyX6TYKvjoLoU7mjD+nJSPmzWYuuwfMVI6SCSpHobP9NzgMorxjS5mHkPcZA28lPFv
         n7hcvYCQTJTMEVsdfzCrYXEV3Pu0lEbIKuZ/AIM1GVc6HxIPmzWqabyG0E7UvYl5iMej
         C/ieS5neFH2+kvxdv5oKt9FeQlSEHIJWeU/oSjTDzl5ObNxuzr1YTPgATTjyFMEMldbl
         PzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5moJgPZ2Xa4K5tgWm4Nx1p1i/obHq7JljyrRhB5JMRE=;
        b=QEDrNSST8CDrPw/ii9KEWuk0ZpkU6V+ugVvBRaaxF/k/xQtq0fs6SaPAmK7XhRWn2B
         F7W4u3hk3sD/erTSJN08T7dq6lvcdlvqTYwXZdfOrO57SQUzYeqOt3IlTbN3vvpDfzMC
         FYxXPHDHhneSsS0xZcy0444H61ddcJqhhswZIDX8ff9M0D+DRHoWhBzK4fraaALOqgfN
         AWVP5kpM+CByd5SQb7Pzf6opKfZ5BuP1D6WvVwYemK6uIWuQQmbLTo3VNAWlW7jrZt/U
         wl9ZUMP3EmyoijsYtQZxSTWWVjkLl5DyNPj363U+uXueAnHIWn8dvOvK0M3VP2II/SuY
         ciLw==
X-Gm-Message-State: APjAAAUdWSQaaF+6hVo5WbxRT/upwSbVIlIyRwTfVZuEmBnrq6cEI9QD
        YbV45QDau+GTiVV08+SBnk8=
X-Google-Smtp-Source: APXvYqyENGMF9SXlPr4qGV/3eRe7qevM85JCOvQQL+vx8ubTmEmeymRNPBFgEQko9Pq3j+vv3WDJXw==
X-Received: by 2002:a19:6a03:: with SMTP id u3mr3068782lfu.25.1573506988675;
        Mon, 11 Nov 2019 13:16:28 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/17] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Tue, 12 Nov 2019 00:15:43 +0300
Message-Id: <20191111211556.20723-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
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

