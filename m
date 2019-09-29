Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC3C18CF
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfI2SAO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33197 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI2SAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so5341755lfc.0;
        Sun, 29 Sep 2019 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVJwFVXBEAamYflB/lqjMOTdbTS2JG3wi6554M0zQk0=;
        b=fc9pCJf1wEZb2IiwTfJqDvGJslAM/3KX+YORlFOJ4RoPfg8lnCQQhQncL+yxB93Nk3
         A4b050AcFCnFO3NPGKG3lAossJ7rubPJ8xXkiKETTwuHxlm/K8B3j/FrqXf9/y/rkd3S
         ob+QPb7TiKxdUW5rbmz0ZDeptar8Ui9sCjWX8N+0CFaxL7GKNcXPFY2pL+cjwTbG8LPP
         TJivu5uxIA9N6rJX11GaIALCGfvWWag7mKy03NYEUvk0iqbBkr+kEGmK6JuruiGAXpyd
         UL3zAqyvsmp8/jjvw7t7j8Sx/j78p7pLUIC39TiinbTo+k+BPSVPd0kRXTF8iwHZonym
         lniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVJwFVXBEAamYflB/lqjMOTdbTS2JG3wi6554M0zQk0=;
        b=hfWWVt5vdDByU0+ziZmg5MmdhS61KTTX85Mx2ET3Me0JG8+x22cbvfpxLBvpVaxSaX
         CckkWYlUtzV+GaxGPpch8+ZZyUE5rQY2F/TWM12B1sJ/GzhgfOS51gwpmFBpmcTufEK6
         n1AwtbNaiQlU2/TmN+INLaHyVM8csqnkFpYijyMSALZ2AwrdsNZGAuhtSCRTVMXpiVde
         oyn6E31anvx9fvI77wCteyu1oEj2J1wJ+G0BSh7TxSwnPXFbRtiOWMDCk/DuXP0vkEMN
         HYzUjFWSTmGIUyABDlsWork116PH0wmHBNuksAnhv+ij3NCmHUW3lCJN0PjmOqlUTc+q
         V3Ow==
X-Gm-Message-State: APjAAAXXQwojfxXISVAloZAovLk3MXy5VgkQkt4/u41SoHFy2Yf/nA/d
        XnpNbBeaWW4pC/SNDygWUpA=
X-Google-Smtp-Source: APXvYqxnwOm5TCNZ89b8v1Ub0XR4vpc7n9sIBi/JAh8ggLML2WhYRhB8OXhaweZ96nXX9fAkD9kTxg==
X-Received: by 2002:a19:98e:: with SMTP id 136mr9147200lfj.156.1569780010172;
        Sun, 29 Sep 2019 11:00:10 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/14] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Sun, 29 Sep 2019 20:59:40 +0300
Message-Id: <20190929175952.22690-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The old Tegra30 CPUIDLE driver had intention to check whether primary
CPU was the last CPU that entered LP2 (CC6) idle-state, but that
functionality never got utilized by the old-removed driver because it
never supported the CC6 while secondary CPUs were online. The new driver
will properly support CC6 on Tegra30, including the case where secondary
CPUs are online, and that knowledge about what CPUs entered CC6 won't be
needed at all because new driver will use different approach by making use
of the coupled idle-state and explicitly parking secondary CPUs before
entering into CC6.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 8 +-------
 arch/arm/mach-tegra/pm.h | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 6aaacb5757e1..2f6fb54be9f8 100644
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
index 1e51a9b636eb..3f3164ad04b7 100644
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

