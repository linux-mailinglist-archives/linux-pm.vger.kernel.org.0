Return-Path: <linux-pm+bounces-13773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA496EFA3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E749F1F2247D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451741CB135;
	Fri,  6 Sep 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="C/7qhqBM"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851E1C9DFE;
	Fri,  6 Sep 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615489; cv=none; b=YfICfaywVQoVrp9LSb00+uzqdJ2iWXv2bOVyBKfQ7T29OSMbTpm2+REhJxNdxVROTCE5+Y8fQWNGoPJJ2LJo9Z9oB5+nVFltM05pVHbaH+q477Fg8yIF4y932d86e1DK/i1iCT0Latal2GKw/CDE5qkdBob9y+GjY29AudbDkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615489; c=relaxed/simple;
	bh=ZDalrpwEdV0Qxr1hRJF8/Uw2c77gU75IvuJskdvWmIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUQdf+onAXcOQqsfT1w5Lep6yPnXX/b2iWAPPMFWCRJ8/qxyZ2ZQGMHzu7fjFvqkwMyIrKffai8xzDUrsqF7pfT0MERsKJEMolUAETcLpTzXS2KLx143bhKz87U1lqjaNq92HBqvBuux9zt1Ae9KRnnr4IC+XPBW9xtfS/Xsy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=C/7qhqBM; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 0936078A03;
	Fri,  6 Sep 2024 17:38:03 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 0936078A03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615485;
	bh=YQ6dfBwyAAugUzhApDOCUWBWXXsLha14N6rXzvxlRLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/7qhqBMMoDhCuEwhTLpqO9/NNtx+QAbpHZ7XlBHXQWF4DIAIBfmvqYEDnM13mLS/
	 gZm8AuWipJ5pawuqbs+SgbHRhXKnRjZSaobhnenwK5+RlA/O36OtQG2ehZIbBN3E7A
	 uIFDYxeC7RFBXtzOoYPgsNvR8AUS61D3OgtdMuLU=
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
Subject: [PATCH 5/9] rtc: Add Photonicat PMU real-time clock
Date: Fri,  6 Sep 2024 17:36:26 +0800
Message-ID: <20240906093630.2428329-6-bigfoot@classfun.cn>
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

Photonicat PMU MCU will send status reports regularly,
including the MCU RTC date time.

Use command 0x09 to update the RTC date time of MCU.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 drivers/rtc/Kconfig          |  12 +++
 drivers/rtc/Makefile         |   1 +
 drivers/rtc/rtc-photonicat.c | 190 +++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/rtc/rtc-photonicat.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2a95b05982ad..3403ba3f5643 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -516,6 +516,18 @@ config RTC_DRV_PCF8583
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8583.
 
+config RTC_DRV_PHOTONICAT_PMU
+	tristate "Photonicat PMU RTC"
+	depends on MFD_PHOTONICAT_PMU
+	help
+	  Photonicat PMU MCU will send status reports regularly,
+	  including the MCU RTC date time.
+
+	  If you say yes here you get support for the Photonicat PMU RTC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-photonicat.
+
 config RTC_DRV_M41T80
 	tristate "ST M41T62/65/M41T80/81/82/83/84/85/87 and compatible"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 3004e372f25f..f050a134da1f 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_RTC_DRV_PCF8523)	+= rtc-pcf8523.o
 obj-$(CONFIG_RTC_DRV_PCF85363)	+= rtc-pcf85363.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_PCF8583)	+= rtc-pcf8583.o
+obj-$(CONFIG_RTC_DRV_PHOTONICAT_PMU)	+= rtc-photonicat.o
 obj-$(CONFIG_RTC_DRV_PIC32)	+= rtc-pic32.o
 obj-$(CONFIG_RTC_DRV_PL030)	+= rtc-pl030.o
 obj-$(CONFIG_RTC_DRV_PL031)	+= rtc-pl031.o
