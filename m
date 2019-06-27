Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CE583AC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF0Nen (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 09:34:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0Nen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 09:34:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5415C607CA; Thu, 27 Jun 2019 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642482;
        bh=sNGHRg/AVqvcuTMuiO6jtsnX89/WYPc7sjQ6Yr/5IKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUuCCPGw9JYEnIf5r5uZ6Ml24cepvZKH7TEkucJs1K18mzh+U/8A6s+2duGLLWMri
         k1HearZJT1LRD9CXYp3eU1VZqo1xRmZ6PVbQWS9AvyFUh0DPF0Pj59VZyjw8C3duCT
         RsaWZo0gmP7J5UFZcBRBoTAJgSCzP1lxJ8Lut2Rk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FE5660A33;
        Thu, 27 Jun 2019 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561642481;
        bh=sNGHRg/AVqvcuTMuiO6jtsnX89/WYPc7sjQ6Yr/5IKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYD501kMzkX4BCy96Ew+uubjgWIYzLGl5EemTcDgTLvPhhWWmScA0/Rqvkw37gRtv
         WdsP1jPSr78oHs2AnlWC+Wm2eXkD0MpD022/iCIdfdZTkWfjC0B1UJ9sDlnEKkcY3t
         zzlGe43dO43hxM57Ete04ly9v8xcPODoUYKGHzVg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FE5660A33
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 1/4] OPP: Add and export helper to update voltage
Date:   Thu, 27 Jun 2019 19:04:21 +0530
Message-Id: <20190627133424.4980-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627133424.4980-1-sibis@codeaurora.org>
References: <20190627133424.4980-1-sibis@codeaurora.org>
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
 drivers/opp/core.c     | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 10 ++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 68551d6366e6b..c85c04dc2c7de 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2197,6 +2197,58 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
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
+ * Return: 0 if no modification was done OR modification was
+ * successful or a negative error value.
+ */
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt)
+{
+	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
+	struct opp_table *opp_table;
+	unsigned long tol;
+	int ret = 0;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq, false);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, ret);
+		goto put_opp;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	/* update only if the opp is disabled */
+	if (opp->available)
+		goto unlock;
+
+	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
+	opp->supplies[0].u_volt_min = u_volt - tol;
+	opp->supplies[0].u_volt = u_volt;
+	opp->supplies[0].u_volt_min = u_volt + tol;
+
+unlock:
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+put_opp:
+	dev_pm_opp_put(opp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
+
 /**
  * dev_pm_opp_register_notifier() - Register OPP notifier for the device
  * @dev:	Device for which notifier needs to be registered
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 87fa09d93d8c2..a17c462974851 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -130,6 +130,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt);
+
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
@@ -261,6 +264,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
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

