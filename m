Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7189BD2823
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfJJLkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39677 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfJJLkS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so5843002ljj.6
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zajMnk2cgVpbetFqzeuJjqL5gocttncCIISD2oCeqro=;
        b=w/wpfkf4JD7NtMhgYW5bka2jwABBrG/zFpdfSK+C6Y8ZEzk1usOy+0SZ037SEiwojW
         8ikm7DR8YcoaSKOsLXm8/4fAoU66XIkDrdXmlfD0bKpQ4pPfXVVdHhNQ8eWlxdKdwF8m
         3v9pJu7MyhXBh0O8lxuIkg9S/oSY3v5jPH/hUxyxae9He70A2JNrMcErYiipUzzxW6la
         RPJBm1dTBVGovcLV6kmCCd3lqZrimb7rDvRlZSKv2Ch/iQaQuACu1Dssa3Z+C2w/ecWr
         XF0jqnbdyn9OWFCh7gZX9bj7CuKUEM3iw2jfcQG61bDXCjKqE62EJgVMKO9gnqC4ni9I
         rSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zajMnk2cgVpbetFqzeuJjqL5gocttncCIISD2oCeqro=;
        b=XTiiHPaca3zKfvED602tFMW3tgK1ZoBUOflcvaMo/6Zbf/FYVHZHdQZS+rthdaa11s
         CXn/AFGvjCcm1WErZBV2mQlVxXFawqfJ/KB6iK/HFIQrZESH9quYof+xRRkJ26ATiZBk
         6bc8bdOamR9tc251oTt6sv/KHngKokwp5NaGiYYHWpo+1LZ2W5jV0ieV6bxk5RtTa9v3
         vwnrCYhDx3k8FIkO8djNeWUDsyCh2S6WermMgYFTwu3pMQD9m+2k5sR0zzUSgTSWLj8h
         S/rJtqj2Ih1nNW4lpInXqAWp5kNOuUZl8ovaH6IYp+7nE+DsUl4/X0tBUbdT/vKFsR2s
         Bpfg==
X-Gm-Message-State: APjAAAWLtMgJ9VD2Eg5AcWEaNColfaYnbE7gIrP+oSrB9mTzjqr7J/18
        MyBn/pOcj63VkziHGAHgM2VbLw==
X-Google-Smtp-Source: APXvYqx8XV+oQ6tAHK6bndR8s4uIRBDsgX8TGkAPZYFU0mns7A7hnFIcGWvIyBsKIHrN+DhA2aCXOg==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr5973843ljj.43.1570707614837;
        Thu, 10 Oct 2019 04:40:14 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:14 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 06/13] cpuidle: psci: Simplify OF parsing of CPU idle state nodes
Date:   Thu, 10 Oct 2019 13:39:30 +0200
Message-Id: <20191010113937.15962-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010113937.15962-1-ulf.hansson@linaro.org>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
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
 drivers/cpuidle/cpuidle-psci.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2e91c8d6c211..1195a1056139 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -73,28 +73,22 @@ static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
-static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node,
+				unsigned int state_nodes, int cpu)
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
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	psci_states = kcalloc(state_nodes, sizeof(*psci_states), GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < state_nodes; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
@@ -104,6 +98,11 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
 
+	if (i != state_nodes) {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
@@ -113,7 +112,7 @@ static int __init psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	return ret;
 }
 
-static __init int psci_cpu_init_idle(unsigned int cpu)
+static __init int psci_cpu_init_idle(unsigned int cpu, unsigned int state_nodes)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -129,7 +128,7 @@ static __init int psci_cpu_init_idle(unsigned int cpu)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
+	ret = psci_dt_cpu_init_idle(cpu_node, state_nodes, cpu);
 
 	of_node_put(cpu_node);
 
@@ -185,7 +184,7 @@ static int __init psci_idle_init_cpu(int cpu)
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

