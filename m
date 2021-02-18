Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F831F13F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBRUm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhBRUkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:32 -0500
Date:   Thu, 18 Feb 2021 20:39:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdicK8riblfXNYYJlXt79kVHtidRebkF2kkcZRYd4HQ=;
        b=VLBP3Yd912chrKJlezCfPitNKv/eIzlqaGw8F/CGnPkx8/8mBBynTU+tTLbi11Jrlct+Ck
        VMzG5qL3wn3ZJLyKPQM0jsa06oPIA05DC/KR7ReJn6/IFvtqprPkoHLVYKdFBN3EvjbQ43
        NoGACiHYSYpoAZDAFFWTHnH8BLKVnd+INMQgj7rih1XjUIou1a49MP5XUpvkoZpne1XU7h
        ORowEygyjbulCg+WIjtPEVIkwdkMdCoBxHPD/jT1YfAvlhKtWe1Bm1cGm9+LBFGzuP6bd8
        00kfSdUO0y6EgLPexsZCn8gBll9rhmPvg9x2ZlwDB687or3FdCBMLVgdvv07WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdicK8riblfXNYYJlXt79kVHtidRebkF2kkcZRYd4HQ=;
        b=ayPWcNoJCYG6tQeyz2NFsCGkGM3O+r2nXpg/k09o80zcfjVT0ogw0EBdFw4ac8jTByJS3T
        QdeWiZNzS2gyU4CA==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: qcom-vadc-common: rewrite vadc7 die
 temp calculation
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-10-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-10-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078360.20312.11434002224259466980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3bd0ceb566f700adc5d164f431d1da039374aa97
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3bd0ceb566f700adc5d164f431d1da039374aa97
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:55:03 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:32:36 

iio: adc: qcom-vadc-common: rewrite vadc7 die temp calculation

qcom_vadc7_scale_hw_calib_die_temp() uses a table format different from
the rest of volt/temp conversion functions in this file. Also the
conversion functions results in non-monothonic values conversion, which
seems wrong.

Rewrite qcom_vadc7_scale_hw_calib_die_temp() to use
qcom_vadc_map_voltage_temp() directly, like the rest of conversion
functions do.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-10-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c       | 50 ++++++-----------------
 include/linux/iio/adc/qcom-vadc-common.h |  5 +--
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 45a3860..0c705bb 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -101,18 +101,18 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
 };
 
 static const struct vadc_map_pt adcmap7_die_temp[] = {
-	{ 433700, 1967},
-	{ 473100, 1964},
-	{ 512400, 1957},
-	{ 551500, 1949},
-	{ 590500, 1940},
-	{ 629300, 1930},
-	{ 667900, 1921},
-	{ 706400, 1910},
-	{ 744600, 1896},
-	{ 782500, 1878},
-	{ 820100, 1859},
-	{ 857300, 0},
+	{ 857300, 160000 },
+	{ 820100, 140000 },
+	{ 782500, 120000 },
+	{ 744600, 100000 },
+	{ 706400, 80000 },
+	{ 667900, 60000 },
+	{ 629300, 40000 },
+	{ 590500, 20000 },
+	{ 551500, 0 },
+	{ 512400, -20000 },
+	{ 473100, -40000 },
+	{ 433700, -60000 },
 };
 
 /*
@@ -585,33 +585,13 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
 				u16 adc_code, int *result_mdec)
 {
 
-	int voltage, vtemp0, temp, i;
+	int voltage;
 
 	voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
 				prescale, data, 1);
 
-	if (adcmap7_die_temp[0].x > voltage) {
-		*result_mdec = DIE_TEMP_ADC7_SCALE_1;
-		return 0;
-	}
-
-	if (adcmap7_die_temp[ARRAY_SIZE(adcmap7_die_temp) - 1].x <= voltage) {
-		*result_mdec = DIE_TEMP_ADC7_MAX;
-		return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(adcmap7_die_temp); i++)
-		if (adcmap7_die_temp[i].x > voltage)
-			break;
-
-	vtemp0 = adcmap7_die_temp[i - 1].x;
-	voltage = voltage - vtemp0;
-	temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
-		adcmap7_die_temp[i - 1].y);
-	temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i - 1));
-	*result_mdec = temp;
-
-	return 0;
+	return qcom_vadc_map_voltage_temp(adcmap7_die_temp, ARRAY_SIZE(adcmap7_die_temp),
+			voltage, result_mdec);
 }
 
 static int qcom_vadc_scale_hw_smb_temp(
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 1d337dd..5821612 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -54,11 +54,6 @@
 #define R_PU_100K				100000
 #define RATIO_MAX_ADC7				BIT(14)
 
-#define DIE_TEMP_ADC7_SCALE_1			-60000
-#define DIE_TEMP_ADC7_SCALE_2			20000
-#define DIE_TEMP_ADC7_SCALE_FACTOR		1000
-#define DIE_TEMP_ADC7_MAX			160000
-
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
  * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
