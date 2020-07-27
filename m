Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8BD22E91E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgG0Jhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 05:37:38 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:26593 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0Jhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 05:37:37 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 05:37:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1595842653;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vHFYsy+B0ZI9jf7FTGV9RzgIHZlt6VzLM1vcnLyUtEg=;
        b=V/MNkYoVD0fXjF7xufbB6oEAV1PsCSvuWhVh+Zmulu8jMBItdWH3gBNMtAEz+GupZ8
        M5KA1NXnC7rQV00zNEVsxAGYfkmy/vcvWgUMm4AHD+Isq53UVQuQ3I0rAJrTi1kbUONr
        NBBh0RU/hRbLJs+B0NA2jKbhNRJRzmkxCl9b0fwHrvWs5CrdY8ZXjmxewUv5f84e+9kj
        ZBSWy+LmZX2wWkG95+Wd02E771Vg+intBGnabaqsbLDUWwLiDlbeYcO3jI/uAyKcIxgB
        FgXzk0NLTCLauVVcmNVDrLCbEXhiolq8DKYet/RGu0EqJIMZC48ohrIJvojpa7CoRIFX
        Tmag==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6IbY0="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew6R9VYKof
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 27 Jul 2020 11:31:34 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [RFC PATCH 2/2] cpufreq: dt: Refactor initialization to handle probe deferral properly
Date:   Mon, 27 Jul 2020 11:30:47 +0200
Message-Id: <20200727093047.8274-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727093047.8274-1-stephan@gerhold.net>
References: <20200727093047.8274-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
An alternative (and possibly more clean) solution would be to handle
-EPROBE_DEFER for the cpufreq_driver->init() callback. However, this
would require patching subsys_interface_register() to handle the
return values of the subsys_interface->add_dev() callback (and
rollback appropriately). The subsys functionality is used in a lot
of places so I did not really feel comfortable changing that...
---
 drivers/cpufreq/cpufreq-dt.c | 275 +++++++++++++++++------------------
 1 file changed, 133 insertions(+), 142 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 944d7b45afe9..42cdde325dff 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -24,18 +24,35 @@
 #include "cpufreq-dt.h"
 
 struct private_data {
-	struct opp_table *opp_table;
+	cpumask_var_t cpus;
+	struct private_data *next;
+
 	struct device *cpu_dev;
-	const char *reg_name;
+	struct opp_table *opp_table;
+	struct opp_table *reg_opp_table;
 	bool have_static_opps;
 };
 
+static struct private_data *cpu_data;
+
 static struct freq_attr *cpufreq_dt_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,   /* Extra space for boost-attr if required */
 	NULL,
 };
 
+static struct private_data *cpufreq_dt_find_data(int cpu)
+{
+	struct private_data *priv = cpu_data;
+
+	while (priv) {
+		if (cpumask_test_cpu(cpu, priv->cpus))
+			break;
+		priv = priv->next;
+	}
+	return priv;
+}
+
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct private_data *priv = policy->driver_data;
@@ -90,83 +107,23 @@ static const char *find_supply_name(struct device *dev)
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
+	struct private_data *priv = cpufreq_dt_find_data(policy->cpu);
 	struct cpufreq_frequency_table *freq_table;
-	struct opp_table *opp_table = NULL;
-	struct private_data *priv;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
 	unsigned int transition_latency;
-	bool fallback = false;
-	const char *name;
 	int ret;
 
-	cpu_dev = get_cpu_device(policy->cpu);
-	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", policy->cpu);
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
@@ -174,45 +131,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
@@ -237,26 +155,12 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
@@ -288,11 +192,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
@@ -320,12 +219,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
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
 
@@ -344,21 +238,112 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
-static int dt_cpufreq_probe(struct platform_device *pdev)
+static int dt_cpufreq_init_cpu(struct device *dev, int cpu)
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
+	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	priv->cpu_dev = cpu_dev;
+	priv->next = cpu_data;
+	cpu_data = priv;
+
+	/* Try to get OPP table early to ensure resources are available */
+	priv->opp_table = dev_pm_opp_get_opp_table(cpu_dev);
+	if (IS_ERR(priv->opp_table)) {
+		ret = PTR_ERR(priv->opp_table);
+		if (ret != -EPROBE_DEFER)
+			dev_err(cpu_dev, "failed to get OPP table: %d\n", ret);
+		return ret;
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
+			return ret;
+		}
+	}
+
+	/* Get OPP-sharing information from "operating-points-v2" bindings */
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->cpus);
+	if (ret) {
+		if (ret != -ENOENT)
+			return ret;
+
+		/*
+		 * operating-points-v2 not supported, fallback to old method of
+		 * finding shared-OPPs for backward compatibility if the
+		 * platform hasn't set sharing CPUs.
+		 */
+		if (dev_pm_opp_get_sharing_cpus(cpu_dev, priv->cpus)) {
+			/* Fallback to all CPUs */
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
+	return 0;
+}
+
+static void dt_cpufreq_release(void)
+{
+	struct private_data *priv = cpu_data;
+
+	while (priv) {
+		if (!IS_ERR_OR_NULL(priv->reg_opp_table))
+			dev_pm_opp_put_regulators(priv->reg_opp_table);
+		if (!IS_ERR_OR_NULL(priv->opp_table))
+			dev_pm_opp_put_opp_table(priv->opp_table);
+		free_cpumask_var(priv->cpus);
+		priv = priv->next;
+	}
+	cpu_data = NULL;
+}
+
+static int dt_cpufreq_probe(struct platform_device *pdev)
+{
+	struct cpufreq_dt_platform_data *data = dev_get_platdata(&pdev->dev);
+	int ret, cpu;
+
+	/* Request resources early so we can return in case of -EPROBE_DEFER */
+	for_each_possible_cpu(cpu) {
+		ret = dt_cpufreq_init_cpu(&pdev->dev, cpu);
+		if (ret)
+			goto err;
+	};
 
 	if (data) {
 		if (data->have_governor_per_policy)
@@ -374,15 +359,21 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
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
2.27.0

