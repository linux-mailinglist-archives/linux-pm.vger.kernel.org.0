Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D362414AADA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA0UEf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:04:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51737 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbgA0UEf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:04:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155475; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tRkiug46cbevcWIh2EsjxvwfdWbmSAuqNGdTaK/He0k=; b=QaRlV8pL8Nf0ncN5knbgH2K6kOOL2km2FYF7+GubWtljbxCebT/vPwVJ/XQhSHx0JV0tibsL
 40zPkof6nwQF2MLi3n2mk1+smmgyi9fSMVWsTh6/qkySJKu+Hy/np17ZX25Mx25VrxFuTImt
 firMcM1Hbnb7Tz2j5AnPomjZvGg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f4251.7f0f2c0193b0-smtp-out-n03;
 Mon, 27 Jan 2020 20:04:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0E1F6C447A6; Mon, 27 Jan 2020 20:04:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6658EC433CB;
        Mon, 27 Jan 2020 20:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6658EC433CB
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
Subject: [RFC v3 04/10] OPP: Add and export helper to update voltage
Date:   Tue, 28 Jan 2020 01:33:44 +0530
Message-Id: <20200127200350.24465-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add and export 'dev_pm_opp_update_voltage' to find and update voltage
of an opp for a given frequency. This will be useful to update the opps
with voltages read back from firmware.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 10 ++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9aa2a44a5d638..f241e83ec926a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2503,6 +2503,61 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
 
+/**
+ * dev_pm_opp_update_voltage() - Find and update voltage
+ * @dev:	device for which we do this operation
+ * @freq:	OPP frequency to update voltage
+ * @u_volt:	voltage requested for this opp
+ *
+ * Find and update voltage of a disabled opp corresponding to the given
+ * frequency. This is useful only for devices with single power supply.
+ *
+ * Return: 0 if modification was successful or a negative error value.
+ */
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt)
+{
+	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
+	struct opp_table *opp_table;
+	unsigned long tol;
+	int ret = 0;
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, ret);
+		return PTR_ERR(opp_table);
+	}
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
index 62c88898bae46..b26d492cbd635 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -132,6 +132,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt);
+
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
@@ -311,6 +314,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
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
