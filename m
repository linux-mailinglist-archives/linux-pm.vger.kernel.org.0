Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB8258E6E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIAMow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgIAMMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 08:12:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CAC061246
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 05:12:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so1208261ljn.6
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cU9q2qmzfSVfsoCjyVJEHGi6YkUuYbmq67VIQe2n0w=;
        b=yhguxh/vBJx2bdVfHod6sKwD+1nJ4mtd2exx8L4uSxfsblzwU8/UI4+al8NZ74PQO8
         D5BQ/MeCvwpak00y3RoOKDziEzdlvWO0xu9r2e75mYpjG7AWWmozD57JqiVocyyudU7d
         +u+I64yVM0QGRK0L4ii7FD0oP9EgVBIscJQxRfLD89PfS+9jQTuL0gf7nAX61JRmxKo2
         S/gS6p1LPrFTBBNR3D/MHdpakT1nbn1dss5lVYE8NDSfdGuVjJ25V3TvmUQ+YZDxm8cP
         eUfKpZJn4YmC55xnxQk8nDjIu04Ce5TCXFHwXc1bytsEsMFUg7DH1T7AA/Qfpho1tojP
         sdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cU9q2qmzfSVfsoCjyVJEHGi6YkUuYbmq67VIQe2n0w=;
        b=ZKui4LLw+hoRWqIdIRizKWxsff0ohuV7JpiP03delD2S0J+Kj6DPrB2/0C87MTeSej
         o5tJSZafUrpLe/aI2fGuoMIsOCWgfU53ocX/CWM1v7v+YBFJvD5riJH+pQeOYViY/v+e
         xcFMj9aH90cF4JfJAQ5BJXclCt22B656BeF13lHqUazpuyB+2qJFKmDnyY0PHci9zhkX
         hfuoBapUgYl4dVqlr02KR+HI7ocHxQi0z3gJ0qf2A9HKHGZqcREuip1Iuk9UpmSjbt5/
         YB4f+3wSKvucfadUGVBq8gpI5AHaSAfMrHjsymTtZOQuAGdVSn/Uc9nMFnxJwj/aA+mg
         lT2Q==
X-Gm-Message-State: AOAM533N2xTheHZodLadDEBYwA4IxZndUGkMOsM0zHuFgzgRpu5ApwCE
        4PVQTIwUQ9iKV17vN+7auKHFLg==
X-Google-Smtp-Source: ABdhPJwoffSXIieoiLOcYaunHNPEpTMob++deBrMhVsh7hnLRFyn++yNJrS0iqiCQfJehQt6yFzv4g==
X-Received: by 2002:a2e:854c:: with SMTP id u12mr453343ljj.120.1598962359733;
        Tue, 01 Sep 2020 05:12:39 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id u6sm241193ljg.105.2020.09.01.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 05:12:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
Date:   Tue,  1 Sep 2020 14:12:26 +0200
Message-Id: <20200901121226.217568-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901121226.217568-1-ulf.hansson@linaro.org>
References: <20200901121226.217568-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
topology with the genpd providers isn't initialized. This is perfectly fine
from cpuidle-psci point of view.

However, since the PM domain topology in the DTS files is a description of
the HW, no matter of whether the PSCI OSI mode is supported or not, other
consumers besides the CPUs may rely on it.

Therefore, let's always allow the initialization of the PM domain topology
to succeed, independently of whether the PSCI OSI mode is supported.
Consequentially we need to track if we succeed to enable the OSI mode, as
to know when a domain idlestate can be selected.

Note that, CPU devices are still not being attached to the PM domain
topology, unless the PSCI OSI mode is supported.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Assign the genpd ->power_off() callback, only when the PSCI OSI mode
	has been successfully enabled.

---
 drivers/cpuidle/cpuidle-psci-domain.c | 57 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b6ab0415f450..256e7e35b5af 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -105,7 +105,7 @@ static void psci_pd_free_states(struct genpd_power_state *states,
 	kfree(states);
 }
 
