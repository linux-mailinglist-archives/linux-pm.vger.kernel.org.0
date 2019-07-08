Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CE61D52
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfGHK6H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 06:58:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41772 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfGHK6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 06:58:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so7483641pgj.8
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6dAM1ci7o4TpmVIsFndVbeON4KwXV2vAddiMtp+2rg=;
        b=OaJtkbrqh3wVDVn0wJ1z7YpmxrRLRh7Cq81kUShPCKTuv09KsroCnCNfvB4j55bW/3
         SToRBa4nJ6lmtBZr+9D8ElurhqxQTG+1VIfel9R8AapebZJEp7Z+0IwivYl4RWWkw8aN
         sFZ+Q2iY0NBb5MAwCYcXHhQ1mpKCtq6ApGvcaq1f845FCj8cZw3gTwc9sPpoTwTZiLQX
         Q9LSh0ThqxKYgbOYp++tUBXPzpGzT6dAnMf7o5oSZ7iei/9l11qtfLYb3N2jhc7t1vcw
         d9FGmJCdl2o9ftP1q2fRo/jq3KUkI0D2bBdx4FlFPUdYZQ7ComK8Kh0JtRttr1W7q5bs
         FalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6dAM1ci7o4TpmVIsFndVbeON4KwXV2vAddiMtp+2rg=;
        b=Gc+J6z07E0HMXpVQ7+Z+v0/0n43QYpEha7MwEvnTmfL0WpPnjXxta1QX3vnSIATxTp
         16TtR5vdCAnKEpQhZz9Lz/CjOfP1HEvSP2nLxWLSGmm3YuolZ/k0TURTfyuz5vcEdavH
         bWUxv/majNOGyeD50+HTevtxMpytjfnav01W66v5u1p+AXc2bdlu5Ee1ZFVy2C5hHKdg
         EIvP9ZlOaEpCTbThHLaQN6w5FAVFnpyVoq0o1YE5V4gzTGf595VbZVNF/muKTS4CftbB
         BhYNdyOhlbcOaZ2xAPDoRQehhiAKmLOauV6wUBzvSmQMQUUxFFrgzdplGy1BU+DQ92WL
         NSPg==
X-Gm-Message-State: APjAAAXAdqoEqtaNJjoZq7LHWAJrJJk7ibIimGExb+PyGyrqTB31JE60
        6PjYGhXPyzVl9sXMMQz4ZtYITg==
X-Google-Smtp-Source: APXvYqz1++7+NABdTV15GtQMlvDYbNUBN3T/HAMKhj2R4v7YzhrP7J3zu2vSkKjkEzUM7x+bjDCQ+Q==
X-Received: by 2002:a63:7a4f:: with SMTP id j15mr23302231pgn.427.1562583485927;
        Mon, 08 Jul 2019 03:58:05 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p7sm21360144pfp.131.2019.07.08.03.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 03:58:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        ulf.hansson@linaro.org, sfr@canb.auug.org.au, pavel@ucw.cz,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS framework
Date:   Mon,  8 Jul 2019 16:27:52 +0530
Message-Id: <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This registers the notifiers for min/max frequency constraints with the
PM QoS framework. The constraints are also taken into consideration in
cpufreq_set_policy().

This also relocates cpufreq_policy_put_kobj() as it is required to be
called from cpufreq_policy_alloc() now.

refresh_frequency_limits() is updated to avoid calling
cpufreq_set_policy() for inactive policies and handle_update() is
updated to have proper locking in place.

No constraints are added until now though.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
V6->V7:
- All callers of refresh_frequency_limits(), except handle_update(),
  take the policy->rwsem and result in deadlock as
  refresh_frequency_limits() also takes the same lock again. Fix that
  by taking the rwsem from handle_update() instead.

@Rafael: Sending it before Pavel has verified it as I would be offline
later, in case you want to apply this today itself.

 drivers/cpufreq/cpufreq.c | 135 +++++++++++++++++++++++++++++---------
 include/linux/cpufreq.h   |   3 +
 2 files changed, 108 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ceb57af15ca0..b96ef6db1bfe 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
@@ -999,7 +1000,7 @@ static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	if (!dev)
+	if (unlikely(!dev))
 		return;
 
 	if (cpumask_test_and_set_cpu(cpu, policy->real_cpus))
@@ -1117,14 +1118,16 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 
 static void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy new_policy = *policy;
