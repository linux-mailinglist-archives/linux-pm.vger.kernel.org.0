Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8781C14AAE9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgA0UFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:05:00 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59383 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727872AbgA0UE7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:04:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155499; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1/OCv/YWi9A5ql/vJL6uSomFHcmrXg+3BhQMo7h7H4I=; b=RGK5cyoZ/HGmcX6xSsYN6S5cz5xPeJBf14v4d2Ubp67vCvEKknAJIUSqnMpIrFFxlAO2eGW/
 M18oIsImq1urtongRjcRJdSBMRyuQayXWWSvhbnDIld7dvBX82i8oj7+b1MufGkrt7NQDwFn
 O2uJ4cuqH0D+AIhhF9IhFtl/pV8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f4266.7fd3cd82a9d0-smtp-out-n03;
 Mon, 27 Jan 2020 20:04:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 249EBC447A4; Mon, 27 Jan 2020 20:04:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 409D1C447A1;
        Mon, 27 Jan 2020 20:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 409D1C447A1
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
Subject: [RFC v3 07/10] opp: Remove multiple attached opp tables from a device
Date:   Tue, 28 Jan 2020 01:33:47 +0530
Message-Id: <20200127200350.24465-8-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce _dev_pm_opp_find_and_remove_table_indexed to remove
all the linked opp tables from a device.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e9d633c9e40b1..cc2f156db7fda 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2632,12 +2632,13 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
 }
 EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
 
-void _dev_pm_opp_find_and_remove_table(struct device *dev)
+static void _dev_pm_opp_find_and_remove_table_indexed(struct device *dev,
+						      int index)
 {
 	struct opp_table *opp_table;
 
 	/* Check for existing table for 'dev' */
-	opp_table = _find_opp_table_indexed(dev, 0);
+	opp_table = _find_opp_table_indexed(dev, index);
 	if (IS_ERR(opp_table)) {
 		int error = PTR_ERR(opp_table);
 
@@ -2658,6 +2659,18 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
+void _dev_pm_opp_find_and_remove_table(struct device *dev)
+{
+	int count, i;
+
+	count = of_count_phandle_with_args(dev->of_node,
+					   "operating-points-v2", NULL);
+	count = max(count, 1);
+
+	for (i = 0; i < count; i++)
+		_dev_pm_opp_find_and_remove_table_indexed(dev, i);
+}
+
 /**
  * dev_pm_opp_remove_table() - Free all OPPs associated with the device
  * @dev:	device pointer used to lookup OPP table.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
