Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34D2A8F6D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 07:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgKFGZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 01:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFGZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 01:25:47 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C62CC0613CF
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 22:25:47 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so163834pgk.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 22:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WaW/Kl55+DVDxtYNyOBh4gwHpyqJtIa03Gx18IWwOY=;
        b=iSOAb50AYOS4sZQXnLvptdF+hXVBdQs1ZtMUfVPbGE/jX5VDDofDsPSZKdxVrj+x5N
         aCK1lf7xnug98SPUYOXlZ3TGozT9h9LvJikZ9LJh0cPmYyZXRp3o/sEPOxDT/R7SOe1n
         HzUvau2aiRbiNzMqPu+/j7aDZwaUtpcbmgCxBFtMDfGpSJYIWgfUPqOvFtjqL4EywE1I
         Eg0pyCoWCgIH7TO9rhiolK2ZwtGiKQuGFDouhGrhcjWKPxpp5RjWKskJ/XD7qSYfVFZw
         uff8Ivj5JX0/eNjhLPnoxydXa8HlxVXU2j+E1s9hPJHwE+9/Lz40q3AqNoNqdmHFNMkX
         W5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+WaW/Kl55+DVDxtYNyOBh4gwHpyqJtIa03Gx18IWwOY=;
        b=syMAcviwoR//sUF2d2JyoImQxCimh5BWPtixWIi8TJh/WLlhIJoklvhe6PhkhS+mjQ
         p8pr6ksDv3Ok3zXpttximHiJ1OKF/Tt9iW7d277Kv8uLr9TgZupY/RrmFowituiggTZU
         4VuT3UBLEOj32pvDCxsI2q4+vDOqBZ5WDbUKw6hLv5cqrhStGVNyXKVjzoXC1Z483fZj
         O0d7CKk/d/wypszHhNvYvk59HaUxgByqJNlsNAriWWpzLLussLjyLub/0ejXv/ou9tWy
         A8h8jP+7FgrZWriUtFHPhVU6TmxXuE4LOIFbGlK6zCQF8lasvXqUY99pn9puAnFsYLpd
         NNTA==
X-Gm-Message-State: AOAM5303VQ7ibrZlf7BtZBc71/hCdk+GfS2JmFNkcQCViXv3UanYd6AY
        G1AKbRtI2VQnjRgHZO98CHa2hIdylinpog==
X-Google-Smtp-Source: ABdhPJxo9qyAqKQekHRi0uct4Rzw7NXa2Zd0iU/re5qij6bPI73jFb2Ecv1fNwshJJyp5NGFw3Xlhw==
X-Received: by 2002:a17:90a:5898:: with SMTP id j24mr865337pji.78.1604643946639;
        Thu, 05 Nov 2020 22:25:46 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id d123sm574601pfa.206.2020.11.05.22.25.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 22:25:45 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP table
Date:   Fri,  6 Nov 2020 11:54:35 +0530
Message-Id: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initially, the helper dev_pm_opp_get_opp_table() was supposed to be used
only for the OPP core's internal use (it tries to find an existing OPP
table and if it doesn't find one, then it allocates the OPP table).

Sometime back, the cpufreq-dt driver started using it to make sure all
the relevant resources required by the OPP core are available earlier
during initialization process to properly propagate -EPROBE_DEFER.

It worked but it also abused the API to create an OPP table, which
should be created with the help of other helpers provided by the OPP
core.

The OPP core will be updated in a later commit to limit the scope of
dev_pm_opp_get_opp_table() to only finding an existing OPP table and not
create one. This commit updates the cpufreq-dt driver before that
happens.

Now the cpufreq-dt driver creates the OPP and cpufreq tables for all the
CPUs from driver's init callback itself.

Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 158 +++++++++++++++--------------------
 1 file changed, 68 insertions(+), 90 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e363ae04aac6..66b3db5efb53 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -30,7 +30,7 @@ struct private_data {
 	cpumask_var_t cpus;
 	struct device *cpu_dev;
 	struct opp_table *opp_table;
-	struct opp_table *reg_opp_table;
+	struct cpufreq_frequency_table *freq_table;
 	bool have_static_opps;
 };
 
