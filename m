Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6ABE8D0A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfJ2Qo7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:44:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33915 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390436AbfJ2Qo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:44:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id 139so15865240ljf.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gp0cxGjsLa/5p2k8fB9GEAU+2hCtpg307yRdN/E/Ges=;
        b=kloNjm7Qehm+0bNq+PjeVTCYJebZI/Nt6BoOXCGhZ42Lubnovk82si9lvQTNSrPnjm
         yzvWB1RpsrPT+K1kmcm6o5d4IqmC41y1IyMDP13qMcKxRrQh2YmwJqIaW3OBGnAjTFuV
         DszyrwgR8jjtwkB3ejpvj2tTiJ2M8eEhgOD179EDaWIRqU83CoUZIlGbm7U8eQ9vDiTA
         zsrKHMsBtxGZAqsMxXGD65M6PTDqW6izTs0p+m4Hb4Xe/idX0r3dkQ8L+nBIBxMca/SL
         cEDO7mPDzkN1WnosM9QLAZr6n83sytpWKb58MPsofUsZCNBPGuC7ElmYfAbQppnCVQM3
         bhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gp0cxGjsLa/5p2k8fB9GEAU+2hCtpg307yRdN/E/Ges=;
        b=Z0P3lO8tutvmOmdT0QC36SUjmF3xq36H80qegtxnemh5FZN6wTgIpMEbpiHWO07qcz
         PY5dFosWrBs1HCLzj9zg7TooHi3kyVtjZ3JdaVJMavuvbvfaOJjGrjjCS3njwoTLIg9p
         QFfjvSuRvcX+aFlbcQeWU/FHbHj9O6S1GKjkRVTvSF+7i69F17KnTmwYjwi3mJ8DI+q4
         gQ3i5KiZdGgyXtWnb0WDBEgNCvLwkZ9IEGfRpRrMTVjy1dqzdqRDpoqA6xtwzjuuLf2n
         HeukgNiI/rkW8wFIj5w77moBoyXSFhqqU4IoaS2Tue6NrITWpRgifuPvNEaTTKijzGhO
         8h1Q==
X-Gm-Message-State: APjAAAUWCvYsTRCePLHcVOYCGrPl2yF+Q8xVNOYeOLOUBu2qvczYnXop
        XdJVb40fkDLZ9keDkv2SCcdb3e4WT7s=
X-Google-Smtp-Source: APXvYqxF9BFsEOTuLQ4K8J/4i3dG6qTKDv5+wlVsmO+sGvo23A7onGcqdB8AKr150o5WRbwcKMmJAg==
X-Received: by 2002:a2e:9782:: with SMTP id y2mr3394331lji.46.1572367496902;
        Tue, 29 Oct 2019 09:44:56 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:44:56 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 08/13] cpuidle: psci: Add a helper to attach a CPU to its PM domain
Date:   Tue, 29 Oct 2019 17:44:33 +0100
Message-Id: <20191029164438.17012-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Reorder patch to be the first one that starts adding the PM domain
	  support.
	- Rebased.

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

