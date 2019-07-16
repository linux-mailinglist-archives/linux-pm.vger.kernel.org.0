Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A866A9C0
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfGPNhT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:37:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfGPNhT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:37:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81DC761891; Tue, 16 Jul 2019 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563284238;
        bh=kFPWp3OiWaa+h8GCS5e6X4O/YcbeaQ/dIWMs++2VxUM=;
        h=From:To:Cc:Subject:Date:From;
        b=TLzJGRsfIOt7IM9aEHjH4CGa94w1Ca3610gbjv5ef+XKLv2P4SiuKZYQt7d7HBAln
         NHqyhLZYPBdJPzBf1KnwAA/PJWC5greyTnndYRmQ5dL7UzWycxF2VGwwQ+wwkVZEOd
         0+5qxoGtGUdYY86OzTvLIUSrv0wKCfzmBGJahLrw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3C5E60C60;
        Tue, 16 Jul 2019 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563284235;
        bh=kFPWp3OiWaa+h8GCS5e6X4O/YcbeaQ/dIWMs++2VxUM=;
        h=From:To:Cc:Subject:Date:From;
        b=TeRaARVaABJeBRA+wrxuqu5wMUo1Hyd88vueiLrosF2fRgqw+3VEiovVN/tdj+91z
         93wMjhSkk/juYn8k0wjqbLO8CSNznx7DdgJmBt6wq4PZrwJPEA3lmTUPOU8GKw2epa
         KsLjMZLJ6sqRAxYMwnQ+h99qZx/w2LngetKffrk4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3C5E60C60
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     saravanak@google.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com
Cc:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, hsinyi@chromium.org,
        adharmap@codeaurora.org, Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC v2] PM / devfreq: Add cpu based scaling support to passive_governor
Date:   Tue, 16 Jul 2019 19:06:59 +0530
Message-Id: <20190716133700.30024-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

Many CPU architectures have caches that can scale independent of the
CPUs. Frequency scaling of the caches is necessary to make sure that the
cache is not a performance bottleneck that leads to poor performance and
power. The same idea applies for RAM/DDR.

To achieve this, this patch adds support for cpu based scaling to the
passive governor. This is accomplished by taking the current frequency
of each CPU frequency domain and then adjust the frequency of the cache
(or any devfreq device) based on the frequency of the CPUs. It listens
to CPU frequency transition notifiers to keep itself up to date on the
current CPU frequency.

To decide the frequency of the device, the governor does one of the
following:
* Derives the optimal devfreq device opp from required-opps property of
  the parent cpu opp_table.

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its
  max frequency. If the CPUs are running at their min frequency, the
  device runs at its min frequency. It is interpolated for frequencies
  in between.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
[Sibi: Integrated cpu-freqmap governor into passive_governor]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
v2:
* Address Chanwoo's review comments

This patch is a re-work of:
https://patchwork.kernel.org/patch/10553171/

This patch depends on Saravana's add required-opps support series:
https://patchwork.kernel.org/cover/11016423/

 drivers/devfreq/Kconfig            |   2 +
 drivers/devfreq/governor_passive.c | 275 +++++++++++++++++++++++++++--
 include/linux/devfreq.h            |  40 ++++-
 3 files changed, 296 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index f3b242987fd91..5db8633f94d83 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -73,6 +73,8 @@ config DEVFREQ_GOV_PASSIVE
 	  device. This governor does not change the frequency by itself
 	  through sysfs entries. The passive governor recommends that
 	  devfreq device uses the OPP table to get the frequency/voltage.
+	  Alternatively the governor can also be chosen to scale based on
+	  the online CPUs current frequency.
 
 comment "DEVFREQ Drivers"
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 24ce94c80f06e..743b6093cc732 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -8,11 +8,86 @@
  */
 
 #include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
+#include <linux/slab.h>
 #include "governor.h"
 
