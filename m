Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5759311B3CC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfLKPoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35905 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbfLKPoN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so24633884ljg.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C9yDPOd0OTPQBhTZJI/d5IX3T66EXAgmCmdgu1ZiaJ4=;
        b=MnnWQmWEeBtnTrCwz+if5edRXhdr8n1z8NyRUUN+vY5sIwfgvW8I9kvOpkWFAei451
         nND8kLG3NcWd6u+J5e37NWK4CNjCGeVhqZNkwNXqP7d5jxtP9D64PYQMpqhlHHK+doCH
         bdaqR8Go/MWDUGCDh60YKNTwkVFA0ZfEt9yrLkKhA/KA97D6/r1LjUahAH+VIeIqOPXQ
         1ODrXRWkTCHuV154SJI8hmmNc6d7Z5sxTc/R6CQIy3F/BU9Xpq6pO/13gBpG7/G0J8Ch
         HvkwMA0i/FWcmSKmxXPJlpjTTS64BXL55MlhDk8DojW1fkrhMA4hOmvftk5HDjV9JtP9
         9rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C9yDPOd0OTPQBhTZJI/d5IX3T66EXAgmCmdgu1ZiaJ4=;
        b=pmAU4wzc/WeB5pXwdQqSaEQDbHQ28I8ad20fGD3KxtmHkbxRrNYAmvC82n2Ocv3xfZ
         ReuX0z8hksiDWPsfJRF8JZreaSlB5gIiacWBaHhGqGczo9PVY/rAatRsdvDsDKzRiNiO
         VcLKBJx6T+Ov/PRiaK390SihNooUMn5A/y7p5GekAW2dcXR1lGT7B8mfWt6ksfEA8891
         CNRqCkRADuOS5tKQmHw7phM9SIZ7/Tu2tZp78KiU1idpmoeiF4Wo68orWyaLlp77N0ka
         m6QpS+NdFNAcYnuxpnKjg9Ka3usivJGIA2Lu3XTYAfiRkujxFQbjobwDVdc57VwGP/Bv
         tshA==
X-Gm-Message-State: APjAAAVipVtrSQL2V00378k5SbCjeS85c4Hu3G96I9cL2CpoWFxhzd9w
        N6DAQQV+nZWzAR+3nHMddQdsPA==
X-Google-Smtp-Source: APXvYqzDtybEqOEpWbUBHh5vtyfTA9qvNWwzUAhOzqDHGkA5ldRK0aDwlSTGQ73RmyeYlolJmJRFnw==
X-Received: by 2002:a2e:5751:: with SMTP id r17mr2591479ljd.254.1576079051400;
        Wed, 11 Dec 2019 07:44:11 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:10 -0800 (PST)
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
Subject: [PATCH v4 12/14] cpuidle: psci: Support CPU hotplug for the hierarchical model
Date:   Wed, 11 Dec 2019 16:43:41 +0100
Message-Id: <20191211154343.29765-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
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

Changes in v4:
	- Folded in the patch to be part of the series.
	- Rebased on top of earlier changes.

---
 drivers/cpuidle/cpuidle-psci.c | 45 +++++++++++++++++++++++++++++++++-
 include/linux/cpuhotplug.h     |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 6e7804e697ed..34a89d99bb0f 100644
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
 
 static inline void psci_set_domain_state(u32 state)
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
@@ -166,9 +206,11 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		 * selection of a shared state for the domain, assumes the
 		 * domain states are all deeper states.
 		 */
-		if (data->dev)
+		if (data->dev) {
 			drv->states[state_count - 1].enter =
 				psci_enter_domain_idle_state;
+			psci_cpuidle_use_cpuhp = true;
+		}
 	}
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
@@ -289,6 +331,7 @@ static int __init psci_idle_init(void)
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

