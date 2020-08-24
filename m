Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60A24F726
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHXJJt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgHXJJl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 05:09:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7CC061575
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:09:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so4263856pgb.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkjksCGs4AQuVWCwGfdEcJFYrQa9D8++X80GpI0F1Zo=;
        b=BPXypc1U/ODzYLqbC9yrqE4xPIwzl1Ox4y5aPhPJ66J/ahwQz/B0ppevelkSK8WqFo
         eIIpvjrVmIgJaU5e1AwKWm8c6KhLAb4hq8CQsSlOUddaO9LiCKKfPeM28Ie1Iv/0Qd6p
         +6Pipv/rmD59wKhGKvZ4J0zLYEkvkSF/FwU5zTxTjvzkYz4fUfXLqBnOKCELssTmv4c4
         e8NmNd0QyeFsNdtjg/VtMqUEQcarutVcdG2JCnKMjQrQIqemG6Y2YcB8zzA8P3ksArMW
         nVVoi2mo0ra88W0QtZECvg/Rn2TXtjM3isK00WZ1zhu92BqbXJX1cfV9DVESbXYO7njY
         pHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkjksCGs4AQuVWCwGfdEcJFYrQa9D8++X80GpI0F1Zo=;
        b=NkJSPeYN+dd0zMrdhZ1sQBDsbLQxkAc64BTUlk0RqNg3DsYPBhdyepMGB8GB0GjO59
         rVPbVdaUcFBMCH/uvu0PrPdEXzDzVKJPK8dq8SRKjF6WRG/jYgkoZJ40Z6AoFmgur7xJ
         tvpb1sx/gzBqn0KS+i3o7XfYspp1e3XLj9FOVi2fanAYUcjmAKjYNJm+cBnzMGo0aRhf
         YRysowEin+JtGi0O2tkESdV0je3iPEYjqk8G8GeOMpyiWrygAXdTms/1PwhcQOFtsrjN
         ohJE6YBCglIM2REpE4fYTrzrBLQ/yBOvIXO+Hvt8N+mrvPrwsCZi1gzEYGBnuUDIgaBi
         3qTA==
X-Gm-Message-State: AOAM533oHPq0mAuWpuDVG3iDb/mc1TocRA2QzlutdJD5Opci6aKgXidP
        qQ/Pwje2XCXLorHTtqfaV98O9w==
X-Google-Smtp-Source: ABdhPJyJVYyNtoeLgVn3sekF5Av1U4evkK87vnqaw33gDUhUL13Ji8mvBsdyrgxvAjnJnWQ6qyhGwA==
X-Received: by 2002:a63:5542:: with SMTP id f2mr2822925pgm.196.1598260180107;
        Mon, 24 Aug 2020 02:09:40 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id r7sm10965833pfl.186.2020.08.24.02.09.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:09:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER
Date:   Mon, 24 Aug 2020 14:39:32 +0530
Message-Id: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

The OPP core manages various resources, e.g. clocks or interconnect paths.
These resources are looked up when the OPP table is allocated once
dev_pm_opp_get_opp_table() is called the first time (either directly
or indirectly through one of the many helper functions).

At this point, the resources may not be available yet, i.e. looking them
up will result in -EPROBE_DEFER. Unfortunately, dev_pm_opp_get_opp_table()
is currently unable to propagate this error code since it only returns
the allocated OPP table or NULL.

This means that all consumers of the OPP core are required to make sure
that all necessary resources are available. Usually this happens by
requesting them, checking the result and releasing them immediately after.

For example, we have added "dev_pm_opp_of_find_icc_paths(dev, NULL)" to
several drivers now just to make sure the interconnect providers are
ready before the OPP table is allocated. If this call is missing,
the OPP core will only warn about this and then attempt to continue
without interconnect. This will eventually fail horribly, e.g.:

    cpu cpu0: _allocate_opp_table: Error finding interconnect paths: -517
    ... later ...
    of: _read_bw: Mismatch between opp-peak-kBps and paths (1 0)
    cpu cpu0: _opp_add_static_v2: opp key field not found
    cpu cpu0: _of_add_opp_table_v2: Failed to add OPP, -22

This example happens when trying to use interconnects for a CPU OPP
table together with qcom-cpufreq-nvmem.c. qcom-cpufreq-nvmem calls
dev_pm_opp_set_supported_hw(), which ends up allocating the OPP table
early. To fix the problem with the current approach we would need to add
yet another call to dev_pm_opp_of_find_icc_paths(dev, NULL).
But actually qcom-cpufreq-nvmem.c has nothing to do with interconnects...

This commit attempts to make this more robust by allowing
dev_pm_opp_get_opp_table() to return an error pointer. Fixing all
the usages is trivial because the function is usually used indirectly
through another helper (e.g. dev_pm_opp_set_supported_hw() above).
These other helpers already return an error pointer.

The example above then works correctly because set_supported_hw() will
return -EPROBE_DEFER, and qcom-cpufreq-nvmem.c already propagates that
error. It should also be possible to remove the remaining usages of
"dev_pm_opp_of_find_icc_paths(dev, NULL)" from other drivers as well.

