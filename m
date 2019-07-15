Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE8699BD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfGOR3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46934 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfGOR3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so17113087ljg.13;
        Mon, 15 Jul 2019 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NH6XObUnMoJEgSclRt0t6O4vavDHd+pv9Qe4go8awrw=;
        b=BbJ828kFCqPNTHApzW5LDPTdpAdpOwvsLzCFty608E8wDMgsP1XkZCNm7VMV+2E+06
         fPJJDJbk+YlyIxpbivZhHOw8RYbiaOkQr7jq2C+7YxgMIb9RTi8dndZRSiZKsyWF6F7a
         NHib5eRuSxu3ILrJBn6F5AL5FAoLbFrG0CUGWSO4KHqIB+4F2xms0rN6VmxZA1Z7+f6j
         Owkh83S8itTZknckh30yC5xAz5MKqBV7fNbD9O0CkKnPPdlsjm4i+gfZr6od7NACjn9n
         4s+aWfZlPjiOCoJg6tdXQXMqBrsNR1Mvd3gX2RfBSBpV3LqQBgT1N+1EQILk2XQ3o8/z
         /PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH6XObUnMoJEgSclRt0t6O4vavDHd+pv9Qe4go8awrw=;
        b=tsTsk7/rD4GAp2BsUV7GLi9w1oESzyB6OIHG7l6NKYjdiEwlM7Sk4eDO0xZlIIfIDB
         z6uwzurm3eOFVG3xlXem7jz5gkPoi032Y9Gxb7B8igoN4D4A3U4uuaELiIdLxldQ0HBz
         i5zt+J6o7a/qSbmaKkUwpIrlN+8qTIAIEhfUmR47DuWMAwhTrrhzifzGUOGqxuAx9Aij
         Q2i16SlpOEyWODsXHenN0t+rpJX8VLq6Q+clKIXJ5wHTE9prDfWL7CPlGmbDpH/yQyhU
         A5j3Oo4RgGpRZ9N778BxWQrrJhrQrDbwZ20hUgkl9LV8sjrYaTWUYCgTfQTmmd+A+eMY
         WAEg==
X-Gm-Message-State: APjAAAUztB8pINtYcFSUoHtRlnO4OAwhgsm+QSZSxerasR1SEQMsli4E
        u3MJORzruYuq5Smc1HwD2J0=
X-Google-Smtp-Source: APXvYqxaW6beHBsuSFoN5AgBhdc8iDZOUW0gyu9p6ltekagezmd/bo3Hdv/3qXfmwFIUlezdv0Y1ug==
X-Received: by 2002:a2e:98d7:: with SMTP id s23mr14381746ljj.179.1563211790667;
        Mon, 15 Jul 2019 10:29:50 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] ARM: tegra: Rename some of the newly exposed PM functions
Date:   Mon, 15 Jul 2019 20:26:22 +0300
Message-Id: <20190715172629.4437-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
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
2.22.0

