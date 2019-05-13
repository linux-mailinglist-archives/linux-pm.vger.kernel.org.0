Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAE1BDC3
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfEMTZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:25:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43022 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbfEMTXQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:23:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so9912511lfg.10
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HHIW4beg1Jo/n8yn03ZEmR2mqH0MtY+zTbuMOhYgiNI=;
        b=anVw6Y6EzHqSNxrL6pGJpo0scx6tqJdSTeUKkDH1VoRuqz97rmscnr3deHcKsbcTF9
         KBUeSJS+GoswseXScGGlJTy0SXat8ZH2YEchgAhGyniX/PXerb1jLyWkPb9fOUxfu0Lw
         IUL2YhhLknbWKObj+AdmWeg4lbExhFib0lAuxr50jWg5yFgGkT0hrzvCnBhiv+cBPeZP
         2EMMNN28h8myMwiax1VcJt7Y/V2t3O/wZnNuc61AwrUov8LMgRP4C601bVL3eyn/P31r
         R81H8S2BAi5piWYLe8XXYPuZgg59NszI1sA3l2CVOpIAXy6JNGqLYmyGqsFRZ5tCJK6G
         StRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HHIW4beg1Jo/n8yn03ZEmR2mqH0MtY+zTbuMOhYgiNI=;
        b=brfGIFr5rN7oOYhQ7ZOJZbteq3I1XHLbiUaErOSTntAz74U5S3kTg6DHgoppooemSj
         z0Cf9CzbXPa0o4bcub181wnh1nS8cnsUDhv63RkS3CTT8T6XCxuXjMp5DO+ftqR4FL/l
         DOnXOum6YO8QZyjxM11jjX65J+sxqRe+nPwSFR8FCiKdGira6lqK6bhyC/s3mjN+rfv+
         bDnWbMSCrMnJiMGWr0xmlkcV7coyFaLeVYokKVKXBIpehKFNCMp2rgrLl3ipv1ISqjQv
         XKtrLAYwdTRyhQXDTYg5FgAzwpCPOGu6AnCRUqnSRTVhiSoi2UQGMqp/2UWaNH6xf7jv
         rZpg==
X-Gm-Message-State: APjAAAXb9PwsoOMeajAojQP3OyLZKADih6eBXFt+NFpT6gIcNvqGTqlf
        EItNtZFGQWbnDufJ2e9oCzd5MQ==
X-Google-Smtp-Source: APXvYqxRt2bTvjgwV68tXj3LgqrAAbaA1jPCgVPYT0nHrhupILypGycEOanmCUjC0XjwqBqYOWLpQg==
X-Received: by 2002:ac2:593a:: with SMTP id v26mr14391804lfi.64.1557775393399;
        Mon, 13 May 2019 12:23:13 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:12 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: [PATCH 04/18] ARM/ARM64: cpuidle: Let back-end init ops take the driver as input
Date:   Mon, 13 May 2019 21:22:46 +0200
Message-Id: <20190513192300.653-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To allow arch back-end init ops to operate on the cpuidle driver for the
corresponding CPU, let's pass along a pointer to the struct cpuidle_driver*
and forward it the relevant layers of callbacks for ARM/ARM64.

Following changes for the PSCI firmware driver starts making use of this.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

Changes:
	- None.

Note:
	- This patch is needed by the subsequent patch, but more importantly,
	  also by "[PATCH 10/18] drivers: firmware: psci: Add hierarchical
	  domain idle states converter".

