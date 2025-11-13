Return-Path: <linux-pm+bounces-37980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F605C59A1E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CE63B95F3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDEE31A04E;
	Thu, 13 Nov 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jynbY1bl"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344631771B;
	Thu, 13 Nov 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060847; cv=none; b=kwvNtZ2CBmDNApS03yto5KEJ5auHlb8USF+FN7npmVyoDU+AJG8QqPSTvKkAgJ08hNXlcEPYr6lLmJzi/cY04LhEyrPfAt49LBeLtRx/p4oKIBHJeJRjne6oFfh7rM0rXEniGkIJY8YhTGLJeXxSRbI91/NDoCT9ht53RNs0OTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060847; c=relaxed/simple;
	bh=nv67wrlfTtpEt8muDUPeDzA9Ss5epmezzhocRJlIO3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQqi1TnKuhI/ihVyYhzUKaztGI2N/0wpZBwsjRQ8u0XiZYtxdicnM+5nZ/HxRo2ucpYGsI6eXOUnGhoOSztZgFvW5jmUMzr5Bqa4KvfUFn+10Xl+zZMg6yWnbq8zqK1MYl6FDMgB3VeoFuKeIuEPvDxXdxnf9xIONCxTsN3f4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jynbY1bl; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1079C26783;
	Thu, 13 Nov 2025 20:07:24 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0gJgWxdTwZk; Thu, 13 Nov 2025 20:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060842; bh=nv67wrlfTtpEt8muDUPeDzA9Ss5epmezzhocRJlIO3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jynbY1blh/cM4iDRguJbZm+emTl7rXfpTAMJx20LkG2+ch63KIxRtDrA1ySkG/bg8
	 VQySj87fDrPg6i6btKcrC/+CL9uHbUPVBe03PBECJA80RAzhRNMBFEVyAR8se4nh8i
	 9wUghSvIJQ/11R1ogqTWQaRDKNtz9Gz1qxjipGqv/zYx6bEAW7x1DFSVfOqAS2tzXD
	 40iSz0BW1L2Go9eO5Xn0QUWwt0wqH8VbXoBF2B6uaw6dZpLQWmYgyxx4hWXZ7XQSZR
	 nTOzLc50kYsBymqohDxP9hZkoZ6DDqjjh26BeDcSpqsuLp6tyV9A0YeCpDGmZgJG+g
	 7GHSVlmc1vQOg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:10 +0530
Subject: [PATCH 09/13] leds: flash: add support for Samsung S2M series PMIC
 flash LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-9-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=14501;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=nv67wrlfTtpEt8muDUPeDzA9Ss5epmezzhocRJlIO3c=;
 b=IGfhTa9mVlolpn8zeK3unpq7g5eziFg2H+BCzlKrJ0GWmrFsKIED8sBIgwQy5d6V4aEnP+l7Y
 fq2+9FtqP6UDNvhUwl+qTHJIU43M9DShewCtPBBlY+TTHrGm3T6+py6
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Add support for flash LEDs found in certain Samsung S2M series PMICs.
The device has two channels for LEDs, typically for the back and front
cameras in mobile devices. Both channels can be independently
controlled, and can be operated in torch or flash modes.

