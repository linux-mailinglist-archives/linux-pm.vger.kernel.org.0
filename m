Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CD276F54
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgIXLG2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 07:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgIXLGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 07:06:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7048C0613D5
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u4so2343839ljd.10
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAxfRIdJbGO7nz2FmPpJIl5UEIFSG/7HeLctBXhA9PY=;
        b=xd2x+7jffqo3IG1nC2Bh6YjiWXK6oQeUrj18f4UYn13yo1kDoEYZLXJQ7DzI31GdBM
         omhixxdIWqCLw/GR4uUzWinDwcjSdBW6Ip+GccLJ+LH0J3t1iaQ+G7JvvuRZ6/T85fFP
         koy/iazYUQa+iS7PobmSEnPYZk9lkcBJug7OsWP2+eozPAi7LXmTcaQwcSIev9hkci63
         ++LGPo8uiWlJDUXxHztCp0zoL52Xc++ra+7+OhOYsVrVqo7lyHG1p4UlkcBd4rTMV5qV
         jZYkitBbmLG8zpIEMYVznb82woHzIA3PLUlc1yWpnE4DHRGXr7JAgaAElhfTkCbrQyiA
         UXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAxfRIdJbGO7nz2FmPpJIl5UEIFSG/7HeLctBXhA9PY=;
        b=qEracCmA1JP7tpeflqWGCgE6z8RpzhPZUyJyV4NFydyEMaNjT4nC83BDD0vS30uPIY
         miN7PJ7n0eQ3LvZpXoOfCcQrfAKaJol3UVRTVa2ylIbSsGH1iEj6/+gP7522aFhhCeGO
         CdNsqoQGwN7+NHOXFi1N3UHwySb2kc0TxUzbNyZWLFRw2oUbGvHpYfx7/x2KNuJ9kgGO
         RON1aazYX6jwgEW2GhJRJU9YhllwlavwOaakHfVGaJEXLp3Lyr1ev6wGYq0DSDOmldZX
         d2A6POjLFBp/bhh2oZJ/nNi15qpgvmovIKytChI+qxzLiOm5DJ+a73t28mEPJCvlI/aF
         WapA==
X-Gm-Message-State: AOAM5333h67cWLrFVrtfhigCox2bwSncNehXGUQVEl2iMHRFyg2YrAu7
        qlMx8YOjjLUpYSbHN5dQz4xiHQ==
X-Google-Smtp-Source: ABdhPJwpqdgNbpHQwGyumC6fGscyjxCmKxqGXHBdvb8Jnrdlfy/a3rsww4Votv4EU/TC8XrBncuG/g==
X-Received: by 2002:a2e:9143:: with SMTP id q3mr147845ljg.253.1600945581946;
        Thu, 24 Sep 2020 04:06:21 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id w4sm1762393lfr.139.2020.09.24.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:06:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off notifiers for genpd
Date:   Thu, 24 Sep 2020 13:04:49 +0200
Message-Id: <20200924110449.329523-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924110449.329523-1-ulf.hansson@linaro.org>
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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

Changes in v2:
	- Improved error handling from fired notifications, according to
	suggestions by Lina Iyer.

---
 drivers/base/power/domain.c | 142 ++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  15 ++++
 2 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0198af358503..f001ac6326fb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -497,7 +497,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended = 0;
-	int ret;
+	int ret, nr_calls = 0;
 
 	/*
 	 * Do not try to power off the domain in the following situations:
@@ -545,13 +545,22 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd->gov)
 		genpd->state_idx = 0;
 
+	/* Notify consumers that we are about to power off. */
+	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
+					GENPD_STATE_OFF, NULL, -1, &nr_calls);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto busy;
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
@@ -564,6 +573,12 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	}
 
 	return 0;
+busy:
+	if (nr_calls)
+		__raw_notifier_call_chain(&genpd->power_notifiers,
+					  GENPD_STATE_ON, NULL,
+					  nr_calls - 1, NULL);
+	return ret;
 }
 
 /**
@@ -609,6 +624,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	genpd->status = GENPD_STATE_ON;
 	genpd_update_accounting(genpd);
 
+	/* Inform consumers that we have powered on. */
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
+
 	return 0;
 
  err:
@@ -938,6 +956,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 				 unsigned int depth)
 {
 	struct gpd_link *link;
+	int err, nr_calls = 0;
 
 	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
 		return;
@@ -948,8 +967,15 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
+
+	/* Notify consumers that we are about to power off. */
+	err = __raw_notifier_call_chain(&genpd->power_notifiers,
+					GENPD_STATE_OFF, NULL, -1, &nr_calls);
+	if (notifier_to_errno(err))
+		goto err;
+
 	if (_genpd_power_off(genpd, false))
-		return;
+		goto err;
 
 	genpd->status = GENPD_STATE_OFF;
 
@@ -964,6 +990,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 		if (use_lock)
 			genpd_unlock(link->parent);
 	}
+
+	return;
+err:
+	if (nr_calls)
+		__raw_notifier_call_chain(&genpd->power_notifiers,
+					  GENPD_STATE_ON, NULL,
+					  nr_calls - 1, NULL);
 }
 
 /**
@@ -998,6 +1031,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 
 	_genpd_power_on(genpd, false);
 	genpd->status = GENPD_STATE_ON;
+
+	/* Inform consumers that we have powered on. */
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON, NULL);
 }
 
 /**
@@ -1592,6 +1628,101 @@ int pm_genpd_remove_device(struct device *dev)
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
@@ -1762,6 +1893,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
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

