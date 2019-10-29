Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7DE8D06
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390639AbfJ2Qo4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:44:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46257 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390436AbfJ2Qo4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:44:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so11015774lfc.13
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lVOXUxxNfV4wN8bXUUjCt19F2H674agulhVmSpBAGAE=;
        b=Wq5NfHQPAlEsbZnoQSMFmjC6IAkDnAhfODokHmgWVS89BHlzxBq+ZIf8QlWoglh0YS
         4TeLiSC2uYyogVPZ3eCnP0EuopYnwKNk6DKy0T/tPABYmb6JOUPxItn2XxgeuAuSCWpq
         OudHPaKwaUZRxh/QMpMbNhOjU2IZ2Q8cIzpFzc7tLvhIoGa1oFjLfmpIIbsmbAPEXOQL
         HRdAyY1mdURR5DmHxMN5wRmFt9zw1oS9mLzxxVM+T5b7WILz0Sx81Jg9XXWGRdz4YURc
         Jg67ktqi3/B61awY2CkjMd5/w09MMl3vU1SwFJXpNNHKp7Xt5yFrq3EiH/oH55ELcysM
         DT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lVOXUxxNfV4wN8bXUUjCt19F2H674agulhVmSpBAGAE=;
        b=acqCcqkRzFTP9hNmiXPkgZhTAo7bxYi9bXLvuUOU9XNJwEnFZal4THLmG7QjCGfkT1
         +5YX43Q8tULLpJMyVoweQSpLRCmtZmaKX7wVxGakyFbHCwwAmrGRO3qNTaD8Fzlmq74C
         zkFSFVNafaL+BjnPWPzHeLFTEgrRGWbvq7H8josDjI41BJCn7pVfZmPNBw+vxG0ubzsS
         pegRvUQLAXqiy1xbaxHAiPWi/PrdsHR1J5h2Qg4JNOElQi82nh6yzenahp6JGn61I4vc
         h7ecfeUWP1stOeIM6uYsO0tstONg+o48Y6pbed1ndgqBKXlrc1AQJvcf5a0AK53Bq1jP
         DPhA==
X-Gm-Message-State: APjAAAWXyJG9TzEO0IIu9k97w71oSsLTpiXpgK7xv76aSORwPeWneU74
        0DrNQO+l8iN6mH1bVi7Ale6XSw==
X-Google-Smtp-Source: APXvYqxGf8w8I3KVuSqOM7/zKsnP0xinWPh7Ee1N9tyxQPh9MinelvopEFVFU27e5Ky+H/l8+CQgXw==
X-Received: by 2002:ac2:5b42:: with SMTP id i2mr3123478lfp.164.1572367493929;
        Tue, 29 Oct 2019 09:44:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f28sm2048161lfh.35.2019.10.29.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:44:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 06/13] cpuidle: psci: Simplify OF parsing of CPU idle state nodes
Date:   Tue, 29 Oct 2019 17:44:31 +0100
Message-Id: <20191029164438.17012-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029164438.17012-1-ulf.hansson@linaro.org>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Iterating through the idle state nodes in DT, to find out the number of
states that needs to be allocated is unnecessary, as it has already been
done from dt_init_idle_driver(). Therefore, drop the iteration and use the
number we already have at hand.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased.
	- Renamed variable and fixed tab-intendent.

---
 drivers/cpuidle/cpuidle-psci.c | 35 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 361985f52ddd..761359be50f2 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -73,30 +73,24 @@ static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
-static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
+					unsigned int state_count, int cpu)
 {
-	int i, ret = 0, count = 0;
+	int i, ret = 0;
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
-	}
-
-	if (!count)
-		return -ENODEV;
-
-	count++; /* Add WFI state too */
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	state_count++; /* Add WFI state too */
+	psci_states = kcalloc(state_count, sizeof(*psci_states), GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 1; i < count; i++) {
+	for (i = 1; i < state_count; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
 					      i - 1);
+		if (!state_node)
+			break;
+
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
@@ -106,6 +100,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
 
+	if (i != state_count) {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
@@ -115,7 +114,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	return ret;
 }
 
-static __init int psci_cpu_init_idle(unsigned int cpu)
+static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_count)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -131,7 +130,7 @@ static __init int psci_cpu_init_idle(unsigned int cpu)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
+	ret = psci_dt_cpu_init_idle(cpu_node, state_count, cpu);
 
 	of_node_put(cpu_node);
 
@@ -187,7 +186,7 @@ static int __init psci_idle_init_cpu(int cpu)
 	/*
 	 * Initialize PSCI idle states.
 	 */
-	ret = psci_cpu_init_idle(cpu);
+	ret = psci_cpu_init_idle(cpu, ret);
 	if (ret) {
 		pr_err("CPU %d failed to PSCI idle\n", cpu);
 		goto out_kfree_drv;
-- 
2.17.1

