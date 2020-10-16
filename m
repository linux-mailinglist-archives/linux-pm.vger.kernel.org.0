Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983DC290839
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409935AbgJPPWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:22:52 -0400
Received: from z5.mailgun.us ([104.130.96.5]:55073 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409854AbgJPPWw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 11:22:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602861771; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Gw5o/OBreB/7rQySpl25kzB4bEDo/KasLSBvttY/r8w=; b=KWKtvBRWk5cPveu4KlP7tHP9uw94rMvogR3aw6/MVwDF3tKQnYB6c/dOtt/vvaMsA8RMhf42
 /9PTvavUJvrMdaLMjn4O99vKN4gCUh1qjnGXeZzr1oNgzLJ7b7mnLxqLr24JUWXLShEtPB09
 f76iHGxMJrNnVyyBe/e8DVGQ0X4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f89babe0764f13b00cd349e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 15:22:37
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2CC83C43387; Fri, 16 Oct 2020 15:22:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 51E83C433CB;
        Fri, 16 Oct 2020 15:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51E83C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 16 Oct 2020 09:22:34 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM: domains: Add support for PM domain on/off
 notifiers for genpd
Message-ID: <20201016152234.GA16756@codeaurora.org>
References: <20201013122339.450955-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201013122339.450955-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13 2020 at 06:23 -0600, Ulf Hansson wrote:
>A device may have specific HW constraints that must be obeyed to, before
>its corresponding PM domain (genpd) can be powered off - and vice verse at
>power on. These constraints can't be managed through the regular runtime PM
>based deployment for a device, because the access pattern for it, isn't
>always request based. In other words, using the runtime PM callbacks to
>deal with the constraints doesn't work for these cases.
>
>For these reasons, let's instead add a PM domain power on/off notification
>mechanism to genpd. To add/remove a notifier for a device, the device must
>already have been attached to the genpd, which also means that it needs to
>be a part of the PM domain topology.
>
>To add/remove a notifier, let's introduce two genpd specific functions:
> - dev_pm_genpd_add|remove_notifier()
>
>Note that, to further clarify when genpd power on/off notifiers may be
>used, one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT
>notifiers. In the long run, the genpd power on/off notifiers should be able
>to replace them, but that requires additional genpd based platform support
>for the current users.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
>
>Changes in v3:
>	- Adopted suggestions from Peng Fan to allow more fine grained levels of
>	notifications, which is needed on some NXP platforms.
>	- Move the code that fires the notifications into _genpd_power_on|off(),
>	as it simply fits better in there.
>
>Note that, I understand that some of us may be occupied with dealing with the
>merge window, but I still wanted to get this submitted to allow those that have
>some time to review and test.
>
>Kind regards
>Ulf Hansson
>
>---
> drivers/base/power/domain.c | 161 +++++++++++++++++++++++++++++++++---
> include/linux/pm_domain.h   |  22 +++++
> 2 files changed, 171 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 05bb4d4401b2..c2a8821bdb26 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -413,28 +413,47 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> 	unsigned int state_idx = genpd->state_idx;
> 	ktime_t time_start;
> 	s64 elapsed_ns;
>-	int ret;
>+	int ret, nr_calls = 0;
>+
>+	/* Notify consumers that we are about to power on. */
>+	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
>+					GENPD_NOTIFY_PRE_ON, NULL, -1,
>+					&nr_calls);
>+	ret = notifier_to_errno(ret);
>+	if (ret)
>+		goto err;
>
> 	if (!genpd->power_on)
>-		return 0;
>+		goto out;
>
>-	if (!timed)
>-		return genpd->power_on(genpd);
>+	if (!timed) {
>+		ret = genpd->power_on(genpd);
>+		if (ret)
>+			goto err;
>+
>+		goto out;
>+	}
>
> 	time_start = ktime_get();
> 	ret = genpd->power_on(genpd);
> 	if (ret)
>-		return ret;
>+		goto err;
>
> 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
> 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
>-		return ret;
>+		goto out;
>
> 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
> 	genpd->max_off_time_changed = true;
> 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> 		 genpd->name, "on", elapsed_ns);
>
>+out:
>+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
>+	return 0;
>+err:
>+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
>+				NULL);
> 	return ret;
> }
>
>@@ -443,29 +462,51 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
> 	unsigned int state_idx = genpd->state_idx;
> 	ktime_t time_start;
> 	s64 elapsed_ns;
>-	int ret;
>+	int ret, nr_calls = 0;
>+
>+	/* Notify consumers that we are about to power off. */
>+	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
>+					GENPD_NOTIFY_PRE_OFF, NULL, -1,
>+					&nr_calls);
>+	ret = notifier_to_errno(ret);
>+	if (ret)
>+		goto busy;
Nit: You could enclose this in a function call to keep these functions
clean.

