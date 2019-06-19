Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F424B235
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfFSGjx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 02:39:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40589 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSGjx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 02:39:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so4427907pgj.7
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KAXBjc7glk0c+HE4Clw27sMJtcWTAp7e/EA0t3BWvYc=;
        b=Y4pgHIKKYczvlutIQ9hWKHWk76TCFrTf2sFR9+JDlKvgQag2KOrOw9jsJLaWmGpe22
         omOC94n1VDzJKMIdbecVWKg4WS+Bo1+/acMIt+SWCVThBs4GlQY4oXmzLbs8KmP296Hq
         l3rYNiEzYeKL3sg0Gs4CFSicW3LHm2WptH+yVisRGADuehe79n03ZPEkQna64CVHzinI
         geMSKYfPWE8zuRpqnP93bk4EX/kaKB/BQ9pg2XUlz+Xm6t9Rtlzc5GX+ueHyNGYtsQt8
         KBO4dEIMkPP42fZHwckWCudp2eZkU3PwpQFmH3tYcqbHzs8oWlW4qh7RUx22phsH4cPv
         AnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KAXBjc7glk0c+HE4Clw27sMJtcWTAp7e/EA0t3BWvYc=;
        b=QsIWu6Q7qvj5KdU+EcX5t4VoRB2LEKaoC70qR2zdoCyC7OIm7t9Vy4ybRig56Y+TLR
         FsFZgu3QhgWTFwJ5Eskod0UfHM9api5/i3qj17Y0MiD4vZpCnrkVP2aa6A1hZr2oEGqs
         b0MG8U2PqGw4NAg7xQbGv7nMLQHuC+LnKKHE0gPAIrVdR7x8cJEvhF98V7VYMQMbAKFM
         +1bM68xGahnMknICIhKG1yRQNGyCn9e9RSZH93dfFR7/1abZykQkOEO1CfSsH4zk1yNd
         HmlQ8pBes/afmMrA9FH1Cofo2gMRk0wpIYyY2N+W/6MHr59CiYvt68RY04CuhifLjDey
         vmTg==
X-Gm-Message-State: APjAAAXHDdYJgmrLwPgV31/sKiFJcbxKZpGFhc1PBpOo09gqGpOf/Uf5
        lllt1We3YjMPHH975EppnJUtdQ==
X-Google-Smtp-Source: APXvYqwC7LNxJSthdvpM1tbhqqTP1fYjEdwZ6Lyb8i1z6leoDylAGsZ/teBkos+7J4MQTY9pKLsLCA==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr9743345pjr.113.1560926392084;
        Tue, 18 Jun 2019 23:39:52 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id t7sm664336pjq.20.2019.06.18.23.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 23:39:49 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:09:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190619063947.nj2awibmalrdccn2@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <3504053.Rmt1Mul0J4@kreacher>
 <20190618112522.4odrysf7wmxgjlb2@vireshk-i7>
 <3176289.QFhGQadiPc@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3176289.QFhGQadiPc@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-06-19, 00:23, Rafael J. Wysocki wrote:
> In patch [3/5] you could point notifiers for both min and max freq to the same
> notifier head.   Both of your notifiers end up calling cpufreq_update_policy()
> anyway.

I tried it and the changes in qos.c file look fine. But I don't like at all how
cpufreq.c looks now. We only register for min-freq notifier now and that takes
care of max as well. What could have been better is if we could have registered
a freq-notifier instead of min/max, which isn't possible as well because of how
qos framework works.

Honestly, the cpufreq changes look hacky to me :(

What do you say.

-- 
viresh

---
 drivers/base/power/qos.c  | 15 ++++++++-------
 drivers/cpufreq/cpufreq.c | 38 ++++++++------------------------------
 include/linux/cpufreq.h   |  3 +--
 3 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index cde2692b97f9..9bbf2d2a3376 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -202,20 +202,20 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
+	n = kzalloc(2 * sizeof(*n), GFP_KERNEL);
 	if (!n) {
 		kfree(qos);
 		return -ENOMEM;
 	}
 
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
 	c->target_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
 	c->default_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
 	c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
-	c->notifiers = n;
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
+	c->notifiers = n++;
 
 	c = &qos->latency_tolerance;
 	plist_head_init(&c->list);
@@ -224,14 +224,16 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	/* Same notifier head is used for both min/max frequency */
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
 	c = &qos->min_frequency;
 	plist_head_init(&c->list);
 	c->target_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
 	c->default_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
 	c->no_constraint_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
 	c->type = PM_QOS_MAX;
-	c->notifiers = ++n;
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
+	c->notifiers = n;
 
 	c = &qos->max_frequency;
 	plist_head_init(&c->list);
@@ -239,8 +241,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->default_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 	c->no_constraint_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 	c->type = PM_QOS_MIN;
-	c->notifiers = ++n;
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
+	c->notifiers = n;
 
 	INIT_LIST_HEAD(&qos->flags.list);
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1344e1b1307f..1605dba1327e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1139,19 +1139,10 @@ static int cpufreq_update_freq(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
+static int cpufreq_notifier_qos(struct notifier_block *nb, unsigned long freq,
 				void *data)
 {
-	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
-
-	return cpufreq_update_freq(policy);
-}
-
-static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
-				void *data)
-{
-	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_qos);
 
 	return cpufreq_update_freq(policy);
@@ -1214,10 +1205,10 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
-	policy->nb_min.notifier_call = cpufreq_notifier_min;
-	policy->nb_max.notifier_call = cpufreq_notifier_max;
+	policy->nb_qos.notifier_call = cpufreq_notifier_qos;
 
-	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
+	/* Notifier for min frequency also takes care of max frequency notifier */
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_qos,
 				      DEV_PM_QOS_MIN_FREQUENCY);
 	if (ret) {
 		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
@@ -1225,18 +1216,10 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_kobj_remove;
 	}
 
-	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
-				      DEV_PM_QOS_MAX_FREQUENCY);
-	if (ret) {
-		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
-			ret, cpumask_pr_args(policy->cpus));
-		goto err_min_qos_notifier;
-	}
-
 	policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
 				       GFP_KERNEL);
 	if (!policy->min_freq_req)
-		goto err_max_qos_notifier;
+		goto err_min_qos_notifier;
 
 	policy->max_freq_req = policy->min_freq_req + 1;
 	INIT_LIST_HEAD(&policy->policy_list);
@@ -1250,11 +1233,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
-err_max_qos_notifier:
-	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
-				   DEV_PM_QOS_MAX_FREQUENCY);
 err_min_qos_notifier:
-	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+	dev_pm_qos_remove_notifier(dev, &policy->nb_qos,
 				   DEV_PM_QOS_MIN_FREQUENCY);
 err_kobj_remove:
 	cpufreq_policy_put_kobj(policy);
@@ -1284,9 +1264,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
-				   DEV_PM_QOS_MAX_FREQUENCY);
-	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+	dev_pm_qos_remove_notifier(dev, &policy->nb_qos,
 				   DEV_PM_QOS_MIN_FREQUENCY);
 	cancel_work_sync(&policy->req_work);
 	dev_pm_qos_remove_request(policy->max_freq_req);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6bbed9af4fd2..2080d6490ed1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -145,8 +145,7 @@ struct cpufreq_policy {
 	/* Pointer to the cooling device if used for thermal mitigation */
 	struct thermal_cooling_device *cdev;
 
-	struct notifier_block nb_min;
-	struct notifier_block nb_max;
+	struct notifier_block nb_qos;
 };
 
 struct cpufreq_freqs {
