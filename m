Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC52125447
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLRVGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46905 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfLRVGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so1286191ljc.13;
        Wed, 18 Dec 2019 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ictt12Eq7VaaXoLWFuFA5etM79lSU8mNQN6AK4ra3FM=;
        b=PT0sDezmOHOS1LyLXQ9CFOpEW/FpT9KCJifb1HaT/VVuM5/+ajWCZfT1ZXyxb1rkKc
         5PTRL59ceZWTyuPN9L4+/dDwAjv2HjUVD9E26J9lV+XRFqlMfuGHqLBxTs0BkHNwKwkR
         OyLOv+OEf2kqJ/7zxU2XNOXdqlY9IBylopp/n+O7FqCJRVENcRLmgvl75gNXw+reC30A
         yvIrd/Ulu0wVajFLAEXkn1bfvwt4/5WAdz15NmCVwXE5G0dYOiOpEzfI1YWbXJfu2utc
         DrnDkXRZbhxLTuZtCeKxI69wQt+Uu7xLlIIOt2kDJ/M/avIP3P3Z4EbZd8M65yAZ4TT7
         rMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ictt12Eq7VaaXoLWFuFA5etM79lSU8mNQN6AK4ra3FM=;
        b=Aap5ObHI6fT/5MxGaG/ydHtL+6im3fUzAPyhoXpHiO+h7h3XR7gmDOXKn8aSqWmg0n
         +erEdh4lt7X2bCESopIyoV3Q1TXuHAUDxw6nXptImOerIb9wkQINgzvW3HgqwxcfCKdS
         P/L2CFdbdNqq5opK5Ix20umQb4R/5Dc+jTO4cluuCWCaZ7tHh6HlYZRSeAHC5DBf1xy4
         zoqBC/wt6E1KKMebjH2Agrh8fO2KI22JHDrnGsP99d2vbFLTP0VtAD7W86H9Uh+C11dH
         U4jjpq31tSD00vGf+nEayfeAycxOMaP0IDJf0ONdTGVIw+Rsz9y3yccQo3H4OmjxP8x4
         sJMg==
X-Gm-Message-State: APjAAAVxUJexcDVXW0x+/Z1/8xuoCkbHeA2xNG8dpcrkh767ozCjkYVW
        6eMDcIPPJDVjhqcA0Nmi9E4=
X-Google-Smtp-Source: APXvYqz6SkYMTz0qW4TS7TqAzKn+gLRtecXbCQFSqtJ6UW+mlbhiuOxsp2s8/zgpPVHsRNz4YrbFWQ==
X-Received: by 2002:a2e:9015:: with SMTP id h21mr3303439ljg.69.1576703202623;
        Wed, 18 Dec 2019 13:06:42 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/17] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Thu, 19 Dec 2019 00:04:50 +0300
Message-Id: <20191218210503.6689-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
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

