Return-Path: <linux-pm+bounces-13775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C196EFB0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72541C2421F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191B1CB314;
	Fri,  6 Sep 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="o9B0rZJu"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2C51CB120;
	Fri,  6 Sep 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615490; cv=none; b=GTLLnVpQ5AXTYd+SCjz+SK5K+TsRM5BTOzPawRkxj1oiqPTnoU4u9jCyNra8dPTL+bXz9FugULWAQqcuatvBiKP/HPlYFwmKPDI44yt/3m0bKO09ZKDO8tXigIWQ6NM5G6EcaodzO4wCiUQU7gU70TSpeXlq04/ZMhXnMYMkyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615490; c=relaxed/simple;
	bh=zh+e71h2U4lw36sE5Dk7bOPWKfCudS9fUPzrtFoG8RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPOaZ3MjFsx1T+/nKVbdZywknV8U42WWdXGf/j0LXuse9AJ/6m9ygU5neqslFOtg+zFZdU8QuxKjvhfUzw6TmIR7xMTPOyt2bLB07m5/9ed2fpszsDSVYb4p4B8tspf35FJk//NU/8AdBGb7uotVSq+tWHHdq5FWUVtU1ODDWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=o9B0rZJu; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 923D378A05;
	Fri,  6 Sep 2024 17:38:06 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 923D378A05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615487;
	bh=hZTZbSfVVPcaXYurK+c0izrqCxaMJo+BxeNMmFk+NcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9B0rZJuGBHvVtcF31692tZGc2gAOONZc0k+F5MeU4K3bBBBaAfuFH+FHmJI3QgCU
	 vyy3/9iVIrlMnjMieJWmT+12vyqD495myfsH76jRzwV9Fc9rGSVokEtejpt7vBn8GY
	 9w1gByiYcP/B7z9yx1BJQbFo9tus4JE3TyttJxjM=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>
Subject: [PATCH 7/9] leds: add Photonicat PMU LED driver
Date: Fri,  6 Sep 2024 17:36:28 +0800
Message-ID: <20240906093630.2428329-8-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906093630.2428329-1-bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Photonicat has a network status LED that can be controlled by system.
The LED status can be set through command 0x19.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 drivers/leds/Kconfig           | 11 +++++
 drivers/leds/Makefile          |  1 +
 drivers/leds/leds-photonicat.c | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/leds/leds-photonicat.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 8d9d8da376e4..539adb5944e6 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -381,6 +381,17 @@ config LEDS_PCA9532_GPIO
 	  To use a pin as gpio pca9532_type in pca9532_platform data needs to
 	  set to PCA9532_TYPE_GPIO.
 
+config LEDS_PHOTONICAT_PMU
+	tristate "LED Support for Photonicat PMU"
+	depends on LEDS_CLASS
+	depends on MFD_PHOTONICAT_PMU
+	help
+	  Photonicat has a network status LED that can be controlled by system,
+	  this option enables support for LEDs connected to the Photonicat PMU.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called leds-photonicat.
+
 config LEDS_GPIO
 	tristate "LED Support for GPIO connected LEDs"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 18afbb5a23ee..dcd5312aee12 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_PCA9532)		+= leds-pca9532.o
 obj-$(CONFIG_LEDS_PCA955X)		+= leds-pca955x.o
 obj-$(CONFIG_LEDS_PCA963X)		+= leds-pca963x.o
 obj-$(CONFIG_LEDS_PCA995X)		+= leds-pca995x.o
+obj-$(CONFIG_LEDS_PHOTONICAT_PMU)	+= leds-photonicat.o
 obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
 obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
diff --git a/drivers/leds/leds-photonicat.c b/drivers/leds/leds-photonicat.c
new file mode 100644
index 000000000000..3aa5ce525b83
--- /dev/null
+++ b/drivers/leds/leds-photonicat.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
+ */
+
+#include <linux/mfd/photonicat-pmu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+
+struct pcat_leds {
+	struct device *dev;
+	struct pcat_pmu *pmu;
+	struct led_classdev cdev;
+};
+
+static int pcat_led_status_set(struct led_classdev *cdev,
+			       enum led_brightness brightness)
+{
+	struct pcat_leds *leds = container_of(cdev, struct pcat_leds, cdev);
+	struct pcat_data_cmd_led_setup setup = { 0, 0, 0 };
+
+	if (brightness)
+		setup.on_time = 100;
+	else
+		setup.down_time = 100;
+	return pcat_pmu_write_data(leds->pmu, PCAT_CMD_NET_STATUS_LED_SETUP,
+				   &setup, sizeof(setup));
+}
+
+static int pcat_leds_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct pcat_leds *leds;
+	const char *label;
+
+	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	leds->dev = dev;
+	leds->pmu = dev_get_drvdata(dev->parent);
+	platform_set_drvdata(pdev, leds);
+
+	ret = of_property_read_string(dev->of_node, "label", &label);
+	if (ret)
+		return dev_err_probe(dev, ret, "No label property\n");
+
+	leds->cdev.name = label;
+	leds->cdev.max_brightness = 1;
+	leds->cdev.brightness_set_blocking = pcat_led_status_set;
+
+	return devm_led_classdev_register(dev, &leds->cdev);
+}
+
+static const struct of_device_id pcat_leds_dt_ids[] = {
+	{ .compatible = "ariaboard,photonicat-pmu-leds", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pcat_leds_dt_ids);
+
+static struct platform_driver pcat_leds_driver = {
+	.driver = {
+		.name = "photonicat-leds",
+		.of_match_table = pcat_leds_dt_ids,
+	},
+	.probe = pcat_leds_probe,
+};
+module_platform_driver(pcat_leds_driver);
+
+MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
+MODULE_DESCRIPTION("Photonicat PMU Status LEDs");
+MODULE_LICENSE("GPL");
-- 
2.46.0