---
 arch/arm/include/asm/cpuidle.h   | 4 ++--
 arch/arm/kernel/cpuidle.c        | 5 +++--
 arch/arm64/include/asm/cpu_ops.h | 4 +++-
 arch/arm64/include/asm/cpuidle.h | 6 ++++--
 arch/arm64/kernel/cpuidle.c      | 6 +++---
 drivers/cpuidle/cpuidle-arm.c    | 2 +-
 drivers/firmware/psci/psci.c     | 7 ++++---
 drivers/soc/qcom/spm.c           | 3 ++-
 include/linux/psci.h             | 4 +++-
 9 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 6b2ff7243b4b..bee0a7847733 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -32,7 +32,7 @@ struct device_node;
 
 struct cpuidle_ops {
 	int (*suspend)(unsigned long arg);
-	int (*init)(struct device_node *, int cpu);
+	int (*init)(struct cpuidle_driver *, struct device_node *, int cpu);
 };
 
 struct of_cpuidle_method {
@@ -47,6 +47,6 @@ struct of_cpuidle_method {
 
 extern int arm_cpuidle_suspend(int index);
 
-extern int arm_cpuidle_init(int cpu);
+extern int arm_cpuidle_init(struct cpuidle_driver *drv, int cpu);
 
 #endif
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index fda5579123a8..43778c9b373d 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -122,6 +122,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 
 /**
  * arm_cpuidle_init() - Initialize cpuidle_ops for a specific cpu
+ * @drv: the drv to be initialized
  * @cpu: the cpu to be initialized
  *
  * Initialize the cpuidle ops with the device for the cpu and then call
@@ -137,7 +138,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
  *  -ENXIO if the HW reports a failure or a misconfiguration,
  *  -ENOMEM if the HW report an memory allocation failure 
  */
-int __init arm_cpuidle_init(int cpu)
+int __init arm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
 {
 	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
 	int ret;
@@ -147,7 +148,7 @@ int __init arm_cpuidle_init(int cpu)
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
 	if (!ret)
-		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+		ret = cpuidle_ops[cpu].init(drv, cpu_node, cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 8f03446cf89f..8db870c29f1b 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/threads.h>
 
+struct cpuidle_driver;
+
 /**
  * struct cpu_operations - Callback operations for hotplugging CPUs.
  *
@@ -58,7 +60,7 @@ struct cpu_operations {
 	int		(*cpu_kill)(unsigned int cpu);
 #endif
 #ifdef CONFIG_CPU_IDLE
-	int		(*cpu_init_idle)(unsigned int);
+	int		(*cpu_init_idle)(struct cpuidle_driver *, unsigned int);
 	int		(*cpu_suspend)(unsigned long);
 #endif
 };
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 3c5ddb429ea2..3fd3efb61649 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -4,11 +4,13 @@
 
 #include <asm/proc-fns.h>
 
+struct cpuidle_driver;
+
 #ifdef CONFIG_CPU_IDLE
-extern int arm_cpuidle_init(unsigned int cpu);
+extern int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu);
 extern int arm_cpuidle_suspend(int index);
 #else
-static inline int arm_cpuidle_init(unsigned int cpu)
+static inline int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index f2d13810daa8..aaf9dc5cb87a 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -18,13 +18,13 @@
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
-int arm_cpuidle_init(unsigned int cpu)
+int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
 	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_suspend &&
 			cpu_ops[cpu]->cpu_init_idle)
-		ret = cpu_ops[cpu]->cpu_init_idle(cpu);
+		ret = cpu_ops[cpu]->cpu_init_idle(drv, cpu);
 
 	return ret;
 }
@@ -51,7 +51,7 @@ int arm_cpuidle_suspend(int index)
 
 int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
-	return arm_cpuidle_init(cpu);
+	return arm_cpuidle_init(NULL, cpu);
 }
 
 int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 3a407a3ef22b..39413973b21d 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -106,7 +106,7 @@ static int __init arm_idle_init_cpu(int cpu)
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
 	 */
-	ret = arm_cpuidle_init(cpu);
+	ret = arm_cpuidle_init(drv, cpu);
 
 	/*
 	 * Allow the initialization to continue for other CPUs, if the reported
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index fe090ef43d28..88e90e0f06b9 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -303,7 +303,8 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
-static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, int cpu)
 {
 	int i, ret = 0, count = 0;
 	u32 *psci_states;
@@ -391,7 +392,7 @@ static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
 }
 #endif
 
-int psci_cpu_init_idle(unsigned int cpu)
+int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -410,7 +411,7 @@ int psci_cpu_init_idle(unsigned int cpu)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
+	ret = psci_dt_cpu_init_idle(drv, cpu_node, cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 53807e839664..6e967f0a8608 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -208,7 +208,8 @@ static const struct of_device_id qcom_idle_state_match[] __initconst = {
 	{ },
 };
 
-static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
+static int __init qcom_cpuidle_init(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, int cpu)
 {
 	const struct of_device_id *match_id;
 	struct device_node *state_node;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5935ab..4f29a3bff379 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -20,9 +20,11 @@
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
 
+struct cpuidle_driver;
+
 bool psci_tos_resident_on(int cpu);
 
-int psci_cpu_init_idle(unsigned int cpu);
+int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
 enum psci_conduit {
-- 
2.17.1

