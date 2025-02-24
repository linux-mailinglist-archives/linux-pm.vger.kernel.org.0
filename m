Return-Path: <linux-pm+bounces-22828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CEDA429E3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1429188DCC1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D1265CB9;
	Mon, 24 Feb 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DSyCeX1k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2598265629
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418327; cv=none; b=WN1GB4LGm0d5Np9XEQXqI/JkkfRhkUArDCMUtSHEvA4Fgo7ygAg4OshFJ9TuAvOlFPYrhptWElF9cC6ZSRkMXzK6KY9/iCXvYJdNn/0gkqTBE9KCmLaTx+H8yUPyARsZMP+794sFlhaAVmc4QxIAX8mgycQEhVxd112fzJA8SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418327; c=relaxed/simple;
	bh=kNFPldhm2W3bHv5L4qigR68BEhuVlB5Rirl+9zoIjxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwIHK3hLw1mNYnQr6jQJ5FC50dy0vltECORKWBFzhCxIXOT1e5RfAYF4e7apz0UaHqVaw5YxNmWoxFe1GR0LQIt9DyFaucPScDe2q70ap2HeS1ByVQ4Ae7pbhChQG7wHbjxQ2m64OTLU4wd/reNhi1MgLapdFHbbdo2AFasTC18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DSyCeX1k; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so7585351a12.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 09:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740418322; x=1741023122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnk3gh3LgHdCUikLOQiG60CSoKjMkn/o1mpGvpwpEfo=;
        b=DSyCeX1kDQrCxKRGYZRWEZ4IIKBH7o+vmdK2Uu1LAYSfruzegodc3cAsc5J6CzyIxp
         FgD+pnpsU7Y3b7wWxMriOdhy7h9OI7d5w3G4xvZrYyq5/X1F3QfXqMw30mD4PIHgaQLc
         JeD8BYBp6nuV6MOi+ZtVebg2EQM+TVO+jYFTJnyjK5Ds5zGjby4IqQIPs6z6ZzZlCglx
         UQM5Qzk5+Oy/e98x8wSMyVAtrVE3hZrdyaVsxlf0Im52dGyKkOIVU9xboSDzoxeb00nc
         aOXCZNhrp/oFBTEfx26BuhUl/e7GCoEpnyzns0eMK9mJreXZBxEt2A2PwqT+RiYOtl5g
         WpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418322; x=1741023122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vnk3gh3LgHdCUikLOQiG60CSoKjMkn/o1mpGvpwpEfo=;
        b=lt613cmj4z1fbODRs0FcK/ORZFTjX6Rv3k0Gt+FMPptoLTFUSAChPYPOQ8u7woErZL
         znj+wgMmOQ6asB8ZLSMsBW3abuMFH5L8Q1MOeNewkAXt2TAH3xYq5jcomgqSWy6/6A6V
         jOx3FeA/3cW2J8BRiaYDwwa8PiE6zIsgphyiqmS2y8hLNohszL9XY4LXXN401RT+E5A3
         7FW3qEAg1dtd3DZsXn47etkR4jYHbHJI7Mxjyc3LwuCEvnWZDZ0pIkJeqy92Z2L0RtHq
         r4YvNgZeLcdSj+J6CkwksmjAKxJDA+xBjQdLF2Ub9uFAwtzpb8UohHb7Z6o3UFs7a6g4
         ZR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+I1PEaaLaGnc9Chrdw7RqHFlYN5bFz3kO0UZva48M4TlE33jGOhs4mA6iHCUCC6CDd4VJj4w42g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8buHXzY0M5Y5yUP6dhj5w7H6fwENflAPAsN/CX/d+DDFTAQR
	6rrsL2RRD2vacxSC1TJfeotToFgwDugQ6Q56Bw728UZxKolIuLSlj98SPpsGN9A=
X-Gm-Gg: ASbGncssZZZ0Tiz7YqrbBIfPIFm0WcdCHf5Z/F0ZAaoDdvUmoPnKKX9yuXeoeJ+fX76
	qVBjLYrFNgdtF+/rqRLZUuYP545nh05QVVem4xE9q2XK/W4OpxqLCs227CM5+tl533j2SY6NIX8
	HapOyNuxOeLtMoH3n0QyTq7ex64zC4MHxBii9HFhaKl0oQ/QYR2ZRdo5usDI+puTZ7TEdiWDd43
	kcUbAlpRTimFsmIUegp81Ig02Ys0uOf1LhQu86K4EDLNj/B3mPyu+CHhj6AD+rDFzLL79R3B9V7
	kfw8jAr/uKyNkdW7KYNhyhU6JWNZ9mMqk8dU1iFrgUvZ8onnwMBMTak=
