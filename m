Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECD699D8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfGOR3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35006 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbfGOR3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so17127020ljh.2;
        Mon, 15 Jul 2019 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWP8nyImS39zSZSpsquwa+7h83m45I0RXPq4864glDw=;
        b=RWQpIYdoamyKmsukWr13hJKtqCnneWSq7yu7efc2V+0BLViyoxGqimT0vQG+N9f+0O
         zHpnUDGzaMXjKc4DP/e9FLmXS3frE8y/S15vaw54SFmIjEboEsRt2E9s98CFEiCIPaJD
         w8LM4N2C+okvLbnYWxVma0ZF6mQhd9bJKugJ6sklqJ/kIcN4h5vlgNWl/ai9bQUffWom
         LXZYl7QqJrZ7COD1pQyzYwM49UB/3RLsw7Tz2EYh8EgTiPmhnnsqdnyQANEFAIOCE2+5
         pgizxgEs77aCxJMBfvsbsxskUMc6z+9NR1G0MghmRGnyBPUcYtckCXkV2kMFGr6INU5O
         PbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWP8nyImS39zSZSpsquwa+7h83m45I0RXPq4864glDw=;
        b=tl9SYeMiOErvszcMdWI7gBiKCxHzevS+1T2vwI0BzIobR+pdZjLwRjiLeHtWWy2MWf
         MaCmNwY3hcL9wUMCYLKgw3MA5/bddIvBhA5jJlXMT9sKoJnuZj4EWpo4VFLipDFGvEnV
         m8PGrtoQOwvkaFnl7B7WQjabjoPefkK1wDR7it1L1g/A5+Y4mWW6RgjLT6jObtvYHdLg
         5rA1xZxtZE1dKk8V97MsrR3IDcenRb2g1Sx1N3bM26dQLPw6dhKmoPgWWG5q2hM032RF
         klggusoCc29VLS8l2Svi7quPpHJw80xs4RtYdz3fLH2e56CwWsKtfFm2tSv72q2Wj7TJ
         n4Rg==
X-Gm-Message-State: APjAAAUHXle/lLX+5gbb3wqPBjirXMUtpAeuNmrjy2OYN1hZaePEIS2V
        V02nNNpAJEF4ezi+2U3Sj0I=
X-Google-Smtp-Source: APXvYqw8bOGPiSnN9XxJlrOgVc0nqpbRzNvMF09KebTKnS4GmvoNRJ9SePz7z9OknQhgOqy29kWAvg==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr14666214ljn.111.1563211789666;
        Mon, 15 Jul 2019 10:29:49 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/13] ARM: tegra: Expose PM functions required for new cpuidle driver
Date:   Mon, 15 Jul 2019 20:26:21 +0300
Message-Id: <20190715172629.4437-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The upcoming unified CPUIDLE driver will be added to the drivers/cpuidle/
directory and it will require all these exposed Tegra PM-core functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/irq.c   |  2 ++
 arch/arm/mach-tegra/pm.h    |  3 ---
 arch/arm/mach-tegra/sleep.h |  1 -
 include/soc/tegra/irq.h     | 13 +++++++++++++
 include/soc/tegra/pm.h      | 25 +++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100644 include/soc/tegra/irq.h

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4c065b54cbe7..4e1ee70b2a3f 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -18,6 +18,8 @@
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
 
+#include <soc/tegra/irq.h>
+
 #include "board.h"
 #include "iomap.h"
 
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index ae68fc7db576..81525f5f4a44 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -23,9 +23,6 @@ void tegra20_sleep_core_init(void);
 void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
-void tegra_clear_cpu_in_lp2(void);
-void tegra_set_cpu_in_lp2(void);
-int tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 4978def9db46..4718a3cb45a1 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -122,7 +122,6 @@ void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
 
 void tegra20_tear_down_cpu(void);
-int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
 
 #endif
diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
new file mode 100644
index 000000000000..8eb11a7109e4
--- /dev/null
+++ b/include/soc/tegra/irq.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
+ */
+
+#ifndef __SOC_TEGRA_IRQ_H
+#define __SOC_TEGRA_IRQ_H
+
+#if defined(CONFIG_ARM)
+bool tegra_pending_sgi(void);
+#endif
+
+#endif /* __SOC_TEGRA_IRQ_H */
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 951fcd738d55..bc1abdf41d61 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -6,6 +6,8 @@
 #ifndef __SOC_TEGRA_PM_H__
 #define __SOC_TEGRA_PM_H__
 
+#include <linux/errno.h>
+
 enum tegra_suspend_mode {
 	TEGRA_SUSPEND_NONE = 0,
 	TEGRA_SUSPEND_LP2, /* CPU voltage off */
@@ -20,6 +22,11 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 
 /* low-level resume entry point */
 void tegra_resume(void);
+
+int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
+void tegra_clear_cpu_in_lp2(void);
+void tegra_set_cpu_in_lp2(void);
+int tegra_idle_lp2_last(void);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -30,6 +37,24 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
 static inline void tegra_resume(void)
 {
 }
+
+static inline int tegra30_sleep_cpu_secondary_finish(unsigned long arg)
+{
+	return -ENOTSUPP;
+}
+
+static inline void tegra_clear_cpu_in_lp2(void)
+{
+}
+
+static inline void tegra_set_cpu_in_lp2(void)
+{
+}
+
+static inline int tegra_idle_lp2_last(void)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.22.0

