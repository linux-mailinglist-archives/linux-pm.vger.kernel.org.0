Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B324F72F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHXJJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 05:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgHXJJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 05:09:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D207C0613ED
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:09:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so3870791pjx.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bBoN/fJ8ZBi4jWE5LR3K6DN1QrhriBADtjA3PVqbrE=;
        b=X2SB9idbucp6OUq+YHiAk5O+GWd7c4BKzZZ87q61ExZvqSCX+iNgw9ep9V40U4G6R1
         UdC4ZiS37It7yusiAJy3C4jYmZSUVlBqwV00kFEqa+gGd3vEQ1FRCq0Oeo4p8bCpsVd6
         Is/bYwmlJ9hJsUxUlKlzWKy6jm48s5ul8oHaph3msMudK9RnvWAxLPP6n8eDPeJ9NIQt
         Ja8/jDN+oIXSm2L0eBLMYj1FkQgULmgjpGNyjidWflFjohghAcIT5kZz9uAm494azLu4
         f0aLOfzFtkmYtHSAxDg7QyIf4ERR4dxWrteyNyFlmvUhXCJ0EXOKc/n0f5RypCM8FWGR
         YtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bBoN/fJ8ZBi4jWE5LR3K6DN1QrhriBADtjA3PVqbrE=;
        b=tZiAcqhG5qE+4ghlR9uRNFlymZy/CabVSzBM+XWY68TIXEkqxHqO4lIUpIh96W8ayi
         66O171TF3I+/5JNdpDHwD9BLPY+wQPIhFoxIo4+NZziIDoBX7Gsb8pwCuh06UKB03uFd
         E4q7gF29CbgmpcKr70YGQXsz3dOb22zAnySBf8oE6LxaZZyCvvTZgI8ZjO+pnqiP13nZ
         eZXmHnG+3GVRm04qS+6+Mxo5giC4SY4X2bmq9ZX7XFgs17Vmx/r2PB48hsVB8wA5D4Fj
         WC7Rh5o5AOm3deEZbldY59y8BTmKoAvHDo2gBtw5Ibk5DNOxb0mFG2txakJzTFSGw8fq
         LCLg==
X-Gm-Message-State: AOAM532gvVxu0C6FiK4edzck9UENIym5yoZE26SSeZJtvKjD4yZsUteS
        73gW0H9ohWa8OtwXr4AWqdCA+Q==
X-Google-Smtp-Source: ABdhPJysuL2P27A0MhItF3iWtZ72BaF+LBbbr+ahMI0iWIHcldzo7JR555unRu+kdht5WROg99gRCg==
X-Received: by 2002:a17:902:d20e:: with SMTP id t14mr3188949ply.327.1598260183394;
        Mon, 24 Aug 2020 02:09:43 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id h15sm9772040pjf.54.2020.08.24.02.09.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:09:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        nks@flawful.org, georgi.djakov@linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] cpufreq: dt: Refactor initialization to handle probe deferral properly
Date:   Mon, 24 Aug 2020 14:39:33 +0530
Message-Id: <f75c61f193f396608d592ae2a9938264d582c038.1598260050.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

cpufreq-dt is currently unable to handle -EPROBE_DEFER properly
because the error code is not propagated for the cpufreq_driver->init()
callback. Instead, it attempts to avoid the situation by temporarily
requesting all resources within resources_available() and releasing them
again immediately after. This has several disadvantages:

  - Whenever we add something like interconnect handling to the OPP core
    we need to patch cpufreq-dt to request these resources early.

  - resources_available() is only run for CPU0, but other clusters may
    eventually depend on other resources that are not available yet.
    (See FIXME comment removed by this commit...)

  - All resources need to be looked up several times.

Now that the OPP core can propagate -EPROBE_DEFER during initialization,
it would be nice to avoid all that trouble and just propagate its error
code when necessary.

This commit refactors the cpufreq-dt driver to initialize private_data
before registering the cpufreq driver. We do this by iterating over
all possible CPUs and ensure that all resources are initialized:

  1. dev_pm_opp_get_opp_table() ensures the OPP table is allocated
     and initialized with clock and interconnects.

  2. dev_pm_opp_set_regulators() requests the regulators and assigns
     them to the OPP table.

  3. We call dev_pm_opp_of_get_sharing_cpus() early so that we only
     initialize the OPP table once for each shared policy.

With these changes, we actually end up saving a few lines of code,
the resources are no longer looked up multiple times and everything
should be much more robust.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[ Viresh: Use list_head structure for maintaining the list and minor
	  changes ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 286 +++++++++++++++++------------------
 1 file changed, 143 insertions(+), 143 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 944d7b45afe9..d29cd93045fa 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,6 +13,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -24,18 +25,35 @@
 #include "cpufreq-dt.h"
 
 struct private_data {
-	struct opp_table *opp_table;
+	struct list_head node;
+
+	cpumask_var_t cpus;
 	struct device *cpu_dev;
-	const char *reg_name;
+	struct opp_table *opp_table;
+	struct opp_table *reg_opp_table;
 	bool have_static_opps;
 };
 
+static LIST_HEAD(priv_list);
+
 static struct freq_attr *cpufreq_dt_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,   /* Extra space for boost-attr if required */
 	NULL,
 };
 
