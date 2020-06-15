Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F51F9BD5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgFOPVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgFOPVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 11:21:08 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A90C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i8so3296179lfo.4
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GC70gu/KuM6k/D+t12MJpeTyl5aXSJlixkvFE052RDs=;
        b=JnL0VFDLFIILGO0nUCBh6p0+PJ00P5rFYB20L3+wdzaaf8acyU6+crOeQkjOcz8p/E
         NfwTDioK18cs92dba9RgtWPAcJDK+LIXfIhyOw3QuLi12wdFTNil8MGzDJchWaNQlfaa
         zFWw+iLfdLh3nXCfCUB0VlxhohW1EzmVJmRdCauuidUUtv7YYIXDeybeVxxORKB5vXnd
         Udwb7Ru4v7rRwdqK139qq9Jpmu+7RZ+IAxL8B44Pw/JCegI3nsv5BN+j6UFNiQeW24iX
         QDAOMGAC4aAlcWUSDRxGHPNdDzww078zeUC/8FqlNt7EVD3yO8oehMaZZ0FxB8sN/uAw
         P9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GC70gu/KuM6k/D+t12MJpeTyl5aXSJlixkvFE052RDs=;
        b=hAueown5Ss3VuerPNygcGRYXTHRn+KTMkunSVPeYqPh2NHj80XO/BesAjjmpeUBUtb
         Fo24xdVc0MoaNZ+r9BInKk5JA74Ertl0esgbjJvEggREDcC+Ho9oLV63pVALoLGPawfT
         HSubaejWz1EgEYNFT8rej3ViitRpr0MPNYE65dNj+EGh3YqeXv9eqUdrW8lyyHzN4Oo9
         LV/fDt/KZMVPU4/+ddRXfCl5MBaV852q4Z+ETLtR0yBsEH9va/9jMZ/ws3KkQrD1LNnF
         pZ2kiFQ7rFaTe0DK/acqX2VOP5S50K17zoFlmnrVqu7Xy8nWRfFuS/bLfYSqN167a87f
         3NeQ==
X-Gm-Message-State: AOAM530KBHwB+li4U9HMCQa3/Mb/PT0OHd0OBTW/Q/5Lpkng8a9LEgws
        TOilpFOqoEydCPFpFFTCo3z/Pg==
X-Google-Smtp-Source: ABdhPJzuWrj4m6EK3EepgYnbI6CxPwGIQzFsWlLIN5e2ApsKrVZA6GxkeECekZVHmqtxdz1F/MtQnw==
X-Received: by 2002:ac2:48a6:: with SMTP id u6mr8375406lfg.49.1592234466371;
        Mon, 15 Jun 2020 08:21:06 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id r13sm507045lfp.80.2020.06.15.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:21:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
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
Subject: [PATCH 4/5] cpuidle: psci: Convert PM domain to platform driver
Date:   Mon, 15 Jun 2020 17:20:53 +0200
Message-Id: <20200615152054.6819-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200615152054.6819-1-ulf.hansson@linaro.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To enable support for deferred probing and to allow implementation of the
->sync_state() callback from subsequent changes, let's convert into a
platform driver.

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

