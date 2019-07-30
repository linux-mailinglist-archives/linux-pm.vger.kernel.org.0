Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5696C7AF3D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfG3RKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51507 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfG3RKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so57893413wma.1;
        Tue, 30 Jul 2019 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NH6XObUnMoJEgSclRt0t6O4vavDHd+pv9Qe4go8awrw=;
        b=S7bkPcx94KOQ8Be7NlR8S/8DZqHU1imOlDR8Kp4yERNcpuNOB91H+Fa/O36xDPuAzl
         9yQNR00RMvsOpb6kETumXVg2mKVRNdRY+hfb+qz3D+RuPdmSHcq8J/jbHafDmrgE/qye
         KBB3vrOlE5VhGnjbwlc25cVhuIMCsj0urj3ldecSdit8+VaLUawVPPjZJPu63Ip99Zg2
         FXnVF3VIB8X5Gz8ykvxUKqpy4BJ3q5o+yyAK5wWWbV5lRsEXKwTuk+BJm0d5Al7O0IQQ
         TpBlyqiFPI/DRMwexlLgeMPq0eDvj7GN09ZdVVIsQ6SL6FmpAaSmWyPh9jE3v0e/O+u1
         BxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH6XObUnMoJEgSclRt0t6O4vavDHd+pv9Qe4go8awrw=;
        b=XrbYd5y7kMUR0zRANBXjq1H8qZHDrwNk0Drn4q1UrcpsY17oGHp6TZUQ1O8ZpLfMQ8
         JxwoP2xVBoyyzzTeHcA8nvljPeva/k9LAhLjyIQUOY/x8N7UppG494K35rZPGt5/fMEs
         c7Iyhl1kWyDDsZYfXFQ/2nwedclcM6dod/okP0oNWIMqjuc4IFjVVrXbOYeqduRgdIJg
         iXx9Z5liXImOLufeIOZ8XCUKTE/PFN1CKWw+rJZNKdMFhOrhkBX0hef/FyR6bGYMNQCP
         1FwuW+kXOc8kQS6tKWTjtqs37w0gfnYXoyNzwxT7ol1aCajaAw94ieYOGP9TNknd/x6I
         kPsg==
X-Gm-Message-State: APjAAAVeHI+dkiEyG+GYl+TSkX6VdtZDk/2vbNv1geSR1VErYXt/fGRG
        cikg1mXFIBlBN3eyp3kPCys=
X-Google-Smtp-Source: APXvYqxgugSlFK9JiMqipavLlGWSWBG6uhiM/DZt3dLpMlwjhqiQtAh/RNUVPC/3aq16h1ftq7/FMQ==
X-Received: by 2002:a05:600c:20ca:: with SMTP id y10mr73119321wmm.72.1564506613937;
        Tue, 30 Jul 2019 10:10:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/13] ARM: tegra: Rename some of the newly exposed PM functions
Date:   Tue, 30 Jul 2019 20:09:48 +0300
Message-Id: <20190730170955.11987-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
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

