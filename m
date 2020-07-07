Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB7216D4B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGGM63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGM63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 08:58:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B51C061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 05:58:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so49790140ljn.4
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkXZj4/pMT9pPcwacUaB98YwreiOuCxYZG9xrLmembw=;
        b=A88VM81IK+t1ZB6Q06hKJOLn4l/0OxUy5gRIgQgiNvaI4lyYmybOHoi/Kq63L95xjX
         gvrkw8iwNxowjbR//1jD2C9h/2B+2Y7lMHhfflH1wkEMCNxGZ4zpTDUMSuNHMJfydVGL
         H+QNZxR3i8p13BIcbZS2lymhDrCnxZEThXWkx8xn0eZsbHjtBOQ5XlisMuOq+IcPN1x9
         Ex5iWq77Zn4FWWNlbIThuGbV76s0DBIw1XeLaWo0DHMA4AWPHKFim5m7DuY2k9syFmEq
         o4IwrkUrIPDk7gR9hjW3FFC2DOwDjCRSzJWl8DkMPvg/1NUqpxhF9Zru8ZCwIC53Dghd
         wbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkXZj4/pMT9pPcwacUaB98YwreiOuCxYZG9xrLmembw=;
        b=nOaHQG3F1+Ss/yZWul++bEyCBKXWUXvBRPGzkPt/NiMenNe+dnWFJWIEviELaGJKlD
         MUa90aB9XGPhL1Ul1wkg0kKeBjdYTE9sHAXrukBWnFXkqGq8r+PkTLGYglrxMIkDnWgQ
         4/DYKM2oUxO6n5/HNZhdGfrsnf54Yf1p+O7bVmdKpfn7JZZ859TcZcKrO+JL9V+7NJFK
         4Bwb1B2lBJpwh2oLhDjTEn4u+raUCiLXLa5xcHPyHRyDKyM7n01ID+z/A/rQ6rAAIySP
         XtRxP6764zIYRhbf0UmUn0EwS9Yy2c9/ldxs2qhBTYu0JlDEzRnpm5HsJEHTwMY7DqEa
         VkkA==
X-Gm-Message-State: AOAM531rx7sGi0FUSv8NxDVrYAfqccdaO7EWspCVDctdlUfbA64FxLVR
        HTdc52sV1LQLAnnv74290LSdag==
X-Google-Smtp-Source: ABdhPJyBSriC7tiBtcgSZ/HW3ozSjjB3SMNR1qyrVjRG5PFGhtQNnT1gJ+8CVfwWMf7aVvGYjk6GIw==
X-Received: by 2002:a2e:9883:: with SMTP id b3mr23503453ljj.390.1594126707435;
        Tue, 07 Jul 2020 05:58:27 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id 11sm9554395lfz.78.2020.07.07.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 05:58:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] cpuidle: psci: Convert PM domain to platform driver
Date:   Tue,  7 Jul 2020 14:58:03 +0200
Message-Id: <20200707125804.13030-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707125804.13030-1-ulf.hansson@linaro.org>
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To enable support for deferred probing and to allow implementation of the
->sync_state() callback from subsequent changes, let's convert into a
platform driver.

Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 45 +++++++++++++++++----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index e48e578aaa7d..bf527d2bb4b6 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -12,6 +12,7 @@
 #include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/psci.h>
@@ -42,8 +43,8 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
 	return 0;
 }
 
-static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
-					int state_count)
+static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
+				     int state_count)
 {
 	int i, ret;
 	u32 psci_state, *psci_state_buf;
@@ -72,7 +73,7 @@ static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
 	return ret;
 }
 
-static int __init psci_pd_parse_states(struct device_node *np,
+static int psci_pd_parse_states(struct device_node *np,
 			struct genpd_power_state **states, int *state_count)
 {
 	int ret;
@@ -100,7 +101,7 @@ static void psci_pd_free_states(struct genpd_power_state *states,
 	kfree(states);
 }
 
-static int __init psci_pd_init(struct device_node *np)
+static int psci_pd_init(struct device_node *np)
 {
 	struct generic_pm_domain *pd;
 	struct psci_pd_provider *pd_provider;
@@ -167,7 +168,7 @@ static int __init psci_pd_init(struct device_node *np)
 	return ret;
 }
 
-static void __init psci_pd_remove(void)
+static void psci_pd_remove(void)
 {
 	struct psci_pd_provider *pd_provider, *it;
 	struct generic_pm_domain *genpd;
@@ -185,7 +186,7 @@ static void __init psci_pd_remove(void)
 	}
 }
 
-static int __init psci_pd_init_topology(struct device_node *np, bool add)
+static int psci_pd_init_topology(struct device_node *np, bool add)
 {
 	struct device_node *node;
 	struct of_phandle_args child, parent;
@@ -211,24 +212,24 @@ static int __init psci_pd_init_topology(struct device_node *np, bool add)
 	return 0;
 }
 
-static int __init psci_pd_add_topology(struct device_node *np)
+static int psci_pd_add_topology(struct device_node *np)
 {
 	return psci_pd_init_topology(np, true);
 }
 
-static void __init psci_pd_remove_topology(struct device_node *np)
+static void psci_pd_remove_topology(struct device_node *np)
 {
 	psci_pd_init_topology(np, false);
 }
 
-static const struct of_device_id psci_of_match[] __initconst = {
+static const struct of_device_id psci_of_match[] = {
 	{ .compatible = "arm,psci-1.0" },
 	{}
 };
 
-static int __init psci_idle_init_domains(void)
+static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
-	struct device_node *np = of_find_matching_node(NULL, psci_of_match);
+	struct device_node *np = pdev->dev.of_node;
 	struct device_node *node;
 	int ret = 0, pd_count = 0;
 
@@ -237,7 +238,7 @@ static int __init psci_idle_init_domains(void)
 
 	/* Currently limit the hierarchical topology to be used in OSI mode. */
 	if (!psci_has_osi_support())
-		goto out;
+		return 0;
 
 	/*
 	 * Parse child nodes for the "#power-domain-cells" property and
@@ -256,7 +257,7 @@ static int __init psci_idle_init_domains(void)
 
 	/* Bail out if not using the hierarchical CPU topology. */
 	if (!pd_count)
-		goto out;
+		return 0;
 
 	/* Link genpd masters/subdomains to model the CPU topology. */
 	ret = psci_pd_add_topology(np);
@@ -271,9 +272,8 @@ static int __init psci_idle_init_domains(void)
 		goto remove_pd;
 	}
 
-	of_node_put(np);
 	pr_info("Initialized CPU PM domain topology\n");
-	return pd_count;
+	return 0;
 
 put_node:
 	of_node_put(node);
@@ -281,10 +281,21 @@ static int __init psci_idle_init_domains(void)
 	if (pd_count)
 		psci_pd_remove();
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-out:
-	of_node_put(np);
 	return ret;
 }
+
+static struct platform_driver psci_cpuidle_domain_driver = {
+	.probe  = psci_cpuidle_domain_probe,
+	.driver = {
+		.name = "psci-cpuidle-domain",
+		.of_match_table = psci_of_match,
+	},
+};
+
+static int __init psci_idle_init_domains(void)
+{
+	return platform_driver_register(&psci_cpuidle_domain_driver);
+}
 subsys_initcall(psci_idle_init_domains);
 
 struct device *psci_dt_attach_cpu(int cpu)
-- 
2.20.1