+static struct private_data *cpufreq_dt_find_data(int cpu)
+{
+	struct private_data *priv;
+
+	list_for_each_entry(priv, &priv_list, node) {
+		if (cpumask_test_cpu(cpu, priv->cpus))
+			return priv;
+	}
+
+	return NULL;
+}
+
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct private_data *priv = policy->driver_data;
@@ -90,83 +108,24 @@ static const char *find_supply_name(struct device *dev)
 	return name;
 }
 
-static int resources_available(void)
-{
-	struct device *cpu_dev;
-	struct regulator *cpu_reg;
-	struct clk *cpu_clk;
-	int ret = 0;
-	const char *name;
-
-	cpu_dev = get_cpu_device(0);
-	if (!cpu_dev) {
-		pr_err("failed to get cpu0 device\n");
-		return -ENODEV;
-	}
-
-	cpu_clk = clk_get(cpu_dev, NULL);
-	ret = PTR_ERR_OR_ZERO(cpu_clk);
-	if (ret) {
-		/*
-		 * If cpu's clk node is present, but clock is not yet
-		 * registered, we should try defering probe.
-		 */
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "clock not ready, retry\n");
-		else
-			dev_err(cpu_dev, "failed to get clock: %d\n", ret);
-
-		return ret;
-	}
-
-	clk_put(cpu_clk);
-
-	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
-	if (ret)
-		return ret;
-
-	name = find_supply_name(cpu_dev);
-	/* Platform doesn't require regulator */
-	if (!name)
-		return 0;
-
-	cpu_reg = regulator_get_optional(cpu_dev, name);
-	ret = PTR_ERR_OR_ZERO(cpu_reg);
-	if (ret) {
-		/*
-		 * If cpu's regulator supply node is present, but regulator is
-		 * not yet registered, we should try defering probe.
-		 */
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
-		else
-			dev_dbg(cpu_dev, "no regulator for cpu0: %d\n", ret);
-
-		return ret;
-	}
-
-	regulator_put(cpu_reg);
-	return 0;
-}
-
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
-	struct opp_table *opp_table = NULL;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	unsigned int transition_latency;
-	bool fallback = false;
-	const char *name;
 	int ret;
 
-	cpu_dev = get_cpu_device(policy->cpu);
-	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", policy->cpu);
+	priv = cpufreq_dt_find_data(policy->cpu);
+	if (!priv) {
+		pr_err("failed to find data for cpu%d\n", policy->cpu);
 		return -ENODEV;
 	}
 
+	cpu_dev = priv->cpu_dev;
+	cpumask_copy(policy->cpus, priv->cpus);
+
 	cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
 		ret = PTR_ERR(cpu_clk);
@@ -174,45 +133,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	/* Get OPP-sharing information from "operating-points-v2" bindings */
-	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
-	if (ret) {
-		if (ret != -ENOENT)
-			goto out_put_clk;
-
-		/*
-		 * operating-points-v2 not supported, fallback to old method of
-		 * finding shared-OPPs for backward compatibility if the
-		 * platform hasn't set sharing CPUs.
-		 */
-		if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
-			fallback = true;
-	}
-
-	/*
-	 * OPP layer will be taking care of regulators now, but it needs to know
-	 * the name of the regulator first.
-	 */
-	name = find_supply_name(cpu_dev);
-	if (name) {
-		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
-		if (IS_ERR(opp_table)) {
-			ret = PTR_ERR(opp_table);
-			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
-				policy->cpu, ret);
-			goto out_put_clk;
-		}
-	}
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_put_regulator;
-	}
-
-	priv->reg_name = name;
-	priv->opp_table = opp_table;
-
 	/*
 	 * Initialize OPP tables for all policy->cpus. They will be shared by
 	 * all CPUs which have marked their CPUs shared with OPP bindings.
@@ -232,31 +152,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	ret = dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <= 0) {
-		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
-		ret = -EPROBE_DEFER;
+		dev_err(cpu_dev, "OPP table can't be empty\n");
+		ret = -ENODEV;
 		goto out_free_opp;
 	}
 
-	if (fallback) {
-		cpumask_setall(policy->cpus);
-
-		/*
-		 * OPP tables are initialized only for policy->cpu, do it for
-		 * others as well.
-		 */
-		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
-		if (ret)
-			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
-				__func__, ret);
-	}
-
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 		goto out_free_opp;
 	}
 
-	priv->cpu_dev = cpu_dev;
 	policy->driver_data = priv;
 	policy->clk = cpu_clk;
 	policy->freq_table = freq_table;
@@ -288,11 +194,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_opp:
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
-	kfree(priv);
-out_put_regulator:
-	if (name)
-		dev_pm_opp_put_regulators(opp_table);
-out_put_clk:
 	clk_put(cpu_clk);
 
 	return ret;
