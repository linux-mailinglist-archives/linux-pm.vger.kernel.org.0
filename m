Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5C31F141
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBRUmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhBRUke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402AC061797
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:53 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UO5F5L6sbkiAW9q1FqzA1WNYhmeTJFRnMDOYGNHUoI=;
        b=iO5Qor+//TW+AL3W6Zps7P1YH2DEXNz9LuzRuzBBDQivmwfVCcY8YcTIe94zYYcl7Wztg/
        ILw6FVNJd1hsUaUbBSUEekqo1XvW0WvQffP5GiPcNNPLQ9ZwPogk4XVd4tB0j8iYCZwfCr
        iJZH9j9wJy7mV8ILEHKtT2aastutdoXqMTQoo23l4FK7PInpYZ77pbpzSQnfpLq5+mOiDJ
        Xijrv+0MzIUd/IdX8TcwgLdlDFboh3lDDg2oM2/y7VNYD3Rh6eCfHkJF+OiZ6eDgMpIk27
        cVw9xUlsib5y0cRUH/bj1baKhz91JYdUjYcqk49RkgFE7ovkHNdSLfXgHC3Lzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UO5F5L6sbkiAW9q1FqzA1WNYhmeTJFRnMDOYGNHUoI=;
        b=6TUDLCvCjGVgFO3NJDYyf5bq4U2/uYUjPtWuXB5eOVGeDmpWytdyU2eGDcIlUR4LwmFElP
        SPZ05xhcRL2tNYBA==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: move qcom-vadc-common.h to include dir
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-6-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078477.20312.15976516391676731569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ec82edb258bbf0233306cc45f65d4b6092243ee9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ec82edb258bbf0233306cc45f65d4b6092243ee9
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:54:59 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:20:56 

iio: adc: move qcom-vadc-common.h to include dir

qcom-vadc-common module will be used by ADC thermal monitoring driver,
so move it to global include dir.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-6-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c      |   3 +-
 drivers/iio/adc/qcom-spmi-adc5.c         |   2 +-
 drivers/iio/adc/qcom-spmi-vadc.c         |   3 +-
 drivers/iio/adc/qcom-vadc-common.c       |   3 +-
 drivers/iio/adc/qcom-vadc-common.h       | 185 +----------------------
 include/linux/iio/adc/qcom-vadc-common.h | 187 ++++++++++++++++++++++-
 6 files changed, 191 insertions(+), 192 deletions(-)
 delete mode 100644 drivers/iio/adc/qcom-vadc-common.h
 create mode 100644 include/linux/iio/adc/qcom-vadc-common.h

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 7e108da..0610bf2 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -10,6 +10,7 @@
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
@@ -21,8 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/regulator/consumer.h>
 
