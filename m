Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71611DE5C7
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgEVLpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 07:45:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:13748 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729016AbgEVLpm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 07:45:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590147941; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AnR/ORUWsLt+1AJXmqnKAUo2zYTTrRNNSjBzs8iR+rg=; b=L4EJYsTLSMQTsbTXblFKLtVZwvaR1SKjpyLDhI81Lbia76UT5kqeq+RszDGOsJpsADWOekhe
 KSvvkecT0OJXawvwkgOy8MjKdrbxUjSz1W2hk/OxvlJYX38+l02CECCjY8JYNmTDk2GRB/AH
 hEFgoTQwCcp7TroSlS7lYScM00M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec7bb51.7fad28751e68-smtp-out-n03;
 Fri, 22 May 2020 11:45:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4068CC433CB; Fri, 22 May 2020 11:45:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A059DC433C8;
        Fri, 22 May 2020 11:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A059DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=manafm@codeaurora.org
From:   Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Subject: [PATCH v3 1/2] drivers: thermal: tsens: Add cold interrupt support
Date:   Fri, 22 May 2020 17:14:51 +0530
Message-Id: <20200522114452.28647-2-manafm@codeaurora.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522114452.28647-1-manafm@codeaurora.org>
References: <20200522114452.28647-1-manafm@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.6+ adds cold interrupt support. It triggers set
interrupt when aggregated minimum temperature of all TSENS falls
below cold preset threshold, 5 degree Celsius and triggers
reset interrupt when aggregated minimum temperature of all TSENS
crosses above reset threshold, 10 degree Celsius. These threshold
values could change in boot firmware code. Add support for this
interrupt in the driver.

It adds another virtual sensor to the of-thermal along with all
individual TSENS. This cold sensor only gives cold state value of
1 or 0 for successful temperature read. A state value of 1 indicates
minimum one TSENS is in cold temperature condition and state value
of 0 indicates all TSENS are out of cold temperature condition.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
---
 drivers/thermal/qcom/tsens-v2.c |   5 ++
 drivers/thermal/qcom/tsens.c    | 112 +++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.h    |  11 ++++
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index b293ed32174b..1692e636d3bd 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -23,6 +23,7 @@
 #define TM_Sn_UPPER_LOWER_THRESHOLD_OFF 0x0020
 #define TM_Sn_CRITICAL_THRESHOLD_OFF	0x0060
 #define TM_Sn_STATUS_OFF		0x00a0
+#define TM_COLD_INT_STATUS_OFF		0x00e0
 #define TM_TRDY_OFF			0x00e4
 #define TM_WDOG_LOG_OFF		0x013c
 
@@ -86,6 +87,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	REG_FIELD_FOR_EACH_SENSOR16(CRITICAL_STATUS, TM_Sn_STATUS_OFF, 19,  19),
 	REG_FIELD_FOR_EACH_SENSOR16(MAX_STATUS,      TM_Sn_STATUS_OFF, 20,  20),
 
+	/* COLD INTERRUPT STATUS */
+	[COLD_STATUS] = REG_FIELD(TM_COLD_INT_STATUS_OFF, 0, 0),
+
 	/* TRDY: 1=ready, 0=in progress */
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
@@ -93,6 +97,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
+	.get_cold_status  = get_cold_int_status,
 };
 
 struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 8d3e94d2a9ed..ee93e9d07678 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -205,7 +205,8 @@ static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
 		index = LOW_INT_CLEAR_0 + hw_id;
 		break;
 	case CRITICAL:
-		/* No critical interrupts before v2 */
+	case COLD:
+		/* No critical and cold interrupts before v2 */
 		return;
 	}
 	regmap_field_write(priv->rf[index], enable ? 0 : 1);
@@ -236,6 +237,9 @@ static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
 		index_mask  = CRIT_INT_MASK_0 + hw_id;
 		index_clear = CRIT_INT_CLEAR_0 + hw_id;
 		break;
