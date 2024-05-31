Return-Path: <linux-pm+bounces-8457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA918D60E0
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C1728365A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B486157A67;
	Fri, 31 May 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiM6nvVR"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B1157493
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155700; cv=none; b=QZv5P5TJ71f6WKL8uGJ9OcJej1cKKAJgAyzy76EZxsX/7ConWhcMCGkGp5R9p5loh6P3YcVc/JTdCmzmsvukpFt+TXtKsxxn/RnXcxC2gY+oGvbPle+5uPzLwrWHtwatNd/S1XwOMis1fRakx4WXGqtq1TjfybCJFODs4dNtu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155700; c=relaxed/simple;
	bh=/Y1cANjGsNxw79Q7QT5Ay89/GPkTFneBf1TSZzyvz8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9QZ5QpUimjLYImmnXoTRT/eEU/LNRENs1MRFpbk6xPjFiNaEfwfVthWyPgGUgFCijsKXvPH0vM28O2M85zLkU+ZmuTgt0JyUrQQCizW+sLLpFl6B0EW3JsTAkgXLmf+bF8b8G5DEMesKqDHz+EHBUBSbrcZ2VhrgR668zD5EsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiM6nvVR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717155698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgoJzHCO0fF6+GWMsQVsPo+HgDxcKOKoGklnp5IwUdY=;
	b=PiM6nvVRnya2hag58PEatGL2WxqaQ62GhjgiijG+KHR++ZnHbB2vf8Ywx1fOENX5Myq22L
	mIlF1Y94Ydw3ynVoYUTwgrxB5kZ6+I1KPpaeaLKrFtNTOu5NYTRA34NSQOWNFiq0c7yqUW
	46lLVuewJOYAXc6liNiJ0hzmppjL80E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-DqhDFjn_PcmUqyiEdbwMfw-1; Fri,
 31 May 2024 07:41:34 -0400
X-MC-Unique: DqhDFjn_PcmUqyiEdbwMfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C8791C0512B;
	Fri, 31 May 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0F727414;
	Fri, 31 May 2024 11:41:31 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Kate Hsuan <hpa@redhat.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v10 1/6] leds: rgb: leds-ktd202x: Get device properties through fwnode to support ACPI
Date: Fri, 31 May 2024 13:41:19 +0200
Message-ID: <20240531114124.45346-2-hdegoede@redhat.com>
In-Reply-To: <20240531114124.45346-1-hdegoede@redhat.com>
References: <20240531114124.45346-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Kate Hsuan <hpa@redhat.com>

This LED controller is installed on a Xiaomi pad2 and it is an x86
platform. The original driver is based on the device tree and can't be
used for this ACPI based system. This patch migrated the driver to use
fwnode to access the properties. Moreover, the fwnode API supports the
device tree so this work won't affect the original implementations.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
Tested-by: André Apitzsch <git@apitzsch.eu> # on BQ Aquaris M5
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/leds/rgb/Kconfig        |  1 -
 drivers/leds/rgb/leds-ktd202x.c | 64 +++++++++++++++++----------------
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 8fc12d6a2958..222d943d826a 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -17,7 +17,6 @@ config LEDS_GROUP_MULTICOLOR
 config LEDS_KTD202X
 	tristate "LED support for KTD202x Chips"
 	depends on I2C
-	depends on OF
 	select REGMAP_I2C
 	help
 	  This option enables support for the Kinetic KTD2026/KTD2027
diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index 514965795a10..f1c810c415a4 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -99,7 +99,7 @@ struct ktd202x {
 	struct device *dev;
 	struct regmap *regmap;
 	bool enabled;
-	int num_leds;
+	unsigned long num_leds;
 	struct ktd202x_led leds[] __counted_by(num_leds);
 };
 
@@ -381,16 +381,19 @@ static int ktd202x_blink_mc_set(struct led_classdev *cdev,
 				 mc->num_colors);
 }
 
