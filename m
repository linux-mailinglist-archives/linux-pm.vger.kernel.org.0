Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2558836CBE5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbhD0TpN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhD0TpN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:13 -0400
Date:   Tue, 27 Apr 2021 19:44:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wimLexVTC9ydWMndwLyV2to4/Kc5k9Pt2DB5qNlvLQ8=;
        b=cIPB5qozfCERRB0uKa9vWfplQe5m6tlWYgrtFL47bwLm2oekb5DjMSHggjUI3b0Xma64ID
        EogzH8cPSZ1SU2JDDi+F5N88ccrovdLhmGvJ+X2QUR/pVPOMExT2xx/lqYSpH2CWNwnz4x
        yW2jRaMwGn1XKCmnO5ukSShq1TaVhfVgN2xLEzjiXXS9cdrhgcJKtvh3uLaeLWiGAsMy0f
        TmmqSKbC9ow4QWE8eVyDvJd6zyH6rYN6JJdryUFZr6e43z9pzPmhbM6JEQtEty0x3QxsI6
        IaJe/HyEF4oXjaN4mDlGOgPvVHa7JFgUDedAvaErAezXBg2E7bB/y6J7PyVpZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wimLexVTC9ydWMndwLyV2to4/Kc5k9Pt2DB5qNlvLQ8=;
        b=ZnmjwJSr3Q/g1CSjbriueuo+ay/dX3Fn7UC/BPhJoCNa5bZKktjgpNamzF7BH8dPHTnNET
        aFUrluHrzIWJ6TCg==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Add VER_0 tsens version
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210420183343.2272-4-ansuelsmth@gmail.com>
References: <20210420183343.2272-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161955266826.29796.17113524831057161892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     53e2a20e4c41683b695145436b34aa4a14bbcd8c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//53e2a20e4c41683b695145436b34aa4a14bbcd8c
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:33:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 14:09:14 +02:00

thermal/drivers/tsens: Add VER_0 tsens version

VER_0 is used to describe device based on tsens version before v0.1.
These device are devices based on msm8960 for example apq8064 or
ipq806x. Add support for VER_0 in tsens.c and set the right tsens feat
in tsens-8960.c file.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210420183343.2272-4-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens-8960.c |   9 ++-
 drivers/thermal/qcom/tsens.c      | 150 +++++++++++++++++++++++------
 drivers/thermal/qcom/tsens.h      |   4 +-
 3 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8=
960.c
index 0d0c264..0dd15e8 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -347,8 +347,17 @@ static const struct tsens_ops ops_8960 =3D {
 	.resume		=3D resume_8960,
 };
=20
+static struct tsens_features tsens_8960_feat =3D {
+	.ver_major	=3D VER_0,
+	.crit_int	=3D 0,
+	.adc		=3D 1,
+	.srot_split	=3D 0,
+	.max_sensors	=3D 11,
+};
+
 struct tsens_plat_data data_8960 =3D {
 	.num_sensors	=3D 11,
 	.ops		=3D &ops_8960,
+	.feat		=3D &tsens_8960_feat,
 	.fields		=3D tsens_8960_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d6f8021..83e01cb 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
@@ -516,6 +517,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
 				hw_id, __func__, temp);
 		}
+
+		if (tsens_version(priv) < VER_0_1) {
+			/* Constraint: There is only 1 interrupt control register for all
+			 * 11 temperature sensor. So monitoring more than 1 sensor based
+			 * on interrupts will yield inconsistent result. To overcome this
+			 * issue we will monitor only sensor 0 which is the master sensor.
+			 */
+			break;
+		}
 	}
=20
 	return IRQ_HANDLED;
@@ -531,6 +541,13 @@ static int tsens_set_trips(void *_sensor, int low, int h=
igh)
 	int high_val, low_val, cl_high, cl_low;
 	u32 hw_id =3D s->hw_id;
=20
+	if (tsens_version(priv) < VER_0_1) {
+		/* Pre v0.1 IP had a single register for each type of interrupt
+		 * and thresholds
+		 */
+		hw_id =3D 0;
+	}
+
 	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
 		hw_id, __func__, low, high);
=20
@@ -585,18 +602,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, =
int *temp)
 	u32 valid;
 	int ret;
