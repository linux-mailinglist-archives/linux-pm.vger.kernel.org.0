Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7014AAE4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgA0UEz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:04:55 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:22279 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgA0UEy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:04:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155493; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3kgeoLZd2Ff+NKwY5h0VmurEmZp7SbDVSmBUbxlhE/s=; b=f5vWoAapSdtDz4tY+cmvR23mdELNaOaxuF585EeCIqSk9GqPBlpVTxgmqXTF8/5sY3tQUCaV
 Mx8IsCpuxSmIlVgrYNnn/iyQQ6HbGwFpmVeTJ2ips0IrFqLTG474JRj48OeS8bzdIAIDNvTq
 5jbWSoO8hrhdjMgymTT2Jaz9GCs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f425f.7feba2a79960-smtp-out-n02;
 Mon, 27 Jan 2020 20:04:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DDCBC447A4; Mon, 27 Jan 2020 20:04:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 515A3C43383;
        Mon, 27 Jan 2020 20:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 515A3C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC v3 06/10] opp: Allow multiple opp_tables to be mapped to a single device
Date:   Tue, 28 Jan 2020 01:33:46 +0530
Message-Id: <20200127200350.24465-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce _find_opp_table_indexed and its unlocked variant to allow for
multiple distinct opp_tables to be linked to a single device.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f241e83ec926a..e9d633c9e40b1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -46,19 +46,26 @@ static struct opp_device *_find_opp_dev(const struct device *dev,
 	return NULL;
 }
 
-static struct opp_table *_find_opp_table_unlocked(struct device *dev)
+static struct opp_table *_find_opp_table_indexed_unlocked(struct device *dev,
+							  int index)
 {
 	struct opp_table *opp_table;
+	struct device_node *np;
 	bool found;
 
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	of_node_put(np);
+
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		mutex_lock(&opp_table->lock);
 		found = !!_find_opp_dev(dev, opp_table);
 		mutex_unlock(&opp_table->lock);
 
 		if (found) {
-			_get_opp_table_kref(opp_table);
+			if (np && opp_table->np != np)
+				continue;
 
+			_get_opp_table_kref(opp_table);
 			return opp_table;
 		}
 	}
@@ -67,17 +74,19 @@ static struct opp_table *_find_opp_table_unlocked(struct device *dev)
 }
 
 /**
- * _find_opp_table() - find opp_table struct using device pointer
+ * _find_opp_table_indexed() - find opp_table struct using device pointer
  * @dev:	device pointer used to lookup OPP table
+ * @index:	Index number.
  *
- * Search OPP table for one containing matching device.
+ * Search OPP table for one containing matching device at the given
+ * index.
  *
  * Return: pointer to 'struct opp_table' if found, otherwise -ENODEV or
  * -EINVAL based on type of error.
  *
  * The callers must call dev_pm_opp_put_opp_table() after the table is used.
  */
-struct opp_table *_find_opp_table(struct device *dev)
+struct opp_table *_find_opp_table_indexed(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 
@@ -87,12 +96,28 @@ struct opp_table *_find_opp_table(struct device *dev)
 	}
 
 	mutex_lock(&opp_table_lock);
-	opp_table = _find_opp_table_unlocked(dev);
+	opp_table = _find_opp_table_indexed_unlocked(dev, index);
 	mutex_unlock(&opp_table_lock);
 
 	return opp_table;
 }
 
+/**
+ * _find_opp_table() - find opp_table struct using device pointer
+ * @dev:	device pointer used to lookup OPP table
+ *
+ * Search OPP table for one containing matching device.
+ *
+ * Return: pointer to 'struct opp_table' if found, otherwise -ENODEV or
+ * -EINVAL based on type of error.
+ *
+ * The callers must call dev_pm_opp_put_opp_table() after the table is used.
+ */
+struct opp_table *_find_opp_table(struct device *dev)
+{
+	return _find_opp_table_indexed(dev, 0);
+}
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
@@ -1238,7 +1263,7 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 	/* Hold our table modification lock here */
 	mutex_lock(&opp_table_lock);
 
-	opp_table = _find_opp_table_unlocked(dev);
+	opp_table = _find_opp_table_indexed_unlocked(dev, index);
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
@@ -2612,7 +2637,7 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 	struct opp_table *opp_table;
 
 	/* Check for existing table for 'dev' */
-	opp_table = _find_opp_table(dev);
+	opp_table = _find_opp_table_indexed(dev, 0);
 	if (IS_ERR(opp_table)) {
 		int error = PTR_ERR(opp_table);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
