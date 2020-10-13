Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D396228CE42
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgJMMXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgJMMXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 08:23:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B8C0613D2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 05:23:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a4so20176367lji.12
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZrjiOcdm0pKRodvUlxkeQ8J127iIfDZEkBWmG6GzZSM=;
        b=wNzI6EXXLHND5/Uw5EOFRFzgmNiG0D6tOn/7lI72s+0zWQ9pJTqD2hJYy1gTf5kXpA
         qRKrqE5nw2hMyk+qja54m067uyek22/YgholvlIC0GcQAQJJhN8aJt9/bUWuFfSMb+6u
         BzelN+pPcD4BYZzP3wCmnZLhg0bKMajF+lu1vzCzYVsrvCTNUpdnxQOPv5HjKnsaOJyK
         Trh5ehFQ+jUfS4Twm5DWZWqd66WIeFC4sVwndowkupGgQ+koBanb4J6IOi5OsRIYzTIn
         aHfFwtdsu82gguR0/Frx3bOUoFzmY+mH9Ys3Z+8fDylgDrflxNTcHDylnKKbT1NLyZxD
         UPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZrjiOcdm0pKRodvUlxkeQ8J127iIfDZEkBWmG6GzZSM=;
        b=uZwlY62XjFMQ1X0w0+8X9tEd2EwoTRPQwR8njzeGWHqc5/Wh8+3dAYUrnxScsw6BNW
         thwv6uWFDk3Fxd5dVV2zpBSu+W7g2hZ/GtU4QPYDzDeCc04I4VEwf1BWFBPnPEuWLeDZ
         qzNHpB+ycUFIm8XYM17TLLSmxMVsnRReNkQdi3WkFT3H35fXSz+iIOoKMwZPNyaqSvGx
         FjY6KioQPiHkOdz8dy21/XCa+Ya0OaldBaoF0z9rIQvK3oFc5PZ/o4b5wzg2o4CBhWxj
         uT4mEKGR1+1Zio+wdo8dGdqJXW2KP9Z8L2gzNWvrNz7zCWSJv/jRliOrxaQiKlQY/bsN
         oqSw==
X-Gm-Message-State: AOAM5332B1Ztar6uZVwnUVn6PM60zt4jX8TBAnad+tx6k3knDSLvPmmL
        pg5XlMYYDWQNc3ycm+8mNYkn7Q==
X-Google-Smtp-Source: ABdhPJwyLkxW5iOkM8sY/6MXEco3tfayQFsludZxRGKyxGCdXDEzjYIB5CXZvx38y4gpNmtiflFjgA==
X-Received: by 2002:a05:651c:d3:: with SMTP id 19mr3602967ljr.180.1602591827524;
        Tue, 13 Oct 2020 05:23:47 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-91.NA.cust.bahnhof.se. [98.128.180.91])
        by smtp.gmail.com with ESMTPSA id u14sm5176845lji.83.2020.10.13.05.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:23:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PM: domains: Add support for PM domain on/off notifiers for genpd
Date:   Tue, 13 Oct 2020 14:23:39 +0200
Message-Id: <20201013122339.450955-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Changes in v3:
	- Adopted suggestions from Peng Fan to allow more fine grained levels of
	notifications, which is needed on some NXP platforms.
	- Move the code that fires the notifications into _genpd_power_on|off(),
	as it simply fits better in there.

Note that, I understand that some of us may be occupied with dealing with the
merge window, but I still wanted to get this submitted to allow those that have
some time to review and test.

Kind regards
Ulf Hansson

---
 drivers/base/power/domain.c | 161 +++++++++++++++++++++++++++++++++---
 include/linux/pm_domain.h   |  22 +++++
 2 files changed, 171 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 05bb4d4401b2..c2a8821bdb26 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -413,28 +413,47 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
-	int ret;
+	int ret, nr_calls = 0;
+
+	/* Notify consumers that we are about to power on. */
+	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
+					GENPD_NOTIFY_PRE_ON, NULL, -1,
+					&nr_calls);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto err;
 
 	if (!genpd->power_on)
-		return 0;
+		goto out;
 
-	if (!timed)
-		return genpd->power_on(genpd);
+	if (!timed) {
+		ret = genpd->power_on(genpd);
+		if (ret)
+			goto err;
+
+		goto out;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_on(genpd);
 	if (ret)
-		return ret;
+		goto err;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
-		return ret;
+		goto out;
 
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "on", elapsed_ns);
 
+out:
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
+	return 0;
+err:
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
+				NULL);
 	return ret;
 }
 
@@ -443,29 +462,51 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
 	s64 elapsed_ns;
-	int ret;
+	int ret, nr_calls = 0;
+
+	/* Notify consumers that we are about to power off. */
+	ret = __raw_notifier_call_chain(&genpd->power_notifiers,
+					GENPD_NOTIFY_PRE_OFF, NULL, -1,
+					&nr_calls);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto busy;
 
 	if (!genpd->power_off)
-		return 0;
+		goto out;
+
+	if (!timed) {
+		ret = genpd->power_off(genpd);
+		if (ret)
+			goto busy;
 
-	if (!timed)
-		return genpd->power_off(genpd);
+		goto out;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_off(genpd);
 	if (ret)
-		return ret;
+		goto busy;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
-		return 0;
+		goto out;
 
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "off", elapsed_ns);
 
+out:
+	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
+				NULL);
 	return 0;
+busy:
+	if (nr_calls)
+		__raw_notifier_call_chain(&genpd->power_notifiers,
+					  GENPD_NOTIFY_ON, NULL, nr_calls - 1,
+					  NULL);
+	return ret;
 }
 
 /**
@@ -1592,6 +1633,101 @@ int pm_genpd_remove_device(struct device *dev)
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
@@ -1762,6 +1898,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_LIST_HEAD(&genpd->parent_links);
 	INIT_LIST_HEAD(&genpd->child_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
+	RAW_INIT_NOTIFIER_HEAD(&genpd->power_notifiers);
 	genpd_lock_init(genpd);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 66f3c5d64d81..db039da0aba2 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -68,6 +68,13 @@ enum gpd_status {
 	GENPD_STATE_OFF,	/* PM domain is off */
 };
 
+enum genpd_notication {
+	GENPD_NOTIFY_PRE_OFF = 0,
+	GENPD_NOTIFY_OFF,
+	GENPD_NOTIFY_PRE_ON,
+	GENPD_NOTIFY_ON,
+};
+
 struct dev_power_governor {
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
 	bool (*suspend_ok)(struct device *dev);
@@ -112,6 +119,7 @@ struct generic_pm_domain {
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
 	struct opp_table *opp_table;	/* OPP table of the genpd */
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
 						 struct dev_pm_opp *opp);
@@ -178,6 +186,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
 	void *data;
@@ -204,6 +213,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
+int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
+int dev_pm_genpd_remove_notifier(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -251,6 +262,17 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
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