-
-	pr_debug("updating policy for CPU %u\n", policy->cpu);
+	struct cpufreq_policy new_policy;
 
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
+	if (!policy_is_inactive(policy)) {
+		new_policy = *policy;
+		pr_debug("updating policy for CPU %u\n", policy->cpu);
 
-	cpufreq_set_policy(policy, &new_policy);
+		new_policy.min = policy->user_policy.min;
+		new_policy.max = policy->user_policy.max;
+		cpufreq_set_policy(policy, &new_policy);
+	}
 }
 
 static void handle_update(struct work_struct *work)
@@ -1133,14 +1136,60 @@ static void handle_update(struct work_struct *work)
 		container_of(work, struct cpufreq_policy, update);
 
 	pr_debug("handle_update for cpu %u called\n", policy->cpu);
+	down_write(&policy->rwsem);
 	refresh_frequency_limits(policy);
+	up_write(&policy->rwsem);
+}
+
+static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
+
+	schedule_work(&policy->update);
+	return 0;
+}
+
+static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
+
+	schedule_work(&policy->update);
+	return 0;
+}
+
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+{
+	struct kobject *kobj;
+	struct completion *cmp;
+
+	down_write(&policy->rwsem);
+	cpufreq_stats_free_table(policy);
+	kobj = &policy->kobj;
+	cmp = &policy->kobj_unregister;
+	up_write(&policy->rwsem);
+	kobject_put(kobj);
+
+	/*
+	 * We need to make sure that the underlying kobj is
+	 * actually not referenced anymore by anybody before we
+	 * proceed with unloading.
+	 */
+	pr_debug("waiting for dropping of refcount\n");
+	wait_for_completion(cmp);
+	pr_debug("wait complete\n");
 }
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
+	struct device *dev = get_cpu_device(cpu);
 	int ret;
 
+	if (!dev)
+		return NULL;
+
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
@@ -1157,7 +1206,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
-		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
 		/*
 		 * The entire policy object will be freed below, but the extra
 		 * memory allocated for the kobject name needs to be freed by
@@ -1167,6 +1216,25 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	policy->nb_min.notifier_call = cpufreq_notifier_min;
+	policy->nb_max.notifier_call = cpufreq_notifier_max;
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_kobj_remove;
+	}
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_min_qos_notifier;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1177,6 +1245,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_min_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
+err_kobj_remove:
+	cpufreq_policy_put_kobj(policy);
 err_free_real_cpus:
 	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
@@ -1189,30 +1262,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
-{
-	struct kobject *kobj;
-	struct completion *cmp;
-
-	down_write(&policy->rwsem);
-	cpufreq_stats_free_table(policy);
-	kobj = &policy->kobj;
-	cmp = &policy->kobj_unregister;
-	up_write(&policy->rwsem);
-	kobject_put(kobj);
-
-	/*
-	 * We need to make sure that the underlying kobj is
-	 * actually not referenced anymore by anybody before we
-	 * proceed with unloading.
-	 */
-	pr_debug("waiting for dropping of refcount\n");
-	wait_for_completion(cmp);
-	pr_debug("wait complete\n");
-}
-
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
+	struct device *dev = get_cpu_device(policy->cpu);
 	unsigned long flags;
 	int cpu;
 
@@ -1224,6 +1276,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
+
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -2283,6 +2340,8 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 		       struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2297,11 +2356,27 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (new_policy->min > new_policy->max)
 		return -EINVAL;
 
+	/*
+	 * PM QoS framework collects all the requests from users and provide us
+	 * the final aggregated value here.
+	 */
+	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
+
+	if (min > new_policy->min)
+		new_policy->min = min;
+	if (max < new_policy->max)
+		new_policy->max = max;
+
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
 		return ret;
 
+	/*
+	 * The notifier-chain shall be removed once all the users of
+	 * CPUFREQ_ADJUST are moved to use the QoS framework.
+	 */
 	/* adjust if necessary - all reasons */
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_ADJUST, new_policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a1467aa7f58b..95425941f46d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -147,6 +147,9 @@ struct cpufreq_policy {
 
 	/* Pointer to the cooling device if used for thermal mitigation */
 	struct thermal_cooling_device *cdev;
+
+	struct notifier_block nb_min;
+	struct notifier_block nb_max;
 };
 
 struct cpufreq_freqs {
-- 
2.21.0.rc0.269.g1a574e7a288b

