Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E652C2638D0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIWIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 18:08:20 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:44964
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIIWIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 18:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599689299;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=hzvZvx1MYCrv6d2Rm3AxGLKpuZ8qoBgm/eA9frU1bDw=;
        b=OSyOqXC0dn7ZZmUPmP2P2PRHjapt7xL/zYO7yTtZYLhfgnWAxl9s1evcY6KMSajn
        a0vxsvPrY2KR6iujp2c6mEcHK+6mU1vvGAXwpQEiQPdak4uQ44N5zVb7RJff8ArW+C8
        94PURBYmG8m+8y2V1/L/kktWmrTtZlrnc/NgfWoM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599689299;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=hzvZvx1MYCrv6d2Rm3AxGLKpuZ8qoBgm/eA9frU1bDw=;
        b=LjYv1xzaBJrOuv228ssZwOfRYhn6yBx4C49Sru74j4yEHb3T4P4RpKjyLZLnM+LF
        MzZpyX/M8SOBoSvuKx47pFvXMYhs60DoXmuHjStAv9qnTVSLmenb6XNQJGWWagCCB9i
        aQrQ3OWNUJUuhXXScK1biT/3Ca+h4YTXGAiyZTPc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A493AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 9 Sep 2020 22:08:18 +0000
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
Message-ID: <0101017474e993a8-a6b84db3-a829-4710-b37e-77103f1af8dc-000000@us-west-2.amazonses.com>
References: <20200819104057.318230-1-ulf.hansson@linaro.org>
 <20200819104057.318230-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819104057.318230-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.09-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-----Original Message-----
Date: Wed, 19 Aug 2020 12:40:57 +0200
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman
 <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi
 <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lina Iyer <ilina@codeaurora.org>, Lukasz Luba <lukasz.luba@arm.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Bjorn
 Andersson <bjorn.andersson@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PM / Domains: Add support for PM domain on/off notifiers
 for genpd

A device may have specific HW constraints that must be obeyed to, before
its corresponding PM domain (genpd) can be powered off - and vice verse at
power on. These constraints can't be managed through the regular runtime PM
based deployment for a device, because the access pattern for it, isn't
always request based. In other words, using the runtime PM callbacks to
deal with the constraints doesn't work for these cases.

For these reasons, let's instead add a PM domain power on/off notification
mechanism to genpd. To add/remove a notifier for a device, the device must
already have been attached to the genpd, which also means that it needs to
be a part of the PM domain topology.

To add/remove a notifier, let's introduce two genpd specific functions:
 - dev_pm_genpd_add|remove_notifier()

Note that, to further clarify when genpd power on/off notifiers may be
used, one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT
notifiers. In the long run, the genpd power on/off notifiers should be able
to replace them, but that requires additional genpd based platform support
for the current users.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 130 ++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  15 +++++
 2 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b787e1ff188..9cb85a5e8342 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -545,13 +545,21 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd->gov)
 		genpd->state_idx = 0;
 
+	/* Notify consumers that we are about to power off. */
+	ret = raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_OFF,
+				      NULL);
+	if (ret)
+		return ret;
+
 	/* Don't power off, if a child domain is waiting to power on. */
-	if (atomic_read(&genpd->sd_count) > 0)
-		return -EBUSY;
+	if (atomic_read(&genpd->sd_count) > 0) {
+		ret = -EBUSY;
+		goto busy;
+	}
 
 	ret = _genpd_power_off(genpd, true);
 	if (ret)
-		return ret;
+		goto busy;
 
 	genpd->status = GENPD_STATE_OFF;
 	genpd_update_accounting(genpd);
@@ -564,6 +572,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 
 	return 0;
+busy:
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
+	return ret;
 }
 
 /**
@@ -606,6 +617,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	if (ret)
 		goto err;
 
+	/* Inform consumers that we have powered on. */
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
+
 	genpd->status = GENPD_STATE_ON;
 	genpd_update_accounting(genpd);
 
