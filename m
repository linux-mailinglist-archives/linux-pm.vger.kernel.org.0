Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE54C881
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfFTHgC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:36:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42480 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbfFTHf7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:35:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so1106961pgh.9
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3L+AYr9wx391racengGEmm+lT+bdqXhQKRHKGNTBvxQ=;
        b=zu1fg8kg7hEc8Jjw0MVXRCmifTHxWow3WTVmw9QFiG8FO9FDwNLSi8vWXr2ClfwSm6
         SUCsYlWTCLjYXePNm8WIq3U2fVNeotMHnimkHdqbnmjLMT3iHWU836r3URFDCQnz6xgy
         0XAy1bYWI/WZdjuz0pOACjj2qRRUHgmbCDs4ObCSIsqLAq298Q+jfZyaM9wiMoE2O28l
         Ae1vwwarnxTn0njvqBT54dUJmJZN5xzkUvVhH6KfThkU6f8zRSzeVOEWe7MFCQAYmJEB
         PUr1z9lQpmhj19vNO3nAYHodWIXVUekO5fS20t0S01enlqzEMqs1uiJoXo5h8i8gFHrv
         1WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L+AYr9wx391racengGEmm+lT+bdqXhQKRHKGNTBvxQ=;
        b=Eyc1lZoN7mGyvblYd0C+v5pL9k5S+g+5VYVAPWLtGdD8bmfhfwf7c9Gq9v2z18UVCM
         BI7mTYGDpZpHsoOIrpe7n0IYiojw46WcdU40mcEZPnTeSf0QIbRL/Bz7zdGi0UwjX7ap
         7cGhDUsAtF8lJunknTGUcB7aGXZC+SXi52EkcY4tuUpH3DYWUgk5FZij0Nb50oeHg2lT
         FcvGDgrhMLiCd6q4zn8QL0UB3Y411w8lykdHgxwBGh8KQRqAdsBdPQktjnJpnMphCiPu
         z/Uxiz0pyCCCizrZSkWy15+Zo5rv9lRBAvyGfCbgW0isZtGvhDPhKyJbJXmz+65QHHKA
         yeTg==
X-Gm-Message-State: APjAAAUOPlnJO8E6WvD418xWAplWxRDeQk4isX9hedPI9SqO+w+BHeEK
        Lh4kMI0Qf3f+IsSkHt4OFh23Jg==
X-Google-Smtp-Source: APXvYqwHWkItS8WIWIf5vrxa/Bbl0bseVaB2leZ9dbBF88nPtfj20y95cwh7nXsy+p0nXKVmUqrwBg==
X-Received: by 2002:a17:90a:21cc:: with SMTP id q70mr1719543pjc.56.1561016158823;
        Thu, 20 Jun 2019 00:35:58 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id p67sm10475789pfg.124.2019.06.20.00.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/6] cpufreq: Add QoS requests for userspace constraints
Date:   Thu, 20 Jun 2019 13:05:29 +0530
Message-Id: <9495cc2133740450884c9c79a89a3b9fd5ae6969.1561014965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561014965.git.viresh.kumar@linaro.org>
References: <cover.1561014965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This implements QoS requests to manage userspace configuration of min
and max frequency.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 87 ++++++++++++++++++++-------------------
 include/linux/cpufreq.h   |  8 +---
 2 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b47a6c094171..5d050b4a3806 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -718,23 +718,15 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	int ret, temp;							\
-	struct cpufreq_policy new_policy;				\
+	unsigned long val;						\
+	int ret;							\
 									\
-	memcpy(&new_policy, policy, sizeof(*policy));			\
-	new_policy.min = policy->user_policy.min;			\
-	new_policy.max = policy->user_policy.max;			\
-									\
-	ret = sscanf(buf, "%u", &new_policy.object);			\
+	ret = sscanf(buf, "%lu", &val);					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	temp = new_policy.object;					\
-	ret = cpufreq_set_policy(policy, &new_policy);		\
-	if (!ret)							\
-		policy->user_policy.object = temp;			\
-									\
-	return ret ? ret : count;					\
+	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
+	return ret >= 0 ? count : ret;					\
 }
 
 store_one(scaling_min_freq, min);