The driver includes initial support for the S2MU005 PMIC flash LEDs.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/leds/flash/Kconfig          |  12 ++
 drivers/leds/flash/Makefile         |   1 +
 drivers/leds/flash/leds-s2m-flash.c | 413 ++++++++++++++++++++++++++++++++++++
 3 files changed, 426 insertions(+)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index 5e08102a6784..be62e0527742 100644
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
index 712fb737a428..44e6c1b4beb3 100644
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
index 000000000000..7ea033403b43
--- /dev/null
+++ b/drivers/leds/flash/leds-s2m-flash.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Flash and Torch LED Driver for Samsung S2M series PMICs.
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/led-class-flash.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/mfd/samsung/s2mu005.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
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
+	struct mutex lock;
+	const struct s2m_fled_spec *spec;
+	unsigned int pmic_revision;
+	u8 channel;
+	u8 flash_brightness;
+	u8 flash_timeout;
+};
+
+struct s2m_fled_spec {
+	u8 num_channels;
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
+static int s2mu005_fled_torch_brightness_set(struct led_classdev *cdev,
+					     enum led_brightness value)
+{
+	struct s2m_fled *priv = to_led_priv(to_cdev_flash(cdev));
+	struct regmap *regmap = priv->regmap;
+	u8 channel = priv->channel;
+	unsigned int reg_enable;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	/*
+	 * Get the LED enable register address. Revision EVT0 has the
+	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
+	 */
+	if (priv->pmic_revision == 0)
+		reg_enable = S2MU005_REG_FLED_CTRL4;
+	else
+		reg_enable = S2MU005_REG_FLED_CTRL6;
+
+	if (value == LED_OFF) {
+		ret = regmap_clear_bits(regmap, reg_enable,
+					S2MU005_FLED_TORCH_EN(channel));
+		if (ret < 0)
+			dev_err(priv->dev, "failed to disable torch LED\n");
+		goto unlock;
+	}
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL1(channel),
+				 S2MU005_FLED_TORCH_IOUT,
+				 FIELD_PREP(S2MU005_FLED_TORCH_IOUT, value - 1));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set torch current\n");
+		goto unlock;
+	}
+
+	ret = regmap_set_bits(regmap, reg_enable, S2MU005_FLED_TORCH_EN(channel));
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
+	u8 channel = priv->channel;
+	unsigned int reg_enable;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	/*
+	 * Get the LED enable register address. Revision EVT0 has the
+	 * register at CTRL4, while EVT1 and higher have it at CTRL6.
+	 */
+	if (priv->pmic_revision == 0)
+		reg_enable = S2MU005_REG_FLED_CTRL4;
+	else
+		reg_enable = S2MU005_REG_FLED_CTRL6;
+
+	ret = regmap_clear_bits(regmap, reg_enable, S2MU005_FLED_FLASH_EN(channel));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to disable flash LED\n");
+		goto unlock;
+	}
+
+	if (!state)
+		goto unlock;
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL0(channel),
+				 S2MU005_FLED_FLASH_IOUT,
+				 FIELD_PREP(S2MU005_FLED_FLASH_IOUT,
+					    priv->flash_brightness));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set flash brightness\n");
+		goto unlock;
+	}
+
+	ret = regmap_update_bits(regmap, S2MU005_REG_FLED_CH_CTRL3(channel),
+				 S2MU005_FLED_FLASH_TIMEOUT,
+				 FIELD_PREP(S2MU005_FLED_FLASH_TIMEOUT,
+					    priv->flash_timeout));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set flash timeout\n");
+		goto unlock;
+	}
+
+	ret = regmap_set_bits(regmap, reg_enable, S2MU005_FLED_FLASH_EN(channel));
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
+static const struct s2m_fled_spec s2mu005_fled_spec = {
+	.num_channels = 2,
+	.torch_max_brightness = 16,
+	.flash_min_current_ua = 25000,
+	.flash_max_current_ua = 375000, /* 400000 causes flickering */
+	.flash_min_timeout_us = 62000,
+	.flash_max_timeout_us = 992000,
+	.torch_brightness_set_blocking = s2mu005_fled_torch_brightness_set,
+	.flash_ops = &s2mu005_fled_flash_ops,
+};
+
+static int s2m_fled_init_channel(struct device *dev, struct fwnode_handle *fwnp,
+				 struct s2m_fled *priv)
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
+	ret = devm_led_classdev_flash_register_ext(dev, &priv->cdev, &init_data);
+	if (ret < 0) {
+		dev_err(dev, "failed to create LED flash device\n");
+		return ret;
+	}
+
+	v4l2_cfg.intensity.min = priv->spec->flash_min_current_ua;
+	v4l2_cfg.intensity.step = priv->spec->flash_min_current_ua;
+	v4l2_cfg.intensity.max = priv->spec->flash_max_current_ua;
+	v4l2_cfg.intensity.val = priv->spec->flash_max_current_ua;
+
+	v4l2_cfg.has_external_strobe = true;
+
+	priv->v4l2_flash = v4l2_flash_init(dev, fwnp, &priv->cdev,
+					   &s2m_fled_v4l2_flash_ops, &v4l2_cfg);
+	if (IS_ERR(priv->v4l2_flash)) {
+		dev_err(dev, "failed to create V4L2 flash device\n");
+		v4l2_flash_release(priv->v4l2_flash);
+		return PTR_ERR(priv->v4l2_flash);
+	}
+
+	return devm_add_action_or_reset(dev, (void *)v4l2_flash_release,
+					priv->v4l2_flash);
+}
+
+static int s2m_fled_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sec_pmic_dev *pmic_drvdata = dev_get_drvdata(dev->parent);
+	struct s2m_fled *priv;
+	struct fwnode_handle *child;
+	struct regmap *regmap;
+	const struct s2m_fled_spec *spec;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv) * MAX_CHANNELS, GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver private\n");
+
+	platform_set_drvdata(pdev, priv);
+	regmap = pmic_drvdata->regmap_pmic;
+
+	switch (platform_get_device_id(pdev)->driver_data) {
+	case S2MU005:
+		spec = &s2mu005_fled_spec;
+		/* Enable the LED channels. */
+		ret = regmap_set_bits(regmap, S2MU005_REG_FLED_CTRL1,
+				      S2MU005_FLED_CH_EN);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to enable LED channels\n");
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "device type %d is not supported by driver\n",
+				     pmic_drvdata->device_type);
+	}
+
+	device_for_each_child_node(dev, child) {
+		u32 reg;
+
+		if (fwnode_property_read_u32(child, "reg", &reg))
+			goto next_child;
+
+		if (reg >= spec->num_channels) {
+			dev_warn(dev, "channel %d is non-existent\n", reg);
+			goto next_child;
+		}
+
+		if (priv[reg].dev) {
+			dev_warn(dev, "duplicate node for channel %d\n", reg);
+			goto next_child;
+		}
+
+		priv[reg].dev = dev;
+		priv[reg].regmap = regmap;
+		priv[reg].channel = (u8)reg;
+		priv[reg].spec = spec;
+		priv[reg].pmic_revision = pmic_drvdata->revision;
+
+		ret = devm_mutex_init(dev, &priv[reg].lock);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to create mutex lock\n");
+
+		ret = s2m_fled_init_channel(dev, child, &priv[reg]);
+		if (ret < 0)
+			dev_warn(dev, "channel init failed (%d)\n", ret);
+
+next_child:
+		fwnode_handle_put(child);
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
+static const struct of_device_id s2m_fled_of_match_table[] = {
+	{
+		.compatible = "samsung,s2mu005-flash",
+		.data = (void *)S2MU005,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2m_fled_of_match_table);
+#endif
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
2.51.2


