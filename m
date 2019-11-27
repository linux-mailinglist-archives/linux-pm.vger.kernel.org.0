Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5693B10ADA5
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfK0K33 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46865 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfK0K33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so16681828lfi.13
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0I9CQqrUBNSTNqaPoYCSgGHqC9smjnctVcF6YeNShSQ=;
        b=vZ1vOFaHIZmtCdVywrWmJBZGQYGImGUJFdgpnJpTpl9g9lZQrdtiKa347hWKoVT80M
         2ui5XajnnMJ2OqZe4jTjaj6WoYmEaPHvpSpjJVAlkpqIEfv0Y1TLqmeCOQq1i+nWax2E
         5ZwTRG1xMvRIj8zQ/E/62lyspn9awdC/GJEmr5HNssUDKOjdv8LcTflXAXXYepmrrwSQ
         fQ4DEY6vociDIPd9KFLaCtvFZo9F0nNRnCCwSaoFWrz4OdLn2wETIbPvI6Drbgzbezzl
         vCXF1Jm6ldsz1uIfzHl8kckcS66a8S5yo1Vd03uGTo2LXIXjUj92xStSzceDPHBUe0bI
         n5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0I9CQqrUBNSTNqaPoYCSgGHqC9smjnctVcF6YeNShSQ=;
        b=b9MDbd23LDgODssXO0ZErnQC5knOoZy/OPzgBrfCA60J+PAOgDSXCCVKpW0z8ArpZF
         +/9P97yfqsqsKicH2x0+P94WXL3tw/3UiOk3bWouUC1Qpc5QEU+6C6fX85w5T98eK1+m
         s3W93SzppLuZtPeo9wSjWrJSMOBwsiLWj9cfgdCsfl58kjVyb3Y79kIjkHqHVRbKgn4u
         ZWta8JWKZoQz+uR1nIzFRSUZLd4sOIICQYc3ET1tcX5HuHh4xrilKaU6gbpSmJL/fta1
         XVXm63EdMi/aZ3FWOaxNWvMuOHHfOSWQjlRvNTvXjxF9H6aHdhILTstpgyokjjDQm0RW
         Y9Lg==
X-Gm-Message-State: APjAAAUyNDCfvEAs6oBeyjWYK8Ht5gfH0A1kcatHuyVtsYsefcG8H0Yn
        7XdTVqltnUVwfhjiSnhFGCMluQ==
X-Google-Smtp-Source: APXvYqwNFTas3Bs6wwHxVh132p8pvVvuXzBhsyjzWLzItUAMqGGEB3v2xG26muuVMBiwA8d0S7N2BQ==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr1270912lfq.176.1574850567136;
        Wed, 27 Nov 2019 02:29:27 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:26 -0800 (PST)
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
Subject: [PATCH v3 06/13] cpuidle: psci: Simplify OF parsing of CPU idle state nodes
Date:   Wed, 27 Nov 2019 11:29:07 +0100
Message-Id: <20191127102914.18729-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127102914.18729-1-ulf.hansson@linaro.org>
References: <20191127102914.18729-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Iterating through the idle state nodes in DT, to find out the number of
states that needs to be allocated is unnecessary, as it has already been
done from dt_init_idle_driver(). Therefore, drop the iteration and use the
number we already have at hand.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes in v3:
	- None.

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

