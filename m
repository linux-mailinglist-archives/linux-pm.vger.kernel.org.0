Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0110F42F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCAnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:43:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34928 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLCAmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so1710108lja.2;
        Mon, 02 Dec 2019 16:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lggSWbCZNX4XnKftuaR7fJMavXczez7/+ave15WB09g=;
        b=aTO2dQSxtLsNpKvjGhKfHA+Dho91ikfU8iK1uYu3rGNE2aNovu7uxkfuQ/kwT7Mjgd
         3yR11LoWQUL9+fplIPmQa7Wxr+TtrD2nmmIPFC+B+QSYvc1QtTNAWDH0ZNM9A8sKH0kA
         FPbKItZbr1LfXl0BaKHsFQz1IdRKprpiOJnVpLjb4qXaDFP16T3JBROWQR+cJ7JES5Kb
         bQV6W4MKcatkvB5N5s9js2GkiDCafVKxRqu1pYUuJj1vEqcJvn+JAcIn6g0nxtOb+/Xa
         aLGr4hJlSc1HPcdKPvWXo9hToCdmpv7sHN1ozja6oIsBFEjnHswMWSbuL6uavXjeHSWD
         Vahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lggSWbCZNX4XnKftuaR7fJMavXczez7/+ave15WB09g=;
        b=h0iFwQFqEvDYUtaRRs1n28hNhylSvOcML/taJfunUkC2yXtojTP9jIfbiWk8liDmm/
         5KnrvUZXt7PPvhHkM00MWQ/XasA6TegQV8DMuIsrqhc43WKzRhJOPI6jcHtNiMi56UQ7
         mC/bPe6zj2ELFvDBhOFhWgP28HlgUKwAeVvLMz1KSByWOjbWA86wFYZeTjAIySddIIxO
         vXLJ/nnCSdmpwrat+sTfPjqGliEH4NR0dUw3G2DT9KoL9J3cYEmpo8Nvtn1xrlfV85Y7
         ihaEVngGdSRWkjCFDMXceCBc7V8au3bJYRcwuJcvdNEPz4GFCu6jWmxW03yYDxvXRFwO
         N9Hw==
X-Gm-Message-State: APjAAAWg6YI0aAYbBhbAHe/SWXjzQqT52d6scRBJJInyRKKNPwGZOxPt
        Ael+Zx/n6HvBfG9dxaMAHprBYfok
X-Google-Smtp-Source: APXvYqxyFBmKkomgX9ONthvnDaB7i4Ua9A46iWU2dN3NEFThRceWwppnAHq/XfJY6OEZKPJNaj+f+w==
X-Received: by 2002:a2e:8e69:: with SMTP id t9mr851837ljk.91.1575333725701;
        Mon, 02 Dec 2019 16:42:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/19] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Tue,  3 Dec 2019 03:41:01 +0300
Message-Id: <20191203004116.11771-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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
2.24.0