@@ -102,7 +102,6 @@ static const char *find_supply_name(struct device *dev)
 
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
-	struct cpufreq_frequency_table *freq_table;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct clk *cpu_clk;
@@ -114,9 +113,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		pr_err("failed to find data for cpu%d\n", policy->cpu);
 		return -ENODEV;
 	}
-
 	cpu_dev = priv->cpu_dev;
-	cpumask_copy(policy->cpus, priv->cpus);
 
 	cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
@@ -125,67 +122,32 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	/*
-	 * Initialize OPP tables for all policy->cpus. They will be shared by
-	 * all CPUs which have marked their CPUs shared with OPP bindings.
-	 *
-	 * For platforms not using operating-points-v2 bindings, we do this
-	 * before updating policy->cpus. Otherwise, we will end up creating
-	 * duplicate OPPs for policy->cpus.
-	 *
-	 * OPPs might be populated at runtime, don't check for error here
-	 */
-	if (!dev_pm_opp_of_cpumask_add_table(policy->cpus))
-		priv->have_static_opps = true;
-
-	/*
-	 * But we need OPP table to function so if it is not there let's
-	 * give platform code chance to provide it for us.
-	 */
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
-		dev_err(cpu_dev, "OPP table can't be empty\n");
-		ret = -ENODEV;
-		goto out_free_opp;
-	}
-
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
-	if (ret) {
-		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto out_free_opp;
-	}
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
 
+	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data = priv;
 	policy->clk = cpu_clk;
-	policy->freq_table = freq_table;
-
+	policy->freq_table = priv->freq_table;
 	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu_dev) / 1000;
