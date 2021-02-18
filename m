Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3128E31F146
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBRUnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:43:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhBRUkg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:36 -0500
Date:   Thu, 18 Feb 2021 20:39:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRHbDDCdXD6rw64W2X1zRNdWT8OOjhKATTvNOTSCUF8=;
        b=JzephqNjbGdfbZfpFsWn5hgEhH4E2cC/u9J/BCl9r7MSYPIzbgrfJ0zfIniKAumotuSzPS
        FHY04i6mok2leHv+duF06P/qHIQEdnXdm2qiSFTp/d0NIS+0my5KD6OVQQBViv3mvG4pXP
        YS+dxBNIGi12OLhcrtieFRGodRheFGN6p7IFiUsTb0gH2F6KvrFcGHavw+DHNJdvs5DcBv
        RHvSK+KE06JFA+a9wehmo2G/jeDkWY06OGJYTCtP4V+k8JnZdQ8lH7zAMI/9RNqK5dw+AB
        GOQ2304CFFOFvyzv25ZVIczjHO2JuTh9crUHoAoFrVdQk+pjyNWHa/XjUuqeAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRHbDDCdXD6rw64W2X1zRNdWT8OOjhKATTvNOTSCUF8=;
        b=apEdGyyTWhW1/DiJFl7Z/ZMTJY4xsX1EQDAl2GAE3sCH0Fls4UKo4UQ9wCVWqKrcsrD3Mh
        5ifd2JOLDgGvAnAQ==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: qcom-vadc: move several adc5
 functions to common file
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-4-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078526.20312.4286362677976331479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c7ba98fc404305c6f27a8cca4d793cf668a7bfc7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c7ba98fc404305c6f27a8cca4d793cf668a7bfc7
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:54:57 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:17:26 

iio: adc: qcom-vadc: move several adc5 functions to common file

ADC-TM5 driver will make use of several functions from ADC5 driver. Move
them to qcom-vadc-common driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-4-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c   | 75 ++---------------------------
 drivers/iio/adc/qcom-vadc-common.c | 68 +++++++++++++++++++++++++-
 drivers/iio/adc/qcom-vadc-common.h | 10 +++-
 3 files changed, 82 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c10aa28..c2da8f0 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -154,18 +154,6 @@ struct adc5_chip {
 	const struct adc5_data	*data;
 };
 
-static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
-	{.num =  1, .den =  1},
-	{.num =  1, .den =  3},
-	{.num =  1, .den =  4},
-	{.num =  1, .den =  6},
-	{.num =  1, .den = 20},
-	{.num =  1, .den =  8},
-	{.num = 10, .den = 81},
-	{.num =  1, .den = 10},
-	{.num =  1, .den = 16}
-};
-
 static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
@@ -181,55 +169,6 @@ static int adc5_masked_write(struct adc5_chip *adc, u16 offset, u8 mask, u8 val)
 	return regmap_update_bits(adc->regmap, adc->base + offset, mask, val);
 }
 
-static int adc5_prescaling_from_dt(u32 num, u32 den)
-{
-	unsigned int pre;
-
-	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
-		if (adc5_prescale_ratios[pre].num == num &&
-		    adc5_prescale_ratios[pre].den == den)
-			break;
-
-	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
-		return -EINVAL;
-
-	return pre;
-}
-
-static int adc5_hw_settle_time_from_dt(u32 value,
-					const unsigned int *hw_settle)
-{
-	unsigned int i;
-
-	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
-		if (value == hw_settle[i])
-			return i;
-	}
-
-	return -EINVAL;
-}
-
-static int adc5_avg_samples_from_dt(u32 value)
-{
-	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
-		return -EINVAL;
-
-	return __ffs(value);
-}
-
-static int adc5_decimation_from_dt(u32 value,
-					const unsigned int *decimation)
-{
-	unsigned int i;
-
-	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
-		if (value == decimation[i])
-			return i;
-	}
-
-	return -EINVAL;
-}
-
 static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
 {
 	int ret;
@@ -511,7 +450,7 @@ static int adc_read_raw_common(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
-			&adc5_prescale_ratios[prop->prescale],
+			prop->prescale,
 			adc->data,
 			adc_code_volt, val);
 		if (ret)
@@ -717,7 +656,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32(node, "qcom,decimation", &value);
 	if (!ret) {
-		ret = adc5_decimation_from_dt(value, data->decimation);
+		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid decimation %d\n",
 				chan, value);
@@ -730,7 +669,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
 	if (!ret) {
-		ret = adc5_prescaling_from_dt(varr[0], varr[1]);
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
 				chan, varr[0], varr[1]);
@@ -759,11 +698,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
 			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
 			adc->data->info == &adc7_info)