+	case COLD:
+		/* Nothing to handle for cold interrupt */
+		return;
 	}
 
 	if (enable) {
@@ -367,6 +371,35 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 	return 0;
 }
 
+/**
+ * tsens_cold_irq_thread - Threaded interrupt handler for cold interrupt
+ * @irq: irq number
+ * @data: tsens controller private data
+ *
+ * Whenever interrupt triggers notify thermal framework using
+ * thermal_zone_device_update().
+ *
+ * Return: IRQ_HANDLED
+ */
+
+irqreturn_t tsens_cold_irq_thread(int irq, void *data)
+{
+	struct tsens_priv *priv = data;
+	struct tsens_sensor *s = priv->cold_sensor;
+	int cold_status, ret;
+
+	ret = regmap_field_read(priv->rf[COLD_STATUS], &cold_status);
+	if (ret)
+		return ret;
+
+	dev_dbg(priv->dev, "[%u] %s: cold interrupt is %s\n",
+		s->hw_id, __func__, cold_status ? "triggered" : "cleared");
+
+	thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * tsens_critical_irq_thread() - Threaded handler for critical interrupts
  * @irq: irq number
@@ -575,6 +608,20 @@ void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
+int get_cold_int_status(const struct tsens_sensor *s, bool *cold_status)
+{
+	struct tsens_priv *priv = s->priv;
+	int prev_cold = 0, ret;
+
+	ret = regmap_field_read(priv->rf[COLD_STATUS], &prev_cold);
+	if (ret)
+		return ret;
+
+	*cold_status = (bool)prev_cold;
+
+	return 0;
+}
+
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
@@ -843,6 +890,19 @@ int __init init_common(struct tsens_priv *priv)
 		regmap_field_write(priv->rf[CC_MON_MASK], 1);
 	}
 
+	if (tsens_version(priv) > VER_1_X &&  ver_minor > 5) {
+		/* COLD interrupt is present only on v2.6+ */
+		priv->feat->cold_int = 1;
+		priv->rf[COLD_STATUS] = devm_regmap_field_alloc(
+						dev,
+						priv->tm_map,
+						priv->fields[COLD_STATUS]);
+		if (IS_ERR(priv->rf[COLD_STATUS])) {
+			ret = PTR_ERR(priv->rf[COLD_STATUS]);
+			goto err_put_device;
+		}
+	}
+
 	spin_lock_init(&priv->ul_lock);
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
@@ -852,6 +912,30 @@ int __init init_common(struct tsens_priv *priv)
 	return ret;
 }
 
+/**
+ * tsens_get_cold_status - It gets cold temperature status of TSENS
+ * @data: tsens cold sensor private data
+ * @cold_status: pointer to store last cold interrupt status
+ *
+ * It gives cold state value of 0 or 1 on success. A state
+ * value of 1 indicates minimum one TSENS is in cold temperature
+ * condition and a state value of 0 indicates all TSENS are out of
+ * cold temperature condition.
+ *
+ * Return: 0 on success, a negative errno will be returned in
+ * error cases.
+ */
+static int tsens_get_cold_status(void *data, int *cold_status)
+{
+	struct tsens_sensor *s = data;
+	struct tsens_priv *priv = s->priv;
+
+	if (priv->ops->get_cold_status)
+		return priv->ops->get_cold_status(s, (bool *)cold_status);
+
+	return -ENOTSUPP;
+}
+
 static int tsens_get_temp(void *data, int *temp)
 {
 	struct tsens_sensor *s = data;
@@ -923,6 +1007,10 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.set_trips = tsens_set_trips,
 };
 