@@ -948,9 +962,18 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
-	if (_genpd_power_off(genpd, false))
+
+	/* Notify consumers that we are about to power off. */
+	if (raw_notifier_call_chain(&genpd->power_notifiers,
+				    GENPD_STATE_OFF, NULL))
 		return;
If any of the notified returns an error, we probably should inform that
the genpd failed as well. 

-- Lina

+	if (_genpd_power_off(genpd, false)) {
+		raw_notifier_call_chain(&genpd->power_notifiers,
+					GENPD_STATE_ON, NULL);
+		return;
+	}
+
 	genpd->status = GENPD_STATE_OFF;
 
 	list_for_each_entry(link, &genpd->child_links, child_node) {
@@ -998,6 +1021,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 
 	_genpd_power_on(genpd, false);
 
+	/* Inform consumers that we have powered on. */
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
+
 	genpd->status = GENPD_STATE_ON;
 }
 
@@ -1593,6 +1619,101 @@ int pm_genpd_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
 
+/**
+ * dev_pm_genpd_add_notifier - Add a genpd power on/off notifier for @dev
+ *
+ * @dev: Device that should be associated with the notifier
+ * @nb: The notifier block to register
+ *
+ * Users may call this function to add a genpd power on/off notifier for an
+ * attached @dev. Only one notifier per device is allowed. The notifier is
+ * sent when genpd is powering on/off the PM domain.
+ *
+ * It is assumed that the user guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
+{
+	struct generic_pm_domain *genpd;
+	struct generic_pm_domain_data *gpd_data;
+	int ret;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (WARN_ON(!dev->power.subsys_data ||
+		     !dev->power.subsys_data->domain_data))
+		return -EINVAL;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	if (gpd_data->power_nb)
+		return -EEXIST;
+
+	genpd_lock(genpd);
+	ret = raw_notifier_chain_register(&genpd->power_notifiers, nb);
+	genpd_unlock(genpd);
+
+	if (ret) {
+		dev_warn(dev, "failed to add notifier for PM domain %s\n",
+			 genpd->name);
+		return ret;
+	}
+
+	gpd_data->power_nb = nb;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_add_notifier);
+
+/**
+ * dev_pm_genpd_remove_notifier - Remove a genpd power on/off notifier for @dev
+ *
+ * @dev: Device that is associated with the notifier
+ *
+ * Users may call this function to remove a genpd power on/off notifier for an
+ * attached @dev.
+ *
+ * It is assumed that the user guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_remove_notifier(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+	struct generic_pm_domain_data *gpd_data;
+	int ret;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return -ENODEV;
+
+	if (WARN_ON(!dev->power.subsys_data ||
+		     !dev->power.subsys_data->domain_data))
+		return -EINVAL;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	if (!gpd_data->power_nb)
+		return -ENODEV;
+
+	genpd_lock(genpd);
+	ret = raw_notifier_chain_unregister(&genpd->power_notifiers,
+					    gpd_data->power_nb);
+	genpd_unlock(genpd);
+
+	if (ret) {
+		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
+			 genpd->name);
+		return ret;
+	}
+
+	gpd_data->power_nb = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_remove_notifier);
+
 static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 			       struct generic_pm_domain *subdomain)
 {
@@ -1763,6 +1884,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_LIST_HEAD(&genpd->parent_links);
 	INIT_LIST_HEAD(&genpd->child_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
+	RAW_INIT_NOTIFIER_HEAD(&genpd->power_notifiers);
 	genpd_lock_init(genpd);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 66f3c5d64d81..3b2b561ce846 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -112,6 +112,7 @@ struct generic_pm_domain {
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
 	struct opp_table *opp_table;	/* OPP table of the genpd */
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
 						 struct dev_pm_opp *opp);
@@ -178,6 +179,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
 	void *data;
@@ -204,6 +206,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
+int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
+int dev_pm_genpd_remove_notifier(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -251,6 +255,17 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_genpd_add_notifier(struct device *dev,
+					    struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline int dev_pm_genpd_remove_notifier(struct device *dev)
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.25.1

