Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DD259069
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgIAO3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgIAO3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 10:29:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A1C061246
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 07:29:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j15so892879lfg.7
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8BpIdoUWarD6YsNR5keyc/R3LV3nr8+EDPnN27oa5w=;
        b=OTEkxGHMQo6lwO7qWEQS2nyPIV/ZoNJAB8hDU6ChkbgvxwNGtDewDKJtFveHjZzp/i
         PhZPCdhzh82f/yTaY/0usjl1LHnulS839xOg82DPgxEgo/CgC7TLxL479PBtD2fZhqO7
         lI/JnOvhYQjtu3BYAcB1posah3WmMsckT4zi9C0dKjfCYlRXN7hpZ77HGsJlJZjIK6Tm
         rPxtcJIuobY348SoLcmpP1GydVYZu2iY6w+QxF731AZdgLmbcSKkHfJEvE68M/i2e0eX
         3LvLsiYsWQIGGKIodQI6FR7wu6hoGhAFnEU61O1utmljufbDwhM15eKkAiX6GMVRhd8W
         vbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8BpIdoUWarD6YsNR5keyc/R3LV3nr8+EDPnN27oa5w=;
        b=W0qlSXeNvEgnAxKBE/NG/qtworuCNMkpZ0BrBO/AAtdj9AXWaleiyrZUI48saTe+df
         KqzivonB1gwzWHSLDY/PXwn3JhHfqhrxUU1RP86cPLB6DZs6tHDHDdgh9tHYyoKZTj4W
         eIe4NdvQ+MGbFhL8hYDSrWYR2vTBPSIDfIG4JDjvtNoJlRIFQCJHtvlRLXHn0W+UU9uK
         EAjtz4wN5kVEwRiRIdBUtGBqKg5ke5Fja91EYeKwBdxX1p8cRldT6ncCpkFUA85lMqEY
         SlMzZ15+MJbnzkkzf9CcTD0083GDk82r9k/45gtt4T/wKVPxbKLJ1rAgla+HVGfMMs8+
         ElLg==
X-Gm-Message-State: AOAM533XeWNdX6ViOLC1+B+bdSMbJcx8ZipgfzKWB5Y8G9wG8wBHpaIo
        xNM1yDtdQU6WbAlemN9A3103LA==
X-Google-Smtp-Source: ABdhPJyfXiM4Okzd/SRkCrEceXeq0ysdCqTtfeVh0J2LAdPZF7qAOjGHIdlheefSoZzDhHIGzHmNWw==
X-Received: by 2002:a05:6512:200e:: with SMTP id a14mr749683lfb.49.1598970549872;
        Tue, 01 Sep 2020 07:29:09 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id r7sm318313lfn.84.2020.09.01.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:29:08 -0700 (PDT)
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
Subject: [PATCH v3 2/2] cpuidle: psci: Allow PM domain to be initialized even if no OSI mode
Date:   Tue,  1 Sep 2020 16:28:59 +0200
Message-Id: <20200901142859.224381-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901142859.224381-1-ulf.hansson@linaro.org>
References: <20200901142859.224381-1-ulf.hansson@linaro.org>
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

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Added acked-by tag.
	- Use GENPD_FLAG_ALWAYS_ON to prevent power off, unless OSI has been
	successfully enabled.

---
 drivers/cpuidle/cpuidle-psci-domain.c | 59 ++++++++++++++-------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b6ab0415f450..4a031c62f92a 100644
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
@@ -135,11 +135,16 @@ static int psci_pd_init(struct device_node *np)
 
 	pd->free_states = psci_pd_free_states;
 	pd->name = kbasename(pd->name);
-	pd->power_off = psci_pd_power_off;
 	pd->states = states;
 	pd->state_count = state_count;
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
+	/* Allow power off when OSI has been successfully enabled. */
+	if (use_osi)
+		pd->power_off = psci_pd_power_off;
+	else
+		pd->flags |= GENPD_FLAG_ALWAYS_ON;
+
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
 
@@ -190,7 +195,7 @@ static void psci_pd_remove(void)
 	}
 }
 
-static int psci_pd_init_topology(struct device_node *np, bool add)
+static int psci_pd_init_topology(struct device_node *np)
 {
 	struct device_node *node;
 	struct of_phandle_args child, parent;
@@ -203,9 +208,7 @@ static int psci_pd_init_topology(struct device_node *np, bool add)
 
 		child.np = node;
 		child.args_count = 0;
-
-		ret = add ? of_genpd_add_subdomain(&parent, &child) :
-			of_genpd_remove_subdomain(&parent, &child);
+		ret = of_genpd_add_subdomain(&parent, &child);
 		of_node_put(parent.np);
 		if (ret) {
 			of_node_put(node);
@@ -216,14 +219,20 @@ static int psci_pd_init_topology(struct device_node *np, bool add)
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
@@ -244,14 +253,14 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
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
@@ -261,7 +270,7 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 		if (!of_find_property(node, "#power-domain-cells", NULL))
 			continue;
 
-		ret = psci_pd_init(node);
+		ret = psci_pd_init(node, use_osi);
 		if (ret)
 			goto put_node;
 
@@ -270,30 +279,24 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 
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

