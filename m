Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572591C47FE
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEDUYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:24:19 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16376 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgEDUYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:24:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623858; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=e8+9aaR0dV277/iGPXIsEd+NcTTiEfOLq4U1XvgNI0M=; b=xkHpbPXcO+Xf5k8tQ4BOtCywAhF68BMGBwzHNkVLCRvGc2er6ZMrnSSezfvbiY/vT8cc4k9D
 C5M3V6fi3oQdd87M0hOxCUAqQ+dLk0biNwjLIEgJxMx3EkZUgQag26uiVDY5D8eowUVBfykd
 y/hfhNenWQnuXRVMpekH/To7tLE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb079f1.7f012f4d8d50-smtp-out-n01;
 Mon, 04 May 2020 20:24:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5728DC433D2; Mon,  4 May 2020 20:24:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2065EC433F2;
        Mon,  4 May 2020 20:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2065EC433F2
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
Subject: [PATCH v4 04/12] OPP: Add and export helper to update voltage
Date:   Tue,  5 May 2020 01:52:35 +0530
Message-Id: <20200504202243.5476-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add and export 'dev_pm_opp_update_voltage' to update the voltage of an
opp for a given frequency. This will be useful to update the opps with
voltages read back from firmware.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v4:
 * Function description update [Matthias]
 * Drop initialization [Matthias]
 * Drop err message on opp_table get failure

 drivers/opp/core.c     | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 10 +++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cfad09f5dfffa..7f7060079bb28 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2248,6 +2248,57 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
 
+/**
+ * dev_pm_opp_update_voltage() - Update the voltage of an opp
+ * @dev:	device for which we do this operation
+ * @freq:	OPP frequency to update voltage
+ * @u_volt:	voltage requested for this opp
+ *
+ * Update voltage of a disabled opp corresponding to the given frequency.
+ * This is useful only for devices with single power supply.
+ *
+ * Return: 0 if modification was successful or a negative error value.
+ */
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	unsigned long tol;
+	int ret = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, false);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto put_table;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	/* update only if the opp is disabled */
+	if (opp->available) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
+	opp->supplies[0].u_volt_min = u_volt - tol;
+	opp->supplies[0].u_volt = u_volt;
+	opp->supplies[0].u_volt_min = u_volt + tol;
+
+unlock:
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put(opp);
+put_table:
+	dev_pm_opp_put_opp_table(opp_table);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
+
 /**
  * dev_pm_opp_register_notifier() - Register OPP notifier for the device
  * @dev:	Device for which notifier needs to be registered
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cfceb02904018..639bc0382ee02 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -134,6 +134,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt);
+
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
@@ -277,6 +280,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 	return 0;
 }
 
+static inline int dev_pm_opp_update_voltage(struct device *dev,
+					    unsigned long freq,
+					    unsigned long u_volt)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
 	return -ENOTSUPP;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
