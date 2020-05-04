Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189051C480E
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEDUYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:24:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51515 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbgEDUYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:24:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623887; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BLkVHANfP1T+UysucutpBK8VG9t4buVxKJsZZeHRBaw=; b=HAgl1NOWjU1xRHd/HzrNjrp9Mya/Cru3Wqd8LiqTsKQe08PGzE7H4FmAt+nMmelBsV1U+nCY
 OcmBHrEhjCOQRRmgCUWD+bpHc1Um88PbJjfFs5oBpakFe91v7ZgCQR3WOtHTgVwE4gkBt/Iq
 MyPyTj63FHEFokEieXuvasjIBFc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07a0a.7f3fd6b3dce0-smtp-out-n03;
 Mon, 04 May 2020 20:24:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44BFCC44791; Mon,  4 May 2020 20:24:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11FBBC433BA;
        Mon,  4 May 2020 20:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11FBBC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 07/12] OPP: Add and export helper to get icc path count
Date:   Tue,  5 May 2020 01:52:38 +0530
Message-Id: <20200504202243.5476-8-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add and export 'dev_pm_opp_get_path_count' to get the icc path count
associated with the device.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c     | 20 ++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f157e2d768d76..6106146a582d5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -343,6 +343,26 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
+int dev_pm_opp_get_path_count(struct device *dev)
+{
+	struct opp_table *opp_table;
+	int count;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		count = PTR_ERR(opp_table);
+		dev_dbg(dev, "%s: OPP table not found (%d)\n",
+			__func__, count);
+		return count;
+	}
+
+	count = opp_table->path_count;
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_path_count);
+
 /**
  * dev_pm_opp_find_freq_exact() - search for an exact frequency
  * @dev:		device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 87ba295080a2b..ffd075c8da0ca 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -101,6 +101,7 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
+int dev_pm_opp_get_path_count(struct device *dev);
 unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
@@ -197,6 +198,11 @@ static inline int dev_pm_opp_get_opp_count(struct device *dev)
 	return 0;
 }
 
+static inline int dev_pm_opp_get_path_count(struct device *dev)
+{
+	return 0;
+}
+
 static inline unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
 {
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
