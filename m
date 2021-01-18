Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118442F9716
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbhARBDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbhARA5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0757C061793;
        Sun, 17 Jan 2021 16:55:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o17so21664235lfg.4;
        Sun, 17 Jan 2021 16:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6f4AT9gcxWNNircaoBevbJDLZI+952qLRubU5cLyss=;
        b=eSKqqMSDOvQeXnobkQTCgrR4K2CZ2qceg2wO0+KgZiE9NZwyAabQTo7cKFt5QD/+rj
         r0UB73EjUhG9ytlcmcq8aUzsOJaNOmKeGWOqsC4eD1nBJt6ZkghcH1rFhd1AHTMkNSrN
         HHVQAkgS5c4VOJzjtFwfyvlb4dPKcTRBvWSm3bRIoA7SRIvs7FW1xFTa/duWQjoTkjhT
         xnpcO0qMZtFYarPZP5pfgOoTR94neVNrPBgadF7uUxlhVdHitqTSLoqW6ShQjJKPj61N
         CBLlSK75GcyD11Az914vVo55RVYkkup3XwsAZsyAeYo7RO6Ip6dPNLY35l7EhXe8iUU3
         K5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6f4AT9gcxWNNircaoBevbJDLZI+952qLRubU5cLyss=;
        b=pn3TZeICaer9vbuD5t/1FmPyOrBIeQrOr1kVHDsZ72TIJOTC7TlWA+1N9oli2QLNTw
         FgSgMJFIoMyFjwJCFGBJTmqb5/tH7VnIlwEJJau6bzyjI5Ysju6KaR4PlqAJYItbTzXb
         L0uA13KRmFBwa6U1zaUz0PWrkc69Cgf+IoWgl+ouEf2ZtCPfhxHOr5aYrA79KXwz3AdF
         7NdCaCsECeWFFLGgRq9Vf5Ik8apLjIOO2FCWRhbJjbB1lej3/Dvl+iXraxYkqMIQ5epT
         8cds7Wk2p2XRtiTVY7+iqIE37AAjExLIAznKCFRFDzDR/IaK8xdx4l2nMyn7GP7tzmQv
         5Unw==
X-Gm-Message-State: AOAM530njvXUVaQJStx6iGvGamr04VWTJSv7dvHjN+qbTMPYJeN+YRzl
        PZuUxt21PAiT/hSx+lnSQBk=
X-Google-Smtp-Source: ABdhPJz4crxlKxPiY08WnbMui0nzQ9K9CkptpbVwjYoxsedY3zylazSoo5E3coxlZPp9Za84mixEoQ==
X-Received: by 2002:a19:810:: with SMTP id 16mr10532223lfi.233.1610931344312;
        Sun, 17 Jan 2021 16:55:44 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 10/12] opp: Support set_opp() customization without requiring to use regulators
Date:   Mon, 18 Jan 2021 03:55:22 +0300
Message-Id: <20210118005524.27787-11-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support set_opp() customization without requiring to use regulators. This
is needed by drivers which want to use dev_pm_opp_set_rate() for changing
rates of a multiple clocks and don't need to touch regulator.