=20
-	ret =3D regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
+	/* VER_0 doesn't have VALID bit */
+	if (tsens_version(priv) >=3D VER_0_1) {
 		ret =3D regmap_field_read(priv->rf[valid_idx], &valid);
 		if (ret)
 			return ret;
+		while (!valid) {
+			/* Valid bit is 0 for 6 AHB clock cycles.
+			 * At 19.2MHz, 1 AHB clock is ~60ns.
+			 * We should enter this loop very, very rarely.
+			 */
+			ndelay(400);
+			ret =3D regmap_field_read(priv->rf[valid_idx], &valid);
+			if (ret)
+				return ret;
+		}
 	}
=20
 	/* Valid bit is set, OK to read the temperature */
@@ -609,15 +629,29 @@ int get_temp_common(const struct tsens_sensor *s, int *=
temp)
 {
 	struct tsens_priv *priv =3D s->priv;
 	int hw_id =3D s->hw_id;
-	int last_temp =3D 0, ret;
+	int last_temp =3D 0, ret, trdy;
+	unsigned long timeout;
=20
-	ret =3D regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
-	if (ret)
-		return ret;
+	timeout =3D jiffies + usecs_to_jiffies(TIMEOUT_US);
+	do {
+		if (tsens_version(priv) =3D=3D VER_0) {
+			ret =3D regmap_field_read(priv->rf[TRDY], &trdy);
+			if (ret)
+				return ret;
+			if (!trdy)
+				continue;
+		}
=20
-	*temp =3D code_to_degc(last_temp, s) * 1000;
+		ret =3D regmap_field_read(priv->rf[LAST_TEMP_0 + hw_id], &last_temp);
+		if (ret)
+			return ret;
=20
-	return 0;
+		*temp =3D code_to_degc(last_temp, s) * 1000;
+
+		return 0;
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
 }
=20
 #ifdef CONFIG_DEBUG_FS
@@ -739,19 +773,34 @@ int __init init_common(struct tsens_priv *priv)
 		priv->tm_offset =3D 0x1000;
 	}
