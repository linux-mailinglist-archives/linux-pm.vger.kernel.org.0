Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439411BDE9
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEMT33 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:29:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41662 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfEMT33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:29:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so12070638lja.8
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WrUBlQWQzfbgrdk7klxniFTaW91XaiQj55o38mlFd9s=;
        b=sPy1xWvat53hABQ29ElA2SDvZnqfRV5oZCv6u9/BoxR2ZPqFXvyAG3a5TqRkJY1a78
         ViroHIx+ON0jQRU/3UrEYHgnwsRgfEfK1eI6rvzBvxBl01A+l0VD3RNQr/pCLeiGgll5
         oZk8WImmrSosBLIL5WDY5HKxk6DoQYAY3hOyay9Zaekc0Qx48OBqfoEIU9LOQbcuUzO9
         y21fdWLhr9sVngZjVbZUtziI2z+WwnXK05qOJ7jaN6FqE68r4gmG+pebrx9IRchSta0X
         VzfAclg9EtvAhwIfrDB0k8yyetyh5giqMkUfQdSjeFYl6oWMRIbrHygy50HEN/rtT2Ov
         JANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WrUBlQWQzfbgrdk7klxniFTaW91XaiQj55o38mlFd9s=;
        b=lNELXqbkg0X91quVae3UsI1N/4psKQcqW0KDfp2frmJ9NZvBc6zidPeV0NrCUaAgAW
         i33FZ/Ae6hUT9io/qXnjlrTM4pSULMsot2h+hzk2qwnQ56FPujIF+6YVR1/RlsLyd2vY
         UEo5uV2vX3UPPrZWNsZGAa1GI8TE3Kb7IIs5dImNyuWxkhdzK0OhIV5sknF99cgF/cWV
         Z8dR9ps7NQBiEqhgcIkhZYVpb8qbScQ4sTAtune7GRARj0tRwW4uwKlSOk8z9NRgFvzH
         80n3Pbs92AqI9/oh1DRS2HtZXmCoIi3QtgQWhP4C78Ey6iHhSkj++qQ3n+jmrq5kzZha
         DbvQ==
X-Gm-Message-State: APjAAAUJL0S8roZ6IUylkZlWnciD8gG39B/bQtycN7IlVmjp8P8JySWf
        +08zo0eAQ6YZkP90ZJjtsjzAzA==
X-Google-Smtp-Source: APXvYqwd8hFjFHeIWZMZf2tJMuRrNt9YuVmMQEmung/qTBri+UbFr4ziejpMmn/ZiqWmeUdPeQNSbw==
X-Received: by 2002:a2e:2b58:: with SMTP id q85mr14768159lje.179.1557775413538;
        Mon, 13 May 2019 12:23:33 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:32 -0700 (PDT)
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
Subject: [PATCH 15/18] drivers: firmware: psci: Support CPU hotplug for the hierarchical model
Date:   Mon, 13 May 2019 21:22:57 +0200
Message-Id: <20190513192300.653-16-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the hierarchical CPU topology is used and when a CPU has been put
offline (hotplug), that same CPU prevents its PM domain and thus also
potential master PM domains, from being powered off. This is because genpd
observes the CPU's attached device as being active from a runtime PM point
of view.

To deal with this, let's decrease the runtime PM usage count by calling
pm_runtime_put_sync_suspend() of the attached struct device when putting
the CPU offline. Consequentially, we must then increase the runtime PM
usage count, while putting the CPU online again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Use get_logical_index() to find the CPU number.
	- Verify that a corresponding struct device* has been attached to the
	  PM domain before doing runtime PM refrence counting.
	- Clear the domain state when the CPU goes offline, to start fresh.
	- Move code to internal helper functions and move them inside
	  "ifdef CONFIG_CPU_IDLE.

---
 drivers/firmware/psci/psci.c | 47 +++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2c4157d3a616..5ad93c3694b5 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
@@ -93,6 +94,9 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
+static void psci_cpuidle_cpu_off(void);
+static void psci_cpuidle_cpu_on(unsigned long cpuid);
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -188,6 +192,8 @@ static int psci_cpu_off(u32 state)
 	int err;
 	u32 fn;
 
+	psci_cpuidle_cpu_off();
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -200,7 +206,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 
 	fn = psci_function_id[PSCI_FN_CPU_ON];
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
-	return psci_to_linux_errno(err);
+	err = psci_to_linux_errno(err);
+	if (err)
+		return err;
+
+	psci_cpuidle_cpu_on(cpuid);
+
+	return 0;
 }
 
 static int psci_migrate(unsigned long cpuid)
@@ -540,8 +552,41 @@ static int __init _psci_dt_topology_init(struct device_node *np)
 
 	return ret;
 }
+
+static void psci_cpuidle_cpu_off(void)
+{
+	struct device *dev = __this_cpu_read(psci_cpuidle_data.dev);
+
+	/*
+	 * Drop the runtime PM usage count if the CPU has been attached to a
+	 * CPU PM domain. This is needed to, for example, not prevent other
+	 * master domains in the hierarchy to remain powered on.
+	 */
+	if (dev)
+		pm_runtime_put_sync_suspend(dev);
+}
+
+static void psci_cpuidle_cpu_on(unsigned long cpuid)
+{
+	struct device *dev;
+	int cpu;
+
+	if (!psci_dt_topology)
+		return;
+
+	cpu = get_logical_index(cpuid);
+	if (cpu < 0)
+		return;
+
+	dev = per_cpu(psci_cpuidle_data.dev, cpu);
+	if (dev)
+		pm_runtime_get_sync(dev);
+}
+
 #else
 static inline int _psci_dt_topology_init(struct device_node *np) { return 0; }
+static void psci_cpuidle_cpu_off(void) {}
+static void psci_cpuidle_cpu_on(unsigned long cpuid) {}
 #endif
 
 static int psci_system_suspend(unsigned long unused)
-- 
2.17.1

