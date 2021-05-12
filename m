Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6037B5B1
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhELGQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 02:16:28 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53424 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELGQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 02:16:26 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2021 23:15:19 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 May 2021 23:15:17 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 May 2021 11:44:39 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 73844478D; Wed, 12 May 2021 11:44:38 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V4 1/5] input: pm8941-pwrkey: add support for PMK8350 PON_HLOS PMIC peripheral
Date:   Wed, 12 May 2021 11:44:09 +0530
Message-Id: <1620800053-26405-2-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Collins <collinsd@codeaurora.org>

On Qualcomm Technologies, Inc. PMIC PMK8350, the PON peripheral
is split into two peripherals: PON_HLOS and PON_PBS.  The
application processor only has write access to PON_HLOS which
limits it to only receiving PON interrupts.

Add support for the PMK8350 PON_HLOS peripheral so that its
KPDPWR_N and RESIN_N interrupts can be used to detect key
presses.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Signed-off-by: satya priya <skakit@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes in V2:
 - No change.

Changes in V3:
 - No change.

Changes in V4:
 - No change.

 drivers/input/misc/pm8941-pwrkey.c | 103 ++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 31 deletions(-)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index cf81044..10e3fc0 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
+ * Copyright (c) 2010-2011, 2020-2021, The Linux Foundation. All rights reserved.
  * Copyright (c) 2014, Sony Mobile Communications Inc.
  */
 
@@ -22,6 +22,8 @@
 #define PON_RT_STS			0x10
 #define  PON_KPDPWR_N_SET		BIT(0)
 #define  PON_RESIN_N_SET		BIT(1)
+#define  PON_GEN3_RESIN_N_SET		BIT(6)
+#define  PON_GEN3_KPDPWR_N_SET		BIT(7)
 
 #define PON_PS_HOLD_RST_CTL		0x5a
 #define PON_PS_HOLD_RST_CTL2		0x5b
