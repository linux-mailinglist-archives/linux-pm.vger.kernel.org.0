Return-Path: <linux-pm+bounces-13771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411896EF8E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707551C23FC0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E71C9DE8;
	Fri,  6 Sep 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="cOWjLARj"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086F1C86F6;
	Fri,  6 Sep 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615485; cv=none; b=kT7Dcnmh9ZTFDNWsDnbTglEU7bYfM/ATmPOlQQl4p9cWhrdFhCQXhNpP5I5EYyFSDBsBewL9syznm1PjuaqdL1jT14RsaQhqaHTHNnp7DS4oz3HUWQYUgMsmb2VASl54bvAZBbQeWY9MdUi7R3AXRm56Dgi/Pk7uXNTMeLiDjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615485; c=relaxed/simple;
	bh=LfPgJ9L7ipnqXTC1RE0Chy7mvYPec7F2PG4Ztb0NhtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZIXRFgdSDaWOB9Hg92/KG3K93GTXo+DPejAHkI3AtCu0BFYTYfefAa3fNaBOgOD2bBpTzgc/AafHC+TJGEc1Bfa0xBG+HKwNL2oyIiti9nhYBlvUk4uRKe34lM66g5lR/jHp7SumHsGU89zPS+pmWe9IESzy657QD1R1KBbobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=cOWjLARj; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 7478E78A01;
	Fri,  6 Sep 2024 17:38:01 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 7478E78A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615482;
	bh=/BoOWIWGCb24d6nKmXmJ9+eWvMhDf9jlRmzVWBVGxXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOWjLARj/yCmcU4XoKmi9pd17fR2pQn017YQRLfZnjNNFdtVg+/NxX8N/wGLQgqBV
	 +6F7mi4pWMpY9tNkv4vo886Hnh2wna5hr+BsqTMhRHDv27oGf0jhw1aIsxP59Z2qQb
	 Ig42NdTjLQF+pv67M8nvmHgVkL9M7v/BXRao4204=
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
Subject: [PATCH 3/9] watchdog: Add Photonicat PMU watchdog driver
Date: Fri,  6 Sep 2024 17:36:24 +0800
Message-ID: <20240906093630.2428329-4-bigfoot@classfun.cn>
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

This driver provides access to Photonicat PMU watchdog functionality.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 drivers/watchdog/Kconfig          |  12 +++
 drivers/watchdog/Makefile         |   1 +
 drivers/watchdog/photonicat-wdt.c | 124 ++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/watchdog/photonicat-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index bae1d97cce89..4094216a1c09 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -300,6 +300,18 @@ config MENZ069_WATCHDOG
 	  This driver can also be built as a module. If so the module
 	  will be called menz069_wdt.
 
+config PHOTONICAT_PMU_WDT
+	tristate "Photonicat PMU Watchdog"
+	depends on MFD_PHOTONICAT_PMU
+	select WATCHDOG_CORE
+	help
+	  This driver provides access to Photonicat PMU watchdog functionality.
+
+	  Say Y here to include support for the Photonicat PMU Watchdog.
+
+	  This driver can also be built as a module. If so the module
+	  will be called photonicat-wdt.
+
 config WDAT_WDT
 	tristate "ACPI Watchdog Action Table (WDAT)"
 	depends on ACPI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index b51030f035a6..14375af84039 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -234,6 +234,7 @@ obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
 obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
+obj-$(CONFIG_PHOTONICAT_PMU_WDT) += photonicat-wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
diff --git a/drivers/watchdog/photonicat-wdt.c b/drivers/watchdog/photonicat-wdt.c
new file mode 100644
index 000000000000..1e758fcfb49f
--- /dev/null
+++ b/drivers/watchdog/photonicat-wdt.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
+ */
+
+#include <linux/mfd/photonicat-pmu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+struct pcat_watchdog {
+	struct device *dev;
+	struct pcat_pmu *pmu;
+	struct watchdog_device wdd;
+	u8 timeout;
+	bool started;
+};
+
+static const struct watchdog_info pcat_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "Photonicat PMU Watchdog",
+};
+
+static int pcat_wdt_setup(struct pcat_watchdog *data, int timeout)
+{
+	int ret;
+	u8 time = 0;
+	u8 times[3] = { 60, 60, 0 };
+
+	time = MIN(255, MAX(0, timeout));
+
+	ret = pcat_pmu_write_data(data->pmu, PCAT_CMD_WATCHDOG_TIMEOUT_SET,
+				  times, sizeof(times));
+	if (!ret)
+		data->started = timeout != 0;
+
+	return ret;
+}
+
+static int pcat_wdt_start(struct watchdog_device *wdev)
+{
+	struct pcat_watchdog *data = watchdog_get_drvdata(wdev);
+
+	return pcat_wdt_setup(data, data->timeout);
+}
+
+static int pcat_wdt_stop(struct watchdog_device *wdev)
+{
+	struct pcat_watchdog *data = watchdog_get_drvdata(wdev);
+
+	return pcat_wdt_setup(data, 0);
+}
+
+static int pcat_wdt_ping(struct watchdog_device *wdev)
+{
+	struct pcat_watchdog *data = watchdog_get_drvdata(wdev);
+
+	return pcat_pmu_send(data->pmu, PCAT_CMD_HEARTBEAT, NULL, 0);
+}
+
+static int pcat_wdt_set_timeout(struct watchdog_device *wdev, unsigned int val)
+{
+	int ret = 0;
+	struct pcat_watchdog *data = watchdog_get_drvdata(wdev);
+
+	data->timeout = val;
+	if (data->started)
+		ret = pcat_wdt_setup(data, data->timeout);
+
+	return ret;
+}
+
+static const struct watchdog_ops pcat_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = pcat_wdt_start,
+	.stop = pcat_wdt_stop,
+	.ping = pcat_wdt_ping,
+	.set_timeout = pcat_wdt_set_timeout,
+};
+
+static int pcat_watchdog_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pcat_watchdog *watchdog;
+
+	watchdog = devm_kzalloc(dev, sizeof(*watchdog), GFP_KERNEL);
+	if (!watchdog)
+		return -ENOMEM;
+
+	watchdog->dev = dev;
+	watchdog->pmu = dev_get_drvdata(dev->parent);
+	watchdog->wdd.info = &pcat_wdt_info;
+	watchdog->wdd.ops = &pcat_wdt_ops;
+	watchdog->wdd.timeout = 60;
+	watchdog->wdd.max_timeout = U8_MAX;
+	watchdog->wdd.min_timeout = 0;
+	watchdog->wdd.parent = dev;
+
+	watchdog_stop_on_reboot(&watchdog->wdd);
+	watchdog_set_drvdata(&watchdog->wdd, watchdog);
+	platform_set_drvdata(pdev, watchdog);
+
+	return devm_watchdog_register_device(dev, &watchdog->wdd);
+}
+
+static const struct of_device_id pcat_watchdog_dt_ids[] = {
+	{ .compatible = "ariaboard,photonicat-pmu-watchdog", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pcat_watchdog_dt_ids);
+
+static struct platform_driver pcat_watchdog_driver = {
+	.driver = {
+		.name = "photonicat-watchdog",
+		.of_match_table = pcat_watchdog_dt_ids,
+	},
+	.probe = pcat_watchdog_probe,
+};
+module_platform_driver(pcat_watchdog_driver);
+
+MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
+MODULE_DESCRIPTION("Photonicat PMU watchdog");
+MODULE_LICENSE("GPL");
-- 
2.46.0


