Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002F72A48F6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKCPHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKCPGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 10:06:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57BC0613D1
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 07:06:44 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y184so20647050lfa.12
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2aikAnlU4Rv0xJ54ndQnr8H+vElIy0SKy9Omrer1Ow=;
        b=ysK/IoiTp/UV3EPWH4UVFRHclwAjajJUvSrrM3LNcbaoGkicwm6doZuxeL3S7sfb32
         DMFErTSnQPcB0MgRCAtgupil1fcRLbb/LpGIBHCMUfHOsWw9qzbQxWIGEC67sBhHFAer
         PDJ9z0Fcss7tqgwKKqbQgOpcdfRU+m6wbJZbaEljBcMhGeiN0O0pERIMF+E2xxDGATeT
         JrjkX3Cju0HiFYns0PYd1VSMF6Yu9XGNMtlesWDovCfEjuzW3UrVQ+KcbZum6o7hIvFq
         b27ldA7bQuHFTP0JoBqJcNNJM4rZpxEIgYrP2VCwickkqKCeq7rQvpP4TzbYkbbO2MjF
         aJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2aikAnlU4Rv0xJ54ndQnr8H+vElIy0SKy9Omrer1Ow=;
        b=eaQll137Ms13dinr02b6jazIzFUtx/J3KO32d7JgxpkimCkmyu8rQjQ+VQoJgCCbes
         Kdqzt9YNzrOaXfd0zIz4/kHIo80kyPnew7C54Uxx86w3uA3oQKyIbTtp00SNnZCIrKIJ
         FjlHVUjdTzAB/0GQcofDgMQ/ESzbMw7vS+j92kQw1KzLWC+6oY8DkAx+DVCgcPC5rLz9
         Pmg8O8uUgV1rH/NUatufLVgyveQjWhs+7hT3yfPqY7oycjId5bBbW7mLlmXD6debk/3d
         sF+fAqOTG66z86yF+D3Xw7ifng4AuHkPOiLKjD23rMsGriHSHGIq2tVPQwc4oRXLmbzV
         PUNQ==
X-Gm-Message-State: AOAM5318Peh5fFP8w2eVe3YspLFSIo8iQghFZnJulfF8O0iLKSJ4lzM/
        a61nX9N5f7EOjGePqtoeteZKrQ==
X-Google-Smtp-Source: ABdhPJzaNwaa4JfoulcPt1J10kPgf3A10Pfy/kvKPYlSj4ezifUxRuTpYUt3gCD3A1Gn05zKdnj4Gw==
X-Received: by 2002:a19:ca4b:: with SMTP id h11mr8466061lfj.6.1604416002518;
        Tue, 03 Nov 2020 07:06:42 -0800 (PST)
Received: from localhost.localdomain (h-155-4-131-134.NA.cust.bahnhof.se. [155.4.131.134])
        by smtp.gmail.com with ESMTPSA id a25sm3522169lfo.141.2020.11.03.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:06:41 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] cpuidle: psci: Enable suspend-to-idle for PSCI OSI mode
Date:   Tue,  3 Nov 2020 16:06:27 +0100
Message-Id: <20201103150627.233438-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103150627.233438-1-ulf.hansson@linaro.org>
References: <20201103150627.233438-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To select domain idlestates for cpuidle-psci when OSI mode has been
enabled, the PM domains via genpd are being managed through runtime PM.
This works fine for the regular idlepath, but it doesn't during system wide
suspend. More precisely, the domain idlestates becomes temporarily
disabled, which is because the PM core disables runtime PM for devices
during system wide suspend.

Later in the system suspend phase, genpd intends to deal with this from its
->suspend_noirq() callback, but this doesn't work as expected for a device
corresponding to a CPU, because the domain idlestates needs to be selected
on a per CPU basis (the PM core doesn't invoke the callbacks like that).

To address this problem, let's enable the syscore flag for the
corresponding CPU device that becomes successfully attached to its PM
domain (applicable only in OSI mode). This informs the PM core to skip
invoke the system wide suspend/resume callbacks for the device, thus also
prevents genpd from screwing up its internal state of it.

Moreover, to properly select a domain idlestate for the CPUs during
suspend-to-idle, let's assign a specific ->enter_s2idle() callback for the
corresponding domain idlestate (applicable only in OSI mode). From that
callback, let's invoke dev_pm_genpd_suspend|resume(), as this allows a
domain idlestate to be selected for the current CPU by genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased upon recent changes.
	- Updated the commit message.

---
 drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
 drivers/cpuidle/cpuidle-psci.c        | 34 +++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 4a031c62f92a..ff2c3f8e4668 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -327,6 +327,8 @@ struct device *psci_dt_attach_cpu(int cpu)
 	if (cpu_online(cpu))
 		pm_runtime_get_sync(dev);
 
+	dev_pm_syscore_device(dev, true);
+
 	return dev;
 }
 
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index d928b37718bd..b51b5df08450 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -19,6 +19,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/psci.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -52,8 +53,9 @@ static inline int psci_enter_state(int idx, u32 state)
 	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
 }
 
-static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv, int idx)
+static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int idx,
+					  bool s2idle)
 {
 	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
 	u32 *states = data->psci_states;
@@ -66,7 +68,12 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 		return -1;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
-	RCU_NONIDLE(pm_runtime_put_sync_suspend(pd_dev));
+	rcu_irq_enter_irqson();
+	if (s2idle)
+		dev_pm_genpd_suspend(pd_dev);
+	else
+		pm_runtime_put_sync_suspend(pd_dev);
+	rcu_irq_exit_irqson();
 
 	state = psci_get_domain_state();
 	if (!state)
@@ -74,7 +81,12 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	RCU_NONIDLE(pm_runtime_get_sync(pd_dev));
+	rcu_irq_enter_irqson();
+	if (s2idle)
+		dev_pm_genpd_resume(pd_dev);
+	else
+		pm_runtime_get_sync(pd_dev);
+	rcu_irq_exit_irqson();
 
 	cpu_pm_exit();
 
@@ -83,6 +95,19 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	return ret;
 }
 
+static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int idx)
+{
+	return __psci_enter_domain_idle_state(dev, drv, idx, false);
+}
+
+static int psci_enter_s2idle_domain_idle_state(struct cpuidle_device *dev,
+					       struct cpuidle_driver *drv,
+					       int idx)
+{
+	return __psci_enter_domain_idle_state(dev, drv, idx, true);
+}
+
 static int psci_idle_cpuhp_up(unsigned int cpu)
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
@@ -170,6 +195,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * deeper states.
 	 */
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
 
 	return 0;
-- 
2.25.1