@@ -1126,8 +1118,6 @@ static void reeval_frequency_limits(struct cpufreq_policy *policy)
 		new_policy = *policy;
 		pr_debug("updating policy for CPU %u\n", policy->cpu);
 
-		new_policy.min = policy->user_policy.min;
-		new_policy.max = policy->user_policy.max;
 		cpufreq_set_policy(policy, &new_policy);
 	}
 
@@ -1237,6 +1227,12 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_min_qos_notifier;
 	}
 
+	policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
+				       GFP_KERNEL);
+	if (!policy->min_freq_req)
+		goto err_max_qos_notifier;
+
+	policy->max_freq_req = policy->min_freq_req + 1;
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1247,6 +1243,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_max_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
 err_min_qos_notifier:
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
@@ -1282,6 +1281,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
+	dev_pm_qos_remove_request(policy->max_freq_req);
+	dev_pm_qos_remove_request(policy->min_freq_req);
+	kfree(policy->min_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
@@ -1360,16 +1362,30 @@ static int cpufreq_online(unsigned int cpu)
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		policy->user_policy.min = policy->min;
-		policy->user_policy.max = policy->max;
+		struct device *dev = get_cpu_device(cpu);
 
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
 		}
-	} else {
-		policy->min = policy->user_policy.min;
-		policy->max = policy->user_policy.max;
+
+		ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
+					     DEV_PM_QOS_MIN_FREQUENCY,
+					     policy->min);
+		if (ret < 0) {
+			dev_err(dev, "Failed to add min-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
+
+		ret = dev_pm_qos_add_request(dev, policy->max_freq_req,
+					     DEV_PM_QOS_MAX_FREQUENCY,
+					     policy->max);
+		if (ret < 0) {
+			dev_err(dev, "Failed to add max-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
 	}
 
 	if (cpufreq_driver->get && has_target()) {
@@ -2345,7 +2361,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_governor *old_gov;
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2353,24 +2368,12 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
-	/*
-	* This check works well when we store new min/max freq attributes,
-	* because new_policy is a copy of policy with one field updated.
-	*/
-	if (new_policy->min > new_policy->max)
-		return -EINVAL;
-
 	/*
 	 * PM QoS framework collects all the requests from users and provide us
 	 * the final aggregated value here.
 	 */
-	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
-	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
-
-	if (min > new_policy->min)
-		new_policy->min = min;
-	if (max < new_policy->max)
-		new_policy->max = max;
+	new_policy->min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	new_policy->max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
 
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
@@ -2459,10 +2462,9 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
  * @cpu: CPU to re-evaluate the policy for.
  *
  * Update the current frequency for the cpufreq policy of @cpu and use
- * cpufreq_set_policy() to re-apply the min and max limits saved in the
- * user_policy sub-structure of that policy, which triggers the evaluation
- * of policy notifiers and the cpufreq driver's ->verify() callback for the
- * policy in question, among other things.
+ * cpufreq_set_policy() to re-apply the min and max limits, which triggers the
+ * evaluation of policy notifiers and the cpufreq driver's ->verify() callback
+ * for the policy in question, among other things.
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
@@ -2522,10 +2524,9 @@ static int cpufreq_boost_set_sw(int state)
 			break;
 		}
 
-		down_write(&policy->rwsem);
-		policy->user_policy.max = policy->max;
-		cpufreq_governor_limits(policy);
-		up_write(&policy->rwsem);
+		ret = dev_pm_qos_update_request(policy->max_freq_req, policy->max);
+		if (ret)
+			break;
 	}
 
 	return ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d8622cf3f46c..b6245f512a26 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -50,11 +50,6 @@ struct cpufreq_cpuinfo {
 	unsigned int		transition_latency;
 };
 
-struct cpufreq_user_policy {
-	unsigned int		min;    /* in kHz */
-	unsigned int		max;    /* in kHz */
-};
-
 struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
@@ -84,7 +79,8 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct cpufreq_user_policy user_policy;
+	struct dev_pm_qos_request *min_freq_req;
+	struct dev_pm_qos_request *max_freq_req;
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

