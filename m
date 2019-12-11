Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE44911B3C6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbfLKPoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39563 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbfLKPoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:44:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id e10so24588618ljj.6
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xFV9pwGCTDQIRD0MEW258+4R088s+9zQCaaqV7y2r0w=;
        b=syw2oRHygvzxLXpdFNwn22dQOkl4y20AEx6z1Uls/sCqdCKH9r/o178DiOzM54g7OV
         IpU/IRF4flzpLrKYOHSTQTgXkwHzSkEXp2rV756hmn2XQCDXaD6+cSKzxqSy4vRFG1yy
         xq9vWaLOGI67hpk7tWHiiKQJ3ewjM9UHPj4tM0WJtVKebWiYIkynUYM2xXG/P/hvtOYR
         ywZw0bgnjxKUvrLx0aTaqE5z5F3scckjHAmyMWiCyO17yUPp1j6PAtHhutWHx9tr/LPd
         lG/RPDAnJMf4qeEVMADGUS/b2jiJQHhs/r3fynwHlNPhQAXvFjnhb+m4tItEuDESwGAR
         Llmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xFV9pwGCTDQIRD0MEW258+4R088s+9zQCaaqV7y2r0w=;
        b=aRXsPZBWa3Ftik+sHY3lN4ElozsKDgsstUYeSV+wlerbEVFP6vfiB+xU5SdRJe972q
         8DWXICI4URszn9vp78vOuXPSmY0tZeuxapq0425gQZ1QWi6NV8+oupnTxO1MISo+GX2v
         r86C38RIX2RsazXPlo+y2Z/tbx7ooXrr8Lzk1M8qjnb5vzTBRy+PRK05fp7QSOMee+X2
         SJX1ICuPYCS6iy5JkANAd7u/YDcecJtgH7js0LWFM8aDVrT4BeJkUSdyoVCe8TcuTY5i
         z7IVI1LA2UykU2qnn6DFC+xVEUPnYwuWPpwy/TwRyfResEI/0JJ75Ckl+5dR3s0+6yM7
         9Tyg==
X-Gm-Message-State: APjAAAX9vlWuGWUtlEguiswDgJN+wXiduMguXk3qVuy5f+Ynq8C51uT4
        kHHAXDoDSz+s+9eKN1iCRSNxGA==
X-Google-Smtp-Source: APXvYqwy9KqxilZ2uPEWVJbqhtBfRH7pmVUc1hwAnfJS9bCNt24+Ia7y6QxnjkBb+pzDnvPQc3Ea1Q==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr2255960ljo.180.1576079048402;
        Wed, 11 Dec 2019 07:44:08 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:44:07 -0800 (PST)
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
Subject: [PATCH v4 10/14] cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
Date:   Wed, 11 Dec 2019 16:43:39 +0100
Message-Id: <20191211154343.29765-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211154343.29765-1-ulf.hansson@linaro.org>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
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

Changes in v4:
	- Rebased on top of earlier changes.
	- Add comment about using the deepest cpuidle state for the domain state
	selection.

---
 drivers/cpuidle/cpuidle-psci.c | 56 ++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 6a87848be3c3..9600fe674a89 100644
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
@@ -118,6 +152,15 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 			ret = PTR_ERR(data->dev);
 			goto free_mem;
 		}
+
+		/*
+		 * Using the deepest state for the CPU to trigger a potential
+		 * selection of a shared state for the domain, assumes the
+		 * domain states are all deeper states.
+		 */
+		if (data->dev)
+			drv->states[state_count - 1].enter =
+				psci_enter_domain_idle_state;
 	}
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
@@ -129,7 +172,8 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
 	return ret;
 }
 
-static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
+static __init int psci_cpu_init_idle(struct cpuidle_driver *drv,
+				     unsigned int cpu, unsigned int state_count)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -145,7 +189,7 @@ static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, state_count, cpu);
+	ret = psci_dt_cpu_init_idle(drv, cpu_node, state_count, cpu);
 
 	of_node_put(cpu_node);
 
@@ -201,7 +245,7 @@ static int __init psci_idle_init_cpu(int cpu)
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

