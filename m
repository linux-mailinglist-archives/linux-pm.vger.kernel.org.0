Return-Path: <linux-pm+bounces-41433-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNYoHzdrdmldQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41433-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:12:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66582030
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB4FC3051470
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C42F1FF4;
	Sun, 25 Jan 2026 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IUzJgE4J"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610A8F4A;
	Sun, 25 Jan 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368126; cv=none; b=ZRFP2pw09QlZw0l/oba7RVZwzGU+gs6h+OT/w8ZrU7b8yKMwJm5tfvBuMwwumdBkqF7khzOhtRKYAflstJydOj/pJ7mPFwJG/JtsspwG1WMnw0UiTJH7e3n2hgGvuUNzvQDGOCmdQx8JxIiS43Wdeo4AdFHmLooCqgBwy/AWlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368126; c=relaxed/simple;
	bh=HIcF/ZD87Z6ZpiLN/KZqlptLT3/nfDt6Nqpj/3KyC6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sz/6ZgkjdOSlxJCXHvF1o89QhBcWbwe+ebIH6zJqrCbJh1JKHZ1ajbAJeopkvZvEo74AkSn1DHgkjbJ/zUlhZSfYtyaA2mCRP4J/hwz4zsfRbpZ5me0E35zi2PtC3ohDyZR/VbYNuL5CCXCw9EdYGYKwOGA0m0+2d5TWOg65CF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IUzJgE4J; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CDCCD27BF6;
	Sun, 25 Jan 2026 20:08:42 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5cxRGa40buKL; Sun, 25 Jan 2026 20:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368121; bh=HIcF/ZD87Z6ZpiLN/KZqlptLT3/nfDt6Nqpj/3KyC6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IUzJgE4JIdu0KawawPcBbHxgCdjOQHb4x++PK+Y0TUvjFkHIFaSO1KL2vMCBWkjzW
	 xTtyZlTNsOr0vWQ/tjwm7oT9oTcgyg98D9DzOpdyo5YzS0MFOC+/9D9ss2tsTaq+ec
	 PIDDmKYwzYm/2erP/Mfd5TSzUBRQJiTnlQRRjqt5zyrtRB3cYcHxa21OuXAl+mxNQ/
	 f6BD5pEn3abQCKNIrxjZgP//LGC0zLizehWgZ3zKKBCAPMbCpQC9d/hv+mGawBUIX3
	 3bbyfhctvfeaMnz6s8yNsukcKRFmDvsmQbM6iASUyhY4mVhLXKi+DbQv8pPwS9TOOk
	 rMSaPbiu5xOUw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:16 +0530
Subject: [PATCH v2 09/12] leds: rgb: add support for Samsung S2M series
 PMIC RGB LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-9-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41433-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1E66582030
X-Rspamd-Action: no action

Add support for the RGB LEDs found in certain Samsung S2M series PMICs.
The device has three LED channels, controlled as a single device. These
LEDs are typically used as status indicators in mobile phones.

The driver includes initial support for the S2MU005 PMIC RGB LEDs.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/leds/rgb/Kconfig        |  11 +
 drivers/leds/rgb/Makefile       |   1 +
 drivers/leds/rgb/leds-s2m-rgb.c | 460 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 472 insertions(+)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 222d943d826aa..e38ba1bd434e9 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -62,6 +62,17 @@ config LEDS_QCOM_LPG
 
 	  If compiled as a module, the module will be named leds-qcom-lpg.
 
+config LEDS_S2M_RGB
+	tristate "Samsung S2M series PMICs RGB LED support"
+	depends on LEDS_CLASS
+	depends on MFD_SEC_CORE
+	select REGMAP_IRQ
+	help
+	  This option enables support for the S2MU005 RGB LEDs. These
+	  devices have three LED channels, with 8-bit brightness control
+	  for each channel. It's usually found in mobile phones as
+	  status indicators.
+
 config LEDS_MT6370_RGB
 	tristate "LED Support for MediaTek MT6370 PMIC"
 	depends on MFD_MT6370
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index a501fd27f1793..fc9d38fa60e1d 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_LEDS_KTD202X)		+= leds-ktd202x.o
 obj-$(CONFIG_LEDS_NCP5623)		+= leds-ncp5623.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
