Return-Path: <linux-pm+bounces-7511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F58BC3C9
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 22:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01621F2205B
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA32276028;
	Sun,  5 May 2024 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rz/9LoT8"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682A757E1;
	Sun,  5 May 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942631; cv=none; b=MA2kVbEBoSXSHXzSfpOlC9UG4OwHmNqbk68Gh9enoMiVteSUvzPntxBny5/+CBFFwcNDiNFUavNO0rXc+q9LkZk3z0g+Q0OpZl9B7jAZhczrfmd2IbNHOhdhkt/Vv6llIMtHlNnDYEX4/U24fsEdmIY/kcYKad7S5NBUn0t+10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942631; c=relaxed/simple;
	bh=gA7s7UCZEe5kKL1FVTHg7aew7OnKObi9bZPJ9EmFYE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWUwhWL0hCPkPZjoP/rSwM9hXc1AadIqd/cEc1UgAZ5Iu04D/6BULXsly9vNQQHZ/aQOcvb9ORgkt9v8LSrpN6w93YWnNbmt+dv1BDOWeh1t8DWnAhx9i+2d63HcZ7dkSUBwDy0Q7sW4RQ0aKjzvFjgs4k+QtW8Ju4qZjkC4CzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rz/9LoT8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714942625;
	bh=gA7s7UCZEe5kKL1FVTHg7aew7OnKObi9bZPJ9EmFYE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rz/9LoT8OW6q0Bm+Qz8blYkgtL+NdbmB6pPFVSazyyg+uN0Rb2WXGpRz6NM3A7At/
	 dCrqDaeJIOdz9vKf58h07++jflzrQTgsFnrtaKmTtYXfboMeQBcO7trtIfmNFYIw+n
	 DxLfhKYEsUMnVw2Dp0eWPmy1UheuZG1YpauSz+00=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 05 May 2024 22:56:34 +0200
Subject: [PATCH 1/2] platform/chrome: cros_ec_framework_laptop: introduce
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240505-cros_ec-framework-v1-1-402662d6276b@weissschuh.net>
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
In-Reply-To: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Dustin L. Howett" <dustin@howett.net>, Sebastian Reichel <sre@kernel.org>, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714942624; l=5459;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gA7s7UCZEe5kKL1FVTHg7aew7OnKObi9bZPJ9EmFYE4=;
 b=fzjK631GremBbM3R6RGdZBVXEfXJ2AnE7f8LuuDx7pEOVcD3zYDZwWfqfTe+u7DEFuOTpBCFv
 R6hVlNV14iuDJYCUC81hwSjuCHosWue/snCEppYnx8KGd3inIfkzRax
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Framework Laptops are using embedded controller firmware based on the
ChromeOS EC project.
In addition to the standard upstream commands, some vendor-specific
ones are implemented.

Add a driver for those custom EC commands.

At first, provide an empty driver that only takes care of scaffolding and
device binding.
Further patches will add functionality to the driver.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS                                        |  5 ++
 drivers/mfd/cros_ec_dev.c                          | 13 ++++++
 drivers/platform/chrome/Kconfig                    | 11 +++++
 drivers/platform/chrome/Makefile                   |  1 +
 drivers/platform/chrome/cros_ec_framework_laptop.c | 53 ++++++++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..60699c289757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4988,6 +4988,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
+CHROMEOS EC FRAMEWORK LAPTOP EXTENSIONS
+M:	Thomas Weißschuh <linux@weissschuh.net>
+S:	Maintained
+F:	drivers/platform/chrome/cros_ec_framework_laptop.c
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a52d59cc2b1e..0a36e77e5039 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -145,6 +145,10 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
 	{ .name = "cros-ec-vbc", }
 };
 
+static const struct mfd_cell cros_ec_framework_cells[] = {
+	{ .name = "cros-ec-framework", }
+};
+
 static void cros_ec_class_release(struct device *dev)
 {
 	kfree(to_cros_ec_dev(dev));
@@ -299,6 +303,15 @@ static int ec_device_probe(struct platform_device *pdev)
 				 retval);
 	}
 
+	 /* The EC on Framework laptops implements some nonstandard features */
+	if (dmi_match(DMI_SYS_VENDOR, "Framework")) {
+		retval = mfd_add_hotplug_devices(ec->dev, cros_ec_framework_cells,
+						 ARRAY_SIZE(cros_ec_framework_cells));
+		if (retval)
+			dev_warn(ec->dev, "failed to add framework laptop devices: %d\n",
+				 retval);
+	}
+
 	return 0;
 
 failed:
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 073616b5b5a0..ff69ee226606 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -239,6 +239,17 @@ config CROS_EC_TYPEC
 	  To compile this driver as a module, choose M here: the module will be
 	  called cros-ec-typec.
 
+config CROS_EC_FRAMEWORK_LAPTOP
+	tristate "ChromeOS EC Framework Laptop extensions"
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
+	help
+	  If you say Y here, you get support for using Framework Laptop-specific extensions
+	  of the Chrome OS EC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros_ec_framework_laptop.
+
 config CROS_HPS_I2C
 	tristate "ChromeOS HPS device"
 	depends on HID && I2C && PM
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 2dcc6ccc2302..ce6aac620086 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)	+= chromeos_privacy_screen.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
 obj-$(CONFIG_CROS_EC)			+= cros_ec.o
+obj-$(CONFIG_CROS_EC_FRAMEWORK_LAPTOP)	+= cros_ec_framework_laptop.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_TYPEC_SWITCH)		+= cros_typec_switch.o
diff --git a/drivers/platform/chrome/cros_ec_framework_laptop.c b/drivers/platform/chrome/cros_ec_framework_laptop.c
new file mode 100644
index 000000000000..8a8bf039fa9c
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_framework_laptop.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  ChromesOS EC driver for Framework laptop
+ *
+ *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME	"cros-ec-framework"
+
+struct cros_fwk_priv {
+	struct cros_ec_device *cros_ec;
+};
+
+static int cros_fwk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct cros_fwk_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->cros_ec = cros_ec;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static const struct platform_device_id cros_fwk_id[] = {
+	{ DRV_NAME, 0 },
+	{ }
+};
+
+static struct platform_driver cros_fwk_driver = {
+	.driver.name	= DRV_NAME,
+	.probe		= cros_fwk_probe,
+	.id_table	= cros_fwk_id,
+};
+
+module_platform_driver(cros_fwk_driver);
+
+MODULE_DEVICE_TABLE(platform, cros_fwk_id);
+MODULE_DESCRIPTION("ChromeOS EC Framework Laptop extensions");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net");
+MODULE_LICENSE("GPL");

-- 
2.45.0