=20
-	res =3D platform_get_resource(op, IORESOURCE_MEM, 0);
-	tm_base =3D devm_ioremap_resource(dev, res);
-	if (IS_ERR(tm_base)) {
-		ret =3D PTR_ERR(tm_base);
-		goto err_put_device;
+	if (tsens_version(priv) >=3D VER_0_1) {
+		res =3D platform_get_resource(op, IORESOURCE_MEM, 0);
+		tm_base =3D devm_ioremap_resource(dev, res);
+		if (IS_ERR(tm_base)) {
+			ret =3D PTR_ERR(tm_base);
+			goto err_put_device;
+		}
+
+		priv->tm_map =3D devm_regmap_init_mmio(dev, tm_base, &tsens_config);
+	} else { /* VER_0 share the same gcc regs using a syscon */
+		struct device *parent =3D priv->dev->parent;
+
+		if (parent)
+			priv->tm_map =3D syscon_node_to_regmap(parent->of_node);
 	}
=20
-	priv->tm_map =3D devm_regmap_init_mmio(dev, tm_base, &tsens_config);
-	if (IS_ERR(priv->tm_map)) {
-		ret =3D PTR_ERR(priv->tm_map);
+	if (IS_ERR_OR_NULL(priv->tm_map)) {
+		if (!priv->tm_map)
+			ret =3D -ENODEV;
+		else
+			ret =3D PTR_ERR(priv->tm_map);
 		goto err_put_device;
 	}
=20
+	/* VER_0 have only tm_map */
+	if (!priv->srot_map)
+		priv->srot_map =3D priv->tm_map;
+
 	if (tsens_version(priv) > VER_0_1) {
 		for (i =3D VER_MAJOR; i <=3D VER_STEP; i++) {
 			priv->rf[i] =3D devm_regmap_field_alloc(dev, priv->srot_map,
@@ -772,6 +821,10 @@ int __init init_common(struct tsens_priv *priv)
 		ret =3D PTR_ERR(priv->rf[TSENS_EN]);
 		goto err_put_device;
 	}
+	/* in VER_0 TSENS need to be explicitly enabled */
+	if (tsens_version(priv) =3D=3D VER_0)
+		regmap_field_write(priv->rf[TSENS_EN], 1);
+
 	ret =3D regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
@@ -794,6 +847,19 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
=20
+	priv->rf[TSENS_SW_RST] =3D
+		devm_regmap_field_alloc(dev, priv->srot_map, priv->fields[TSENS_SW_RST]);
+	if (IS_ERR(priv->rf[TSENS_SW_RST])) {
+		ret =3D PTR_ERR(priv->rf[TSENS_SW_RST]);
+		goto err_put_device;
+	}
+
+	priv->rf[TRDY] =3D devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[=
TRDY]);
+	if (IS_ERR(priv->rf[TRDY])) {
+		ret =3D PTR_ERR(priv->rf[TRDY]);
+		goto err_put_device;
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j =3D LAST_TEMP_0; j <=3D UP_THRESH_15; j +=3D 16) {
 		for (i =3D 0; i < priv->feat->max_sensors; i++) {
@@ -809,7 +875,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
=20
-	if (priv->feat->crit_int) {
+	if (priv->feat->crit_int || tsens_version(priv) < VER_0_1) {
 		/* Loop might need changes if enum regfield_ids is reordered */
 		for (j =3D CRITICAL_STATUS_0; j <=3D CRIT_THRESH_15; j +=3D 16) {
 			for (i =3D 0; i < priv->feat->max_sensors; i++) {
@@ -847,7 +913,11 @@ int __init init_common(struct tsens_priv *priv)
 	}
=20
 	spin_lock_init(&priv->ul_lock);
-	tsens_enable_irq(priv);
+
+	/* VER_0 interrupt doesn't need to be enabled */
+	if (tsens_version(priv) >=3D VER_0_1)
+		tsens_enable_irq(priv);
+
 	tsens_debug_init(op);
=20
 err_put_device:
@@ -949,10 +1019,19 @@ static int tsens_register_irq(struct tsens_priv *priv,=
 char *irqname,
 		if (irq =3D=3D -ENXIO)
 			ret =3D 0;
 	} else {
-		ret =3D devm_request_threaded_irq(&pdev->dev, irq,
-						NULL, thread_fn,
-						IRQF_ONESHOT,
-						dev_name(&pdev->dev), priv);
+		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
+		if (tsens_version(priv) =3D=3D VER_0)
+			ret =3D devm_request_threaded_irq(&pdev->dev, irq,
+							thread_fn, NULL,
+							IRQF_TRIGGER_RISING,
+							dev_name(&pdev->dev),
+							priv);
+		else
+			ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
+							thread_fn, IRQF_ONESHOT,
+							dev_name(&pdev->dev),
+							priv);
+
 		if (ret)
 			dev_err(&pdev->dev, "%s: failed to get irq\n",
 				__func__);
@@ -981,6 +1060,19 @@ static int tsens_register(struct tsens_priv *priv)
 			priv->ops->enable(priv, i);
 	}
=20
+	/* VER_0 require to set MIN and MAX THRESH
+	 * These 2 regs are set using the:
+	 * - CRIT_THRESH_0 for MAX THRESH hardcoded to 120=C2=B0C
+	 * - CRIT_THRESH_1 for MIN THRESH hardcoded to   0=C2=B0C
+	 */
+	if (tsens_version(priv) < VER_0_1) {
+		regmap_field_write(priv->rf[CRIT_THRESH_0],
+				   tsens_mC_to_hw(priv->sensor, 120000));
+
+		regmap_field_write(priv->rf[CRIT_THRESH_1],
+				   tsens_mC_to_hw(priv->sensor, 0));
+	}
+
 	ret =3D tsens_register_irq(priv, "uplow", tsens_irq_thread);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index cba64c3..1471a2c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -13,6 +13,7 @@
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
 #define SLOPE_DEFAULT		3200
+#define TIMEOUT_US		100
 #define THRESHOLD_MAX_ADC_CODE	0x3ff
 #define THRESHOLD_MIN_ADC_CODE	0x0
=20
@@ -25,7 +26,8 @@ struct tsens_priv;
=20
 /* IP version numbers in ascending order */
 enum tsens_ver {
-	VER_0_1 =3D 0,
+	VER_0 =3D 0,
+	VER_0_1,
 	VER_1_X,
 	VER_2_X,
 };
