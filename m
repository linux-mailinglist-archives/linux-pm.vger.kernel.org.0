Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7496CC18CC
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfI2SAP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45800 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbfI2SAP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id r134so5292364lff.12;
        Sun, 29 Sep 2019 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Q6wr4WReeFVr9Ayx3FZ180PdrRVbbg27IxEID5VY5o=;
        b=R69svrcL8OcnC7HCe1mXe9tPuoE5f+s1zMshvd/MLHHNeYSrJm/b3ih06bK0WUWxwk
         dlO/d7ZIcAO0RE6+//ccfnNiDAtR8Thqdoo/ReCuIvh2aaFXlkM+ubj7fSmysn06a16t
         8XWflB0c3S6iER6TUEJhVDqtZ2oJwDlvpHh/VYwbXaZgALi7dD6MltpQ3H2KtaaaMG+i
         Iqkjin014i5lE3UknTbVip/nJdKexUgm31RMdaEABjZhKHkbII3l70HI/StD/Z2zrcJg
         j5TGcC+IlzGOfCFj4dISinNwYUrVH4IIhbV2tUFQQu6XIKG3aebz9nqoBG5WETP6OQBG
         H6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Q6wr4WReeFVr9Ayx3FZ180PdrRVbbg27IxEID5VY5o=;
        b=jdoHWwDgjUJlEdzb8MOX02rcICzoGDicHt92j7OFTQQ8w2MrxkWjQUqMVtLpCLVcU0
         /L0br0M5k8Rmz0CFVhIqU4HTkukXyS8EfeuvurPLrZRFa76MSy0BowYZzO3oEMz4htSo
         MAFuiAQzVkgoMmKCD+SI+TZIzxKSTuU9qZUXNCql03I+K72ZbdsMpBG9VwNsbtSk+qLP
         JcZ7iDRbxWQHXoiCk9ywcN0tn/okkAXTe2P/lLYOoHt3A8YZts/KxZwJJXKezimvZLc/
         YnL40rg2takZBok1+nSxHX/tQE565xrtVFATGvNo6FN2/bcvpMdavw+cVln2fZcUB43l
         KcxA==
X-Gm-Message-State: APjAAAUKDptmWyiXpRk4niFhvjrEoF2176gChIgJNSs//l4D+gnbxmIM
        KvltpWMf+9D0AZPpFbOocu8=
X-Google-Smtp-Source: APXvYqxofJm5iaQF2h75ZmR7yjAWd7kTND1JOBhPh8xLDxMqccsjxuvek7OyFVuaqRpsTNxxxqqE4A==
X-Received: by 2002:ac2:5463:: with SMTP id e3mr8739109lfn.117.1569780012837;
        Sun, 29 Sep 2019 11:00:12 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/14] ARM: tegra: Expose PM functions required for new cpuidle driver
Date:   Sun, 29 Sep 2019 20:59:43 +0300
Message-Id: <20190929175952.22690-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
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
2.23.0