Note that this commit currently only handles -EPROBE_DEFER for the
clock/interconnects within _allocate_opp_table(). Other errors are just
ignored as before. Eventually those should be propagated as well.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[ Viresh: skip checking return value of dev_pm_opp_get_opp_table() for
	  EPROBE_DEFER in domain.c, fix NULL return value and reorder
	  code a bit in core.c, and update exynos-asv.c ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Stephan, I have made some changes to the code. Please try it again and
lemme know if it works fine.

 drivers/base/power/domain.c      | 14 +++++----
 drivers/opp/core.c               | 53 +++++++++++++++++++-------------
 drivers/opp/of.c                 |  8 ++---
 drivers/soc/samsung/exynos-asv.c |  2 +-
 4 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86c..b92bb61550d3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2044,8 +2044,9 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
 		if (ret) {
-			dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
-				ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
+					ret);
 			goto unlock;
 		}
 
@@ -2054,7 +2055,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		 * state.
 		 */
 		genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
-		WARN_ON(!genpd->opp_table);
+		WARN_ON(IS_ERR(genpd->opp_table));
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
@@ -2111,8 +2112,9 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		if (genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
-				dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
-					i, ret);
+				if (ret != -EPROBE_DEFER)
+					dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
+						i, ret);
 				goto error;
 			}
 
@@ -2121,7 +2123,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 			 * performance state.
 			 */
 			genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
-			WARN_ON(!genpd->opp_table);
+			WARN_ON(IS_ERR(genpd->opp_table));
 		}
 
 		genpd->provider = &np->fwnode;
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6978b9218c6e..8c69a764d0a4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1068,7 +1068,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	 */
 	opp_table = kzalloc(sizeof(*opp_table), GFP_KERNEL);
 	if (!opp_table)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&opp_table->lock);
 	mutex_init(&opp_table->genpd_virt_dev_lock);
@@ -1079,8 +1079,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
 	opp_dev = _add_opp_dev(dev, opp_table);
 	if (!opp_dev) {
-		kfree(opp_table);
-		return NULL;
+		ret = -ENOMEM;
+		goto err;
 	}
 
 	_of_init_opp_table(opp_table, dev, index);
@@ -1089,16 +1089,21 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	opp_table->clk = clk_get(dev, NULL);
 	if (IS_ERR(opp_table->clk)) {
 		ret = PTR_ERR(opp_table->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
-				ret);
+		if (ret == -EPROBE_DEFER)
+			goto err;
+
+		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
 	}
 
 	/* Find interconnect path(s) for the device */
 	ret = dev_pm_opp_of_find_icc_paths(dev, opp_table);
-	if (ret)
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			goto err;
+
 		dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
 			 __func__, ret);
+	}
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
@@ -1107,6 +1112,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	/* Secure the device table modification */
 	list_add(&opp_table->node, &opp_tables);
 	return opp_table;
+
+err:
+	kfree(opp_table);
+	return ERR_PTR(ret);
 }
 
 void _get_opp_table_kref(struct opp_table *opp_table)
@@ -1129,7 +1138,7 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 	if (opp_table) {
 		if (!_add_opp_dev_unlocked(dev, opp_table)) {
 			dev_pm_opp_put_opp_table(opp_table);
-			opp_table = NULL;
+			opp_table = ERR_PTR(-ENOMEM);
 		}
 		goto unlock;
 	}
@@ -1573,8 +1582,8 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 	struct opp_table *opp_table;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
 
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
@@ -1632,8 +1641,8 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 	struct opp_table *opp_table;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
 
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
@@ -1725,8 +1734,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	int ret, i;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1833,8 +1842,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	int ret;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1901,8 +1910,8 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 		return ERR_PTR(-EINVAL);
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (!IS_ERR(opp_table))
+		return opp_table;
 
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1982,8 +1991,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	const char **name = names;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
 
 	/*
 	 * If the genpd's OPP table isn't already initialized, parsing of the
@@ -2153,8 +2162,8 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	int ret;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return -ENOMEM;
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
 	/* Fix regulator count for dynamic OPPs */
 	opp_table->regulator_count = 1;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7d9d4455a59e..e39ddcc779af 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -947,8 +947,8 @@ int dev_pm_opp_of_add_table(struct device *dev)
 	int ret;
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, 0);
-	if (!opp_table)
-		return -ENOMEM;
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
 	/*
 	 * OPPs have two version of bindings now. Also try the old (v1)
@@ -1002,8 +1002,8 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 	}
 
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
-	if (!opp_table)
-		return -ENOMEM;
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
 
 	ret = _of_add_opp_table_v2(dev, opp_table);
 	if (ret)
diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index 30bb7b7cc769..8abf4dfaa5c5 100644
--- a/drivers/soc/samsung/exynos-asv.c
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -93,7 +93,7 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
 			continue;
 
 		opp_table = dev_pm_opp_get_opp_table(cpu);
-		if (IS_ERR_OR_NULL(opp_table))
+		if (IS_ERR(opp_table))
 			continue;
 
 		if (!last_opp_table || opp_table != last_opp_table) {
-- 
2.25.0.rc1.19.g042ed3e048af