diff --git a/drivers/rtc/rtc-photonicat.c b/drivers/rtc/rtc-photonicat.c
new file mode 100644
index 000000000000..2e3115fb5c38
--- /dev/null
+++ b/drivers/rtc/rtc-photonicat.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/photonicat-pmu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+struct pcat_data_cmd_startup {
+	struct pcat_data_cmd_date_time time;
+	union {
+		u8 value;
+		struct {
+			bool year : 1;
+			bool month : 1;
+			bool day : 1;
+			bool hour : 1;
+			bool minute : 1;
+			bool second : 1;
+		} __packed;
+	} match;
+} __packed;
+
+struct pcat_rtc {
+	struct device *dev;
+	struct pcat_pmu *pmu;
+	struct notifier_block nb;
+	struct rtc_device *rtc;
+	struct pcat_data_cmd_date_time time;
+	struct completion initial_report;
+};
+
+static bool pcat_time_to_rtc_time(const struct pcat_data_cmd_date_time *time,
+				  struct rtc_time *tm)
+{
+	if (time->second >= 60 || time->minute >= 60 || time->hour >= 24 ||
+	    time->day <= 0 || time->day > 31 || time->month <= 0 ||
+	    time->month > 12 || time->year < 1900 || time->year > 9999)
+		return false;
+
+	tm->tm_sec = time->second;
+	tm->tm_min = time->minute;
+	tm->tm_hour = time->hour;
+	tm->tm_mday = time->day;
+	tm->tm_mon = time->month - 1;
+	tm->tm_year = time->year - 1900;
+	tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, time->year);
+	tm->tm_wday = ((time->year * (365 % 7)) + ((time->year - 1) / 4) -
+		       ((time->year - 1) / 100) + ((time->year - 1) / 400) +
+		       tm->tm_yday) % 7;
+
+	return true;
+}
+
+static void pcat_time_from_rtc_time(struct pcat_data_cmd_date_time *time,
+				    const struct rtc_time *tm)
+{
+	time->year = tm->tm_year + 1900;
+	time->month = tm->tm_mon + 1;
+	time->day = tm->tm_mday;
+	time->hour = tm->tm_hour;
+	time->minute = tm->tm_min;
+	time->second = tm->tm_sec;
+}
+
+static int pcat_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pcat_rtc *rtc = dev_get_drvdata(dev);
+
+	memset(tm, 0, sizeof(*tm));
+	if (!pcat_time_to_rtc_time(&rtc->time, tm))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pcat_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	int ret;
+	struct pcat_rtc *rtc = dev_get_drvdata(dev);
+	struct pcat_data_cmd_date_time time;
+
+	pcat_time_from_rtc_time(&time, tm);
+
+	ret = pcat_pmu_write_data(rtc->pmu, PCAT_CMD_DATE_TIME_SYNC,
+				  &time, sizeof(time));
+	if (ret)
+		return ret;
+
+	memcpy(&rtc->time, &time, sizeof(rtc->time));
+
+	return 0;
+}
+
+static const struct rtc_class_ops pcat_rtc_ops = {
+	.read_time = pcat_rtc_read_time,
+	.set_time = pcat_rtc_set_time,
+};
+
+static int pcat_rtc_notify(struct notifier_block *nb, unsigned long action,
+			   void *data)
+{
+	struct pcat_rtc *rtc = container_of(nb, struct pcat_rtc, nb);
+	struct pcat_data_cmd_status *status = pcat_data_get_data(data);
+
+	if (action != PCAT_CMD_STATUS_REPORT)
+		return NOTIFY_DONE;
+
+	memcpy(&rtc->time, &status->time, sizeof(rtc->time));
+	complete(&rtc->initial_report);
+
+	return NOTIFY_DONE;
+}
+
+static int pcat_rtc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pcat_rtc *rtc;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->dev = dev;
+	rtc->pmu = dev_get_drvdata(dev->parent);
+	rtc->nb.notifier_call = pcat_rtc_notify;
+	init_completion(&rtc->initial_report);
+	platform_set_drvdata(pdev, rtc);
+
+	ret = pcat_pmu_register_notify(rtc->pmu, &rtc->nb);
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_timeout(&rtc->initial_report,
+					 msecs_to_jiffies(3000))) {
+		ret = dev_err_probe(dev, -ETIMEDOUT,
+				    "timeout waiting for initial report\n");
+		goto error;
+	}
+
+	dev_info(dev, "RTC Time: %04d/%02d/%02d %02d:%02d:%02d\n",
+		 rtc->time.year, rtc->time.month, rtc->time.day, rtc->time.hour,
+		 rtc->time.minute, rtc->time.second);
+
+	rtc->rtc = devm_rtc_device_register(&pdev->dev, "pcat-rtc",
+					    &pcat_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc)) {
+		ret = PTR_ERR(rtc->rtc);
+		dev_err_probe(&pdev->dev, ret,
+			      "Failed to register RTC device\n");
+		goto error;
+	}
+
+	return 0;
+error:
+	pcat_pmu_unregister_notify(rtc->pmu, &rtc->nb);
+	return ret;
+}
+
+static void pcat_rtc_remove(struct platform_device *pdev)
+{
+	struct pcat_rtc *rtc = platform_get_drvdata(pdev);
+
+	pcat_pmu_unregister_notify(rtc->pmu, &rtc->nb);
+}
+
+static const struct of_device_id pcat_rtc_dt_ids[] = {
+	{ .compatible = "ariaboard,photonicat-pmu-rtc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pcat_rtc_dt_ids);
+
+static struct platform_driver pcat_rtc_driver = {
+	.driver = {
+		.name = "rtc-photonicat",
+		.of_match_table = pcat_rtc_dt_ids,
+	},
+	.probe = pcat_rtc_probe,
+	.remove = pcat_rtc_remove,
+};
+module_platform_driver(pcat_rtc_driver);
+
+MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
+MODULE_DESCRIPTION("Photonicat PMU RTC");
+MODULE_LICENSE("GPL");
-- 
2.46.0