-			ret = adc5_hw_settle_time_from_dt(value,
-							data->hw_settle_2);
+			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_2);
 		else
-			ret = adc5_hw_settle_time_from_dt(value,
-							data->hw_settle_1);
+			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
 
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid hw-settle-time %d us\n",
@@ -777,7 +714,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
 	if (!ret) {
-		ret = adc5_avg_samples_from_dt(value);
+		ret = qcom_adc5_avg_samples_from_dt(value);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid avg-samples %d\n",
 				chan, value);
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 5113aaa..d11f334 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -278,6 +278,18 @@ static const struct vadc_map_pt adcmap7_100k[] = {
 	{ 2420, 130048 }
 };
 
+static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
+	{.num =  1, .den =  1},
+	{.num =  1, .den =  3},
+	{.num =  1, .den =  4},
+	{.num =  1, .den =  6},
+	{.num =  1, .den = 20},
+	{.num =  1, .den =  8},
+	{.num = 10, .den = 81},
+	{.num =  1, .den = 10},
+	{.num =  1, .den = 16}
+};
+
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
@@ -647,10 +659,12 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 EXPORT_SYMBOL(qcom_vadc_scale);
 
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
-		    const struct vadc_prescale_ratio *prescale,
+		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result)
 {
+	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
+
 	if (!(scaletype >= SCALE_HW_CALIB_DEFAULT &&
 		scaletype < SCALE_HW_CALIB_INVALID)) {
 		pr_err("Invalid scale type %d\n", scaletype);
@@ -662,6 +676,58 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 }
 EXPORT_SYMBOL(qcom_adc5_hw_scale);
 
+int qcom_adc5_prescaling_from_dt(u32 num, u32 den)
+{
+	unsigned int pre;
+
+	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
+		if (adc5_prescale_ratios[pre].num == num &&
+		    adc5_prescale_ratios[pre].den == den)
+			break;
+
+	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
+		return -EINVAL;
+
+	return pre;
+}
+EXPORT_SYMBOL(qcom_adc5_prescaling_from_dt);
+
+int qcom_adc5_hw_settle_time_from_dt(u32 value,
+				     const unsigned int *hw_settle)
+{
+	unsigned int i;
+
+	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
+		if (value == hw_settle[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(qcom_adc5_hw_settle_time_from_dt);
+
+int qcom_adc5_avg_samples_from_dt(u32 value)
+{
+	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
+		return -EINVAL;
+
+	return __ffs(value);
+}
+EXPORT_SYMBOL(qcom_adc5_avg_samples_from_dt);
+
+int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
+{
+	unsigned int i;
+
+	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
+		if (value == decimation[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
+
 int qcom_vadc_decimation_from_dt(u32 value)
 {
 	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index 17b2fc4..7e5f642 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -168,10 +168,18 @@ struct qcom_adc5_scale_type {
 };
 
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
-		    const struct vadc_prescale_ratio *prescale,
+		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result_mdec);
 
+int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
+
+int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
+
+int qcom_adc5_avg_samples_from_dt(u32 value);
+
+int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation);
+
 int qcom_vadc_decimation_from_dt(u32 value);
 
 #endif /* QCOM_VADC_COMMON_H */
