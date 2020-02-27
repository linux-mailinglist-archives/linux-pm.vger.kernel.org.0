Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD911717C4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 13:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgB0Mq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 07:46:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39507 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgB0Mq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 07:46:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so3247491ljg.6
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 04:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTt6UBxA6W5SX+1ICKiklMI9uA6M1ZbDrJNq6V8cSwg=;
        b=xFBxcPAEgZhFSYaozHLmDlFYl2fFzeMwv0JES7iXa4HWNnguu8lRelP1AwlGXLi4Qy
         PXZ2IGeC7mCYSD4xntHc/sAo8J5Xel+aewoQbyw+hhIROWcalIsqchcyI/nUDI7+Ezjn
         gRfLnTl1Dnu9W+EwekxM1i0OuJAZi1egMepLusHNJCyyyYFrfOM6GaB87hkHSQ2rX5k3
         wZs1KJyTfwGRQadAaYQh24FuXwXLM4Xy/JcfzQbiH+NNGi6AVVG2pqzCOzf75aKeuNSz
         H7aSSCv2FmrbgwHqn/ZfbZIxSpHqAmmzzMwLxN5arR4pyQyUL8ZB24l1u39rCDrlIDGz
         UqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTt6UBxA6W5SX+1ICKiklMI9uA6M1ZbDrJNq6V8cSwg=;
        b=OCLJjznvXXgFYU01R6g4/GVe4I75VTkWsAnXAuwLkMtmzljIlO56Ht2rlBlPdZHTdj
         0dBJ7zCmAdvTv9gLLmZXJJ3bk7yun5bexn5VKeMT6HYxDTnsnlvpRDFKm4EvFYMVHIZq
         SCpU/yXhF+HvGsifg+l21pmkTrrGzBHBBIdJblnog/8BGI7HzUWwkN/W2z02iDWTf6zF
         7Wszr6ti8QfY5qn2FURvc8Z/lJt2jIDYag1Eb3GVYtQV6ql+4f3/axsW/2MIRkuqNeyo
         Dff0/X6mj8sB2AubEXw71OszJw8JwcvMfobQWFSGplBy5L4SLRH3/RHHrfA5FxbBD3uB
         pbcg==
X-Gm-Message-State: ANhLgQ2H5lm8litoQX2+wn/t3NDCnFrPF2nAva7QVa+wXozUtu/nf/zQ
        oBw8+EVehUVQPpI3gvZEFFhGzg==
X-Google-Smtp-Source: ADFU+vtahVhqQemAkBHrVNd22ZkStLpI5Lit/jghKpl6hbLD66xlZ/d/3Okl8cC8HxMB8genhlJvdg==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr2781657ljg.3.1582807586339;
        Thu, 27 Feb 2020 04:46:26 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l16sm2669334lfh.74.2020.02.27.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:46:24 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] cpuidle: psci: Allow WFI to be the only state for the hierarchical topology
Date:   Thu, 27 Feb 2020 13:45:51 +0100
Message-Id: <20200227124551.31860-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227124551.31860-1-ulf.hansson@linaro.org>
References: <20200227124551.31860-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's possible that only the WFI state is supported for the CPU, while also
a shared idle state exists for a group of CPUs.

When the hierarchical topology is used, the shared idle state may not be
compatible with arm,idle-state, rather with "domain-idle-state", which
makes dt_init_idle_driver() to return zero. This leads to that the
cpuidle-psci driver bails out during initialization, avoiding to register a
cpuidle driver and instead relies on the default architectural
back-end (called via cpu_do_idle()). In other words, the shared idle state
becomes unused.

Let's fix this behaviour, by allowing the dt_init_idle_driver() to return 0
and then continue with the initialization. If it turns out that the
hierarchical topology is used and we have some additional states to manage,
then continue with the cpuidle driver registration, otherwise bail out, as
we did before.

Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 47 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 7b459f987c50..7699b2dab622 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -56,16 +56,19 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	u32 *states = data->psci_states;
 	struct device *pd_dev = data->dev;
 	u32 state;
-	int ret;
+	int ret = 0;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
 	pm_runtime_put_sync_suspend(pd_dev);
 
 	state = psci_get_domain_state();
-	if (!state)
+	if (!state && states)
 		state = states[idx];
 
-	ret = psci_enter_state(idx, state);
+	if (state)
+		ret = psci_cpu_suspend_enter(state);
+	else
+		cpu_do_idle();
 
 	pm_runtime_get_sync(pd_dev);
 
@@ -181,6 +184,7 @@ static int __init psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 		drv->states[state_count - 1].enter =
 			psci_enter_domain_idle_state;
 		psci_cpuidle_use_cpuhp = true;
+		return 1;
 	}
 
 	return 0;
@@ -195,6 +199,13 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	struct device_node *state_node;
 	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
+	/*
+	 * Special case when WFI is the only state, as we may still need to
+	 * initialize data, if the hierarchical topology is used.
+	 */
+	if (!state_count)
+		return psci_dt_cpu_init_topology(drv, data, 1, cpu);
+
 	state_count++; /* Add WFI state too */
 	psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
 	if (!psci_states)
@@ -226,7 +237,7 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
 	data->psci_states = psci_states;
-	return 0;
+	return state_count;
 
 free_mem:
 	kfree(psci_states);
@@ -285,33 +296,35 @@ static int __init psci_idle_init_cpu(int cpu)
 		return -ENOMEM;
 
 	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
+	drv->state_count = 1;
 
 	/*
-	 * Initialize idle states data, starting at index 1, since
-	 * by default idle state 0 is the quiescent state reached
-	 * by the cpu by executing the wfi instruction.
-	 *
-	 * If no DT idle states are detected (ret == 0) let the driver
-	 * initialization fail accordingly since there is no reason to
-	 * initialize the idle driver if only wfi is supported, the
-	 * default archictectural back-end already executes wfi
-	 * on idle entry.
+	 * Initialize idle states data, starting at index 1, since by default
+	 * idle state 0 is the quiescent state reached by the cpu by executing
+	 * the wfi instruction. If no DT idle states are detected (ret == 0),
+	 * we may still use the hierarchical topology.
 	 */
 	ret = dt_init_idle_driver(drv, psci_idle_state_match, 1);
-	if (ret <= 0) {
-		ret = ret ? : -ENODEV;
+	if (ret < 0)
 		goto out_kfree_drv;
-	}
 
 	/*
 	 * Initialize PSCI idle states.
 	 */
 	ret = psci_cpu_init_idle(drv, cpu, ret);
-	if (ret) {
+	if (ret < 0) {
 		pr_err("CPU %d failed to PSCI idle\n", cpu);
 		goto out_kfree_drv;
 	}
 
+	/* If there are no idle states to manage, but the wfi state and we also
+	 * don't use the hierarchical topology, let the driver initialization
+	 * fail. Instead, let's rely on the default architectural back-end to
+	 * execute wfi on idle entry.
+	 */
+	if (!ret)
+		goto out_kfree_drv;
+
 	ret = cpuidle_register(drv, NULL);
 	if (ret)
 		goto out_kfree_drv;
-- 
2.20.1

