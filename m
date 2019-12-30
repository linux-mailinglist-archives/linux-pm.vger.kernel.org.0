Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60012D101
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfL3Oo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33131 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfL3Oo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so25495162lji.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZefleScox1nm0+WYdQ3BBhBjbSL9pi9Q8gxjnjPNiI=;
        b=k+dt5ccdM3owzCTK74XbbbsHMqeeevmQDr+sXGOzZz/nvx6U4OyDozmpHNQUhuaKRe
         vRVVXwZjnYNFQ3TNWlJlAuJo7RQgfXlH+c2rsmGReY5lw4rMtjSN9RbIU2iPKUIKMXyg
         Am/JZdq9S2seigcx0WOPNH7heKDq3ujz9N9afSvlxLivAVB8SSuDmeC85/GDTrf0eWTI
         MbAXC7Vog/fdCvT99X/JoC1IfKYVLgJhYzLT+sqGCpwsXms2XobgUMwP++a5glp3poQn
         QKLTJHgyhyGIxD+zCfo0yHfKFCRR/77wPTYWkxwowB4AYOhFPIPJF/EesW3EJqk6QpFF
         lboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZefleScox1nm0+WYdQ3BBhBjbSL9pi9Q8gxjnjPNiI=;
        b=rjvT3G6IGLyM77RFjcejD/X1YQxRpTbMtcJFP3TEJDCXKY6sow4AgnrwHUvPkx/Jov
         ryY77XyHwwR4TYtFUA7ao0HHN7lmB1apMHC+SoJhLN/kvvTBfre3jq3M3VoLcJScK7m5
         IoA3Imjts1TC78CY6noBx8j111Lcp9gMDjKlCPbQoEhDTf7C86E76wWcNxtyS+pCRj1Y
         1lMj6RY9mZySlwSysEf5y5Ummhl3od4MO+Jc9SqI3OX43VcbA2TAbsmdde8RWanBuvJ5
         OXHtnmNX8ytqhIRymJ4C790Xxi151yx0Y0jftrnn2sWejPCTJ9oD0l6NTBhv49WoywrB
         dI9Q==
X-Gm-Message-State: APjAAAV5aFZdYYVOnPkaePaOPNr5REhdkdiCJ0BbBW5VTDbzzLhwpA+0
        8mq19QnUotn6omCj/6At4rmCyg==
X-Google-Smtp-Source: APXvYqxJiXnez81BgsM8+ozNoti4VBDX7b1Vf0pT/sSFBdtMD2BiZFUGesyFglHR4O41EPd4kYP/DA==
X-Received: by 2002:a2e:80d9:: with SMTP id r25mr39573873ljg.8.1577717064736;
        Mon, 30 Dec 2019 06:44:24 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:24 -0800 (PST)
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
Subject: [PATCH v5 10/15] cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
Date:   Mon, 30 Dec 2019 15:43:57 +0100
Message-Id: <20191230144402.30195-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
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

Changes in v5:
	- None.

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