X-Google-Smtp-Source: AGHT+IGYy0MH+DqKI1kUPnuAEZZQAu7hFkJGLsuQYOGxMwzTzyvUzPtaIE08GRKEqourf3AcXBqJDA==
X-Received: by 2002:a05:6402:e02:b0:5e0:88f4:1bc1 with SMTP id 4fb4d7f45d1cf-5e0b70cd6dcmr13284106a12.2.1740418322221;
        Mon, 24 Feb 2025 09:32:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a7fsm18674357a12.58.2025.02.24.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:32:01 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/4] thermal: renesas: rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
Date: Mon, 24 Feb 2025 19:31:42 +0200
Message-ID: <20250224173144.1952801-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
the junction temperature. The temperature is reported through a dedicated
ADC channel. Add a driver for the Renesas RZ/G3S TSU.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- use a devres group for the devm resources obtained though this
  driver to avoid issue described in [1]; with this dropped the
  following calls:
-- thermal_add_hwmon_sysfs(priv->tz);
-- thermal_of_zone_register(priv->tz);
-- pm_runtime_enable(priv->dev);
  and use devm variants
- used signed variables for temperature computation
- convert to mili degree Celsius before applying the computation formula
  to avoid losing precision

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/

 MAINTAINERS                             |   7 +
 drivers/thermal/renesas/Kconfig         |   8 +
 drivers/thermal/renesas/Makefile        |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c | 329 ++++++++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e223df29c1c0..0977042a678e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20330,6 +20330,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 F:	drivers/iio/potentiometer/x9250.c
 
+RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
+M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+F:	drivers/thermal/renesas/rzg3s_thermal.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index dcf5fc5ae08e..566478797095 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -26,3 +26,11 @@ config RZG2L_THERMAL
 	help
 	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
 	  thermal framework.
