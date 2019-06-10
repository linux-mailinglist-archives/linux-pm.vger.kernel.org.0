Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0903B37F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389624AbfFJKwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:52:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44319 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfFJKwJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 06:52:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so889603plr.11
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 03:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kF1gfE2iFj/xBErd3TwYUcdGFOPQsFXUuTNqUTUTBvo=;
        b=CbrXhgBfjgryUePAWrlajFiZbQHaXxOplnnQadGyazSwsVWYJe40B1OXpxt7xYx0P1
         t/LFJAUotF0btUWYdNV/FpkdFbjh4nrbXl3PlnravdgjnHbNzIlvW+QNuINYILErIn5F
         ATEmCH1s/5o22AO+ogxPVxlj4+YmNOxGQA9HaGW7fQlLngyX9mfwj7PXt1a7csVCKUym
         MFXteTZuQKLTuYZC3grNAkv+WMD+8gPVwIsPOuElzgZ6ix4QjX0B0paO68OaHnAg1xKY
         IROAaCNltBewMalh9kawVUUA4FKmwm4XszelnfwTLSnkyfQDUQoxyLYw23aRm43LXj9x
         VV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kF1gfE2iFj/xBErd3TwYUcdGFOPQsFXUuTNqUTUTBvo=;
        b=MJyYJtJLYzzujrT5vZAa1TwDHgB0/uGtAaYvzZTij9CRs/+F91kYQifm4TqesWgzI7
         TIu+bO/jLFmacA5Ws3KbNOtLAqZJWgypYw/A18sC976SRmcC8p/pstm4eEjZdHAFtzpN
         ZMDHmnfp80RbVNpfSQPZ03Mg+hGAI+Z7FUAd4JlW0v74oFiC9nSCLR1XLGEUbEfE6wmD
         yzKxvExVAUSf+MkNC4mJLZJg6Ic/Zr3pAg+KL4oaEuAcMjJ5xIKde9FyhypKCe2MFcP4
         zte4AdGnfYq3GAiXRkh6P2iamVwnIei8MwE8vVAOo8uAY2cyGd5wV2iec5fHX8f6IuId
         4pYQ==
X-Gm-Message-State: APjAAAUkW2xXncwtPod0gT6pTge3r8RAPQKjppDD7NFHYXuZLA3TvMMQ
        nMKBJDesTyYam61l1LT/3IutPQ==
X-Google-Smtp-Source: APXvYqyrnq9S6IjrPj5WmohRlK5K511i8/7/fcykiSlJ9YFX40xPnjdpcM5m7yrcTbjOvZYm2MaTJg==
X-Received: by 2002:a17:902:7083:: with SMTP id z3mr5366735plk.205.1560163928529;
        Mon, 10 Jun 2019 03:52:08 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id 18sm7840154pfy.0.2019.06.10.03.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:52:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/5] cpufreq: Add QoS requests for userspace constraints
Date:   Mon, 10 Jun 2019 16:21:36 +0530
Message-Id: <d1a7585539ad2ced2bfcc9e232cf859b1ec9c71a.1560163748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This implements QoS requests to manage userspace configuration of min
and max frequency.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 92 +++++++++++++++++++--------------------
 include/linux/cpufreq.h   |  8 +---
 2 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 547d221b2ff2..ff754981fcb4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -720,23 +720,15 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
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
+	return ret && ret != 1 ? ret : count;				\
 }
 
 store_one(scaling_min_freq, min);
@@ -1133,10 +1125,6 @@ static void cpufreq_update_freq_work(struct work_struct *work)
 		container_of(work, struct cpufreq_policy, req_work);
 	struct cpufreq_policy new_policy = *policy;
 
-	/* We should read constraint values from QoS layer */
-	new_policy.min = 0;
-	new_policy.max = UINT_MAX;
-
 	down_write(&policy->rwsem);
 
 	if (!policy_is_inactive(policy))
@@ -1243,6 +1231,12 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
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
@@ -1254,6 +1248,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_max_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
 err_min_qos_notifier:
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
@@ -1289,6 +1286,10 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
+	dev_pm_qos_remove_request(policy->max_freq_req);
+	dev_pm_qos_remove_request(policy->min_freq_req);
+	kfree(policy->min_freq_req);
+
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -1366,16 +1367,30 @@ static int cpufreq_online(unsigned int cpu)
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
 
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
@@ -2366,7 +2381,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_governor *old_gov;
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2374,24 +2388,12 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 
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
@@ -2480,10 +2482,9 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
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
@@ -2503,8 +2504,6 @@ void cpufreq_update_policy(unsigned int cpu)
 
 	pr_debug("updating policy for CPU %u\n", cpu);
 	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
 
 	cpufreq_set_policy(policy, &new_policy);
 
@@ -2549,10 +2548,9 @@ static int cpufreq_boost_set_sw(int state)
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
index 0fe7678da9c2..6bbed9af4fd2 100644
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
@@ -85,7 +80,8 @@ struct cpufreq_policy {
 					 * called, but you're in IRQ context */
 	struct work_struct	req_work;
 
-	struct cpufreq_user_policy user_policy;
+	struct dev_pm_qos_request *min_freq_req;
+	struct dev_pm_qos_request *max_freq_req;
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

