Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC274719C4
	for <lists+linux-pm@lfdr.de>; Sun, 12 Dec 2021 12:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhLLLUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Dec 2021 06:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhLLLUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Dec 2021 06:20:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78229C061714
        for <linux-pm@vger.kernel.org>; Sun, 12 Dec 2021 03:20:37 -0800 (PST)
Date:   Sun, 12 Dec 2021 11:20:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639308036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HS+x+goveeJvOMKOltKQTy7bpUxZKNS/4fzQT3RHVig=;
        b=cru59QPSBsqmYakRUJpcnlmHeVFW4c/GgP4zXTDsBRk/rxJC0LnsNXZgqccR4eKdDPAXWS
        oM3F1g47Xp06GyQfChuIzNeR4Q0CfBmLub1gjELFG+sqytpnbdHOZWWCVnaHJ4lZj9bPwV
        neZyj6PgL1Eq6rnOqVAoG8vhKPkjLk2gSV5aUu/gYVfz0BDxHjFNpqFkVS4+BwAG7O2Ol/
        R9OS1lSjcL3SZVrpUHkOlEG9EgzUJQB558vtFYlIiFur9s6ID1K/VGXpJoAgBDrEf7me27
        oGV6kO+puNGCa8Tj7QxHm4JU4oR+qR4SKTaJrLR/mUp8Qq5ln9qnI9x1uihC3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639308036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HS+x+goveeJvOMKOltKQTy7bpUxZKNS/4fzQT3RHVig=;
        b=SbXRBtULR4M15laspI4ajvHdgsr/t2pLGTP2YmPKxGcN4ZMyCt97bTT76UIbSINEMcrmWo
        vYoKXdjS8lKgS6DA==
From:   "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers: Add TSU driver for RZ/G2L
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20211130155757.17837-3-biju.das.jz@bp.renesas.com>
References: <20211130155757.17837-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <163930803500.23020.7030190325174622254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     673c68bd48390dad01f7d17670de3e33b60860ac
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//673c68bd48390dad01f7d17670de3e33b60860ac
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 30 Nov 2021 15:57:57=20
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 30 Nov 2021 17:27:56 +01:00

thermal/drivers: Add TSU driver for RZ/G2L

The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that measures the
temperature inside the LSI.

The thermal sensor in this unit measures temperatures in the range from
=E2=88=9240 degree Celsius to 125 degree Celsius with an accuracy of =C2=B13=
=C2=B0C. The
TSU repeats measurement at 20 microseconds intervals and automatically
updates the results of measurement.

The TSU has no interrupts as well as no external pins.

This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211130155757.17837-3-biju.das.jz@bp.renesas=
.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig         |   9 +-
 drivers/thermal/Makefile        |   1 +-
 drivers/thermal/rzg2l_thermal.c | 240 +++++++++++++++++++++++++++++++-
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/thermal/rzg2l_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44de..e37691e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -354,6 +354,15 @@ config RCAR_GEN3_THERMAL
 	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
 	  the Linux thermal framework.
=20
+config RZG2L_THERMAL
+	tristate "Renesas RZ/G2L thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
+	  thermal framework.
+
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e6..f0c36a1 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SUN8I_THERMAL)     +=3D sun8i_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+=3D rcar_gen3_thermal.o
+obj-$(CONFIG_RZG2L_THERMAL)	+=3D rzg2l_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
 obj-y				+=3D samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
