Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2A10ADA9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfK0K3c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41614 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK0K3b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id m4so23825561ljj.8
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHPjR9zZ7uq0Kj/IaV5FCx5nyj5I/bGlCTsLFROfK7Q=;
        b=SpKow93TEIjeXQjtQiOs3Xwd8CuMBf0zXNBrjjIn1bEdIvtZtHvQhEPY5pQzU0bVJW
         pdcv+s2kEU6Qz7/PWhSyBwIqZmOGha0i5j4ktryefoH2e4vK2DMfoIuw91Kw4YKjUBld
         s8z83GMKLj6qPxMqs5aRmxjXH2Z6OnWyoDkEd+SayE1WBAU+OgkbS7UyXudARePKUOCp
         155TWhdsIrS5XtWfS6TX5oGKGGo66sB2uR7ZpMS3JkALDcoWZk6ZkiyVF0+xqhKzutxD
         YrkCUjwTJnc5jgoaZZaTQNQirBpZBBftlCFWx54snz3N8yM/ac8lF1KuRuDCQS1v8Bij
         TMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHPjR9zZ7uq0Kj/IaV5FCx5nyj5I/bGlCTsLFROfK7Q=;
        b=EENW69A7vxF1LMNKPaDp4UVrUMMfdTiNyGJOnZ2Zao/gUBTCXh/RBSDeYN+DF2cbU3
         JObeJv4mDL6Br6ubJx4e8COMFdr5QoiclSRcyF1YuL5Fvjq1Llukuw1cKm3Lhy0AShjL
         3U5kHHJsb6jsFZC7Pk19pAUAV3/1eUSAyqAz7N6L1x0LRCyHy0oB/Ih8tK/2rR406Lmk
         qOHJ6jmWLYo8VKFvg6qgR9GhTz7BHKycshZTc+dlF6R9dNGRI1Yk6Grr227T0TAclo7r
         9D0oyc97IfH4jAr2lZ1iko5DFlzoulrOmi/gnPOQ0tDPVqhOsBpbS7St6PCyXfmI/rED
         uGIQ==
X-Gm-Message-State: APjAAAUsL5CEQRC86NvvDnx7FwkA3wxMxYE4c6CC9QtsoIxIyHBpBi6L
        tbk9YokXlTqoiybkbSIldBpIcZVd++o=
X-Google-Smtp-Source: APXvYqxkmkb3820IUsRaukyCsGnVs+nkOdYxPeLsccuW5B67YbC/Kw/2Tts/IPcs+rrCdKFXCsMFOA==
X-Received: by 2002:a2e:7202:: with SMTP id n2mr27337481ljc.194.1574850569746;
        Wed, 27 Nov 2019 02:29:29 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:29 -0800 (PST)
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
Subject: [PATCH v3 08/13] cpuidle: psci: Add a helper to attach a CPU to its PM domain
Date:   Wed, 27 Nov 2019 11:29:09 +0100
Message-Id: <20191127102914.18729-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
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

Changes in v3:
	- None.

---
 drivers/cpuidle/Makefile              |  4 ++-
 drivers/cpuidle/cpuidle-psci-domain.c | 36 +++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.h        | 12 +++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
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
index 000000000000..bc7df4dc0686
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -0,0 +1,36 @@
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
+#include <linux/psci.h>
+
+#include "cpuidle-psci.h"
+
+struct device *psci_dt_attach_cpu(int cpu)
+{
+	struct device *dev;
+
+	/* Currently limit the hierarchical topology to be used in OSI mode. */
+	if (!psci_has_osi_support())
+		return NULL;
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

