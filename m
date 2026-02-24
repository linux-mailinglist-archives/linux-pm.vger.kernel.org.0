Return-Path: <linux-pm+bounces-43171-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGLDIjD5nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43171-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC918BD0D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EADC4306229A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384D93AA1B8;
	Tue, 24 Feb 2026 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Z6E/K2Wb"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8F3A785B;
	Tue, 24 Feb 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960585; cv=none; b=XFAdPL1rn1HfUrBJp3T0Gye/FsSk6t4bLZt73TOtV4aeq2GW2xKizQ+igQyneB382m58BqiWefyDS81szxxeXm+AhyHMDM0vYe4Qvtpk24rhBpFmNapNKawnlxy+TypvqwOPmW2yHs6aNafZItX7DUKNWxW+LY24PqR/9PO/BAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960585; c=relaxed/simple;
	bh=N3D8IlZIOWBVRYOB67tkr0Zd/WvIzz71vAS/G80vj4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OR0Xhoeqt7GwnVOTS+NyjMXtZ8to+LNaqPk0aGRUDNfSnVE99iFhcK6l6MJJSOLkEIS7S7xyN3VZM+ORSLFmKZmfeS+cWqczyvsqIHi9mkKFZmIVU5VjOwRLSYobaHGHiv3zEyRgSGE0NB9Fx5FKk/PYqhdvYjT7ru+U+DUEwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Z6E/K2Wb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F1ADC25F30;
	Tue, 24 Feb 2026 20:16:21 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQKNqRcQZQCy; Tue, 24 Feb 2026 20:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960580; bh=N3D8IlZIOWBVRYOB67tkr0Zd/WvIzz71vAS/G80vj4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z6E/K2WbYufenCcFEPUqPZy7F1NQIVvdS4QDV/yWWM6GKqu0S4YyeO4sbzLDVYpF0
	 FHSAMHogL5BB+OvEkxluQG/Ak8qgoJchJtPskDW/QSpc3pmNB2rcEIRY+bCZlNc+BZ
	 hRIIv6fhxo83zZUDRmve1CN9Vmcn7OlXP2GBVLTvNF4fdFhAF5hZCF4zCd/Xkw3bSj
	 vtX5qnstkoXk/Ax0eXVFw/YLZ0Csikif62ZXDG1bQAoIrNFVjp4A5RDtS5Wqgf9L8e
	 3SJA1125UdZMfG3NtoMhCnmaKB3ysdUigQsjySH0IIfccgtvJl+cDtGWANLT4WbVUz
	 y+bzGW4fkI+PA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:11 +0530
Subject: [PATCH v3 09/13] leds: flash: add support for Samsung S2M series
 PMIC flash LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-9-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43171-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:mid,disroot.org:dkim,disroot.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69BC918BD0D
X-Rspamd-Action: no action

Add support for flash LEDs found in certain Samsung S2M series PMICs.
The device has two channels for LEDs, typically for the back and front
cameras in mobile devices. Both channels can be independently
controlled, and can be operated in torch or flash modes.

The driver includes initial support for the S2MU005 PMIC flash LEDs.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/leds/flash/Kconfig          |  12 +
 drivers/leds/flash/Makefile         |   1 +
 drivers/leds/flash/leds-s2m-flash.c | 429 ++++++++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index 5e08102a67841..be62e05277429 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -114,6 +114,18 @@ config LEDS_RT8515
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-rt8515.
 
+config LEDS_S2M_FLASH
+	tristate "Samsung S2M series PMICs flash/torch LED support"
+	depends on LEDS_CLASS
+	depends on MFD_SEC_CORE
+	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
+	select REGMAP_IRQ
+	help
+	  This option enables support for the flash/torch LEDs found in
+	  certain Samsung S2M series PMICs, such as the S2MU005. It has
+	  a LED channel dedicated for every physical LED. The LEDs can
+	  be controlled in flash and torch modes.
+
 config LEDS_SGM3140
 	tristate "LED support for the SGM3140"
 	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
index 712fb737a428e..44e6c1b4beb37 100644
--- a/drivers/leds/flash/Makefile
+++ b/drivers/leds/flash/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
 obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
 obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
 obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
+obj-$(CONFIG_LEDS_S2M_FLASH)	+= leds-s2m-flash.o
 obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
 obj-$(CONFIG_LEDS_SY7802)	+= leds-sy7802.o
 obj-$(CONFIG_LEDS_TPS6131X)	+= leds-tps6131x.o