-#include "qcom-vadc-common.h"
-
 /*
  * Definitions for the "user processor" registers lifted from the v3.4
  * Qualcomm tree. Their kernel has two out-of-tree drivers for the ADC:
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c2da8f0..b10a0fc 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -19,7 +20,6 @@
 #include <linux/slab.h>
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
-#include "qcom-vadc-common.h"
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index b0388f8..05ff948 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -20,8 +21,6 @@
 
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
 
-#include "qcom-vadc-common.h"
-
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
 #define VADC_REVISION2_SUPPORTED_VADC		1
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 40d77b3..ee94774 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -3,14 +3,13 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/fixp-arith.h>
+#include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/units.h>
 
-#include "qcom-vadc-common.h"
-
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
 	{1758,	-40},
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
deleted file mode 100644
index 7e5f642..0000000
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ /dev/null
@@ -1,185 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Code shared between the different Qualcomm PMIC voltage ADCs
- */
-
-#ifndef QCOM_VADC_COMMON_H
-#define QCOM_VADC_COMMON_H
-
-#define VADC_CONV_TIME_MIN_US			2000
-#define VADC_CONV_TIME_MAX_US			2100
-
-/* Min ADC code represents 0V */
-#define VADC_MIN_ADC_CODE			0x6000
-/* Max ADC code represents full-scale range of 1.8V */
-#define VADC_MAX_ADC_CODE			0xa800
-
-#define VADC_ABSOLUTE_RANGE_UV			625000
-#define VADC_RATIOMETRIC_RANGE			1800
-
-#define VADC_DEF_PRESCALING			0 /* 1:1 */
-#define VADC_DEF_DECIMATION			0 /* 512 */
-#define VADC_DEF_HW_SETTLE_TIME			0 /* 0 us */
-#define VADC_DEF_AVG_SAMPLES			0 /* 1 sample */
-#define VADC_DEF_CALIB_TYPE			VADC_CALIB_ABSOLUTE
-
-#define VADC_DECIMATION_MIN			512
-#define VADC_DECIMATION_MAX			4096
-#define ADC5_DEF_VBAT_PRESCALING		1 /* 1:3 */
-#define ADC5_DECIMATION_SHORT			250
-#define ADC5_DECIMATION_MEDIUM			420
-#define ADC5_DECIMATION_LONG			840
-/* Default decimation - 1024 for rev2, 840 for pmic5 */
-#define ADC5_DECIMATION_DEFAULT			2
-#define ADC5_DECIMATION_SAMPLES_MAX		3
-
-#define VADC_HW_SETTLE_DELAY_MAX		10000
-#define VADC_HW_SETTLE_SAMPLES_MAX		16
-#define VADC_AVG_SAMPLES_MAX			512
-#define ADC5_AVG_SAMPLES_MAX			16
-
-#define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
-#define PMIC5_SMB_TEMP_CONSTANT			419400
-#define PMIC5_SMB_TEMP_SCALE_FACTOR		356
-
-#define PMI_CHG_SCALE_1				-138890
-#define PMI_CHG_SCALE_2				391750000000LL
-
-#define VADC5_MAX_CODE				0x7fff
-#define ADC5_FULL_SCALE_CODE			0x70e4
-#define ADC5_USR_DATA_CHECK			0x8000
-
-#define R_PU_100K				100000
-#define RATIO_MAX_ADC7				BIT(14)
-
-#define DIE_TEMP_ADC7_SCALE_1			-60000
-#define DIE_TEMP_ADC7_SCALE_2			20000
-#define DIE_TEMP_ADC7_SCALE_FACTOR		1000
-#define DIE_TEMP_ADC7_MAX			160000
-
-/**
- * struct vadc_map_pt - Map the graph representation for ADC channel
- * @x: Represent the ADC digitized code.
- * @y: Represent the physical data which can be temperature, voltage,
- *     resistance.
- */
-struct vadc_map_pt {
-	s32 x;
-	s32 y;
-};
-
-/*
- * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
- * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
- * calibration.
- */
-enum vadc_calibration {
-	VADC_CALIB_ABSOLUTE = 0,
-	VADC_CALIB_RATIOMETRIC
-};
-
-/**
- * struct vadc_linear_graph - Represent ADC characteristics.
- * @dy: numerator slope to calculate the gain.
- * @dx: denominator slope to calculate the gain.
- * @gnd: A/D word of the ground reference used for the channel.
- *
- * Each ADC device has different offset and gain parameters which are
- * computed to calibrate the device.
- */
-struct vadc_linear_graph {
-	s32 dy;
-	s32 dx;
-	s32 gnd;
-};
-
-/**
- * struct vadc_prescale_ratio - Represent scaling ratio for ADC input.
- * @num: the inverse numerator of the gain applied to the input channel.
- * @den: the inverse denominator of the gain applied to the input channel.
- */
-struct vadc_prescale_ratio {
-	u32 num;
-	u32 den;
-};
-
-/**
- * enum vadc_scale_fn_type - Scaling function to convert ADC code to
- *				physical scaled units for the channel.
- * SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
- * SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
- *				 Uses a mapping table with 100K pullup.
- * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
- * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
- * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
- * SCALE_HW_CALIB_DEFAULT: Default scaling to convert raw adc code to
- *	voltage (uV) with hardware applied offset/slope values to adc code.
- * SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
- *	lookup table. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
- *	100k pullup. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
- *	lookup table for PMIC7. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
- *	The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
- *	The hardware applies offset/slope to adc code. This is for PMIC7.
- * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
- *	charger temperature.
- * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
- *	SMB1390 temperature.
- */
-enum vadc_scale_fn_type {
-	SCALE_DEFAULT = 0,
-	SCALE_THERM_100K_PULLUP,
-	SCALE_PMIC_THERM,
-	SCALE_XOTHERM,
-	SCALE_PMI_CHG_TEMP,
-	SCALE_HW_CALIB_DEFAULT,
-	SCALE_HW_CALIB_THERM_100K_PULLUP,
-	SCALE_HW_CALIB_XOTHERM,
-	SCALE_HW_CALIB_THERM_100K_PU_PM7,
-	SCALE_HW_CALIB_PMIC_THERM,
-	SCALE_HW_CALIB_PMIC_THERM_PM7,
-	SCALE_HW_CALIB_PM5_CHG_TEMP,
-	SCALE_HW_CALIB_PM5_SMB_TEMP,
-	SCALE_HW_CALIB_INVALID,
-};
-
-struct adc5_data {
-	const u32	full_scale_code_volt;
-	const u32	full_scale_code_cur;
-	const struct adc5_channels *adc_chans;
-	const struct iio_info *info;
-	unsigned int	*decimation;
-	unsigned int	*hw_settle_1;
-	unsigned int	*hw_settle_2;
-};
-
-int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
-		    const struct vadc_linear_graph *calib_graph,
-		    const struct vadc_prescale_ratio *prescale,
-		    bool absolute,
-		    u16 adc_code, int *result_mdec);
-
-struct qcom_adc5_scale_type {
-	int (*scale_fn)(const struct vadc_prescale_ratio *prescale,
-		const struct adc5_data *data, u16 adc_code, int *result);
-};
-
-int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
-		    unsigned int prescale_ratio,
-		    const struct adc5_data *data,
-		    u16 adc_code, int *result_mdec);
-
-int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
-
-int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
-
-int qcom_adc5_avg_samples_from_dt(u32 value);
-
-int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation);
-
-int qcom_vadc_decimation_from_dt(u32 value);
-
-#endif /* QCOM_VADC_COMMON_H */
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
new file mode 100644
index 0000000..03a9119
--- /dev/null
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Code shared between the different Qualcomm PMIC voltage ADCs
+ */
+
+#ifndef QCOM_VADC_COMMON_H
+#define QCOM_VADC_COMMON_H
+
+#include <linux/types.h>
+
+#define VADC_CONV_TIME_MIN_US			2000
+#define VADC_CONV_TIME_MAX_US			2100
+
+/* Min ADC code represents 0V */
+#define VADC_MIN_ADC_CODE			0x6000
+/* Max ADC code represents full-scale range of 1.8V */
+#define VADC_MAX_ADC_CODE			0xa800
+
+#define VADC_ABSOLUTE_RANGE_UV			625000
+#define VADC_RATIOMETRIC_RANGE			1800
+
+#define VADC_DEF_PRESCALING			0 /* 1:1 */
+#define VADC_DEF_DECIMATION			0 /* 512 */
+#define VADC_DEF_HW_SETTLE_TIME			0 /* 0 us */
+#define VADC_DEF_AVG_SAMPLES			0 /* 1 sample */
+#define VADC_DEF_CALIB_TYPE			VADC_CALIB_ABSOLUTE
+
+#define VADC_DECIMATION_MIN			512
+#define VADC_DECIMATION_MAX			4096
+#define ADC5_DEF_VBAT_PRESCALING		1 /* 1:3 */
+#define ADC5_DECIMATION_SHORT			250
+#define ADC5_DECIMATION_MEDIUM			420
+#define ADC5_DECIMATION_LONG			840
+/* Default decimation - 1024 for rev2, 840 for pmic5 */
+#define ADC5_DECIMATION_DEFAULT			2
+#define ADC5_DECIMATION_SAMPLES_MAX		3
+
+#define VADC_HW_SETTLE_DELAY_MAX		10000
+#define VADC_HW_SETTLE_SAMPLES_MAX		16
+#define VADC_AVG_SAMPLES_MAX			512
+#define ADC5_AVG_SAMPLES_MAX			16
+
+#define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
+#define PMIC5_SMB_TEMP_CONSTANT			419400
+#define PMIC5_SMB_TEMP_SCALE_FACTOR		356
+
+#define PMI_CHG_SCALE_1				-138890
+#define PMI_CHG_SCALE_2				391750000000LL
+
+#define VADC5_MAX_CODE				0x7fff
+#define ADC5_FULL_SCALE_CODE			0x70e4
+#define ADC5_USR_DATA_CHECK			0x8000
+
+#define R_PU_100K				100000
+#define RATIO_MAX_ADC7				BIT(14)
+
+#define DIE_TEMP_ADC7_SCALE_1			-60000
+#define DIE_TEMP_ADC7_SCALE_2			20000
+#define DIE_TEMP_ADC7_SCALE_FACTOR		1000
+#define DIE_TEMP_ADC7_MAX			160000
+
+/**
+ * struct vadc_map_pt - Map the graph representation for ADC channel
+ * @x: Represent the ADC digitized code.
+ * @y: Represent the physical data which can be temperature, voltage,
+ *     resistance.
+ */
+struct vadc_map_pt {
+	s32 x;
+	s32 y;
+};
+
+/*
+ * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
+ * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
+ * calibration.
+ */
+enum vadc_calibration {
+	VADC_CALIB_ABSOLUTE = 0,
+	VADC_CALIB_RATIOMETRIC
+};
+
+/**
+ * struct vadc_linear_graph - Represent ADC characteristics.
+ * @dy: numerator slope to calculate the gain.
+ * @dx: denominator slope to calculate the gain.
+ * @gnd: A/D word of the ground reference used for the channel.
+ *
+ * Each ADC device has different offset and gain parameters which are
+ * computed to calibrate the device.
+ */
+struct vadc_linear_graph {
+	s32 dy;
+	s32 dx;
+	s32 gnd;
+};
+
+/**
+ * struct vadc_prescale_ratio - Represent scaling ratio for ADC input.
+ * @num: the inverse numerator of the gain applied to the input channel.
+ * @den: the inverse denominator of the gain applied to the input channel.
+ */
+struct vadc_prescale_ratio {
+	u32 num;
+	u32 den;
+};
+
+/**
+ * enum vadc_scale_fn_type - Scaling function to convert ADC code to
+ *				physical scaled units for the channel.
+ * SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
+ * SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
+ *				 Uses a mapping table with 100K pullup.
+ * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
+ * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
+ * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
+ * SCALE_HW_CALIB_DEFAULT: Default scaling to convert raw adc code to
+ *	voltage (uV) with hardware applied offset/slope values to adc code.
+ * SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
+ *	lookup table. The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
+ *	100k pullup. The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
+ *	lookup table for PMIC7. The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
+ *	The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
+ *	The hardware applies offset/slope to adc code. This is for PMIC7.
+ * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
+ *	charger temperature.
+ * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
+ *	SMB1390 temperature.
+ */
+enum vadc_scale_fn_type {
+	SCALE_DEFAULT = 0,
+	SCALE_THERM_100K_PULLUP,
+	SCALE_PMIC_THERM,
+	SCALE_XOTHERM,
+	SCALE_PMI_CHG_TEMP,
+	SCALE_HW_CALIB_DEFAULT,
+	SCALE_HW_CALIB_THERM_100K_PULLUP,
+	SCALE_HW_CALIB_XOTHERM,
+	SCALE_HW_CALIB_THERM_100K_PU_PM7,
+	SCALE_HW_CALIB_PMIC_THERM,
+	SCALE_HW_CALIB_PMIC_THERM_PM7,
+	SCALE_HW_CALIB_PM5_CHG_TEMP,
+	SCALE_HW_CALIB_PM5_SMB_TEMP,
+	SCALE_HW_CALIB_INVALID,
+};
+
+struct adc5_data {
+	const u32	full_scale_code_volt;
+	const u32	full_scale_code_cur;
+	const struct adc5_channels *adc_chans;
+	const struct iio_info *info;
+	unsigned int	*decimation;
+	unsigned int	*hw_settle_1;
+	unsigned int	*hw_settle_2;
+};
+
+int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
+		    const struct vadc_linear_graph *calib_graph,
+		    const struct vadc_prescale_ratio *prescale,
+		    bool absolute,
+		    u16 adc_code, int *result_mdec);
+
+struct qcom_adc5_scale_type {
+	int (*scale_fn)(const struct vadc_prescale_ratio *prescale,
+		const struct adc5_data *data, u16 adc_code, int *result);
+};
+
+int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
+		    unsigned int prescale_ratio,
+		    const struct adc5_data *data,
+		    u16 adc_code, int *result_mdec);
+
+int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
+
+int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
+
+int qcom_adc5_avg_samples_from_dt(u32 value);
+
+int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation);
+
+int qcom_vadc_decimation_from_dt(u32 value);
+
+#endif /* QCOM_VADC_COMMON_H */
