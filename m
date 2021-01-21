Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEE2FE8F2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbhAULhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 06:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhAULau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 06:30:50 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCFC0613C1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:30:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so1092858plg.13
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 03:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/s/91ANhuBaU4JbgzRnP0zjULLauKJWjuOxKOA8GyFY=;
        b=MCRk9PgrPaREcmxQnnNY8Ha7rAKjS2CsbbcLa+jAD7KmcCvNrghlmO7KSAxeClWtYi
         jbrGnFEVL6fyh9zk7kKHWgob4JdQksCNP0yvP7M/XMZZ6ES713eSic7NMJ/nsfVLWkLk
         FNs5VrGmpCOFnpHhvcm+geOQrO5ZHiU50WhzV9Y1hhssDBW2GULJK4gLUXE5rPo4nQG6
         0XkCJ7Zc904s4ZpvOtELSMPs+TsOXEHqFWgtbnl0hE/2xxQXalORL0QZHz0ccdA8C8/R
         gEqZr88R1jExQ924FQPZsUxUqo2H0cSoiYiARKa7EgkemPMyVTePqmhwD/7wRsLRUAqT
         5lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/s/91ANhuBaU4JbgzRnP0zjULLauKJWjuOxKOA8GyFY=;
        b=nq8PuUHN1FRaNGrY/Hhx6axM+txm6eNWte+7kMhUOY2XODle3BbTBNGKHEnPkIZI7k
         hyAOPyaUHzbd8DYCG0EOwlHLwB4Pb+gD3RRcSnum0M75VETFuoUJiBwrBjCet/CPUWgC
         2IBTk73AXFTX/HyrHDpoV78hZFEQD2KiMcR1U0Ej+RjVqv18T3siYQ1BKBxPhHMNCgyF
         h+4WLLCGnkKNELCh7DRzQnoRJOpLH41fJ/ob1yEaHKB5Z9fBKvfmz7yQ5BQCIAii4fB4
         Q+Jecw7ScyC1NqIpBn9scRKQW78nDGNUeD2UdjORQj4QRsc0Jv+4DSU84PQHuHsghFs3
         OjNw==
X-Gm-Message-State: AOAM530B9XcyLrDKFodUTdUr6rWdVeG6Wla7ayIgZk0FxxhcLzeMkkCa
        yfmRbATxBvFEw1H1SDqJN/ls6Q==
X-Google-Smtp-Source: ABdhPJxfgn43DtBQWoOhDUkCM1Bi7wxbFoDlJCnv795IJgVUKgpgrIFgL8fN1qNE7lVCm6EKAgrKPw==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr11113853pjb.63.1611228609548;
        Thu, 21 Jan 2021 03:30:09 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j14sm5685837pjl.35.2021.01.21.03.30.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:30:08 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] opp: Prepare for ->set_opp() helper to work without regulators
Date:   Thu, 21 Jan 2021 17:00:05 +0530
Message-Id: <d60bc79ed2ac3fd2f2911449ba994b4d55bd1bfd.1611228541.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Until now the ->set_opp() helper (i.e. special implementation for
setting the OPPs for platforms) was implemented only to take care of
multiple regulators case, but going forward we would need that for other
use cases as well.

This patch prepares for that by allocating the regulator specific part
from dev_pm_opp_set_regulators() and the opp helper part from
dev_pm_opp_register_set_opp_helper().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
V2:
- Fixed a bug where we accessed the wrong pointer
- Add locks in dev_pm_opp_unregister_set_opp_helper()

 drivers/opp/core.c | 83 +++++++++++++++++++++++++---------------------
 drivers/opp/opp.h  |  2 ++
 2 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 846390c9434a..dff939ed5118 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1817,38 +1817,6 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
 
