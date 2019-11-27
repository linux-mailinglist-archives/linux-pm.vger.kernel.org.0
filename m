Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4103110ADB0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK0K3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33427 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK0K3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id d6so16736726lfc.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H5+j5Ryi1tcJuLiRKgHOPY8E8R9ryoJD8uowAry+jGY=;
        b=N7r2gMe8G20i4xmM7Fj5dmDMNSlBcg92v0Zsh8Zkfro8HKOvwra+VU7kUM/k15UbmK
         wsSJOn5K0mvUtqKKaDCKfZW/kfDmH9dkVz985JblmnDAefBdwkBUnxZha3ALcPmALmxQ
         XFG0eCAjobF34aNMzFbcKlFhIorfiDhJdnIQNU7iOtc93ROi0bXG2r93CuJmbJBPkHwS
         pSnk/gyjQdBF2MBy3QVva+bnO9+SeUxN0xuIzwXvuSaUa159rXefXFHi1RRSXwyMKmtD
         /uIlo2tu8tJOqVtmqpzICZIy00kfTjrmT819Ph4Rr9XSkdHn9WHwW8IEM6DdsM8hLkGV
         NkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H5+j5Ryi1tcJuLiRKgHOPY8E8R9ryoJD8uowAry+jGY=;
        b=QFiX36mytwzg0mOG5imzJ4AEJkViGaW4XVuiIvTDvhWLQsW/iw85orYRI1zJxRNri6
         0zdTeYMV3bPf9DMH1IUUvEanucsXewOsFvIycOGqCwt4m3n61TBehMfQedfhe2KslpaM
         ZGyyzfFiQHfZYLvYceafb8Ods3mDV73cep5gCgn27jXtHgHtJpAI4ztD2i/MTvRaWgsy
         J7/MigPRZImlRElill50y7Es575dcf7syrSh5HyER8lAlZql5oqkJzTvywvt+y3QsLFX
         OH96GxoT9fc3q32wWF0jIPtth/NznOOV+eNeckgj3XV1LOoNTper3esNO0YdER4+5X6Z
         2Z3w==
X-Gm-Message-State: APjAAAV5NvAsJ2cLDRzQFVPPwm7Mt25tWpEfBi4RmyyRJJh5m3y5lVD9
        wraE3E0c3n/NqLP2JlUh8/5hkA==
X-Google-Smtp-Source: APXvYqxdSHrsudanOS4bJyuEoaPbKV0mRhbX9ISO6drVkAYmASp9F3ZgFpV3xbFQtUMBfSeYv4YHQg==
X-Received: by 2002:ac2:5464:: with SMTP id e4mr28237342lfn.47.1574850572190;
        Wed, 27 Nov 2019 02:29:32 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:31 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 10/13] cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
Date:   Wed, 27 Nov 2019 11:29:11 +0100
Message-Id: <20191127102914.18729-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The per CPU variable psci_power_state, contains an array of fixed values,
which reflects the corresponding arm,psci-suspend-param parsed from DT, for
each of the available CPU idle states.

This isn't sufficient when using the hierarchical CPU topology in DT, in
combination with having PSCI OS initiated (OSI) mode enabled. More
precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
idle state the cluster (a group of CPUs) should enter, while in PSCI
Platform Coordinated (PC) mode, each CPU independently votes for an idle
state of the cluster.

For this reason, introduce a per CPU variable called domain_state and
implement two helper functions to read/write its value. Then let the
domain_state take precedence over the regular selected state, when entering
and idle state.

To avoid executing the above OSI specific code in the ->enter() callback,
while operating in the default PSCI Platform Coordinated mode, let's also
add a new enter-function and use it for OSI.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Avoid executing any OSI specific code in psci_enter_idle_state(),
	while operating in the default PSCI Platform Coordinated mode.

---
 drivers/cpuidle/cpuidle-psci.c | 52 ++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 167249d0493f..fd664e134c3f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -29,14 +29,47 @@ struct psci_cpuidle_data {
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
+static DEFINE_PER_CPU(u32, domain_state);
+
+static inline void psci_set_domain_state(u32 state)
+{
+	__this_cpu_write(domain_state, state);
+}
+
+static inline u32 psci_get_domain_state(void)
+{
+	return __this_cpu_read(domain_state);
+}
+
+static inline int psci_enter_state(int idx, u32 state)
+{
+	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
+}
+
+static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int idx)
+{
+	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
+	u32 *states = data->psci_states;
+	u32 state = psci_get_domain_state();
+	int ret;
+
+	if (!state)
+		state = states[idx];
+
+	ret = psci_enter_state(idx, state);
+
+	/* Clear the domain state to start fresh when back from idle. */
+	psci_set_domain_state(0);
+	return ret;
+}
 
 static int psci_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
-					   idx, state[idx]);
+	return psci_enter_state(idx, state[idx]);
 }
 
 static struct cpuidle_driver psci_idle_driver __initdata = {
@@ -79,7 +112,8 @@ static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
-static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
+static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
+					struct device_node *cpu_node,
 					unsigned int state_count, int cpu)
 {
 	int i, ret = 0;
@@ -118,6 +152,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 		goto free_mem;
 	}
 
+	/* Manage the deepest state via a dedicated enter-function. */
+	if (dev)
+		drv->states[state_count - 1].enter =
+			psci_enter_domain_idle_state;
+
 	data->dev = dev;
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
@@ -129,7 +168,8 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 	return ret;
 }
 
-static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
+static __init int psci_cpu_init_idle(struct cpuidle_driver *drv,
+				     unsigned int cpu, unsigned int state_count)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -145,7 +185,7 @@ static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, state_count, cpu);
+	ret = psci_dt_cpu_init_idle(drv, cpu_node, state_count, cpu);
 
 	of_node_put(cpu_node);
 
@@ -201,7 +241,7 @@ static int __init psci_idle_init_cpu(int cpu)
 	/*
 	 * Initialize PSCI idle states.
 	 */
-	ret = psci_cpu_init_idle(cpu, ret);
+	ret = psci_cpu_init_idle(drv, cpu, ret);
 	if (ret) {
 		pr_err("CPU %d failed to PSCI idle\n", cpu);
 		goto out_kfree_drv;
-- 
2.17.1

