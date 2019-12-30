Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF812D0FD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfL3OoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35516 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfL3OoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so26137307lja.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=neea4kQTvG+Bpgec4NpbRFMjAla+zHuzZZgjs6GRGkc=;
        b=CY8w9n0qANi3pwpse5njlfUuAXhBW7I2P8v6T8Momocn6zaJyS9eUNpXR6rklTo6dg
         sq+oD3qSYMqB0wdHlDpE3jkyYaDDnJHCkfrXPBz1GfhmtlV7apr9LScWjde4LbAIiZx0
         RLOWOqpMSJiQcd3lmVt5H67wYDzWg+AdVC9P1T20yfcXI8ABlEREGNiOd4yO4jG7QCUI
         bkADMMLprTLR0eR+X7OmdFXwjGSeYM0Ngk65Ev77A+7MtvMrv27NP0obM/n5DvFCWGYy
         5z7X2a5X9oYhJZ3SAkZHCYhKtbgKBoaNCtXSM71AdSInmuszfBFuZrl7vxgoyZ5wjZ4m
         6I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=neea4kQTvG+Bpgec4NpbRFMjAla+zHuzZZgjs6GRGkc=;
        b=U5yK4xvgOvxyTFQ+HIyXkFdpOrecWKHJsgFE5jD0pfr1OFno5pLIdJ/QD9FgeGCGjm
         aK1tr1ZW/TZzRXmikCN+qrEd4NwBOI3BVBFO4II985gDK6/D4+LaCkMboTPD1Nl1NSRA
         3DlrfQtjEv9Nl/Z+4nysentd8fMPT0NdCZp0TG4YZJCYasHPIYwBZP7KTIEMuBJooY9B
         vsn0ywGbS/DZ/oCa8Eo3P5DIXwU4uW/edMC8qxgJ0sgpgg2OGmwfhOsNKk00hRshUIcw
         5Ao+hIHH4uAGwPiZ8GYXw8wBOs6AeL3twEk/pJIvzg9pmJthLwPle+Pxqky/Dzsrfv9W
         YKAA==
X-Gm-Message-State: APjAAAU2qaYEE9eSSiUVlMg9CquKYaM2um0z+Cw4LmIVGSLXKxrU3CKR
        IQzLLlpAccK5g3QZLqcdNLZZtQ==
X-Google-Smtp-Source: APXvYqz4pHdrSZYvR9LPkn6aBxofeWRY+5WpuR/T2iFRqr3dH9alwMysRzcX9iPHqQj6c18Apu+KPg==
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr40357019ljh.50.1577717061929;
        Mon, 30 Dec 2019 06:44:21 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:21 -0800 (PST)
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
Subject: [PATCH v5 08/15] cpuidle: psci: Add a helper to attach a CPU to its PM domain
Date:   Mon, 30 Dec 2019 15:43:55 +0100
Message-Id: <20191230144402.30195-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
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
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v5:
	- Declare psci_dt_attach_cpu() as __init.

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
index 000000000000..87f881c21af1
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
+struct device __init *psci_dt_attach_cpu(int cpu)
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
index 000000000000..8609482cf490
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-psci.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CPUIDLE_PSCI_H
+#define __CPUIDLE_PSCI_H
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+struct device __init *psci_dt_attach_cpu(int cpu);
+#else
+static inline struct device __init *psci_dt_attach_cpu(int cpu) { return NULL; }
+#endif
+
+#endif /* __CPUIDLE_PSCI_H */
-- 
2.17.1