-static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
+static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct fwnode_handle *fwnode,
 				 struct ktd202x_led *led, struct led_init_data *init_data)
 {
+	struct fwnode_handle *child;
 	struct led_classdev *cdev;
-	struct device_node *child;
 	struct mc_subled *info;
 	int num_channels;
 	int i = 0;
 
-	num_channels = of_get_available_child_count(np);
+	num_channels = 0;
+	fwnode_for_each_available_child_node(fwnode, child)
+		num_channels++;
+
 	if (!num_channels || num_channels > chip->num_leds)
 		return -EINVAL;
 
@@ -398,22 +401,22 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
 	if (!info)
 		return -ENOMEM;
 
-	for_each_available_child_of_node(np, child) {
+	fwnode_for_each_available_child_node(fwnode, child) {
 		u32 mono_color;
 		u32 reg;
 		int ret;
 
-		ret = of_property_read_u32(child, "reg", &reg);
+		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret != 0 || reg >= chip->num_leds) {
-			dev_err(chip->dev, "invalid 'reg' of %pOFn\n", child);
-			of_node_put(child);
-			return -EINVAL;
+			dev_err(chip->dev, "invalid 'reg' of %pfw\n", child);
+			fwnode_handle_put(child);
+			return ret;
 		}
 
-		ret = of_property_read_u32(child, "color", &mono_color);
+		ret = fwnode_property_read_u32(child, "color", &mono_color);
 		if (ret < 0 && ret != -EINVAL) {
-			dev_err(chip->dev, "failed to parse 'color' of %pOF\n", child);
-			of_node_put(child);
+			dev_err(chip->dev, "failed to parse 'color' of %pfw\n", child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 
@@ -433,16 +436,16 @@ static int ktd202x_setup_led_rgb(struct ktd202x *chip, struct device_node *np,
 	return devm_led_classdev_multicolor_register_ext(chip->dev, &led->mcdev, init_data);
 }
 
-static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np,
+static int ktd202x_setup_led_single(struct ktd202x *chip, struct fwnode_handle *fwnode,
 				    struct ktd202x_led *led, struct led_init_data *init_data)
 {
 	struct led_classdev *cdev;
 	u32 reg;
 	int ret;
 
-	ret = of_property_read_u32(np, "reg", &reg);
+	ret = fwnode_property_read_u32(fwnode, "reg", &reg);
 	if (ret != 0 || reg >= chip->num_leds) {
-		dev_err(chip->dev, "invalid 'reg' of %pOFn\n", np);
+		dev_err(chip->dev, "invalid 'reg' of %pfw\n", fwnode);
 		return -EINVAL;
 	}
 	led->index = reg;
@@ -454,7 +457,7 @@ static int ktd202x_setup_led_single(struct ktd202x *chip, struct device_node *np
 	return devm_led_classdev_register_ext(chip->dev, &led->cdev, init_data);
 }
 
-static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigned int index)
+static int ktd202x_add_led(struct ktd202x *chip, struct fwnode_handle *fwnode, unsigned int index)
 {
 	struct ktd202x_led *led = &chip->leds[index];
 	struct led_init_data init_data = {};
@@ -463,21 +466,21 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 	int ret;
 
 	/* Color property is optional in single color case */
-	ret = of_property_read_u32(np, "color", &color);
+	ret = fwnode_property_read_u32(fwnode, "color", &color);
 	if (ret < 0 && ret != -EINVAL) {
-		dev_err(chip->dev, "failed to parse 'color' of %pOF\n", np);
+		dev_err(chip->dev, "failed to parse 'color' of %pfw\n", fwnode);
 		return ret;
 	}
 
 	led->chip = chip;
-	init_data.fwnode = of_fwnode_handle(np);
+	init_data.fwnode = fwnode;
 
 	if (color == LED_COLOR_ID_RGB) {
 		cdev = &led->mcdev.led_cdev;
-		ret = ktd202x_setup_led_rgb(chip, np, led, &init_data);
+		ret = ktd202x_setup_led_rgb(chip, fwnode, led, &init_data);
 	} else {
 		cdev = &led->cdev;
-		ret = ktd202x_setup_led_single(chip, np, led, &init_data);
+		ret = ktd202x_setup_led_single(chip, fwnode, led, &init_data);
 	}
 
 	if (ret) {
@@ -490,15 +493,14 @@ static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np, unsigne
 	return 0;
 }
 
-static int ktd202x_probe_dt(struct ktd202x *chip)
+static int ktd202x_probe_fw(struct ktd202x *chip)
 {
-	struct device_node *np = dev_of_node(chip->dev), *child;
+	struct fwnode_handle *child;
+	struct device *dev = chip->dev;
 	int count;
 	int i = 0;
 
-	chip->num_leds = (int)(unsigned long)of_device_get_match_data(chip->dev);
-
-	count = of_get_available_child_count(np);
+	count = device_get_child_node_count(dev);
 	if (!count || count > chip->num_leds)
 		return -EINVAL;
 
@@ -507,11 +509,11 @@ static int ktd202x_probe_dt(struct ktd202x *chip)
 	/* Allow the device to execute the complete reset */
 	usleep_range(200, 300);
 
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node(dev, child) {
 		int ret = ktd202x_add_led(chip, child, i);
 
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 		i++;
@@ -554,6 +556,8 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	chip->num_leds = (unsigned long)i2c_get_match_data(client);
+
 	chip->regulators[0].supply = "vin";
 	chip->regulators[1].supply = "vio";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);
@@ -568,7 +572,7 @@ static int ktd202x_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = ktd202x_probe_dt(chip);
+	ret = ktd202x_probe_fw(chip);
 	if (ret < 0) {
 		regulator_bulk_disable(ARRAY_SIZE(chip->regulators), chip->regulators);
 		return ret;
@@ -605,7 +609,7 @@ static void ktd202x_shutdown(struct i2c_client *client)
 static const struct of_device_id ktd202x_match_table[] = {
 	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
 	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, ktd202x_match_table);
 
-- 
2.45.1


