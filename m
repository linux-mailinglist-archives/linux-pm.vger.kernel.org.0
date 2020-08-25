Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06B251D04
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHYQQY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 12:16:24 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47773 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgHYQQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 12:16:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598372176; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+pAZ+GZwg+dyHEK9ty9PV7fNDRVaLYxMaLMuViXVx20=; b=ZUXAz9E2xgruOozZnXrFYDCQ/VJpo+0tV1uwakFV+3Kpgt+ukpyeAzEvmDtQD1pLPmCQ7bt5
 IjWm7D6TMCOQbz61ylMsHetcprHChT6CGsgLARe9m844b+wyoxL4hZenbM0NgbVPHwxtanQ1
 nusbKRw/e5Bu5VAuelWYRaNoA5M=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f453945053b5de0bb30568e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 16:16:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE8C4C433C6; Tue, 25 Aug 2020 16:16:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E236C433CA;
        Tue, 25 Aug 2020 16:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E236C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 25 Aug 2020 10:16:02 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
Message-ID: <20200825161602.GE12523@codeaurora.org>
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
 <20200819104057.318230-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200819104057.318230-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 19 2020 at 04:41 -0600, Ulf Hansson wrote:
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
> drivers/base/power/domain.c | 130 ++++++++++++++++++++++++++++++++++--
> include/linux/pm_domain.h   |  15 +++++
> 2 files changed, 141 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 4b787e1ff188..9cb85a5e8342 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -545,13 +545,21 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> 	if (!genpd->gov)
> 		genpd->state_idx = 0;
>
>+	/* Notify consumers that we are about to power off. */
>+	ret = raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_OFF,
>+				      NULL);
>+	if (ret)
>+		return ret;
>+
> 	/* Don't power off, if a child domain is waiting to power on. */
>-	if (atomic_read(&genpd->sd_count) > 0)
>-		return -EBUSY;
>+	if (atomic_read(&genpd->sd_count) > 0) {
>+		ret = -EBUSY;
>+		goto busy;
>+	}
>
> 	ret = _genpd_power_off(genpd, true);
> 	if (ret)
>-		return ret;
>+		goto busy;
>
> 	genpd->status = GENPD_STATE_OFF;
> 	genpd_update_accounting(genpd);
>@@ -564,6 +572,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> 	}
>
> 	return 0;
>+busy:
>+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
It would be helpful to abstract these notification related calls into
functions of their own. So, for CPU PM domains, it would help to add
RCU_NONIDLE() around the notifiers, allowing the callbacks to add trace
functions.

--Lina

>+	return ret;
> }
>
> /**
>@@ -606,6 +617,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
> 	if (ret)
> 		goto err;
>
>+	/* Inform consumers that we have powered on. */
>+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
>+
> 	genpd->status = GENPD_STATE_ON;
> 	genpd_update_accounting(genpd);
>
>@@ -948,9 +962,18 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>
> 	/* Choose the deepest state when suspending */
> 	genpd->state_idx = genpd->state_count - 1;
>-	if (_genpd_power_off(genpd, false))
>+
>+	/* Notify consumers that we are about to power off. */
>+	if (raw_notifier_call_chain(&genpd->power_notifiers,
>+				    GENPD_STATE_OFF, NULL))
> 		return;
>
>+	if (_genpd_power_off(genpd, false)) {
>+		raw_notifier_call_chain(&genpd->power_notifiers,
>+					GENPD_STATE_ON, NULL);
>+		return;
>+	}
>+
> 	genpd->status = GENPD_STATE_OFF;
>
> 	list_for_each_entry(link, &genpd->child_links, child_node) {
>@@ -998,6 +1021,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>
> 	_genpd_power_on(genpd, false);
>
>+	/* Inform consumers that we have powered on. */
>+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
>+
> 	genpd->status = GENPD_STATE_ON;
> }
>
>@@ -1593,6 +1619,101 @@ int pm_genpd_remove_device(struct device *dev)
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
>@@ -1763,6 +1884,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> 	INIT_LIST_HEAD(&genpd->parent_links);
> 	INIT_LIST_HEAD(&genpd->child_links);
> 	INIT_LIST_HEAD(&genpd->dev_list);
>+	RAW_INIT_NOTIFIER_HEAD(&genpd->power_notifiers);
> 	genpd_lock_init(genpd);
> 	genpd->gov = gov;
> 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index 66f3c5d64d81..3b2b561ce846 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -112,6 +112,7 @@ struct generic_pm_domain {
> 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
> 	int (*power_off)(struct generic_pm_domain *domain);
> 	int (*power_on)(struct generic_pm_domain *domain);
>+	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
> 	struct opp_table *opp_table;	/* OPP table of the genpd */
> 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
> 						 struct dev_pm_opp *opp);
>@@ -178,6 +179,7 @@ struct generic_pm_domain_data {
> 	struct pm_domain_data base;
> 	struct gpd_timing_data td;
> 	struct notifier_block nb;
>+	struct notifier_block *power_nb;
> 	int cpu;
> 	unsigned int performance_state;
> 	void *data;
>@@ -204,6 +206,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> 		  struct dev_power_governor *gov, bool is_off);
> int pm_genpd_remove(struct generic_pm_domain *genpd);
> int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>+int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>+int dev_pm_genpd_remove_notifier(struct device *dev);
>
> extern struct dev_power_governor simple_qos_governor;
> extern struct dev_power_governor pm_domain_always_on_gov;
>@@ -251,6 +255,17 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
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