-static int psci_pd_init(struct device_node *np)
+static int psci_pd_init(struct device_node *np, bool use_osi)
 {
 	struct generic_pm_domain *pd;
 	struct psci_pd_provider *pd_provider;
@@ -135,11 +135,14 @@ static int psci_pd_init(struct device_node *np)
 
 	pd->free_states = psci_pd_free_states;
 	pd->name = kbasename(pd->name);
-	pd->power_off = psci_pd_power_off;
 	pd->states = states;
 	pd->state_count = state_count;
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
+	/* Use the ->power_off() callback when OSI is enabled. */
+	if (use_osi)
+		pd->power_off = psci_pd_power_off;
+
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
 
@@ -190,7 +193,7 @@ static void psci_pd_remove(void)
 	}
 }
 
-static int psci_pd_init_topology(struct device_node *np, bool add)
+static int psci_pd_init_topology(struct device_node *np)
 {
 	struct device_node *node;
 	struct of_phandle_args child, parent;
@@ -203,9 +206,7 @@ static int psci_pd_init_topology(struct device_node *np, bool add)
 
 		child.np = node;
 		child.args_count = 0;
-
-		ret = add ? of_genpd_add_subdomain(&parent, &child) :
-			of_genpd_remove_subdomain(&parent, &child);
+		ret = of_genpd_add_subdomain(&parent, &child);
 		of_node_put(parent.np);
 		if (ret) {
 			of_node_put(node);
@@ -216,14 +217,20 @@ static int psci_pd_init_topology(struct device_node *np, bool add)
 	return 0;
 }
 
-static int psci_pd_add_topology(struct device_node *np)
+static bool psci_pd_try_set_osi_mode(void)
 {
-	return psci_pd_init_topology(np, true);
-}
+	int ret;
 
-static void psci_pd_remove_topology(struct device_node *np)
-{
-	psci_pd_init_topology(np, false);
+	if (!psci_has_osi_support())
+		return false;
+
+	ret = psci_set_osi_mode(true);
+	if (ret) {
+		pr_warn("failed to enable OSI mode: %d\n", ret);
+		return false;
+	}
+
+	return true;
 }
 
 static void psci_cpuidle_domain_sync_state(struct device *dev)
@@ -244,14 +251,14 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *node;
+	bool use_osi;
 	int ret = 0, pd_count = 0;
 
 	if (!np)
 		return -ENODEV;
 
-	/* Currently limit the hierarchical topology to be used in OSI mode. */
-	if (!psci_has_osi_support())
-		return 0;
+	/* If OSI mode is supported, let's try to enable it. */
+	use_osi = psci_pd_try_set_osi_mode();
 
 	/*
 	 * Parse child nodes for the "#power-domain-cells" property and
@@ -261,7 +268,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		if (!of_find_property(node, "#power-domain-cells", NULL))
 			continue;
 
-		ret = psci_pd_init(node);
+		ret = psci_pd_init(node, use_osi);
 		if (ret)
 			goto put_node;
 
@@ -270,30 +277,24 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 
 	/* Bail out if not using the hierarchical CPU topology. */
 	if (!pd_count)
-		return 0;
+		goto no_pd;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
-	ret = psci_pd_add_topology(np);
+	ret = psci_pd_init_topology(np);
 	if (ret)
 		goto remove_pd;
 
-	/* Try to enable OSI mode. */
-	ret = psci_set_osi_mode(true);
-	if (ret) {
-		pr_warn("failed to enable OSI mode: %d\n", ret);
-		psci_pd_remove_topology(np);
-		goto remove_pd;
-	}
-
 	pr_info("Initialized CPU PM domain topology\n");
 	return 0;
 
 put_node:
 	of_node_put(node);
 remove_pd:
-	if (pd_count)
-		psci_pd_remove();
+	psci_pd_remove();
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
+no_pd:
+	if (use_osi)
+		psci_set_osi_mode(false);
 	return ret;
 }
 
-- 
2.25.1