+obj-$(CONFIG_LEDS_S2M_RGB)		+= leds-s2m-rgb.o
 obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
diff --git a/drivers/leds/rgb/leds-s2m-rgb.c b/drivers/leds/rgb/leds-s2m-rgb.c
new file mode 100644
index 0000000000000..dd304be6c65c8
--- /dev/null
+++ b/drivers/leds/rgb/leds-s2m-rgb.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RGB LED Driver for Samsung S2M series PMICs.
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/container_of.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/mfd/samsung/s2mu005.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct s2m_rgb {
+	struct device *dev;
+	struct regmap *regmap;
+	struct led_classdev_mc cdev;
+	struct mutex lock;
+	const struct s2m_rgb_spec *spec;
+	u8 ramp_up;
+	u8 ramp_dn;
+	u8 stay_hi;
+	u8 stay_lo;
+};
+
+struct s2m_rgb_spec {
+	int (*params_apply)(struct s2m_rgb *priv);
+	int (*params_reset)(struct s2m_rgb *priv);
+	const u32 *lut_ramp_up;
+	const size_t lut_ramp_up_len;
+	const u32 *lut_ramp_dn;
+	const size_t lut_ramp_dn_len;
+	const u32 *lut_stay_hi;
+	const size_t lut_stay_hi_len;
+	const u32 *lut_stay_lo;
+	const size_t lut_stay_lo_len;
+	const unsigned int max_brightness;
+};
+
+static struct led_classdev_mc *to_cdev_mc(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct led_classdev_mc, led_cdev);
+}
+
+static struct s2m_rgb *to_rgb_priv(struct led_classdev_mc *cdev)
+{
+	return container_of(cdev, struct s2m_rgb, cdev);
+}
+
+static int s2m_rgb_lut_calc_timing(const u32 *lut, const size_t len,
+				   const u32 req_time, u8 *idx)
+{
+	int lo = 0;
+	int hi = len - 2;
+
+	/* Bounds checking */
+	if (req_time < lut[0] || req_time > lut[len - 1])
+		return -EINVAL;
+
+	/*
+	 * Perform a binary search to pick the best timing from the LUT.
+	 *
+	 * The search algorithm picks two consecutive elements of the
+	 * LUT and tries to search the pair between which the requested
+	 * time lies.
+	 */
+	while (lo <= hi) {
+		*idx = (lo + hi) / 2;
+
+		if ((lut[*idx] <= req_time) && (req_time <= lut[*idx + 1]))
+			break;
+
+		if ((req_time < lut[*idx]) && (req_time < lut[*idx + 1]))
+			hi = *idx - 1;
+		else
+			lo = *idx + 1;
+	}
+
+	/*
+	 * The searched timing is always less than the requested time. At
+	 * times, the succeeding timing in the LUT is closer thus more
+	 * accurate. Adjust the resulting value if that's the case.
+	 */
+	if (abs(req_time - lut[*idx]) > abs(lut[*idx + 1] - req_time))
+		(*idx)++;
+
+	return 0;
+}
+
+static int s2m_rgb_brightness_set(struct led_classdev *cdev,
+				  enum led_brightness value)
+{
+	struct s2m_rgb *priv = to_rgb_priv(to_cdev_mc(cdev));
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	led_mc_calc_color_components(&priv->cdev, value);
+
+	if (value == LED_OFF)
+		ret = priv->spec->params_reset(priv);
+	else
+		ret = priv->spec->params_apply(priv);
+
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int s2m_rgb_pattern_set(struct led_classdev *cdev,
+			       struct led_pattern *pattern, u32 len, int repeat)
+{
+	struct s2m_rgb *priv = to_rgb_priv(to_cdev_mc(cdev));
+	int brightness_peak = 0;
+	u32 time_hi = 0;
+	u32 time_lo = 0;
+	bool ramp_up_en;
+	bool ramp_dn_en;
+	int ret;
+	int i;
+
+	/*
+	 * The typical pattern supported by this device can be
+	 * represented with the following graph:
+	 *
+	 *  255 T ''''''-.                         .-'''''''-.
+	 *      |         '.                     .'           '.
+	 *      |           \                   /               \
+	 *      |            '.               .'                 '.
+	 *      |              '-...........-'                     '-
+	 *    0 +----------------------------------------------------> time (s)
+	 *
+	 *       <---- HIGH ----><-- LOW --><-------- HIGH --------->
+	 *       <-----><-------><---------><-------><-----><------->
+	 *       stay_hi ramp_dn   stay_lo   ramp_up stay_hi ramp_dn
+	 *
+	 * There are two states, named HIGH and LOW. HIGH has a non-zero
+	 * brightness level, while LOW is of zero brightness. The
+	 * pattern provided should mention only one zero and non-zero
+	 * brightness level. The hardware always starts the pattern from
+	 * the HIGH state, as shown in the graph.
+	 *
+	 * The HIGH state can be divided in three somewhat equal timings:
+	 * ramp_up, stay_hi, and ramp_dn. The LOW state has only one
+	 * timing: stay_lo.
+	 */
+
+	/* Only indefinitely looping patterns are supported. */
+	if (repeat != -1)
+		return -EINVAL;
+
+	/* Pattern should consist of at least two tuples. */
+	if (len < 2)
+		return -EINVAL;
+
+	for (i = 0; i < len; i++) {
+		int brightness = pattern[i].brightness;
+		u32 delta_t = pattern[i].delta_t;
+
+		if (brightness) {
+			/*
+			 * The pattern shold define only one non-zero
+			 * brightness in the HIGH state. The device
+			 * doesn't have any provisions to handle
+			 * multiple peak brightness levels.
+			 */
+			if (brightness_peak && brightness_peak != brightness)
+				return -EINVAL;
+
+			brightness_peak = brightness;
+			time_hi += delta_t;
+			ramp_dn_en = !!delta_t;
+		} else {
+			time_lo += delta_t;
+			ramp_up_en = !!delta_t;
+		}
+	}
+
+	mutex_lock(&priv->lock);
+
+	/*
+	 * The timings ramp_up, stay_hi, and ramp_dn of the HIGH state
+	 * are roughly equal. Firstly, calculate and set timings for
+	 * ramp_up and ramp_dn (making sure they're exactly equal).
+	 */
+	priv->ramp_up = 0;
+	priv->ramp_dn = 0;
+
+	if (ramp_up_en) {
+		ret = s2m_rgb_lut_calc_timing(priv->spec->lut_ramp_up,
+					      priv->spec->lut_ramp_up_len,
+					      time_hi / 3, &priv->ramp_up);
+		if (ret < 0)
+			goto param_fail;
+	}
+
+	if (ramp_dn_en) {
+		ret = s2m_rgb_lut_calc_timing(priv->spec->lut_ramp_dn,
+					      priv->spec->lut_ramp_dn_len,
+					      time_hi / 3, &priv->ramp_dn);
+		if (ret < 0)
+			goto param_fail;
+	}
+
+	/*
+	 * Subtract the allocated ramp timings from time_hi (and also
+	 * making sure it doesn't underflow!). The remaining time is
+	 * allocated to stay_hi.
+	 */
+	time_hi -= min(time_hi, priv->spec->lut_ramp_up[priv->ramp_up]);
+	time_hi -= min(time_hi, priv->spec->lut_ramp_dn[priv->ramp_dn]);
+
+	ret = s2m_rgb_lut_calc_timing(priv->spec->lut_stay_hi,
+				      priv->spec->lut_stay_hi_len, time_hi,
+				      &priv->stay_hi);
+	if (ret < 0)
+		goto param_fail;
+
+	ret = s2m_rgb_lut_calc_timing(priv->spec->lut_stay_lo,
+				      priv->spec->lut_stay_lo_len, time_lo,
+				      &priv->stay_lo);
+	if (ret < 0)
+		goto param_fail;
+
+	led_mc_calc_color_components(&priv->cdev, brightness_peak);
+	ret = priv->spec->params_apply(priv);
+	if (ret < 0)
+		goto param_fail;
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+
+param_fail:
+	mutex_unlock(&priv->lock);
+	priv->ramp_up = 0;
+	priv->ramp_dn = 0;
+	priv->stay_hi = 0;
+	priv->stay_lo = 0;
+
+	return ret;
+}
+
+static int s2m_rgb_pattern_clear(struct led_classdev *cdev)
+{
+	struct s2m_rgb *priv = to_rgb_priv(to_cdev_mc(cdev));
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = priv->spec->params_reset(priv);
+
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int s2mu005_rgb_apply_params(struct s2m_rgb *priv)
+{
+	struct regmap *regmap = priv->regmap;
+	unsigned int ramp_val = 0;
+	unsigned int stay_val = 0;
+	int ret;
+	int i;
+
+	ramp_val |= FIELD_PREP(S2MU005_RGB_CH_RAMP_UP, priv->ramp_up);
+	ramp_val |= FIELD_PREP(S2MU005_RGB_CH_RAMP_DN, priv->ramp_dn);
+
+	stay_val |= FIELD_PREP(S2MU005_RGB_CH_STAY_HI, priv->stay_hi);
+	stay_val |= FIELD_PREP(S2MU005_RGB_CH_STAY_LO, priv->stay_lo);
+
+	ret = regmap_write(regmap, S2MU005_REG_RGB_EN, S2MU005_RGB_RESET);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to reset RGB LEDs\n");
+		return ret;
+	}
+
+	for (i = 0; i < priv->cdev.num_colors; i++) {
+		ret = regmap_write(regmap, S2MU005_REG_RGB_CH_CTRL(i),
+				   priv->cdev.subled_info[i].brightness);
+		if (ret < 0) {
+			dev_err(priv->dev, "failed to set LED brightness\n");
+			return ret;
+		}
+
+		ret = regmap_write(regmap, S2MU005_REG_RGB_CH_RAMP(i), ramp_val);
+		if (ret < 0) {
+			dev_err(priv->dev, "failed to set ramp timings\n");
+			return ret;
+		}
+
+		ret = regmap_write(regmap, S2MU005_REG_RGB_CH_STAY(i), stay_val);
+		if (ret < 0) {
+			dev_err(priv->dev, "failed to set stay timings\n");
+			return ret;
+		}
+	}
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_RGB_EN, S2MU005_RGB_SLOPE,
+				 S2MU005_RGB_SLOPE_SMOOTH);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set ramp slope\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int s2mu005_rgb_reset_params(struct s2m_rgb *priv)
+{
+	struct regmap *regmap = priv->regmap;
+	int ret;
+
+	ret = regmap_write(regmap, S2MU005_REG_RGB_EN, S2MU005_RGB_RESET);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to reset RGB LEDs\n");
+		return ret;
+	}
+
+	priv->ramp_up = 0;
+	priv->ramp_dn = 0;
+	priv->stay_hi = 0;
+	priv->stay_lo = 0;
+
+	return 0;
+}
+
+static const u32 s2mu005_rgb_lut_ramp[] = {
+	0,	100,	200,	300,	400,	500,	600,	700,
+	800,	1000,	1200,	1400,	1600,	1800,	2000,	2200,
+};
+
+static const u32 s2mu005_rgb_lut_stay_hi[] = {
+	100,	200,	300,	400,	500,	750,	1000,	1250,
+	1500,	1750,	2000,	2250,	2500,	2750,	3000,	3250,
+};
+
+static const u32 s2mu005_rgb_lut_stay_lo[] = {
+	0,	500,	1000,	1500,	2000,	2500,	3000,	3500,
+	4000,	4500,	5000,	6000,	7000,	8000,	10000,	12000,
+};
+
+static const struct s2m_rgb_spec s2mu005_rgb_spec = {
+	.params_apply = s2mu005_rgb_apply_params,
+	.params_reset = s2mu005_rgb_reset_params,
+	.lut_ramp_up = s2mu005_rgb_lut_ramp,
+	.lut_ramp_up_len = ARRAY_SIZE(s2mu005_rgb_lut_ramp),
+	.lut_ramp_dn = s2mu005_rgb_lut_ramp,
+	.lut_ramp_dn_len = ARRAY_SIZE(s2mu005_rgb_lut_ramp),
+	.lut_stay_hi = s2mu005_rgb_lut_stay_hi,
+	.lut_stay_hi_len = ARRAY_SIZE(s2mu005_rgb_lut_stay_hi),
+	.lut_stay_lo = s2mu005_rgb_lut_stay_lo,
+	.lut_stay_lo_len = ARRAY_SIZE(s2mu005_rgb_lut_stay_lo),
+	.max_brightness = 255,
+};
+
+static struct mc_subled s2mu005_rgb_subled_info[] = {
+	{
+		.channel = 0,
+		.color_index = LED_COLOR_ID_BLUE,
+	}, {
+		.channel = 1,
+		.color_index = LED_COLOR_ID_GREEN,
+	}, {
+		.channel = 2,
+		.color_index = LED_COLOR_ID_RED,
+	},
+};
+
+static int s2m_rgb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sec_pmic_dev *pmic_drvdata = dev_get_drvdata(dev->parent);
+	struct s2m_rgb *priv;
+	struct led_init_data init_data = {};
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver private\n");
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+	priv->regmap = pmic_drvdata->regmap_pmic;
+
+	switch (platform_get_device_id(pdev)->driver_data) {
+	case S2MU005:
+		priv->spec = &s2mu005_rgb_spec;
+		priv->cdev.subled_info = s2mu005_rgb_subled_info;
+		priv->cdev.num_colors = ARRAY_SIZE(s2mu005_rgb_subled_info);
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "device type %d is not supported by driver\n",
+				     pmic_drvdata->device_type);
+	}
+
+	priv->cdev.led_cdev.max_brightness = priv->spec->max_brightness;
+	priv->cdev.led_cdev.brightness_set_blocking = s2m_rgb_brightness_set;
+	priv->cdev.led_cdev.pattern_set = s2m_rgb_pattern_set;
+	priv->cdev.led_cdev.pattern_clear = s2m_rgb_pattern_clear;
+
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to create mutex lock\n");
+
+	init_data.fwnode = of_fwnode_handle(dev->of_node);
+	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->cdev,
+							&init_data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to create LED device\n");
+
+	return 0;
+}
+
+static const struct platform_device_id s2m_rgb_id_table[] = {
+	{ "s2mu005-rgb", S2MU005 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, s2m_rgb_id_table);
+
+#ifdef CONFIG_OF
+/*
+ * Device is instantiated through parent MFD device and device matching
+ * is done through platform_device_id.
+ *
+ * However if device's DT node contains proper compatible and driver is
+ * built as a module, then the *module* matching will be done through DT
+ * aliases. This requires of_device_id table. In the same time this will
+ * not change the actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2m_rgb_of_match_table[] = {
+	{
+		.compatible = "samsung,s2mu005-rgb",
+		.data = (void *)S2MU005,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2m_rgb_of_match_table);
+#endif
+
+static struct platform_driver s2m_rgb_driver = {
+	.driver = {
+		.name = "s2m-rgb",
+	},
+	.probe = s2m_rgb_probe,
+	.id_table = s2m_rgb_id_table,
+};
+module_platform_driver(s2m_rgb_driver);
+
+MODULE_DESCRIPTION("RGB LED Driver For Samsung S2M Series PMICs");
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_LICENSE("GPL");

-- 
2.52.0


