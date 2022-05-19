Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DB52D2D4
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiESMo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiESMo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17858BA98C
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:26 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eet7rvOHWkqhtE2/4yXDEbCSGMQpXOOYCewgC3zJlA=;
        b=VSFOfb7FGiVQjbVVLcZ7lWPiT7SNikoLabNkdKblvV89a3mYpl/gqI2iWEpzzeSl+ZyUtb
        hN0Pd1oTcRtqUq7PFNxw90FN9xVlIAma7EMDcwngQBQ3/Wju9uXKI7VfC8xLwk0MpIjtvP
        02l4CRiO0LcFfRtj/69Af+eeePTMkuJZI/62CN664v6xkVOsM26hrf89bn30DYM9Hi8pBG
        zGjzPG55jsoalpTAf0g9S98uaK81J2D3KHhHGCevkrWS4CrWuoAEzJGY25r68fN3d4Kdjz
        QauEINvtHOriSXsVtCBh85fyGUyZ0MzrWMTvwh2+rfEMnFZQ+ZVKKZPPHjpLow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eet7rvOHWkqhtE2/4yXDEbCSGMQpXOOYCewgC3zJlA=;
        b=2h5av2u1Sq7265CL8KKqxkOaf7051O+3KP2ANt+8u0yPu46rjoB4GNrOdSKwzn4O4/OTGi
        zDuPQbl/qK8guICA==
From:   "thermal-bot for Jishnu Prakash" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom: Add support for
 multiple generations of devices
Cc:     Jishnu Prakash <quic_jprakash@quicinc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1648991869-20899-4-git-send-email-quic_jprakash@quicinc.com>
References: <1648991869-20899-4-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Message-ID: <165296426351.4207.3815020867955144179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     7e70a89a3a08c515fe7e64ef3200d31faaf8d5ac
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7e70a89a3a08c515fe7e64ef3200d31faaf8d5ac
Author:        Jishnu Prakash <quic_jprakash@quicinc.com>
AuthorDate:    Sun, 03 Apr 2022 18:47:48 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

thermal/drivers/qcom: Add support for multiple generations of devices

Refactor code to support multiple generations of ADC_TM devices
by defining gen number, irq name and disable, configure, isr and
init APIs in the individual data structs.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/1648991869-20899-4-git-send-email-quic_jprakash@quicinc.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 82 ++++++++++++++---------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 824671c..6d8fcf2 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -78,11 +78,10 @@ enum adc5_timer_select {
 	ADC5_TIMER_SEL_NONE,
 };
 
-struct adc_tm5_data {
-	const u32	full_scale_code_volt;
-	unsigned int	*decimation;
-	unsigned int	*hw_settle;
-	bool		is_hc;
+enum adc5_gen {
+	ADC_TM5,
+	ADC_TM_HC,
+	ADC_TM5_MAX
 };
 
 enum adc_tm5_cal_method {
@@ -92,6 +91,19 @@ enum adc_tm5_cal_method {
 };
 
 struct adc_tm5_chip;
+struct adc_tm5_channel;
+
+struct adc_tm5_data {
+	const u32 full_scale_code_volt;
+	unsigned int *decimation;
+	unsigned int *hw_settle;
+	int (*disable_channel)(struct adc_tm5_channel *channel);
+	int (*configure)(struct adc_tm5_channel *channel, int low, int high);
+	irqreturn_t (*isr)(int irq, void *data);
+	int (*init)(struct adc_tm5_chip *chip);
+	char *irq_name;
+	int gen;
+};
 
 /**
  * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
@@ -139,22 +151,6 @@ struct adc_tm5_chip {
 	u16			base;
 };
 
-static const struct adc_tm5_data adc_tm5_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
-	.decimation = (unsigned int []) { 250, 420, 840 },
-	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
-					 1000, 2000, 4000, 8000, 16000, 32000,
-					 64000, 128000 },
-};
-
-static const struct adc_tm5_data adc_tm_hc_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
-	.decimation = (unsigned int []) { 256, 512, 1024 },
-	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
-					 1000, 2000, 4000, 6000, 8000, 10000 },
-	.is_hc = true,
-};
-
 static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
@@ -343,14 +339,14 @@ static int adc_tm5_set_trips(void *data, int low, int high)
 		channel->channel, low, high);
 
 	if (high == INT_MAX && low <= -INT_MAX)
-		ret = adc_tm5_disable_channel(channel);
+		ret = chip->data->disable_channel(channel);
 	else
-		ret = adc_tm5_configure(channel, low, high);
+		ret = chip->data->configure(channel, low, high);
 
 	return ret;
 }
 
-static struct thermal_zone_of_device_ops adc_tm5_ops = {
+static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
 	.get_temp = adc_tm5_get_temp,
 	.set_trips = adc_tm5_set_trips,
 };
@@ -366,7 +362,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
 							   adc_tm->channels[i].channel,
 							   &adc_tm->channels[i],
-							   &adc_tm5_ops);
+							   &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
 				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
@@ -526,6 +522,33 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 	return 0;
 }
 
+static const struct adc_tm5_data adc_tm5_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 250, 420, 840 },
+	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 8000, 16000, 32000,
+					 64000, 128000 },
+	.disable_channel = adc_tm5_disable_channel,
+	.configure = adc_tm5_configure,
+	.isr = adc_tm5_isr,
+	.init = adc_tm5_init,
+	.irq_name = "pm-adc-tm5",
+	.gen = ADC_TM5,
+};
+
+static const struct adc_tm5_data adc_tm_hc_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 256, 512, 1024 },
+	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 6000, 8000, 10000 },
+	.disable_channel = adc_tm5_disable_channel,
+	.configure = adc_tm5_configure,
+	.isr = adc_tm5_isr,
+	.init = adc_tm_hc_init,
+	.irq_name = "pm-adc-tm5",
+	.gen = ADC_TM_HC,
+};
+
 static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
 {
 	struct adc_tm5_channel *channels;
@@ -623,10 +646,7 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (adc_tm->data->is_hc)
-		ret = adc_tm_hc_init(adc_tm);
-	else
-		ret = adc_tm5_init(adc_tm);
+	ret = adc_tm->data->init(adc_tm);
 	if (ret) {
 		dev_err(dev, "adc-tm init failed\n");
 		return ret;
@@ -638,8 +658,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
-					 IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
+	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
+			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
 }
 
 static const struct of_device_id adc_tm5_match_table[] = {
