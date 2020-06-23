Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFCE205870
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgFWRWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 13:22:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22836 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgFWRWR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 13:22:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592932935; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=x8Cxh62MOawA5bvEovUYlLnlKgrUeX79yYs3hO4HFMU=; b=mDDpcqTh39AAmRmxhluQWeFzdLPufBDgIaNb120zzUegMOqhccodHTXmQZQT1ObEjT7G+Hbo
 b7/+VLLkRRIQaTejKiBbJTlVhNT1k47vzpWP8yV8ysl56jegAUw1isbSzpnDx3zB36M3uu6G
 ix08JD7TbguFHR1QqiFB0GrteQo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5ef23a36fe1db4db89f98550 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 17:21:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2E0BC433A0; Tue, 23 Jun 2020 17:21:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6329EC433C6;
        Tue, 23 Jun 2020 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6329EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 23 Jun 2020 11:21:56 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] cpuidle: psci: Convert PM domain to platform driver
Message-ID: <20200623172156.GA16960@codeaurora.org>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
 <20200615152054.6819-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200615152054.6819-5-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15 2020 at 09:21 -0600, Ulf Hansson wrote:
>To enable support for deferred probing and to allow implementation of the
>->sync_state() callback from subsequent changes, let's convert into a
>platform driver.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/cpuidle/cpuidle-psci-domain.c | 45 +++++++++++++++++----------
> 1 file changed, 28 insertions(+), 17 deletions(-)
>
>diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>index e48e578aaa7d..bf527d2bb4b6 100644
>--- a/drivers/cpuidle/cpuidle-psci-domain.c
>+++ b/drivers/cpuidle/cpuidle-psci-domain.c
>@@ -12,6 +12,7 @@
> #include <linux/cpu.h>
> #include <linux/device.h>
> #include <linux/kernel.h>
>+#include <linux/platform_device.h>
> #include <linux/pm_domain.h>
> #include <linux/pm_runtime.h>
> #include <linux/psci.h>
>@@ -42,8 +43,8 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
> 	return 0;
> }
>
>-static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
>-					int state_count)
>+static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
>+				     int state_count)
> {
> 	int i, ret;
> 	u32 psci_state, *psci_state_buf;
>@@ -72,7 +73,7 @@ static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
> 	return ret;
> }
>
>-static int __init psci_pd_parse_states(struct device_node *np,
>+static int psci_pd_parse_states(struct device_node *np,
> 			struct genpd_power_state **states, int *state_count)
> {
> 	int ret;
>@@ -100,7 +101,7 @@ static void psci_pd_free_states(struct genpd_power_state *states,
> 	kfree(states);
> }
>
>-static int __init psci_pd_init(struct device_node *np)
>+static int psci_pd_init(struct device_node *np)
> {
> 	struct generic_pm_domain *pd;
> 	struct psci_pd_provider *pd_provider;
>@@ -167,7 +168,7 @@ static int __init psci_pd_init(struct device_node *np)
> 	return ret;
> }
>
>-static void __init psci_pd_remove(void)
>+static void psci_pd_remove(void)
> {
> 	struct psci_pd_provider *pd_provider, *it;
> 	struct generic_pm_domain *genpd;
>@@ -185,7 +186,7 @@ static void __init psci_pd_remove(void)
> 	}
> }
>
>-static int __init psci_pd_init_topology(struct device_node *np, bool add)
>+static int psci_pd_init_topology(struct device_node *np, bool add)
> {
> 	struct device_node *node;
> 	struct of_phandle_args child, parent;
>@@ -211,24 +212,24 @@ static int __init psci_pd_init_topology(struct device_node *np, bool add)
> 	return 0;
> }
>
>-static int __init psci_pd_add_topology(struct device_node *np)
>+static int psci_pd_add_topology(struct device_node *np)
> {
> 	return psci_pd_init_topology(np, true);
> }
>
>-static void __init psci_pd_remove_topology(struct device_node *np)
>+static void psci_pd_remove_topology(struct device_node *np)
> {
> 	psci_pd_init_topology(np, false);
> }
>
>-static const struct of_device_id psci_of_match[] __initconst = {
>+static const struct of_device_id psci_of_match[] = {
> 	{ .compatible = "arm,psci-1.0" },
> 	{}
> };
>
>-static int __init psci_idle_init_domains(void)
>+static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> {
>-	struct device_node *np = of_find_matching_node(NULL, psci_of_match);
>+	struct device_node *np = pdev->dev.of_node;
> 	struct device_node *node;
> 	int ret = 0, pd_count = 0;
>
>@@ -237,7 +238,7 @@ static int __init psci_idle_init_domains(void)
>
> 	/* Currently limit the hierarchical topology to be used in OSI mode. */
> 	if (!psci_has_osi_support())
>-		goto out;
>+		return 0;
>
> 	/*
> 	 * Parse child nodes for the "#power-domain-cells" property and
>@@ -256,7 +257,7 @@ static int __init psci_idle_init_domains(void)
>
> 	/* Bail out if not using the hierarchical CPU topology. */
> 	if (!pd_count)
>-		goto out;
>+		return 0;
>
> 	/* Link genpd masters/subdomains to model the CPU topology. */
> 	ret = psci_pd_add_topology(np);
>@@ -271,9 +272,8 @@ static int __init psci_idle_init_domains(void)
> 		goto remove_pd;
> 	}
>
>-	of_node_put(np);
> 	pr_info("Initialized CPU PM domain topology\n");
>-	return pd_count;
>+	return 0;
>
> put_node:
> 	of_node_put(node);
>@@ -281,10 +281,21 @@ static int __init psci_idle_init_domains(void)
> 	if (pd_count)
> 		psci_pd_remove();
> 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
>-out:
>-	of_node_put(np);
> 	return ret;
> }
>+
>+static struct platform_driver psci_cpuidle_domain_driver = {
>+	.probe  = psci_cpuidle_domain_probe,
>+	.driver = {
>+		.name = "psci-cpuidle-domain",
>+		.of_match_table = psci_of_match,
>+	},
>+};
>+
>+static int __init psci_idle_init_domains(void)
>+{
>+	return platform_driver_register(&psci_cpuidle_domain_driver);
>+}
> subsys_initcall(psci_idle_init_domains);
>
> struct device *psci_dt_attach_cpu(int cpu)
>-- 
>2.20.1
>
