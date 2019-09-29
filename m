Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C135C18CB
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfI2SAR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46947 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbfI2SAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so5283239lfc.13;
        Sun, 29 Sep 2019 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RptpaDUxXrw3BpU/T4vq1rijHUh8vyrzkTNBzahvDA=;
        b=f6ZjKJnYlGmBBN7gvHgoyC9su7djXyxy/uIxAf08UhnwuXTJmdaZmA18PQUeHgNl+v
         61qG6xbA/hOeBdSZUvS96yVkV6qa3fRs5SqSHvP5tvtQH+Di1i9vEDdDr6pauH6ehvrq
         R3wHK0dQt3sU3IAWozuMM6d098wGfBrNgqJoJ0dlpQ6xnygiDuD95TjuUFcPscwgVVz1
         R2hfM7KhOR7WNY1pwKJUXs6UJqCarIpUExu6gyxOK9slcJS2Upv+MTxXXzJFOft9d2vc
         wwNxhZDYhwquFhyGNfNVeuohwhoekVwYHCln71Qs2Y3Jyug1Xir46o4pzJywtKUSNG3U
         lEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RptpaDUxXrw3BpU/T4vq1rijHUh8vyrzkTNBzahvDA=;
        b=jQsSHE30C17PA/eOLaTwSMf3BwTy23PVSM2OvwmJOBdIrAQHBBGkaqgl5H01qdqRMv
         iHGI43CEBzs09XhbrjWbE0xXnw/iE+tSCt1zUP1FARN1Fj26U5OoXojCECjzdFjCcx2i
         BVSh5vJ2+5alR+1Z8gBAxBsQ3lQL35tHQHDiY58m8V/HmY07ozi8duncmYT87qwJLUPV
         xYLyojMWg1jm2S6QothlN3QDFEPUlDDMA0BM44Af4hFZN0G6Zxx7414Ooh+y5ZkNXwAU
         dQQEFau8nT/j1u0KIXtffJ5OUwap0lwDU7NRfKTNGYzbpebBU3hF13USvdSHb0Hsfj1v
         w0Xw==
X-Gm-Message-State: APjAAAWXXWgXv7VYIA4fR9T0AjgSpvR2uULOPq7Qm9wD4EOI539dVWL/
        2wWqzezRoST20dHFq0l5gRA=
X-Google-Smtp-Source: APXvYqy55L9uI6YBnO6btMW6GZoKn61AZx14mopA7bllS3XRL/f6VEMSzzzd0cbRs+/pfurzBS3y0A==
X-Received: by 2002:a19:a408:: with SMTP id q8mr8528427lfc.94.1569780013746;
        Sun, 29 Sep 2019 11:00:13 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/14] ARM: tegra: Rename some of the newly exposed PM functions
Date:   Sun, 29 Sep 2019 20:59:44 +0300
Message-Id: <20190929175952.22690-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename some of the recently exposed PM functions, prefixing them with
"tegra_pm_" and making naming of those functions more meaningful, for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 10 +++++-----
 arch/arm/mach-tegra/sleep-tegra30.S |  6 +++---
 include/soc/tegra/pm.h              | 16 ++++++++--------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index f9c9bce9e15d..4cc64a135a3e 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -110,7 +110,7 @@ static void suspend_cpu_complex(void)
 	flowctrl_cpu_suspend_enter(cpu);
 }
 
-void tegra_clear_cpu_in_lp2(void)
+void tegra_pm_clear_cpu_in_lp2(void)
 {
 	int phy_cpu_id = cpu_logical_map(smp_processor_id());
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
@@ -123,7 +123,7 @@ void tegra_clear_cpu_in_lp2(void)
 	spin_unlock(&tegra_lp2_lock);
 }
 
-void tegra_set_cpu_in_lp2(void)
+void tegra_pm_set_cpu_in_lp2(void)
 {
 	int phy_cpu_id = cpu_logical_map(smp_processor_id());
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
@@ -189,7 +189,7 @@ static void tegra_pm_set(enum tegra_suspend_mode mode)
 	tegra_pmc_enter_suspend_mode(mode);
 }
 
-int tegra_idle_lp2_last(void)
+int tegra_pm_enter_lp2(void)
 {
 	int err;
 
@@ -356,7 +356,7 @@ static int tegra_suspend_enter(suspend_state_t state)
 		tegra_suspend_enter_lp1();
 		break;
 	case TEGRA_SUSPEND_LP2:
-		tegra_set_cpu_in_lp2();
+		tegra_pm_set_cpu_in_lp2();
 		break;
 	default:
 		break;
@@ -377,7 +377,7 @@ static int tegra_suspend_enter(suspend_state_t state)
 		tegra_suspend_exit_lp1();
 		break;
 	case TEGRA_SUSPEND_LP2:
-		tegra_clear_cpu_in_lp2();
+		tegra_pm_clear_cpu_in_lp2();
 		break;
 	default:
 		break;
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index b408fa56eb89..386319a3d2d2 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -262,11 +262,11 @@ ENTRY(tegra30_sleep_core_finish)
 ENDPROC(tegra30_sleep_core_finish)
 
 /*
- * tegra30_sleep_cpu_secondary_finish(unsigned long v2p)
+ * tegra30_pm_secondary_cpu_suspend(unsigned long unused_arg)
  *
  * Enters LP2 on secondary CPU by exiting coherency and powergating the CPU.
  */
-ENTRY(tegra30_sleep_cpu_secondary_finish)
+ENTRY(tegra30_pm_secondary_cpu_suspend)
 	mov	r7, lr
 
 	/* Flush and disable the L1 data cache */
@@ -278,7 +278,7 @@ ENTRY(tegra30_sleep_cpu_secondary_finish)
 	bl	tegra30_cpu_shutdown
 	mov	r0, #1                          @ never return here
 	ret	r7
-ENDPROC(tegra30_sleep_cpu_secondary_finish)
+ENDPROC(tegra30_pm_secondary_cpu_suspend)
 
 /*
  * tegra30_tear_down_cpu
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index bc1abdf41d61..2fbee9efda21 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -23,10 +23,10 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 /* low-level resume entry point */
 void tegra_resume(void);
 
-int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
-void tegra_clear_cpu_in_lp2(void);
-void tegra_set_cpu_in_lp2(void);
-int tegra_idle_lp2_last(void);
+int tegra30_pm_secondary_cpu_suspend(unsigned long arg);
+void tegra_pm_clear_cpu_in_lp2(void);
+void tegra_pm_set_cpu_in_lp2(void);
+int tegra_pm_enter_lp2(void);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -38,20 +38,20 @@ static inline void tegra_resume(void)
 {
 }
 
-static inline int tegra30_sleep_cpu_secondary_finish(unsigned long arg)
+static inline int tegra30_pm_secondary_cpu_suspend(unsigned long arg)
 {
 	return -ENOTSUPP;
 }
 
-static inline void tegra_clear_cpu_in_lp2(void)
+static inline void tegra_pm_clear_cpu_in_lp2(void)
 {
 }
 
-static inline void tegra_set_cpu_in_lp2(void)
+static inline void tegra_pm_set_cpu_in_lp2(void)
 {
 }
 
-static inline int tegra_idle_lp2_last(void)
+static inline int tegra_pm_enter_lp2(void)
 {
 	return -ENOTSUPP;
 }
-- 
2.23.0

