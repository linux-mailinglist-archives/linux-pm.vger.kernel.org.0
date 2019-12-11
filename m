Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9D11B3BA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfLKPoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35522 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbfLKPoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so17085699lfr.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRfmkf4JnKo9PHq3PVzPd6h/hHi59OtQm8uNLFVlFhw=;
        b=vlqC0QWgeO1GZemTWBSNt6UdSV9A9IQdBl8vegBUr1H/Ag8x1Cd9tjpyIHNvG5fyB9
         QTBTZKMXiUxLQviC7xKcLGZ2YubJVmmZtnTA5ZsQ7z66HDc5/7k1BH83pqFWczznzZwS
         sx36NLkjtCKlPPRvRmiJ3IbuE4YWExffudRu5xmaJQC5nsLvmc9+zlEhYTUXYThE1QiP
         i/4ay48+KWFMXOSTi3JOMjXj8gMa3uArXqiM9CeNFERCQK/vNms394Z7BR1ZUpEdUIxg
         95KsTrmnB2uRI8q9or5tnD7lPJeFGgCXP+jS+vKxOo0opD/4GtZL/ACyneRM5uIdV1Vl
         W/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRfmkf4JnKo9PHq3PVzPd6h/hHi59OtQm8uNLFVlFhw=;
        b=loEZfdkREMVeR1FQC8W+L9Cc00eI6BLndfF6PWM+YzsMAViQoqPsEGVadxouDDdf28
         oAk8Y5dfV9ptJkO74PYOD+D6dju7S9pXJ8K43oYgTiZLK1NtpZNQ/u5Kacl3vHvfhjL1
         qc2mTsj6nWhYM+MZzuYv6G/cQxMGc38Vq0Op9UISMqcmtomtYbJde/lnFt3H7lpXpSS3
         DxIf6v63GOXQQmkOjmhQ79OwE6F1tEuqR/Fp+dGwZ680eDb3IxMNHqIgeY5a38iPfzWq
         JhvgP3+T0Ta7HfVEB+iGGG24ZjyzhJGdpq3pdx4XvC00IXs5LdDgRd8bM5yC4eyhH6Jc
         NoSA==
X-Gm-Message-State: APjAAAUOEANoe9E8bjHoSLttv6kyKZM8S8v3/TVk4gr8gzlNo1U8OY2x
        LokrrQca6tGuM7GXeXQ2YUFuvg==
X-Google-Smtp-Source: APXvYqyhMsqjbCZuwpuxXeIZk5TZCnSHx3W6LBzXGYi7B+TXl9c4TYuR1rKG/FBz0EPE2iPVxo0Zow==
X-Received: by 2002:a19:f006:: with SMTP id p6mr2619628lfc.94.1576079044833;
        Wed, 11 Dec 2019 07:44:04 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:04 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 08/14] cpuidle: psci: Add a helper to attach a CPU to its PM domain
Date:   Wed, 11 Dec 2019 16:43:37 +0100
Message-Id: <20191211154343.29765-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
CPU number as an in-parameter and tries to attach the CPU's struct device
to its corresponding PM domain.

Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
specify "psci" as the "name" of the PM domain to attach to. Additionally,
let's also prepare the attached device to be power managed via runtime PM.

Note that, the implementation of the new helper function is in a new
separate c-file, which may seems a bit too much at this point. However,
subsequent changes that implements the remaining part of the PM domain
support for cpuidle-psci, helps to justify this split.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Drop check for OSI support in psci_dt_attach_cpu().

---
 drivers/cpuidle/Makefile              |  4 +++-
 drivers/cpuidle/cpuidle-psci-domain.c | 31 +++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.h        | 12 +++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
 create mode 100644 drivers/cpuidle/cpuidle-psci.h

diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index ee70d5cc5b99..cc8c769d7fa9 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -21,7 +21,9 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
-obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
+obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
+cpuidle_psci-y				:= cpuidle-psci.o
+cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
new file mode 100644
index 000000000000..656ef3d59149
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PM domains for CPUs via genpd - managed by cpuidle-psci.
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ */
+
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+#include "cpuidle-psci.h"
+
+struct device *psci_dt_attach_cpu(int cpu)
+{
+	struct device *dev;
+
+	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
+	if (IS_ERR_OR_NULL(dev))
+		return dev;
+
+	pm_runtime_irq_safe(dev);
+	if (cpu_online(cpu))
+		pm_runtime_get_sync(dev);
+
+	return dev;
+}
diff --git a/drivers/cpuidle/cpuidle-psci.h b/drivers/cpuidle/cpuidle-psci.h
new file mode 100644
index 000000000000..0cadbb71dc55
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CPUIDLE_PSCI_H
+#define __CPUIDLE_PSCI_H
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+struct device *psci_dt_attach_cpu(int cpu);
+#else
+static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
+#endif
+
+#endif /* __CPUIDLE_PSCI_H */
-- 
2.17.1