new file mode 100644
index 0000000..d47d4a3
--- /dev/null
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L TSU Thermal Sensor Driver
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "thermal_hwmon.h"
+
+#define CTEMP_MASK	0xFFF
+
+/* default calibration values, if FUSE values are missing */
+#define SW_CALIB0_VAL	3148
+#define SW_CALIB1_VAL	503
+
+/* Register offsets */
+#define TSU_SM		0x00
+#define TSU_ST		0x04
+#define TSU_SAD		0x0C
+#define TSU_SS		0x10
+
+#define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
+
+/* Sensor Mode Register(TSU_SM) */
+#define TSU_SM_EN_TS		BIT(0)
+#define TSU_SM_ADC_EN_TS	BIT(1)
+#define TSU_SM_NORMAL_MODE	(TSU_SM_EN_TS | TSU_SM_ADC_EN_TS)
+
+/* TSU_ST bits */
+#define TSU_ST_START		BIT(0)
+
+#define TSU_SS_CONV_RUNNING	BIT(0)
+
+#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
+#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
+#define TS_CODE_CAP_TIMES	8	/* Capture  times */
+
+#define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
+#define RZG2L_TSU_SS_TIMEOUT_US	1000
+
+#define CURVATURE_CORRECTION_CONST	13
+
+struct rzg2l_thermal_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct thermal_zone_device *zone;
+	struct reset_control *rstc;
+	u32 calib0, calib1;
+};
+
+static inline u32 rzg2l_thermal_read(struct rzg2l_thermal_priv *priv, u32 re=
g)
+{
+	return ioread32(priv->base + reg);
+}
+
+static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 =
reg,
+				       u32 data)
+{
+	iowrite32(data, priv->base + reg);
+}
+
+static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+{
+	struct rzg2l_thermal_priv *priv =3D devdata;
+	u32 result =3D 0, dsensor, ts_code_ave;
+	int val, i;
+
+	for (i =3D 0; i < TS_CODE_CAP_TIMES ; i++) {
+		/* TSU repeats measurement at 20 microseconds intervals and
+		 * automatically updates the results of measurement. As per
+		 * the HW manual for measuring temperature we need to read 8
+		 * values consecutively and then take the average.
+		 * ts_code_ave =3D (ts_code[0] + =E2=8B=AF + ts_code[7]) / 8
+		 */
+		result +=3D rzg2l_thermal_read(priv, TSU_SAD) & CTEMP_MASK;
+		usleep_range(20, 30);
+	}
+
+	ts_code_ave =3D result / TS_CODE_CAP_TIMES;
+
+	/* Calculate actual sensor value by applying curvature correction formula
+	 * dsensor =3D ts_code_ave / (1 + ts_code_ave * 0.000013). Here we are doing
+	 * integer calculation by scaling all the values by 1000000.
+	 */
+	dsensor =3D TS_CODE_AVE_SCALE(ts_code_ave) /
+		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * CURVATURE_CORRECTION_CONST));
+
+	/* The temperature Tj is calculated by the formula
+	 * Tj =3D (dsensor =E2=88=92 calib1) * 165/ (calib0 =E2=88=92 calib1) =E2=
=88=92 40
+	 * where calib0 and calib1 are the caliberation values.
+	 */
+	val =3D ((dsensor - priv->calib1) * (MCELSIUS(165) /
+		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
+
+	*temp =3D roundup(val, RZG2L_THERMAL_GRAN);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops =3D {
+	.get_temp =3D rzg2l_thermal_get_temp,
+};
+
+static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv)
+{
+	u32 reg_val;
+
+	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
+	rzg2l_thermal_write(priv, TSU_ST, 0);
+
+	/* Before setting the START bit, TSU should be in normal operating
+	 * mode. As per the HW manual, it will take 60 =C2=B5s to place the TSU
+	 * into normal operating mode.
+	 */
+	usleep_range(60, 80);
+
+	reg_val =3D rzg2l_thermal_read(priv, TSU_ST);
+	reg_val |=3D TSU_ST_START;
+	rzg2l_thermal_write(priv, TSU_ST, reg_val);
+
+	return readl_poll_timeout(priv->base + TSU_SS, reg_val,
+				  reg_val =3D=3D TSU_SS_CONV_RUNNING, 50,
+				  RZG2L_TSU_SS_TIMEOUT_US);
+}
+
+static void rzg2l_thermal_reset_assert_pm_disable_put(struct platform_device=
 *pdev)
+{
+	struct rzg2l_thermal_priv *priv =3D dev_get_drvdata(&pdev->dev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
+}
+
+static int rzg2l_thermal_remove(struct platform_device *pdev)
+{
+	struct rzg2l_thermal_priv *priv =3D dev_get_drvdata(&pdev->dev);
+
+	thermal_remove_hwmon_sysfs(priv->zone);
+	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
+
+	return 0;
+}
+
+static int rzg2l_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *zone;
+	struct rzg2l_thermal_priv *priv;
+	struct device *dev =3D &pdev->dev;
+	int ret;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->dev =3D dev;
+	priv->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc),
+				     "failed to get cpg reset");
+
+	reset_control_deassert(priv->rstc);
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	priv->calib0 =3D rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
+	if (!priv->calib0)
+		priv->calib0 =3D SW_CALIB0_VAL;
+
+	priv->calib1 =3D rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
+	if (!priv->calib1)
+		priv->calib1 =3D SW_CALIB1_VAL;
+
+	platform_set_drvdata(pdev, priv);
+	ret =3D rzg2l_thermal_init(priv);
+	if (ret) {
+		dev_err(dev, "Failed to start TSU");
+		goto err;
+	}
+
+	zone =3D devm_thermal_zone_of_sensor_register(dev, 0, priv,
+						    &rzg2l_tz_of_ops);
+	if (IS_ERR(zone)) {
+		dev_err(dev, "Can't register thermal zone");
+		ret =3D PTR_ERR(zone);
+		goto err;
+	}
+
+	priv->zone =3D zone;
+	priv->zone->tzp->no_hwmon =3D false;
+	ret =3D thermal_add_hwmon_sysfs(priv->zone);
+	if (ret)
+		goto err;
+
+	dev_dbg(dev, "TSU probed with %s caliberation values",
+		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
+
+	return 0;
+
+err:
+	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
+	return ret;
+}
+
+static const struct of_device_id rzg2l_thermal_dt_ids[] =3D {
+	{ .compatible =3D "renesas,rzg2l-tsu", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_thermal_dt_ids);
+
+static struct platform_driver rzg2l_thermal_driver =3D {
+	.driver =3D {
+		.name =3D "rzg2l_thermal",
+		.of_match_table =3D rzg2l_thermal_dt_ids,
+	},
+	.probe =3D rzg2l_thermal_probe,
+	.remove =3D rzg2l_thermal_remove,
+};
+module_platform_driver(rzg2l_thermal_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G2L TSU Thermal Sensor Driver");
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_LICENSE("GPL v2");