@@ -38,8 +40,12 @@
 #define  PON_DBC_DELAY_MASK		0x7
 
 struct pm8941_data {
-	unsigned int pull_up_bit;
-	unsigned int status_bit;
+	unsigned int	pull_up_bit;
+	unsigned int	status_bit;
+	bool		supports_ps_hold_poff_config;
+	bool		supports_debounce_config;
+	const char	*name;
+	const char	*phys;
 };
 
 struct pm8941_pwrkey {
@@ -231,34 +237,40 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 
 	input_set_capability(pwrkey->input, EV_KEY, pwrkey->code);
 
-	pwrkey->input->name = "pm8941_pwrkey";
-	pwrkey->input->phys = "pm8941_pwrkey/input0";
-
-	req_delay = (req_delay << 6) / USEC_PER_SEC;
-	req_delay = ilog2(req_delay);
-
-	error = regmap_update_bits(pwrkey->regmap,
-				   pwrkey->baseaddr + PON_DBC_CTL,
-				   PON_DBC_DELAY_MASK,
-				   req_delay);
-	if (error) {
-		dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
-		return error;
+	pwrkey->input->name = pwrkey->data->name;
+	pwrkey->input->phys = pwrkey->data->phys;
+
+	if (pwrkey->data->supports_debounce_config) {
+		req_delay = (req_delay << 6) / USEC_PER_SEC;
+		req_delay = ilog2(req_delay);
+
+		error = regmap_update_bits(pwrkey->regmap,
+					   pwrkey->baseaddr + PON_DBC_CTL,
+					   PON_DBC_DELAY_MASK,
+					   req_delay);
+		if (error) {
+			dev_err(&pdev->dev, "failed to set debounce: %d\n",
+				error);
+			return error;
+		}
 	}
 
-	error = regmap_update_bits(pwrkey->regmap,
-				   pwrkey->baseaddr + PON_PULL_CTL,
-				   pwrkey->data->pull_up_bit,
-				   pull_up ? pwrkey->data->pull_up_bit : 0);
-	if (error) {
-		dev_err(&pdev->dev, "failed to set pull: %d\n", error);
-		return error;
+	if (pwrkey->data->pull_up_bit) {
+		error = regmap_update_bits(pwrkey->regmap,
+					   pwrkey->baseaddr + PON_PULL_CTL,
+					   pwrkey->data->pull_up_bit,
+					   pull_up ? pwrkey->data->pull_up_bit :
+						     0);
+		if (error) {
+			dev_err(&pdev->dev, "failed to set pull: %d\n", error);
+			return error;
+		}
 	}
 
 	error = devm_request_threaded_irq(&pdev->dev, pwrkey->irq,
 					  NULL, pm8941_pwrkey_irq,
 					  IRQF_ONESHOT,
-					  "pm8941_pwrkey", pwrkey);
+					  pwrkey->data->name, pwrkey);
 	if (error) {
 		dev_err(&pdev->dev, "failed requesting IRQ: %d\n", error);
 		return error;
@@ -271,12 +283,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify,
-	error = register_reboot_notifier(&pwrkey->reboot_notifier);
-	if (error) {
-		dev_err(&pdev->dev, "failed to register reboot notifier: %d\n",
-			error);
-		return error;
+	if (pwrkey->data->supports_ps_hold_poff_config) {
+		pwrkey->reboot_notifier.notifier_call = pm8941_reboot_notify,
+		error = register_reboot_notifier(&pwrkey->reboot_notifier);
+		if (error) {
+			dev_err(&pdev->dev, "failed to register reboot notifier: %d\n",
+				error);
+			return error;
+		}
 	}
 
 	platform_set_drvdata(pdev, pwrkey);
@@ -289,7 +303,8 @@ static int pm8941_pwrkey_remove(struct platform_device *pdev)
 {
 	struct pm8941_pwrkey *pwrkey = platform_get_drvdata(pdev);
 
-	unregister_reboot_notifier(&pwrkey->reboot_notifier);
+	if (pwrkey->data->supports_ps_hold_poff_config)
+		unregister_reboot_notifier(&pwrkey->reboot_notifier);
 
 	return 0;
 }
@@ -297,16 +312,42 @@ static int pm8941_pwrkey_remove(struct platform_device *pdev)
 static const struct pm8941_data pwrkey_data = {
 	.pull_up_bit = PON_KPDPWR_PULL_UP,
 	.status_bit = PON_KPDPWR_N_SET,
+	.name = "pm8941_pwrkey",
+	.phys = "pm8941_pwrkey/input0",
+	.supports_ps_hold_poff_config = true,
+	.supports_debounce_config = true,
 };
 
 static const struct pm8941_data resin_data = {
 	.pull_up_bit = PON_RESIN_PULL_UP,
 	.status_bit = PON_RESIN_N_SET,
+	.name = "pm8941_resin",
+	.phys = "pm8941_resin/input0",
+	.supports_ps_hold_poff_config = true,
+	.supports_debounce_config = true,
+};
+
+static const struct pm8941_data pon_gen3_pwrkey_data = {
+	.status_bit = PON_GEN3_KPDPWR_N_SET,
+	.name = "pmic_pwrkey",
+	.phys = "pmic_pwrkey/input0",
+	.supports_ps_hold_poff_config = false,
+	.supports_debounce_config = false,
+};
+
+static const struct pm8941_data pon_gen3_resin_data = {
+	.status_bit = PON_GEN3_RESIN_N_SET,
+	.name = "pmic_resin",
+	.phys = "pmic_resin/input0",
+	.supports_ps_hold_poff_config = false,
+	.supports_debounce_config = false,
 };
 
 static const struct of_device_id pm8941_pwr_key_id_table[] = {
 	{ .compatible = "qcom,pm8941-pwrkey", .data = &pwrkey_data },
 	{ .compatible = "qcom,pm8941-resin", .data = &resin_data },
+	{ .compatible = "qcom,pmk8350-pwrkey", .data = &pon_gen3_pwrkey_data },
+	{ .compatible = "qcom,pmk8350-resin", .data = &pon_gen3_resin_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8941_pwr_key_id_table);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