+	policy->cpuinfo.transition_latency = transition_latency;
+	policy->dvfs_possible_from_any_cpu = true;
 
 	/* Support turbo/boost mode */
 	if (policy_has_boost_freq(policy)) {
 		/* This gets disabled by core on driver unregister */
 		ret = cpufreq_enable_boost_support();
 		if (ret)
-			goto out_free_cpufreq_table;
+			goto out_clk_put;
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
-	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
-	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
-
-	policy->cpuinfo.transition_latency = transition_latency;
-	policy->dvfs_possible_from_any_cpu = true;
-
 	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
 	return 0;
 
-out_free_cpufreq_table:
-	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
-out_free_opp:
-	if (priv->have_static_opps)
-		dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+out_clk_put:
 	clk_put(cpu_clk);
 
 	return ret;
@@ -208,11 +170,6 @@ static int cpufreq_offline(struct cpufreq_policy *policy)
 
 static int cpufreq_exit(struct cpufreq_policy *policy)
 {
-	struct private_data *priv = policy->driver_data;
-
-	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	if (priv->have_static_opps)
-		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	clk_put(policy->clk);
 	return 0;
 }
@@ -236,6 +193,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 {
 	struct private_data *priv;
 	struct device *cpu_dev;
+	bool fallback = false;
 	const char *reg_name;
 	int ret;
 
@@ -254,69 +212,87 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
 		return -ENOMEM;
 
+	cpumask_set_cpu(cpu, priv->cpus);
 	priv->cpu_dev = cpu_dev;
 
-	/* Try to get OPP table early to ensure resources are available */
-	priv->opp_table = dev_pm_opp_get_opp_table(cpu_dev);
-	if (IS_ERR(priv->opp_table)) {
-		ret = PTR_ERR(priv->opp_table);
-		if (ret != -EPROBE_DEFER)
-			dev_err(cpu_dev, "failed to get OPP table: %d\n", ret);
-		goto free_cpumask;
-	}
-
 	/*
 	 * OPP layer will be taking care of regulators now, but it needs to know
 	 * the name of the regulator first.
 	 */
 	reg_name = find_supply_name(cpu_dev);
 	if (reg_name) {
-		priv->reg_opp_table = dev_pm_opp_set_regulators(cpu_dev,
-								&reg_name, 1);
-		if (IS_ERR(priv->reg_opp_table)) {
-			ret = PTR_ERR(priv->reg_opp_table);
+		priv->opp_table = dev_pm_opp_set_regulators(cpu_dev, &reg_name,
+							    1);
+		if (IS_ERR(priv->opp_table)) {
+			ret = PTR_ERR(priv->opp_table);
 			if (ret != -EPROBE_DEFER)
 				dev_err(cpu_dev, "failed to set regulators: %d\n",
 					ret);
-			goto put_table;
+			goto out;
 		}
 	}
 
-	/* Find OPP sharing information so we can fill pri->cpus here */
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->cpus);
 	if (ret) {
 		if (ret != -ENOENT)
-			goto put_reg;
+			goto out;
 
 		/*
 		 * operating-points-v2 not supported, fallback to all CPUs share
 		 * OPP for backward compatibility if the platform hasn't set
 		 * sharing CPUs.
 		 */
-		if (dev_pm_opp_get_sharing_cpus(cpu_dev, priv->cpus)) {
-			cpumask_setall(priv->cpus);
-
-			/*
-			 * OPP tables are initialized only for cpu, do it for
-			 * others as well.
-			 */
-			ret = dev_pm_opp_set_sharing_cpus(cpu_dev, priv->cpus);
-			if (ret)
-				dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
-					__func__, ret);
-		}
+		if (dev_pm_opp_get_sharing_cpus(cpu_dev, priv->cpus))
+			fallback = true;
+	}
+
+	/*
+	 * Initialize OPP tables for all priv->cpus. They will be shared by
+	 * all CPUs which have marked their CPUs shared with OPP bindings.
+	 *
+	 * For platforms not using operating-points-v2 bindings, we do this
+	 * before updating priv->cpus. Otherwise, we will end up creating
+	 * duplicate OPPs for the CPUs.
+	 *
+	 * OPPs might be populated at runtime, don't check for error here.
+	 */
+	if (!dev_pm_opp_of_cpumask_add_table(priv->cpus))
+		priv->have_static_opps = true;
+
+	/*
+	 * The OPP table must be initialized, statically or dynamically, by this
+	 * point.
+	 */
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_err(cpu_dev, "OPP table can't be empty\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (fallback) {
+		cpumask_setall(priv->cpus);
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, priv->cpus);
+		if (ret)
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &priv->freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out;
 	}
 
 	list_add(&priv->node, &priv_list);
 	return 0;
 
-put_reg:
-	if (priv->reg_opp_table)
-		dev_pm_opp_put_regulators(priv->reg_opp_table);
-put_table:
-	dev_pm_opp_put_opp_table(priv->opp_table);
-free_cpumask:
+out:
+	if (priv->have_static_opps)
+		dev_pm_opp_of_cpumask_remove_table(priv->cpus);
+	if (priv->opp_table)
+		dev_pm_opp_put_regulators(priv->opp_table);
 	free_cpumask_var(priv->cpus);
 	return ret;
 }
@@ -326,9 +302,11 @@ static void dt_cpufreq_release(void)
 	struct private_data *priv, *tmp;
 
 	list_for_each_entry_safe(priv, tmp, &priv_list, node) {
-		if (priv->reg_opp_table)
-			dev_pm_opp_put_regulators(priv->reg_opp_table);
-		dev_pm_opp_put_opp_table(priv->opp_table);
+		dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &priv->freq_table);
+		if (priv->have_static_opps)
+			dev_pm_opp_of_cpumask_remove_table(priv->cpus);
+		if (priv->opp_table)
+			dev_pm_opp_put_regulators(priv->opp_table);
 		free_cpumask_var(priv->cpus);
 		list_del(&priv->node);
 	}
-- 
2.25.0.rc1.19.g042ed3e048af

