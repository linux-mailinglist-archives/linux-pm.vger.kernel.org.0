Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848B11BDC6
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEMTZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 15:25:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41124 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbfEMTXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 15:23:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so12053886lja.8
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h+mBrphGE8r6kKGvHPN2hwwjlulIBItsLgwHs6HK8tw=;
        b=z1qwoOxfxP8ws6K0eXeqsi0M8rg4AiA8aC+/rjIVQbuJPoKSAquEg4iySw4L3cN5x8
         jjlTDZuSJciHj+R09dPL+gALzrtUwcXOVPCSnr1zV5JjUxXC+jTH/bs1uFkycg9wYG8L
         3ilSYwaJ4Q/40soKA1mrFGCJYk6E1a5pkxpihVokTsS7TPrP5nTxTdm7Jw+QAnCFWTxO
         uSmb50ZRpi0pFqGue364kuAdvMUhtO582nHQ8c2OptpkJde/IrOfk1AUVO3SIIewRV7N
         vt3h/dJVN+5qmhzobmOPYqBY1Id026c5O41E9qZf/leKI1FYytDGLpKNJm1MNCm4XpMm
         8yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h+mBrphGE8r6kKGvHPN2hwwjlulIBItsLgwHs6HK8tw=;
        b=eMze0PYJKGhDG/B2nmPy0A293jnXP2R9V145JNDP2B5BAse8AbASUYjwpzQMy+kDHL
         EuU+nnSffA55Nkt17u3aUYl6WNYbqRuwxYzsMFRpA2rIanBYDmhZJTYHn/S8XqV5Gjgt
         b0ewaL+KXnnurSj9xOVU0e8ZD6ZZwMtJOdtL9OE0qqRKG3BT+VhKdi7/ZXv7Ztg18MpA
         wAM2g/SVy+8bI3X2LEU4GBqepcZzf2rkjRjs33z+pAGtlT6LoSjhL8T242xNEtC+0cnh
         sFEX7la3NFPtFRHHWZ9SWxyTcibVpMTNlQcc/fiBlbL+niA8EKCb1697h8HnjC+I15J6
         Gxvw==
X-Gm-Message-State: APjAAAWCerxhqhC9aIxA7EZdHEI5RZwzJ3o8jVUPzX2CyVMo1ZmgCm5v
        1sdW/ta/rU/ttuC0aGdz00WySg==
X-Google-Smtp-Source: APXvYqyeVfJKdGokU/doivXzmlRxtYYG8D4KXKrSzXVVKA9wCQvIkwAm3xVkfpldRQZcHwdKpXbyIA==
X-Received: by 2002:a2e:9241:: with SMTP id v1mr14737256ljg.6.1557775395160;
        Mon, 13 May 2019 12:23:15 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q21sm3449365lfa.84.2019.05.13.12.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 12:23:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/18] drivers: firmware: psci: Simplify state node parsing
Date:   Mon, 13 May 2019 21:22:47 +0200
Message-Id: <20190513192300.653-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of iterating through all the state nodes in DT, to find out how
many states that needs to be allocated, let's use the number already known
by the cpuidle driver. In this way we can drop the iteration altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

Changes:
	- None.

---
 drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 88e90e0f06b9..9c2180bcee4c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -306,26 +306,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
-	int i, ret = 0, count = 0;
+	int i, ret = 0, num_state_nodes = drv->state_count - 1;
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
+	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < num_state_nodes; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
@@ -335,6 +329,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
 
+	if (i != num_state_nodes) {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