-static int _allocate_set_opp_data(struct opp_table *opp_table)
-{
-	struct dev_pm_set_opp_data *data;
-	int len, count = opp_table->regulator_count;
-
-	if (WARN_ON(!opp_table->regulators))
-		return -EINVAL;
-
-	/* space for set_opp_data */
-	len = sizeof(*data);
-
-	/* space for old_opp.supplies and new_opp.supplies */
-	len += 2 * sizeof(struct dev_pm_opp_supply) * count;
-
-	data = kzalloc(len, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->old_opp.supplies = (void *)(data + 1);
-	data->new_opp.supplies = data->old_opp.supplies + count;
-
-	opp_table->set_opp_data = data;
-
-	return 0;
-}
-
-static void _free_set_opp_data(struct opp_table *opp_table)
-{
-	kfree(opp_table->set_opp_data);
-	opp_table->set_opp_data = NULL;
-}
-
 /**
  * dev_pm_opp_set_regulators() - Set regulator names for the device
  * @dev: Device for which regulator name is being set.
@@ -1865,6 +1833,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 					    const char * const names[],
 					    unsigned int count)
 {
+	struct dev_pm_opp_supply *supplies;
 	struct opp_table *opp_table;
 	struct regulator *reg;
 	int ret, i;
@@ -1906,10 +1875,19 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 
 	opp_table->regulator_count = count;
 
-	/* Allocate block only once to pass to set_opp() routines */
-	ret = _allocate_set_opp_data(opp_table);
-	if (ret)
+	supplies = kmalloc_array(count * 2, sizeof(*supplies), GFP_KERNEL);
+	if (!supplies) {
+		ret = -ENOMEM;
 		goto free_regulators;
+	}
+
+	mutex_lock(&opp_table->lock);
+	opp_table->sod_supplies = supplies;
+	if (opp_table->set_opp_data) {
+		opp_table->set_opp_data->old_opp.supplies = supplies;
+		opp_table->set_opp_data->new_opp.supplies = supplies + count;
+	}
+	mutex_unlock(&opp_table->lock);
 
 	return opp_table;
 
@@ -1952,9 +1930,16 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	for (i = opp_table->regulator_count - 1; i >= 0; i--)
 		regulator_put(opp_table->regulators[i]);
 
-	_free_set_opp_data(opp_table);
+	mutex_lock(&opp_table->lock);
+	if (opp_table->set_opp_data) {
+		opp_table->set_opp_data->old_opp.supplies = NULL;
+		opp_table->set_opp_data->new_opp.supplies = NULL;
+	}
+	mutex_unlock(&opp_table->lock);
 
+	kfree(opp_table->sod_supplies);
 	kfree(opp_table->regulators);
+	opp_table->sod_supplies = NULL;
 	opp_table->regulators = NULL;
 	opp_table->regulator_count = -1;
 
@@ -2046,6 +2031,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 			int (*set_opp)(struct dev_pm_set_opp_data *data))
 {
+	struct dev_pm_set_opp_data *data;
 	struct opp_table *opp_table;
 
 	if (!set_opp)
@@ -2062,8 +2048,23 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 	}
 
 	/* Another CPU that shares the OPP table has set the helper ? */
-	if (!opp_table->set_opp)
-		opp_table->set_opp = set_opp;
+	if (opp_table->set_opp)
+		return opp_table;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&opp_table->lock);
+	opp_table->set_opp_data = data;
+	if (opp_table->sod_supplies) {
+		data->old_opp.supplies = opp_table->sod_supplies;
+		data->new_opp.supplies = opp_table->sod_supplies +
+					 opp_table->regulator_count;
+	}
+	mutex_unlock(&opp_table->lock);
+
+	opp_table->set_opp = set_opp;
 
 	return opp_table;
 }
@@ -2085,6 +2086,12 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	WARN_ON(!list_empty(&opp_table->opp_list));
 
 	opp_table->set_opp = NULL;
+
+	mutex_lock(&opp_table->lock);
+	kfree(opp_table->set_opp_data);
+	opp_table->set_opp_data = NULL;
+	mutex_unlock(&opp_table->lock);
+
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4ced7ffa8158..4408cfcb0f31 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -155,6 +155,7 @@ enum opp_table_access {
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
+ * @sod_supplies: Set opp data supplies
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
@@ -202,6 +203,7 @@ struct opp_table {
 	bool is_genpd;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
+	struct dev_pm_opp_supply *sod_supplies;
 	struct dev_pm_set_opp_data *set_opp_data;
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.25.0.rc1.19.g042ed3e048af

