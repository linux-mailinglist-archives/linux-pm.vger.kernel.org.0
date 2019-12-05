Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387F3113F6D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfLEKdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:33:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40181 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfLEKdk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 05:33:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so2085704lfy.7
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 02:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pG2r2/g6r/cRCtHmJlWgFPElnDAc0sUuBSOFJTt/9mM=;
        b=aDoxulZlbbd5bF/v/4CyK6vhcnMYCh7Inj4fn0/I97KJcUrFG4prGB7UZESZdT6Iwl
         7yHiMEAXT+089BDZHMhap7VfP08w0DuVWp02Td6DHD/YJPi4sf1lrDsYgbrExDYUiyHe
         bOFXAG5Cp/2IkMddKesk3iktaRQ9W3ugPFcZimD0Y/dEQdMrQV4wNnFb/d6i8tdqTOw0
         QsHdnXVNj46/6nMnDMfyDhz2IifArYSDS/abkMtb9vXKj0TMm4N/m0aVfJKRXdEUyzU6
         Er/AUYXpEV7VFZ2mzG81IiZq92mONgdNKDK6KFYD+UBMNSSHtJl/fkto9EaDrOe04e/7
         4lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pG2r2/g6r/cRCtHmJlWgFPElnDAc0sUuBSOFJTt/9mM=;
        b=IOx0WwJyV+w7MK2ZVcAS6HKIfFBIomksCAXgqoe7SDZZS72Yn6WyI7otxaJgkSTS0m
         PjUSU3PuDzY2woKmq8YaOu1Lo0xp370h8E5+/vSF0V6845cQioQFrguWJ29CDNXmzTcE
         pXd8Wak6Qv4izn08fhfzS0tyBC/p/lo+qaTs0RcI8C1Mai+2y0W10wUScdhL6bzduRKf
         Ju92jqivaTZ6RXt4+TNWPxj8K3ZeXQJ8fTQRFGVEvS767dMM0bb0e70LpSJAOqwDZN3M
         aEs4+Zq07iHaZVCv0Y8aICTAbqsfQ6XoGESj6DAmVPnxM4XX8RqGiJHkXM8eNjnxBu3A
         lBjw==
X-Gm-Message-State: APjAAAWcozNalyqhPn4Xp5iOj2IzHtwkngQqMH+w5luFmTDCiyQfVKUs
        x0XqS7OU9u5r8VTd7HxP40u+KQ==
X-Google-Smtp-Source: APXvYqxJHIgterRi/o0jlDeDLVi9QArtZJQzyNYGI94YgKkmQimIHKm8hdCfRNfrwkyYxntcSN6ejw==
X-Received: by 2002:a19:e002:: with SMTP id x2mr5043191lfg.28.1575542017782;
        Thu, 05 Dec 2019 02:33:37 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id w2sm4680438ljo.61.2019.12.05.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 02:33:37 -0800 (PST)
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
Subject: [PATCH] cpuidle: psci: Support CPU hotplug for the hierarchical model
Date:   Thu,  5 Dec 2019 11:33:30 +0100
Message-Id: <20191205103330.27166-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the hierarchical CPU topology is used and when a CPU is put offline,
that CPU prevents its PM domain from being powered off, which is because
genpd observes the corresponding attached device as being active from a
runtime PM point of view. Furthermore, any potential master PM domains are
also prevented from being powered off.

To address this limitation, let's add add a new CPU hotplug state
(CPUHP_AP_CPU_PM_STARTING) and register up/down callbacks for it, which
allows us to deal with runtime PM accordingly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Lorenzo, Sudeep, Rafael, Daniel,

Note that, this patch is based upon a recently posted series [1] and the intent
is to queue it on top. I can fold it into the series and resend it all, if that
makes it easier for people. Just tell me what you prefer.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/cover/11263735/

---
 drivers/cpuidle/cpuidle-psci.c | 45 +++++++++++++++++++++++++++++++++-
 include/linux/cpuhotplug.h     |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 835c7c3aa118..46b481c524cc 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -31,6 +32,7 @@ struct psci_cpuidle_data {
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
+static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
 {
@@ -72,6 +74,44 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	return ret;
 }
 
+static int psci_idle_cpuhp_up(unsigned int cpu)
+{
+	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
+
+	if (pd_dev)
+		pm_runtime_get_sync(pd_dev);
+
+	return 0;
+}
+
+static int psci_idle_cpuhp_down(unsigned int cpu)
+{
+	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
+
+	if (pd_dev) {
+		pm_runtime_put_sync(pd_dev);
+		/* Clear domain state to start fresh at next online. */
+		psci_set_domain_state(0);
+	}
+
+	return 0;
+}
+
+static void psci_idle_init_cpuhp(void)
+{
+	int err;
+
+	if (!psci_cpuidle_use_cpuhp)
+		return;
+
+	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
+					"cpuidle/psci:online",
+					psci_idle_cpuhp_up,
+					psci_idle_cpuhp_down);
+	if (err)
+		pr_warn("Failed %d while setup cpuhp state\n", err);
+}
+
 static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
@@ -161,9 +201,11 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	}
 
 	/* Manage the deepest state via a dedicated enter-function. */
-	if (dev)
+	if (dev) {
 		drv->states[state_count - 1].enter =
 			psci_enter_domain_idle_state;
+		psci_cpuidle_use_cpuhp = true;
+	}
 
 	data->dev = dev;
 
@@ -285,6 +327,7 @@ static int __init psci_idle_init(void)
 			goto out_fail;
 	}
 
+	psci_idle_init_cpuhp();
 	return 0;
 
 out_fail:
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e51ee772b9f5..01f04ed6ad92 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -95,6 +95,7 @@ enum cpuhp_state {
 	CPUHP_AP_OFFLINE,
 	CPUHP_AP_SCHED_STARTING,
 	CPUHP_AP_RCUTREE_DYING,
+	CPUHP_AP_CPU_PM_STARTING,
 	CPUHP_AP_IRQ_GIC_STARTING,
 	CPUHP_AP_IRQ_HIP04_STARTING,
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
-- 
2.17.1