+static const struct thermal_zone_of_device_ops tsens_cold_of_ops = {
+	.get_temp = tsens_get_cold_status,
+};
+
 static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 			      irq_handler_t thread_fn)
 {
@@ -980,6 +1068,28 @@ static int tsens_register(struct tsens_priv *priv)
 		ret = tsens_register_irq(priv, "critical",
 					 tsens_critical_irq_thread);
 
+	if (priv->feat->cold_int) {
+		priv->cold_sensor = devm_kzalloc(priv->dev,
+					sizeof(struct tsens_sensor),
+					GFP_KERNEL);
+		if (!priv->cold_sensor)
+			return -ENOMEM;
+
+		priv->cold_sensor->hw_id = COLD_SENSOR_HW_ID;
+		priv->cold_sensor->priv = priv;
+		tzd = devm_thermal_zone_of_sensor_register(priv->dev,
+					priv->cold_sensor->hw_id,
+					priv->cold_sensor,
+					&tsens_cold_of_ops);
+		if (IS_ERR(tzd)) {
+			ret = 0;
+			return ret;
+		}
+
+		priv->cold_sensor->tzd = tzd;
+		ret = tsens_register_irq(priv, "cold", tsens_cold_irq_thread);
+	}
+
 	return ret;
 }
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 59d01162c66a..be532fabef30 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -15,6 +15,7 @@
 #define SLOPE_DEFAULT		3200
 #define THRESHOLD_MAX_ADC_CODE	0x3ff
 #define THRESHOLD_MIN_ADC_CODE	0x0
+#define COLD_SENSOR_HW_ID	128
 
 #include <linux/interrupt.h>
 #include <linux/thermal.h>
@@ -34,6 +35,7 @@ enum tsens_irq_type {
 	LOWER,
 	UPPER,
 	CRITICAL,
+	COLD,
 };
 
 /**
@@ -64,6 +66,7 @@ struct tsens_sensor {
  * @suspend: Function to suspend the tsens device
  * @resume: Function to resume the tsens device
  * @get_trend: Function to get the thermal/temp trend
+ * @get_cold_status: Function to get the cold interrupt status
  */
 struct tsens_ops {
 	/* mandatory callbacks */
@@ -76,6 +79,7 @@ struct tsens_ops {
 	int (*suspend)(struct tsens_priv *priv);
 	int (*resume)(struct tsens_priv *priv);
 	int (*get_trend)(struct tsens_sensor *s, enum thermal_trend *trend);
+	int (*get_cold_status)(const struct tsens_sensor *s, bool *cold_status);
 };
 
 #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
@@ -485,6 +489,8 @@ enum regfield_ids {
 	MAX_STATUS_14,
 	MAX_STATUS_15,
 
+	COLD_STATUS,		/* COLD interrupt status */
+
 	/* Keep last */
 	MAX_REGFIELDS
 };
@@ -497,6 +503,7 @@ enum regfield_ids {
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
  * @has_watchdog: does this IP support watchdog functionality?
+ * @cold_int: does this IP support COLD interrupt ?
  * @max_sensors: maximum sensors supported by this version of the IP
  */
 struct tsens_features {
@@ -505,6 +512,7 @@ struct tsens_features {
 	unsigned int adc:1;
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
+	unsigned int cold_int:1;
 	unsigned int max_sensors;
 };
 
@@ -551,6 +559,7 @@ struct tsens_context {
  * @ops: pointer to list of callbacks supported by this device
  * @debug_root: pointer to debugfs dentry for all tsens
  * @debug: pointer to debugfs dentry for tsens controller
+ * @cold_sensor: pointer to cold sensor attached to this device
  * @sensor: list of sensors attached to this device
  */
 struct tsens_priv {
@@ -571,6 +580,7 @@ struct tsens_priv {
 
 	struct dentry			*debug_root;
 	struct dentry			*debug;
+	struct tsens_sensor		*cold_sensor;
 
 	struct tsens_sensor		sensor[];
 };
@@ -580,6 +590,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
+int get_cold_int_status(const struct tsens_sensor *s, bool *cold_status);
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
-- 
2.26.2
