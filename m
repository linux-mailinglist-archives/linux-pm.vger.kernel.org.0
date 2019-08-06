Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33448305B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfHFLMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 07:12:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54140 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbfHFLMf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FDE21A00D8;
        Tue,  6 Aug 2019 13:12:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 728261A00CD;
        Tue,  6 Aug 2019 13:12:32 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E465A205DD;
        Tue,  6 Aug 2019 13:12:31 +0200 (CEST)
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
Subject: [RFC 1/4] opp: Drop const from opp_device struct device
Date:   Tue,  6 Aug 2019 14:12:25 +0300
Message-Id: <fbb05862236198862e54126c2f3167a93c641274.1565089196.git.leonard.crestez@nxp.com>
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

This is required for fetching struct device from struct opp_table with
casts

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
Does "const" here have any particular significance?

 drivers/opp/core.c | 4 ++--
 drivers/opp/opp.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3b7ffd0234e9..77814d3bc4e6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -913,11 +913,11 @@ static void _remove_opp_dev(struct opp_device *opp_dev,
 	opp_debug_unregister(opp_dev, opp_table);
 	list_del(&opp_dev->node);
 	kfree(opp_dev);
 }
 
-static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
+static struct opp_device *_add_opp_dev_unlocked(struct device *dev,
 						struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
 
 	opp_dev = kzalloc(sizeof(*opp_dev), GFP_KERNEL);
@@ -933,11 +933,11 @@ static struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
 	opp_debug_register(opp_dev, opp_table);
 
 	return opp_dev;
 }
 
-struct opp_device *_add_opp_dev(const struct device *dev,
+struct opp_device *_add_opp_dev(struct device *dev,
 				struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
 
 	mutex_lock(&opp_table->lock);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..5a7ddd55bd84 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -103,11 +103,11 @@ struct dev_pm_opp {
  * This is an internal data structure maintaining the devices that are managed
  * by 'struct opp_table'.
  */
 struct opp_device {
 	struct list_head node;
-	const struct device *dev;
+	struct device *dev;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 #endif
 };
@@ -207,11 +207,11 @@ struct opp_table {
 void dev_pm_opp_get(struct dev_pm_opp *opp);
 void _opp_remove_all_static(struct opp_table *opp_table);
 void _get_opp_table_kref(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
 struct opp_table *_find_opp_table(struct device *dev);
-struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
+struct opp_device *_add_opp_dev(struct device *dev, struct opp_table *opp_table);
 void _dev_pm_opp_find_and_remove_table(struct device *dev);
 struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-- 
2.17.1

