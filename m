Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D31BE06
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEMTb3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:31:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42471 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfEMTb3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:31:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 188so12078979ljf.9
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3HZaV7vcbo/XhlaM1d9i+kdcoQHiHqHOKB8XCuJnJg=;
        b=YrDb+TI/qptrO7/5RXe8SeC+HyCzsJJl8ml3Jr2kE2brTGKdFR7/IJ+N4lXVtKfgGo
         NAHroyR3jEv97wAFOv1N3DRBDosPKmtXcn1hEpIBtK5wsOrvMlCDRGJxZwA8Y/CGP+8R
         ab2aAEL3gSBOsIHFKZCpimEz0v0pvvsft17f2AvJ1ojeV6J8wLK4ixd+AfhWKPZ/c7ZC
         sQLCc6Vgosbnw6yG7ZCHQQ1u7R7deMgYPyyYMCopM3U1unF1AFl5Ap4t5OT1xuDe8t5f
         uoNBPb8pfj6ZvLWRNfIZPJf9225Y1ujm2szcS0/1CCTN+KdvBfR2+owHypKzCboaNJCY
         oIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3HZaV7vcbo/XhlaM1d9i+kdcoQHiHqHOKB8XCuJnJg=;
        b=ECfh+Uhzj82/f9hnAL9nZwrktURMpxrRi/Bf41MGDEHe4j+R10CwjN0Wruxmdb2+EQ
         HV9Hmg94/S8POO50N8rsmbeoBYMvBntcFlBqZUmsMIRTmZZ8rFIgqzP6/u5XTVxQdloL
         WJj0do74/CeumXJ0rIthhLNdgmQR0WwsSsShsBpEcCUqNrqYDAg5fpvN3EzcFhV3UQrN
         7YREAv9kGBv38Td7fl/6UfMJL/jVAup2FePIeQu40UvpK2TSERN+f4DHELS9VfrcEhCq
         kYmE76X4VndtpGY169TowrmKb8033yhB8v4gzPgcBNHjOdGFqcxQd3wEqgoJ6iyUZBSw
         3LRg==
X-Gm-Message-State: APjAAAXhd5axz9Fje5taJaA++TUbexw5EGw5xbUhmZ0ovc/9B/K9R7bk
        oUOI01NItdFMYjF8A1OfP/2i/g==
X-Google-Smtp-Source: APXvYqxhImmrN+c//ITxcw8U+57BeFavH+R85RVOLDvIyx6W8pcBzSGLx1AMwoyfzWMRSAkXmhUcdQ==
X-Received: by 2002:a2e:206:: with SMTP id 6mr13170535ljc.59.1557775408048;
        Mon, 13 May 2019 12:23:28 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 12/18] drivers: firmware: psci: Add a helper to attach a CPU to its PM domain
Date:   Mon, 13 May 2019 21:22:54 +0200
Message-Id: <20190513192300.653-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
a CPU number as an in-parameter and tries to attach the CPU's struct device
to its corresponding PM domain. Let's use dev_pm_domain_attach_by_name(),
as to be able to specify "psci" as the required "power-domain-names".

Additionally, let the helper prepare the CPU to be power managed via
runtime PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Take into account whether the CPU is online/offline.
	- Convert from dev_pm_domain_attach() into using the more future proof
	  dev_pm_domain_attach_by_name().

---
 drivers/firmware/psci/psci.h           |  3 +++
 drivers/firmware/psci/psci_pm_domain.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index c36e0e6649e9..b4254405b8ef 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -4,6 +4,7 @@
 #define __PSCI_H
 
 struct cpuidle_driver;
+struct device;
 struct device_node;
 
 int psci_set_osi_mode(void);
@@ -16,10 +17,12 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 int psci_dt_init_pm_domains(struct device_node *np);
 int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 		struct device_node *cpu_node, u32 *psci_states);
+struct device *psci_dt_attach_cpu(int cpu);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
 static inline int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 		struct device_node *cpu_node, u32 *psci_states) { return 0; }
+static inline struct device *psci_dt_attach_cpu(int cpu) { return NULL; }
 #endif
 #endif
 
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index 3aa645dba81b..1cbe745ee001 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -12,8 +12,10 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 
@@ -383,4 +385,19 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 
 	return 0;
 }
+
+struct device *psci_dt_attach_cpu(int cpu)
+{
+	struct device *dev, *cpu_dev = get_cpu_device(cpu);
+
+	dev = dev_pm_domain_attach_by_name(cpu_dev, "psci");
+	if (IS_ERR_OR_NULL(dev))
+		return dev;
+
+	pm_runtime_irq_safe(dev);
+	if (cpu_online(cpu))
+		pm_runtime_get_sync(dev);
+
+	return dev;
+}
 #endif
-- 
2.17.1