@@ -320,12 +221,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
-	if (priv->reg_name)
-		dev_pm_opp_put_regulators(priv->opp_table);
-
 	clk_put(policy->clk);
-	kfree(priv);
-
 	return 0;
 }
 
@@ -344,21 +240,119 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
-static int dt_cpufreq_probe(struct platform_device *pdev)
+static int dt_cpufreq_early_init(struct device *dev, int cpu)
 {
-	struct cpufreq_dt_platform_data *data = dev_get_platdata(&pdev->dev);
+	struct private_data *priv;
+	struct device *cpu_dev;
+	const char *reg_name;
 	int ret;
 
+	/* Check if this CPU is already covered by some other policy */
+	if (cpufreq_dt_find_data(cpu))
+		return 0;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return -EPROBE_DEFER;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	priv->cpu_dev = cpu_dev;
+
+	/* Try to get OPP table early to ensure resources are available */
+	priv->opp_table = dev_pm_opp_get_opp_table(cpu_dev);
+	if (IS_ERR(priv->opp_table)) {
+		ret = PTR_ERR(priv->opp_table);
+		if (ret != -EPROBE_DEFER)
+			dev_err(cpu_dev, "failed to get OPP table: %d\n", ret);
+		goto free_cpumask;
+	}
+
 	/*
-	 * All per-cluster (CPUs sharing clock/voltages) initialization is done
-	 * from ->init(). In probe(), we just need to make sure that clk and
-	 * regulators are available. Else defer probe and retry.
-	 *
-	 * FIXME: Is checking this only for CPU0 sufficient ?
+	 * OPP layer will be taking care of regulators now, but it needs to know
+	 * the name of the regulator first.
 	 */
-	ret = resources_available();
-	if (ret)
-		return ret;
+	reg_name = find_supply_name(cpu_dev);
+	if (reg_name) {
+		priv->reg_opp_table = dev_pm_opp_set_regulators(cpu_dev,
+								&reg_name, 1);
+		if (IS_ERR(priv->reg_opp_table)) {
+			ret = PTR_ERR(priv->reg_opp_table);
+			if (ret != -EPROBE_DEFER)
+				dev_err(cpu_dev, "failed to set regulators: %d\n",
+					ret);
+			goto put_table;
+		}
+	}
+
+	/* Find OPP sharing information so we can fill pri->cpus here */
+	/* Get OPP-sharing information from "operating-points-v2" bindings */
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->cpus);
+	if (ret) {
+		if (ret != -ENOENT)
+			goto put_reg;
+
+		/*
+		 * operating-points-v2 not supported, fallback to all CPUs share
+		 * OPP for backward compatibility if the platform hasn't set
+		 * sharing CPUs.
+		 */
+		if (dev_pm_opp_get_sharing_cpus(cpu_dev, priv->cpus)) {
+			cpumask_setall(priv->cpus);
+
+			/*
+			 * OPP tables are initialized only for cpu, do it for
+			 * others as well.
+			 */
+			ret = dev_pm_opp_set_sharing_cpus(cpu_dev, priv->cpus);
+			if (ret)
+				dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+					__func__, ret);
+		}
+	}
+
+	list_add(&priv->node, &priv_list);
+	return 0;
+
+put_reg:
+	if (priv->reg_opp_table)
+		dev_pm_opp_put_regulators(priv->reg_opp_table);
+put_table:
+	dev_pm_opp_put_opp_table(priv->opp_table);
+free_cpumask:
+	free_cpumask_var(priv->cpus);
+	return ret;
+}
+
+static void dt_cpufreq_release(void)
+{
+	struct private_data *priv, *tmp;
+
+	list_for_each_entry_safe(priv, tmp, &priv_list, node) {
+		if (priv->reg_opp_table)
+			dev_pm_opp_put_regulators(priv->reg_opp_table);
+		dev_pm_opp_put_opp_table(priv->opp_table);
+		free_cpumask_var(priv->cpus);
+		list_del(&priv->node);
+	}
+}
+
+static int dt_cpufreq_probe(struct platform_device *pdev)
+{
+	struct cpufreq_dt_platform_data *data = dev_get_platdata(&pdev->dev);
+	int ret, cpu;
+
+	/* Request resources early so we can return in case of -EPROBE_DEFER */
+	for_each_possible_cpu(cpu) {
+		ret = dt_cpufreq_early_init(&pdev->dev, cpu);
+		if (ret)
+			goto err;
+	};
 
 	if (data) {
 		if (data->have_governor_per_policy)
@@ -374,15 +368,21 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
+		goto err;
+	}
 
+	return 0;
+err:
+	dt_cpufreq_release();
 	return ret;
 }
 
 static int dt_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&dt_cpufreq_driver);
+	dt_cpufreq_release();
 	return 0;
 }
 
-- 
2.25.0.rc1.19.g042ed3e048af