+
+config RZG3S_THERMAL
+	tristate "Renesas RZ/G3S thermal driver"
+	depends on ARCH_R9A08G045 || COMPILE_TEST
+	depends on OF && IIO && RZG2L_ADC
+	help
+	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
+	  thermal framework.
diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
index bf9cb3cb94d6..1feb5ab78827 100644
--- a/drivers/thermal/renesas/Makefile
+++ b/drivers/thermal/renesas/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
+obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
new file mode 100644
index 000000000000..3d934735c522
--- /dev/null
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3S TSU Thermal Sensor Driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iio/consumer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "../thermal_hwmon.h"
+
+#define TSU_SM			0x0
+#define TSU_SM_EN		BIT(0)
+#define TSU_SM_OE		BIT(1)
+#define OTPTSUTRIM_REG(n)	(0x18 + (n) * 0x4)
+#define OTPTSUTRIM_EN_MASK	BIT(31)
+#define OTPTSUTRIM_MASK		GENMASK(11, 0)
+
+#define TSU_READ_STEPS		8
+
+/* Default calibration values, if FUSE values are missing. */
+#define SW_CALIB0_VAL		1297
+#define SW_CALIB1_VAL		751
+
+#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
+
+/**
+ * struct rzg3s_thermal_priv - RZ/G3S thermal private data structure
+ * @base: TSU base address
+ * @dev: device pointer
+ * @tz: thermal zone pointer
+ * @rstc: reset control
+ * @channel: IIO channel to read the TSU
+ * @devres_group_id: devres group for the driver devres resources
+ *		      obtained in probe
+ * @mode: current device mode
+ * @calib0: calibration value
+ * @calib1: calibration value
+ */
+struct rzg3s_thermal_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct thermal_zone_device *tz;
+	struct reset_control *rstc;
+	struct iio_channel *channel;
+	void *devres_group_id;
+	enum thermal_device_mode mode;
+	u16 calib0;
+	u16 calib1;
+};
+
+static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
+	struct device *dev = priv->dev;
+	int ts_code_ave = 0;
+	int ret, val;
+
+	if (priv->mode != THERMAL_DEVICE_ENABLED)
+		return -EAGAIN;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
+		ret = iio_read_channel_raw(priv->channel, &val);
+		if (ret < 0)
+			goto rpm_put;
+
+		ts_code_ave += val;
+		/*
+		 * According to the HW manual (section 40.4.4 Procedure for Measuring the
+		 * Temperature) we need to wait here at leat 3us.
+		 */
+		usleep_range(5, 10);
+	}
+
+	ret = 0;
+	ts_code_ave = DIV_ROUND_CLOSEST(MCELSIUS(ts_code_ave), TSU_READ_STEPS);
+
+	/*
+	 * According to the HW manual (section 40.4.4 Procedure for Measuring the Temperature)
+	 * the computation formula is as follows:
+	 *
+	 * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
+	 *
+	 * Convert everything to mili Celsius before applying the formula to avoid
+	 * losing precision.
+	 */
+
+	*temp = DIV_ROUND_CLOSEST((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
+				  MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
+
+	/* Report it in mili degrees Celsius and round it up to 0.5 degrees Celsius. */
+	*temp = roundup(*temp, 500);
+
+rpm_put:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static void rzg3s_thermal_set_mode(struct rzg3s_thermal_priv *priv,
+				   enum thermal_device_mode mode)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return;
+
+	if (mode == THERMAL_DEVICE_DISABLED) {
+		writel(0, priv->base + TSU_SM);
+	} else {
+		writel(TSU_SM_EN, priv->base + TSU_SM);
+		/*
+		 * According to the HW manual (section 40.4.1 Procedure for
+		 * Starting the TSU) we need to wait here 30us or more.
+		 */
+		usleep_range(30, 40);
+
+		writel(TSU_SM_OE | TSU_SM_EN, priv->base + TSU_SM);
+		/*
+		 * According to the HW manual (section 40.4.1 Procedure for
+		 * Starting the TSU) we need to wait here 50us or more.
+		 */
+		usleep_range(50, 60);
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+static int rzg3s_thermal_change_mode(struct thermal_zone_device *tz,
+				     enum thermal_device_mode mode)
+{
+	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
+
+	if (priv->mode == mode)
+		return 0;
+
+	rzg3s_thermal_set_mode(priv, mode);
+	priv->mode = mode;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops rzg3s_tz_of_ops = {
+	.get_temp = rzg3s_thermal_get_temp,
+	.change_mode = rzg3s_thermal_change_mode,
+};
+
+static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
+{
+	struct device *dev = priv->dev;
+	u32 val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	val = readl(priv->base + OTPTSUTRIM_REG(0));
+	if (val & OTPTSUTRIM_EN_MASK)
+		priv->calib0 = FIELD_GET(OTPTSUTRIM_MASK, val);
+	else
+		priv->calib0 = SW_CALIB0_VAL;
+
+	val = readl(priv->base + OTPTSUTRIM_REG(1));
+	if (val & OTPTSUTRIM_EN_MASK)
+		priv->calib1 = FIELD_GET(OTPTSUTRIM_MASK, val);
+	else
+		priv->calib1 = SW_CALIB1_VAL;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int rzg3s_thermal_probe(struct platform_device *pdev)
+{
+	struct rzg3s_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	void *devres_group_id;
+	int ret;
+
+	/*
+	 * Open a devres group to allow using devm_pm_runtime_enable()
+	 * w/o interfeering with dev_pm_genpd_detach() in the platform bus
+	 * remove. Otherwise, durring repeated unbind/bind operations,
+	 * the TSU may be runtime resumed when it is not part of its power
+	 * domain, leading to accessing TSU registers (through
+	 * rzg3s_thermal_change_mode()) without its clocks being enabled
+	 * and its PM domain being turned on.
+	 */
+	devres_group_id = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!devres_group_id)
+		return -ENOMEM;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto release_group;
+	}
+	priv->devres_group_id = devres_group_id;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base)) {
+		ret = PTR_ERR(priv->base);
+		goto release_group;
+	}
+
+	priv->channel = devm_iio_channel_get(dev, "tsu");
+	if (IS_ERR(priv->channel)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->channel), "Failed to get IIO channel!\n");
+		goto release_group;
+	}
+
+	priv->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(priv->rstc)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to get reset!\n");
+		goto release_group;
+	}
+
+	priv->dev = dev;
+	priv->mode = THERMAL_DEVICE_DISABLED;
+	platform_set_drvdata(pdev, priv);
+
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
+		goto release_group;
+	}
+
+	ret = rzg3s_thermal_read_calib(priv);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to read calibration data!\n");
+		goto release_group;
+	}
+
+	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &rzg3s_tz_of_ops);
+	if (IS_ERR(priv->tz)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register thermal zone!\n");
+		goto release_group;
+	}
+
+	ret = devm_thermal_add_hwmon_sysfs(dev, priv->tz);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
+		goto release_group;
+	}
+
+	return 0;
+
+release_group:
+	devres_release_group(dev, devres_group_id);
+	return ret;
+}
+
+static void rzg3s_thermal_remove(struct platform_device *pdev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	devres_release_group(priv->dev, priv->devres_group_id);
+}
+
+static int rzg3s_thermal_suspend(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rzg3s_thermal_set_mode(priv, THERMAL_DEVICE_DISABLED);
+
+	return reset_control_assert(priv->rstc);
+}
+
+static int rzg3s_thermal_resume(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	if (priv->mode != THERMAL_DEVICE_DISABLED)
+		rzg3s_thermal_set_mode(priv, priv->mode);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rzg3s_thermal_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(rzg3s_thermal_suspend, rzg3s_thermal_resume)
+};
+
+static const struct of_device_id rzg3s_thermal_dt_ids[] = {
+	{ .compatible = "renesas,r9a08g045-tsu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
+
+static struct platform_driver rzg3s_thermal_driver = {
+	.driver = {
+		.name = "rzg3s_thermal",
+		.of_match_table = rzg3s_thermal_dt_ids,
+		.pm = pm_ptr(&rzg3s_thermal_pm_ops),
+	},
+	.probe = rzg3s_thermal_probe,
+	.remove = rzg3s_thermal_remove,
+};
+module_platform_driver(rzg3s_thermal_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G3S Thermal Sensor Unit Driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