-static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
+					     unsigned int cpu)
+{
+	unsigned int cpu_min, cpu_max, dev_min, dev_max, cpu_percent, max_state;
+	struct devfreq_cpu_state *cpu_state = data->cpu_state[cpu];
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	unsigned long *freq_table = devfreq->profile->freq_table;
+	struct dev_pm_opp *opp = NULL, *cpu_opp = NULL;
+	unsigned long cpu_freq, freq;
+
+	if (!cpu_state || cpu_state->first_cpu != cpu ||
+	    !cpu_state->opp_table || !devfreq->opp_table)
+		return 0;
+
+	cpu_freq = cpu_state->freq * 1000;
+	cpu_opp = devfreq_recommended_opp(cpu_state->dev, &cpu_freq, 0);
+	if (IS_ERR(cpu_opp))
+		return 0;
+
+	opp = dev_pm_opp_xlate_opp(cpu_state->opp_table,
+				   devfreq->opp_table, cpu_opp);
+	dev_pm_opp_put(cpu_opp);
+
+	if (!IS_ERR(opp)) {
+		freq = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+	} else {
+		/* Use Interpolation if required opps is not available */
+		cpu_min = cpu_state->min_freq;
+		cpu_max = cpu_state->max_freq;
+		cpu_freq = cpu_state->freq;
+
+		if (freq_table) {
+			/* Get minimum frequency according to sorting order */
+			max_state = freq_table[devfreq->profile->max_state - 1];
+			if (freq_table[0] < max_state) {
+				dev_min = freq_table[0];
+				dev_max = max_state;
+			} else {
+				dev_min = max_state;
+				dev_max = freq_table[0];
+			}
+		} else {
+			if (devfreq->max_freq <= devfreq->min_freq)
+				return 0;
+			dev_min = devfreq->min_freq;
+			dev_max = devfreq->max_freq;
+		}
+		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
+		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
+	}
+
+	return freq;
+}
+
+static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
+					unsigned long *freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	unsigned int cpu, target_freq = 0;
+
+	for_each_online_cpu(cpu)
+		target_freq = max(target_freq,
+				  xlate_cpufreq_to_devfreq(p_data, cpu));
+
+	*freq = target_freq;
+
+	return 0;
+}
+
+static int get_target_freq_with_devfreq(struct devfreq *devfreq,
 					unsigned long *freq)
 {
 	struct devfreq_passive_data *p_data
@@ -22,16 +97,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
-	/*
-	 * If the devfreq device with passive governor has the specific method
-	 * to determine the next frequency, should use the get_target_freq()
-	 * of struct devfreq_passive_data.
-	 */
-	if (p_data->get_target_freq) {
-		ret = p_data->get_target_freq(devfreq, freq);
-		goto out;
-	}
-
 	/*
 	 * If the parent and passive devfreq device uses the OPP table,
 	 * get the next frequency by using the OPP table.
@@ -102,6 +167,37 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	return ret;
 }
 
+static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
+					   unsigned long *freq)
+{
+	struct devfreq_passive_data *p_data =
+				(struct devfreq_passive_data *)devfreq->data;
+	int ret;
+
+	/*
+	 * If the devfreq device with passive governor has the specific method
+	 * to determine the next frequency, should use the get_target_freq()
+	 * of struct devfreq_passive_data.
+	 */
+	if (p_data->get_target_freq)
+		return p_data->get_target_freq(devfreq, freq);
+
+	switch (p_data->parent_type) {
+	case DEVFREQ_PARENT_DEV:
+		ret = get_target_freq_with_devfreq(devfreq, freq);
+		break;
+	case CPUFREQ_PARENT_DEV:
+		ret = get_target_freq_with_cpufreq(devfreq, freq);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(&devfreq->dev, "Invalid parent type\n");
+		break;
+	}
+
+	return ret;
+}
+
 static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 {
 	int ret;
@@ -156,6 +252,140 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int cpufreq_passive_notifier_call(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct devfreq_passive_data *data =
+			container_of(nb, struct devfreq_passive_data, nb);
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	struct devfreq_cpu_state *cpu_state;
+	struct cpufreq_freqs *freq = ptr;
+	unsigned int current_freq;
+	int ret;
+
+	if (event != CPUFREQ_POSTCHANGE || !freq ||
+	    !data->cpu_state[freq->policy->cpu])
+		return 0;
+
+	cpu_state = data->cpu_state[freq->policy->cpu];
+	if (cpu_state->freq == freq->new)
+		return 0;
+
+	/* Backup current freq and pre-update cpu state freq*/
+	current_freq = cpu_state->freq;
+	cpu_state->freq = freq->new;
+
+	mutex_lock(&devfreq->lock);
+	ret = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+	if (ret) {
+		cpu_state->freq = current_freq;
+		dev_err(&devfreq->dev, "Couldn't update the frequency.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
+{
+	struct devfreq_passive_data *data = *p_data;
+	struct devfreq *devfreq = (struct devfreq *)data->this;
+	struct device *dev = devfreq->dev.parent;
+	struct opp_table *opp_table = NULL;
+	struct devfreq_cpu_state *state;
+	struct cpufreq_policy *policy;
+	struct device *cpu_dev;
+	unsigned int cpu;
+	int ret;
+
+	get_online_cpus();
+	data->nb.notifier_call = cpufreq_passive_notifier_call;
+	ret = cpufreq_register_notifier(&data->nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(dev, "Couldn't register cpufreq notifier.\n");
+		data->nb.notifier_call = NULL;
+		goto out;
+	}
+
+	/* Populate devfreq_cpu_state */
+	for_each_online_cpu(cpu) {
+		if (data->cpu_state[cpu])
+			continue;
+
+		policy = cpufreq_cpu_get(cpu);
+		if (policy) {
+			state = kzalloc(sizeof(*state), GFP_KERNEL);
+			if (!state) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			cpu_dev = get_cpu_device(cpu);
+			if (!cpu_dev) {
+				dev_err(dev, "Couldn't get cpu device.\n");
+				ret = -ENODEV;
+				goto out;
+			}
+
+			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
+			if (IS_ERR(devfreq->opp_table)) {
+				ret = PTR_ERR(opp_table);
+				goto out;
+			}
+
+			state->dev = cpu_dev;
+			state->opp_table = opp_table;
+			state->first_cpu = cpumask_first(policy->related_cpus);
+			state->freq = policy->cur;
+			state->min_freq = policy->cpuinfo.min_freq;
+			state->max_freq = policy->cpuinfo.max_freq;
+			data->cpu_state[cpu] = state;
+			cpufreq_cpu_put(policy);
+		} else {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
+	}
+out:
+	put_online_cpus();
+	if (ret)
+		return ret;
+
+	/* Update devfreq */
+	mutex_lock(&devfreq->lock);
+	ret = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+	if (ret)
+		dev_err(dev, "Couldn't update the frequency.\n");
+
+	return ret;
+}
+
+static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
+{
+	struct devfreq_passive_data *data = *p_data;
+	struct devfreq_cpu_state *cpu_state;
+	int cpu;
+
+	if (data->nb.notifier_call)
+		cpufreq_unregister_notifier(&data->nb,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+
+	for_each_possible_cpu(cpu) {
+		cpu_state = data->cpu_state[cpu];
+		if (cpu_state) {
+			if (cpu_state->opp_table)
+				dev_pm_opp_put_opp_table(cpu_state->opp_table);
+			kfree(cpu_state);
+			cpu_state = NULL;
+		}
+	}
+
+	return 0;
+}
+
 static int devfreq_passive_event_handler(struct devfreq *devfreq,
 				unsigned int event, void *data)
 {
@@ -166,7 +396,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 	struct notifier_block *nb = &p_data->nb;
 	int ret = 0;
 
-	if (!parent)
+	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
 		return -EPROBE_DEFER;
 
 	switch (event) {
@@ -174,13 +404,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 		if (!p_data->this)
 			p_data->this = devfreq;
 
-		nb->notifier_call = devfreq_passive_notifier_call;
-		ret = devm_devfreq_register_notifier(dev, parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
+			nb->notifier_call = devfreq_passive_notifier_call;
+			ret = devm_devfreq_register_notifier(dev, parent, nb,
+						DEVFREQ_TRANSITION_NOTIFIER);
+		} else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
+			ret = cpufreq_passive_register(&p_data);
+		} else {
+			ret = -EINVAL;
+		}
 		break;
 	case DEVFREQ_GOV_STOP:
-		devm_devfreq_unregister_notifier(dev, parent, nb,
-					DEVFREQ_TRANSITION_NOTIFIER);
+		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
+			devm_devfreq_unregister_notifier(dev, parent, nb,
+						DEVFREQ_TRANSITION_NOTIFIER);
+		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
+			cpufreq_passive_unregister(&p_data);
+		else
+			ret = -EINVAL;
 		break;
 	default:
 		break;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 69d487329408e..f3f898dfd09b2 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -263,6 +263,32 @@ struct devfreq_simple_ondemand_data {
 #endif
 
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+/**
+ * struct devfreq_cpu_state - holds the per-cpu state
+ * @freq:	the current frequency of the cpu.
+ * @min_freq:	the min frequency of the cpu.
+ * @max_freq:	the max frequency of the cpu.
+ * @first_cpu:	the cpumask of the first cpu of a policy.
+ * @dev:	reference to cpu device.
+ * @opp_table:	reference to cpu opp table.
+ *
+ * This structure stores the required cpu_state of a cpu.
+ * This is auto-populated by the governor.
+ */
+struct devfreq_cpu_state {
+	unsigned int freq;
+	unsigned int min_freq;
+	unsigned int max_freq;
+	unsigned int first_cpu;
+	struct device *dev;
+	struct opp_table *opp_table;
+};
+
+enum devfreq_parent_dev_type {
+	DEVFREQ_PARENT_DEV,
+	CPUFREQ_PARENT_DEV,
+};
+
 /**
  * struct devfreq_passive_data - void *data fed to struct devfreq
  *	and devfreq_add_device
@@ -274,13 +300,15 @@ struct devfreq_simple_ondemand_data {
  *			using governors except for passive governor.
  *			If the devfreq device has the specific method to decide
  *			the next frequency, should use this callback.
- * @this:	the devfreq instance of own device.
- * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ * @parent_type		parent type of the device
+ * @this:		the devfreq instance of own device.
+ * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
+ * @cpu_state:		the state min/max/current frequency of all online cpu's
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
- * initialize the 'this' and 'nb' field because the devfreq core will handle
- * them.
+ * initialize the 'this', 'nb' and 'cpu_state' field because the devfreq core
+ * will handle them.
  */
 struct devfreq_passive_data {
 	/* Should set the devfreq instance of parent device */
@@ -289,9 +317,13 @@ struct devfreq_passive_data {
 	/* Optional callback to decide the next frequency of passvice device */
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 
+	/* Should set the type of parent device */
+	enum devfreq_parent_dev_type parent_type;
+
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
+	struct devfreq_cpu_state *cpu_state[NR_CPUS];
 };
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