diff --git a/drivers/leds/flash/leds-s2m-flash.c b/drivers/leds/flash/leds-s2m-flash.c
new file mode 100644
index 0000000000000..536a529889a9c
--- /dev/null
+++ b/drivers/leds/flash/leds-s2m-flash.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flash and Torch LED Driver for Samsung S2M series PMICs.
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/container_of.h>
+#include <linux/led-class-flash.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/mfd/samsung/s2mu005.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <media/v4l2-flash-led-class.h>
+
+#define MAX_CHANNELS	2
+
+struct s2m_fled {
+	struct device *dev;
+	struct regmap *regmap;
+	struct led_classdev_flash cdev;
+	struct v4l2_flash *v4l2_flash;
+	/*
+	 * The mutex object prevents the concurrent access of flash control
+	 * registers by the LED and V4L2 subsystems.
+	 */
+	struct mutex lock;
+	const struct s2m_fled_spec *spec;
+	unsigned int reg_enable;
+	u8 channel;
+	u8 flash_brightness;
+	u8 flash_timeout;
+};
+
+struct s2m_fled_spec {
+	u8 nr_channels;
+	u32 torch_max_brightness;
+	u32 flash_min_current_ua;
+	u32 flash_max_current_ua;
+	u32 flash_min_timeout_us;
+	u32 flash_max_timeout_us;
+	int (*torch_brightness_set_blocking)(struct led_classdev *led_cdev,
+					     enum led_brightness brightness);
+	const struct led_flash_ops *flash_ops;
+};
+
+static struct led_classdev_flash *to_cdev_flash(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct led_classdev_flash, led_cdev);
+}
+
+static struct s2m_fled *to_led_priv(struct led_classdev_flash *cdev)
+{
+	return container_of(cdev, struct s2m_fled, cdev);
+}
+
+static int s2m_fled_flash_brightness_set(struct led_classdev_flash *cdev,
+					 u32 brightness)
+{
+	struct s2m_fled *priv = to_led_priv(cdev);
+	struct led_flash_setting *setting = &cdev->brightness;
+
+	priv->flash_brightness = (brightness - setting->min) / setting->step;
+
+	return 0;
+}
+
+static int s2m_fled_flash_timeout_set(struct led_classdev_flash *cdev,
+				      u32 timeout)
+{
+	struct s2m_fled *priv = to_led_priv(cdev);
+	struct led_flash_setting *setting = &cdev->timeout;
+
+	priv->flash_timeout = (timeout - setting->min) / setting->step;
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
+static int s2m_fled_flash_external_strobe_set(struct v4l2_flash *v4l2_flash,
+					      bool enable)
+{
+	struct s2m_fled *priv = to_led_priv(v4l2_flash->fled_cdev);
+
+	mutex_lock(&priv->lock);
+
+	priv->cdev.ops->strobe_set(&priv->cdev, enable);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static const struct v4l2_flash_ops s2m_fled_v4l2_flash_ops = {
+	.external_strobe_set = s2m_fled_flash_external_strobe_set,
+};
+#else
+static const struct v4l2_flash_ops s2m_fled_v4l2_flash_ops;
+#endif
+
+static void s2m_fled_v4l2_flash_release(void *v4l2_flash)
+{
+	v4l2_flash_release(v4l2_flash);
+}
+
+static int s2mu005_fled_torch_brightness_set(struct led_classdev *cdev,
+					     enum led_brightness value)
+{
+	struct s2m_fled *priv = to_led_priv(to_cdev_flash(cdev));
+	struct regmap *regmap = priv->regmap;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	if (value == LED_OFF) {
+		ret = regmap_clear_bits(regmap, priv->reg_enable,
+					S2MU005_FLED_TORCH_EN(priv->channel));
+		if (ret < 0)
+			dev_err(priv->dev, "failed to disable torch LED\n");
+		goto unlock;
+	}
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL1(priv->channel),
+				 S2MU005_FLED_TORCH_IOUT,
+				 FIELD_PREP(S2MU005_FLED_TORCH_IOUT, value - 1));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set torch current\n");
+		goto unlock;
+	}
+
+	ret = regmap_set_bits(regmap, priv->reg_enable,
+			      S2MU005_FLED_TORCH_EN(priv->channel));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to enable torch LED\n");
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int s2mu005_fled_flash_strobe_set(struct led_classdev_flash *cdev,
+					 bool state)
+{
+	struct s2m_fled *priv = to_led_priv(cdev);
+	struct regmap *regmap = priv->regmap;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_clear_bits(regmap, priv->reg_enable,
+				S2MU005_FLED_FLASH_EN(priv->channel));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to disable flash LED\n");
+		goto unlock;
+	}
+
+	if (!state)
+		goto unlock;
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL0(priv->channel),
+				 S2MU005_FLED_FLASH_IOUT,
+				 FIELD_PREP(S2MU005_FLED_FLASH_IOUT,
+					    priv->flash_brightness));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set flash brightness\n");
+		goto unlock;
+	}
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL3(priv->channel),
+				 S2MU005_FLED_FLASH_TIMEOUT,
+				 FIELD_PREP(S2MU005_FLED_FLASH_TIMEOUT,
+					    priv->flash_timeout));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set flash timeout\n");
+		goto unlock;
+	}
+
+	ret = regmap_set_bits(regmap, priv->reg_enable,
+			      S2MU005_FLED_FLASH_EN(priv->channel));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to enable flash LED\n");
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int s2mu005_fled_flash_strobe_get(struct led_classdev_flash *cdev,
+					 bool *state)
+{
+	struct s2m_fled *priv = to_led_priv(cdev);
+	struct regmap *regmap = priv->regmap;
+	u8 channel = priv->channel;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_read(regmap, S2MU005_REG_FLED_STATUS, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to fetch LED status");
+		goto unlock;
+	}
+
+	*state = !!(val & S2MU005_FLED_FLASH_STATUS(channel));
+
+unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static const struct led_flash_ops s2mu005_fled_flash_ops = {
+	.flash_brightness_set = s2m_fled_flash_brightness_set,
+	.timeout_set = s2m_fled_flash_timeout_set,
+	.strobe_set = s2mu005_fled_flash_strobe_set,
+	.strobe_get = s2mu005_fled_flash_strobe_get,
+};
+
+static int s2mu005_fled_init(struct s2m_fled *priv)
+{
+	unsigned int val;
+	int ret;
+
+	/* Enable the LED channels. */
+	ret = regmap_set_bits(priv->regmap, S2MU005_REG_FLED_CTRL1,
+			      S2MU005_FLED_CH_EN);
+	if (ret < 0)
+		return dev_err_probe(priv->dev, ret, "failed to enable LED channels\n");
+
+	/*
+	 * Get the LED enable register address. Revision EVT0 has the
+	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
+	 */
+	ret = regmap_read(priv->regmap, S2MU005_REG_ID, &val);
+	if (ret < 0)
+		return dev_err_probe(priv->dev, ret, "failed to read revision\n");
+
+	if (FIELD_GET(S2MU005_ID_MASK, val) == 0)
+		priv->reg_enable = S2MU005_REG_FLED_CTRL4;
+	else
+		priv->reg_enable = S2MU005_REG_FLED_CTRL6;
+
+	return 0;
+}
+
+static const struct s2m_fled_spec s2mu005_fled_spec = {
+	.nr_channels = 2,
+	.torch_max_brightness = 16,
+	.flash_min_current_ua = 25000,
+	.flash_max_current_ua = 375000, /* 400000 causes flickering */
+	.flash_min_timeout_us = 62000,
+	.flash_max_timeout_us = 992000,
+	.torch_brightness_set_blocking = s2mu005_fled_torch_brightness_set,
+	.flash_ops = &s2mu005_fled_flash_ops,
+};
+
+static int s2m_fled_init_channel(struct s2m_fled *priv,
+				 struct fwnode_handle *fwnp)
+{
+	struct led_classdev *led = &priv->cdev.led_cdev;
+	struct led_init_data init_data = {};
+	struct v4l2_flash_config v4l2_cfg = {};
+	int ret;
+
+	led->max_brightness = priv->spec->torch_max_brightness;
+	led->brightness_set_blocking = priv->spec->torch_brightness_set_blocking;
+	led->flags |= LED_DEV_CAP_FLASH;
+
+	priv->cdev.timeout.min = priv->spec->flash_min_timeout_us;
+	priv->cdev.timeout.step = priv->spec->flash_min_timeout_us;
+	priv->cdev.timeout.max = priv->spec->flash_max_timeout_us;
+	priv->cdev.timeout.val = priv->spec->flash_max_timeout_us;
+
+	priv->cdev.brightness.min = priv->spec->flash_min_current_ua;
+	priv->cdev.brightness.step = priv->spec->flash_min_current_ua;
+	priv->cdev.brightness.max = priv->spec->flash_max_current_ua;
+	priv->cdev.brightness.val = priv->spec->flash_max_current_ua;
+
+	s2m_fled_flash_timeout_set(&priv->cdev, priv->cdev.timeout.val);
+	s2m_fled_flash_brightness_set(&priv->cdev, priv->cdev.brightness.val);
+
+	priv->cdev.ops = priv->spec->flash_ops;
+
+	init_data.fwnode = fwnp;
+	ret = devm_led_classdev_flash_register_ext(priv->dev, &priv->cdev,
+						   &init_data);
+	if (ret < 0)
+		return dev_err_probe(priv->dev, ret, "failed to create LED flash device\n");
+
+	v4l2_cfg.intensity.min = priv->spec->flash_min_current_ua;
+	v4l2_cfg.intensity.step = priv->spec->flash_min_current_ua;
+	v4l2_cfg.intensity.max = priv->spec->flash_max_current_ua;
+	v4l2_cfg.intensity.val = priv->spec->flash_max_current_ua;
+
+	v4l2_cfg.has_external_strobe = true;
+
+	priv->v4l2_flash = v4l2_flash_init(priv->dev, fwnp, &priv->cdev,
+					   &s2m_fled_v4l2_flash_ops, &v4l2_cfg);
+	if (IS_ERR(priv->v4l2_flash)) {
+		v4l2_flash_release(priv->v4l2_flash);
+		return dev_err_probe(priv->dev, PTR_ERR(priv->v4l2_flash),
+				     "failed to create V4L2 flash device\n");
+	}
+
+	ret = devm_add_action_or_reset(priv->dev, (void *)s2m_fled_v4l2_flash_release,
+				       priv->v4l2_flash);
+	if (ret < 0)
+		return dev_err_probe(priv->dev, ret, "failed to add cleanup action\n");
+
+	return 0;
+}
+
+static int s2m_fled_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sec_pmic_dev *pmic_drvdata = dev_get_drvdata(dev->parent);
+	struct s2m_fled *priv;
+	bool channel_initialized[MAX_CHANNELS] = { false };
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv) * MAX_CHANNELS, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+	priv->regmap = pmic_drvdata->regmap_pmic;
+
+	switch (platform_get_device_id(pdev)->driver_data) {
+	case S2MU005:
+		priv->spec = &s2mu005_fled_spec;
+		ret = s2mu005_fled_init(priv);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "device type %d is not supported by driver\n",
+				     pmic_drvdata->device_type);
+	}
+
+	if (priv->spec->nr_channels > MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL,
+				     "number of channels specified (%u) exceeds the limit (%u)\n",
+				     priv->spec->nr_channels, MAX_CHANNELS);
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg;
+
+		if (fwnode_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg >= priv->spec->nr_channels) {
+			dev_warn(dev, "channel %d is non-existent\n", reg);
+			continue;
+		}
+
+		if (channel_initialized[reg]) {
+			dev_warn(dev, "duplicate node for channel %d\n", reg);
+			continue;
+		}
+
+		priv[reg].dev = priv->dev;
+		priv[reg].regmap = priv->regmap;
+		priv[reg].spec = priv->spec;
+		priv[reg].reg_enable = priv->reg_enable;
+		priv[reg].channel = (u8)reg;
+
+		ret = devm_mutex_init(dev, &priv[reg].lock);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to create mutex lock\n");
+
+		ret = s2m_fled_init_channel(priv + reg, child);
+		if (ret < 0)
+			return ret;
+
+		channel_initialized[reg] = true;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id s2m_fled_id_table[] = {
+	{ "s2mu005-flash", S2MU005 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, s2m_fled_id_table);
+
+/*
+ * Device is instantiated through parent MFD device and device matching
+ * is done through platform_device_id.
+ *
+ * However if device's DT node contains proper compatible and driver is
+ * built as a module, then the *module* matching will be done through DT
+ * aliases. This requires of_device_id table. In the same time this will
+ * not change the actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2m_fled_of_match_table[] = {
+	{
+		.compatible = "samsung,s2mu005-flash",
+		.data = (void *)S2MU005,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2m_fled_of_match_table);
+
+static struct platform_driver s2m_fled_driver = {
+	.driver = {
+		.name = "s2m-flash",
+	},
+	.probe = s2m_fled_probe,
+	.id_table = s2m_fled_id_table,
+};
+module_platform_driver(s2m_fled_driver);
+
+MODULE_DESCRIPTION("Flash/Torch LED Driver For Samsung S2M Series PMICs");
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_LICENSE("GPL");

-- 
2.52.0