One example is NVIDIA Tegra30/114 SoCs which have two sibling 3D hardware
units which should be use to the same clock rate, meanwhile voltage
scaling is done using a power domain. In this case OPP table doesn't have
a regulator, causing a NULL dereference in _set_opp_custom().

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 46 +++++++++++++++++++++++++++++++++++-------
 include/linux/pm_opp.h |  3 +++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 49419ab9fbb4..7726c4c40b53 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -829,16 +829,21 @@ static int _set_opp_custom(const struct opp_table *opp_table,
 			   struct dev_pm_opp_supply *new_supply)
 {
 	struct dev_pm_set_opp_data *data;
-	int size;
+	int size, count;
+
+	if (opp_table->regulators)
+		count = opp_table->regulator_count;
+	else
+		count = 0;
 
 	data = opp_table->set_opp_data;
 	data->regulators = opp_table->regulators;
-	data->regulator_count = opp_table->regulator_count;
+	data->regulator_count = count;
 	data->clk = opp_table->clk;
 	data->dev = dev;
 
 	data->old_opp.rate = old_freq;
-	size = sizeof(*old_supply) * opp_table->regulator_count;
+	size = sizeof(*old_supply) * count;
 	if (!old_supply)
 		memset(data->old_opp.supplies, 0, size);
 	else
@@ -1860,8 +1865,14 @@ static int _allocate_set_opp_data(struct opp_table *opp_table)
 	struct dev_pm_set_opp_data *data;
 	int len, count = opp_table->regulator_count;
 
-	if (WARN_ON(!opp_table->regulators))
-		return -EINVAL;
+	/* just bump the refcount if already allocated */
+	if (opp_table->set_opp_data) {
+		kref_get(&opp_table->set_opp_data->kref);
+		return 0;
+	}
+
+	/* allocate maximum number of regulators, for simplicity */
+	count = max(count, 1);
 
 	/* space for set_opp_data */
 	len = sizeof(*data);
@@ -1873,6 +1884,7 @@ static int _allocate_set_opp_data(struct opp_table *opp_table)
 	if (!data)
 		return -ENOMEM;
 
+	kref_init(&data->kref);
 	data->old_opp.supplies = (void *)(data + 1);
 	data->new_opp.supplies = data->old_opp.supplies + count;
 
@@ -1881,10 +1893,17 @@ static int _allocate_set_opp_data(struct opp_table *opp_table)
 	return 0;
 }
 
+static void _release_set_opp_data(struct kref *kref)
+{
+	kfree(container_of(kref, struct dev_pm_set_opp_data, kref));
+}
+
 static void _free_set_opp_data(struct opp_table *opp_table)
 {
-	kfree(opp_table->set_opp_data);
-	opp_table->set_opp_data = NULL;
+	struct dev_pm_set_opp_data *data = opp_table->set_opp_data;
+
+	if (kref_put(&data->kref, _release_set_opp_data))
+		opp_table->set_opp_data = NULL;
 }
 
 /**
@@ -2182,6 +2201,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
 	struct opp_table *opp_table;
+	int ret;
 
 	if (!set_opp)
 		return ERR_PTR(-EINVAL);
@@ -2196,11 +2216,21 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 		return ERR_PTR(-EBUSY);
 	}
 
+	/* Allocate block to pass to set_opp() routines */
+	ret = _allocate_set_opp_data(opp_table);
+	if (ret)
+		goto err;
+
 	/* Another CPU that shares the OPP table has set the helper ? */
 	if (!opp_table->set_opp)
 		opp_table->set_opp = set_opp;
 
 	return opp_table;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_register_set_opp_helper);
 
@@ -2219,6 +2249,8 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
+	_free_set_opp_data(opp_table);
+
 	opp_table->set_opp = NULL;
 	dev_pm_opp_put_opp_table(opp_table);
 }
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index eefd0b15890c..c98fd2add563 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -13,6 +13,7 @@
 
 #include <linux/energy_model.h>
 #include <linux/err.h>
+#include <linux/kref.h>
 #include <linux/notifier.h>
 
 struct clk;
@@ -74,6 +75,7 @@ struct dev_pm_opp_info {
  * @regulator_count: Number of regulators
  * @clk:	Pointer to clk
  * @dev:	Pointer to the struct device
+ * @kref:	Reference counter
  *
  * This structure contains all information required for setting an OPP.
  */
@@ -85,6 +87,7 @@ struct dev_pm_set_opp_data {
 	unsigned int regulator_count;
 	struct clk *clk;
 	struct device *dev;
+	struct kref kref;
 };
 
 #if defined(CONFIG_PM_OPP)
-- 
2.29.2

