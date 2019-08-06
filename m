Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9828305C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfHFLMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 07:12:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32906 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731309AbfHFLMf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C8862002C1;
        Tue,  6 Aug 2019 13:12:33 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F32220020B;
        Tue,  6 Aug 2019 13:12:33 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 82289205DD;
        Tue,  6 Aug 2019 13:12:32 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-pm@vger.kernel.org
Subject: [RFC 2/4] opp: Add dev_pm_opp_table_get_device
Date:   Tue,  6 Aug 2019 14:12:26 +0300
Message-Id: <53d047703057fb09a0345b0a13715576d6eea3da.1565089196.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1565089196.git.leonard.crestez@nxp.com>
References: <cover.1565089196.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This API is the opposite of dev_pm_opp_get_opp_table. OPP tables can be
shared between devices but this ambiguity can be handled by returning an
error if opp table is not exclusive.

This can used for fetching the device pointed to by "required-opps".

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/opp/core.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 77814d3bc4e6..b8bbabbbe44a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -87,10 +87,40 @@ struct opp_table *_find_opp_table(struct device *dev)
 	mutex_unlock(&opp_table_lock);
 
 	return opp_table;
 }
 
+/**
+ * _find_opp_table() - find device struct using opp_table pointer
+ *
+ * OPP table must be exclusive: not be shared between devices.
+ */
+struct device *dev_pm_opp_table_get_device(struct opp_table *opp_table)
+{
+	struct opp_device *opp_dev;
+	struct device *dev = ERR_PTR(-EINVAL);
+	int opp_dev_cnt = 0;
+
+	mutex_lock(&opp_table->lock);
+
+	/* OPP table must not be shared: only one device */
+	if (opp_table->shared_opp != OPP_TABLE_ACCESS_EXCLUSIVE)
+		goto out;
+	list_for_each_entry(opp_dev, &opp_table->dev_list, node)
+		opp_dev_cnt++;
+	if (opp_dev_cnt != 1)
+		goto out;
+
+	opp_dev = list_first_entry(&opp_table->dev_list, struct opp_device, node);
+	dev = opp_dev->dev;
+
+out:
+	mutex_unlock(&opp_table->lock);
+	return dev;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_table_get_device);
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
  *
  * Return: voltage in micro volt corresponding to the opp, else
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b8197ab014f2..a4db3f42d787 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -76,10 +76,11 @@ struct dev_pm_set_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
 struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
+struct device *dev_pm_opp_table_get_device(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
@@ -149,10 +150,15 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
+struct struct device *dev_pm_opp_table_get_device(struct opp_table *opp_table)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;
 }
 
-- 
2.17.1

