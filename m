Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEF4317BE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhJRLsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 07:48:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhJRLsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 07:48:14 -0400
Date:   Mon, 18 Oct 2021 11:46:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634557562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/Hdl2TU5fqUAMbLOr2aomo5EJUHcrPK7NCk7OD0GFI=;
        b=V4Afb+YZyHpMtF11ww/cZOLFKcKFZhf7+kn35Mi2+iKDzZ5v3N/BfK0cUikOsI85DL0ERB
        eKXCrzjbFbmtTbk5KvTlHiJog0qiBw5HfMdtZteUC7r9srKG/gwioWmcqrDZxS0kBF4L94
        EnadwZOSGZ+LT+bdPlm9CFfGbB2hazGGdEE9rWVYw5sgaa5CNfQdwdfIBpwP8d9FrksCTO
        vIDSm8vrmHWXZJXKqFY5md7aKxaswOSEoEij3pu87ssTwVCoF7RCyLFmCe/W2i9FWQZsaN
        ZoFEAKn6PgYck2LQTLC2kjF7ffXLFwv1iqhU/8fyEpBBMFRVijXoHyrJUdYWNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634557562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/Hdl2TU5fqUAMbLOr2aomo5EJUHcrPK7NCk7OD0GFI=;
        b=Hze5wOpYcPeRrIHnZNiCwOloHvL90oUjBhOd7Qm7spbFpow75Y6jzJ3NO6yAM+ayy6CEnM
        ZmXSeQKhg02SI/Bg==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/spmi-adc-tm5: Add
 support for HC variant
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211005032531.2251928-3-bjorn.andersson@linaro.org>
References: <20211005032531.2251928-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <163455756138.25758.3764629610427523719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f6c83676c6097d3f21895b360a03804f810e6d54
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f6c83676c6097d3f21895b360a03804f810e6d54
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Mon, 04 Oct 2021 20:25:29 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 15 Oct 2021 09:13:55 +02:00

thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant

The variant of the ADC Thermal Monitor block found in e.g. PM8998 is
"HC", add support for this variant to the ADC TM5 driver in order to
support using VADC channels as thermal_zones on SDM845 et al.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20211005032531.2251928-3-bjorn.andersson@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 41 ++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 8494cc0..824671c 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -82,6 +82,7 @@ struct adc_tm5_data {
 	const u32	full_scale_code_volt;
 	unsigned int	*decimation;
 	unsigned int	*hw_settle;
+	bool		is_hc;
 };
 
 enum adc_tm5_cal_method {
@@ -146,6 +147,14 @@ static const struct adc_tm5_data adc_tm5_data_pmic = {
 					 64000, 128000 },
 };
 
+static const struct adc_tm5_data adc_tm_hc_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 256, 512, 1024 },
+	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 6000, 8000, 10000 },
+	.is_hc = true,
+};
+
 static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
@@ -375,6 +384,29 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 	return 0;
 }
 
+static int adc_tm_hc_init(struct adc_tm5_chip *chip)
+{
+	unsigned int i;
+	u8 buf[2];
+	int ret;
+
+	for (i = 0; i < chip->nchannels; i++) {
+		if (chip->channels[i].channel >= ADC_TM5_NUM_CHANNELS) {
+			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
+			return -EINVAL;
+		}
+	}
+
+	buf[0] = chip->decimation;
+	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
+
+	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
+	if (ret)
+		dev_err(chip->dev, "block write failed: %d\n", ret);
+
+	return ret;
+}
+
 static int adc_tm5_init(struct adc_tm5_chip *chip)
 {
 	u8 buf[4], channels_available;
@@ -591,7 +623,10 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = adc_tm5_init(adc_tm);
+	if (adc_tm->data->is_hc)
+		ret = adc_tm_hc_init(adc_tm);
+	else
+		ret = adc_tm5_init(adc_tm);
 	if (ret) {
 		dev_err(dev, "adc-tm init failed\n");
 		return ret;
@@ -612,6 +647,10 @@ static const struct of_device_id adc_tm5_match_table[] = {
 		.compatible = "qcom,spmi-adc-tm5",
 		.data = &adc_tm5_data_pmic,
 	},
+	{
+		.compatible = "qcom,spmi-adc-tm-hc",
+		.data = &adc_tm_hc_data_pmic,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