Otherwise,

Tested-by: Lina Iyer <ilina@codeaurora.org>
>
> 	if (!genpd->power_off)
>-		return 0;
>+		goto out;
>+
>+	if (!timed) {
>+		ret = genpd->power_off(genpd);
>+		if (ret)
>+			goto busy;
>
>-	if (!timed)
>-		return genpd->power_off(genpd);
>+		goto out;
>+	}
>
> 	time_start = ktime_get();
> 	ret = genpd->power_off(genpd);
> 	if (ret)
>-		return ret;
>+		goto busy;
>
> 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
> 	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
>-		return 0;
>+		goto out;
>
> 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
> 	genpd->max_off_time_changed = true;
> 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> 		 genpd->name, "off", elapsed_ns);
>
>+out:
>+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
>+				NULL);
> 	return 0;
>+busy:
>+	if (nr_calls)
>+		__raw_notifier_call_chain(&genpd->power_notifiers,
>+					  GENPD_NOTIFY_ON, NULL, nr_calls - 1,
>+					  NULL);
>+	return ret;
> }
>
> /**
>@@ -1592,6 +1633,101 @@ int pm_genpd_remove_device(struct device *dev)
> }
> EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
>
>+/**
>+ * dev_pm_genpd_add_notifier - Add a genpd power on/off notifier for @dev
>+ *
>+ * @dev: Device that should be associated with the notifier
>+ * @nb: The notifier block to register
>+ *
>+ * Users may call this function to add a genpd power on/off notifier for an
>+ * attached @dev. Only one notifier per device is allowed. The notifier is
>+ * sent when genpd is powering on/off the PM domain.
>+ *
>+ * It is assumed that the user guarantee that the genpd wouldn't be detached
>+ * while this routine is getting called.
>+ *
>+ * Returns 0 on success and negative error values on failures.
>+ */
>+int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
>+{
>+	struct generic_pm_domain *genpd;
>+	struct generic_pm_domain_data *gpd_data;
>+	int ret;
>+
>+	genpd = dev_to_genpd_safe(dev);
>+	if (!genpd)
>+		return -ENODEV;
>+
>+	if (WARN_ON(!dev->power.subsys_data ||
>+		     !dev->power.subsys_data->domain_data))
>+		return -EINVAL;
>+
>+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
>+	if (gpd_data->power_nb)
>+		return -EEXIST;
>+
>+	genpd_lock(genpd);
>+	ret = raw_notifier_chain_register(&genpd->power_notifiers, nb);
>+	genpd_unlock(genpd);
>+
>+	if (ret) {
>+		dev_warn(dev, "failed to add notifier for PM domain %s\n",
>+			 genpd->name);
>+		return ret;
>+	}
>+
>+	gpd_data->power_nb = nb;
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(dev_pm_genpd_add_notifier);
>+
>+/**
>+ * dev_pm_genpd_remove_notifier - Remove a genpd power on/off notifier for @dev
>+ *
>+ * @dev: Device that is associated with the notifier
>+ *
>+ * Users may call this function to remove a genpd power on/off notifier for an
>+ * attached @dev.
>+ *
>+ * It is assumed that the user guarantee that the genpd wouldn't be detached
>+ * while this routine is getting called.
>+ *
>+ * Returns 0 on success and negative error values on failures.
>+ */
>+int dev_pm_genpd_remove_notifier(struct device *dev)
>+{
>+	struct generic_pm_domain *genpd;
>+	struct generic_pm_domain_data *gpd_data;
>+	int ret;
>+
>+	genpd = dev_to_genpd_safe(dev);
>+	if (!genpd)
>+		return -ENODEV;
>+
>+	if (WARN_ON(!dev->power.subsys_data ||
>+		     !dev->power.subsys_data->domain_data))
>+		return -EINVAL;
>+
>+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
>+	if (!gpd_data->power_nb)
>+		return -ENODEV;
>+
>+	genpd_lock(genpd);
>+	ret = raw_notifier_chain_unregister(&genpd->power_notifiers,
>+					    gpd_data->power_nb);
>+	genpd_unlock(genpd);
>+
>+	if (ret) {
>+		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
>+			 genpd->name);
>+		return ret;
>+	}
>+
>+	gpd_data->power_nb = NULL;
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(dev_pm_genpd_remove_notifier);
>+
> static int genpd_add_subdomain(struct generic_pm_domain *genpd,
> 			       struct generic_pm_domain *subdomain)
> {
>@@ -1762,6 +1898,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> 	INIT_LIST_HEAD(&genpd->parent_links);
> 	INIT_LIST_HEAD(&genpd->child_links);
> 	INIT_LIST_HEAD(&genpd->dev_list);
>+	RAW_INIT_NOTIFIER_HEAD(&genpd->power_notifiers);
> 	genpd_lock_init(genpd);
> 	genpd->gov = gov;
> 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index 66f3c5d64d81..db039da0aba2 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -68,6 +68,13 @@ enum gpd_status {
> 	GENPD_STATE_OFF,	/* PM domain is off */
> };
>
>+enum genpd_notication {
>+	GENPD_NOTIFY_PRE_OFF = 0,
>+	GENPD_NOTIFY_OFF,
>+	GENPD_NOTIFY_PRE_ON,
>+	GENPD_NOTIFY_ON,
>+};
>+
> struct dev_power_governor {
> 	bool (*power_down_ok)(struct dev_pm_domain *domain);
> 	bool (*suspend_ok)(struct device *dev);
>@@ -112,6 +119,7 @@ struct generic_pm_domain {
> 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
> 	int (*power_off)(struct generic_pm_domain *domain);
> 	int (*power_on)(struct generic_pm_domain *domain);
>+	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
> 	struct opp_table *opp_table;	/* OPP table of the genpd */
> 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> 						 struct dev_pm_opp *opp);
>@@ -178,6 +186,7 @@ struct generic_pm_domain_data {
> 	struct pm_domain_data base;
> 	struct gpd_timing_data td;
> 	struct notifier_block nb;
>+	struct notifier_block *power_nb;
> 	int cpu;
> 	unsigned int performance_state;
> 	void *data;
>@@ -204,6 +213,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> 		  struct dev_power_governor *gov, bool is_off);
> int pm_genpd_remove(struct generic_pm_domain *genpd);
> int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>+int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>+int dev_pm_genpd_remove_notifier(struct device *dev);
>
> extern struct dev_power_governor simple_qos_governor;
> extern struct dev_power_governor pm_domain_always_on_gov;
>@@ -251,6 +262,17 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
> 	return -ENOTSUPP;
> }
>
>+static inline int dev_pm_genpd_add_notifier(struct device *dev,
>+					    struct notifier_block *nb)
>+{
>+	return -ENOTSUPP;
>+}
>+
>+static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>+{
>+	return -ENOTSUPP;
>+}
>+
> #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
> #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
> #endif
>-- 
>2.25.1
>
