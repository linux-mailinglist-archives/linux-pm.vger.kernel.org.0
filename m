Return-Path: <linux-pm+bounces-7808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F78C4F5B
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D665B21022
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876185649;
	Tue, 14 May 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gd0K6B5O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zc4UoTC6"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F67C6C9
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681939; cv=none; b=bMrzxG6xON+SKNC3hxfhiJFmNkuRlFvttz3/irDC3XidyPUsKInATIUVWRxX33SsWOQHZ7lmzbVUhC4FAVsxgmwf4VvCqT7eMz6jojiuQ/Ka67/ZGXs0OqaKbTzXd/+LQ2jtc+SMU8q9rpx9YuhfJH783gOPXtweBTHS2E5W4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681939; c=relaxed/simple;
	bh=3bZZ6IHcMhsWbhKkdQyY3qtCofb1wpH+uXRapb4FGyo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aaAkCI5s1mXYRGRUIC4Ma9ZbvIV5kFyS33BsmA/L9yCo2jWPvsx1L9oYKU1awXdgmGQ+Ka7puLUTwu+aX4qcYSxHIFeiYdBnNAR5Eqc6VaxBEh+uSJQQfIDT5CRTgZczKqmnkMUvZynlhJoi59KNxDFD/r5OgnfDglDYC7O3YZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gd0K6B5O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zc4UoTC6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0omb4V8lRPBnIafcCBxAodAhpAI1HliC3sF/mE9Nt0=;
	b=gd0K6B5OxCJMrS0/VLdcT/OiJ5FlT6XKrPiwuTZgY2o5UVqJNyQny7Dwd2FtXBuks8jUqO
	X/59GFMlK+3oOTSCgzfKnq4cYeMcTdYHg2C+8ziRyD2AdfKM1L8nq1KKUGaVqk0Z8awc7V
	27qtZEyovAi8+mQExpPIErlor0jTN28cfeE19xWGhMKK4JM16xPrXxV8ohV/+RAm41mmO2
	KwgEZxOVV0dvgS1C+PDuBP18NKQ/J6nrpOvLB0w/lgWDJaFMAIWXUkcIZc/Z/uSY3B8Mzc
	CsMmK1ndtKhRPXsrkWx1oSpPgIqphjYIuyImHNb2hS0sjLTsyCYYOfQqFAtxqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0omb4V8lRPBnIafcCBxAodAhpAI1HliC3sF/mE9Nt0=;
	b=zc4UoTC6gK13flimn+VRKqT+clcxlf2MIhNZ+1rnZpqZGhrlDL5jFAA3i/qlgXoEqj5+3p
	v3qI51N1OazO5eBQ==
From: "thermal-bot for Binbin Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/loongson2: Trivial code
 style adjustment
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: =?utf-8?q?=3Cccca50f2ad3fd8c84fcbfcb1f875427ea7f637a0=2E17138?=
 =?utf-8?q?37379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
References: =?utf-8?q?=3Cccca50f2ad3fd8c84fcbfcb1f875427ea7f637a0=2E171383?=
 =?utf-8?q?7379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193317.10875.14717017269836303347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     6ef6d5ff5eddb3457eef8d78d7b8b451be19b5c3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6ef6d5ff5eddb3457eef8d78d7b8b451be19b5c3
Author:        Binbin Zhou <zhoubinbin@loongson.cn>
AuthorDate:    Tue, 23 Apr 2024 09:59:00 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

thermal/drivers/loongson2: Trivial code style adjustment

Here are some minor code style adjustment. Such as fix whitespace code
style; align function call arguments to opening parenthesis.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/ccca50f2ad3fd8c84fcbfcb1f875427ea7f637a0.1713837379.git.zhoubinbin@loongson.cn
---
 drivers/thermal/loongson2_thermal.c | 65 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 0f475fe..5c9cf45 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -14,47 +14,51 @@
 #include <linux/property.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
+
 #include "thermal_hwmon.h"
 
-#define LOONGSON2_MAX_SENSOR_SEL_NUM			3
+#define LOONGSON2_MAX_SENSOR_SEL_NUM	3
 
-#define LOONGSON2_THSENS_CTRL_HI_REG			0x0
-#define LOONGSON2_THSENS_CTRL_LOW_REG			0x8
-#define LOONGSON2_THSENS_STATUS_REG			0x10
-#define LOONGSON2_THSENS_OUT_REG			0x14
+#define LOONGSON2_THSENS_CTRL_HI_REG	0x0
+#define LOONGSON2_THSENS_CTRL_LOW_REG	0x8
+#define LOONGSON2_THSENS_STATUS_REG	0x10
+#define LOONGSON2_THSENS_OUT_REG	0x14
 
-#define LOONGSON2_THSENS_INT_LO				BIT(0)
-#define LOONGSON2_THSENS_INT_HIGH			BIT(1)
-#define LOONGSON2_THSENS_OUT_MASK			0xFF
+#define LOONGSON2_THSENS_INT_LO		BIT(0)
+#define LOONGSON2_THSENS_INT_HIGH	BIT(1)
+#define LOONGSON2_THSENS_INT_EN		(LOONGSON2_THSENS_INT_LO | \
+					 LOONGSON2_THSENS_INT_HIGH)
+#define LOONGSON2_THSENS_OUT_MASK	0xFF
 
 struct loongson2_thermal_chip_data {
-	unsigned int	thermal_sensor_sel;
+	unsigned int thermal_sensor_sel;
 };
 
 struct loongson2_thermal_data {
-	void __iomem	*regs;
+	void __iomem *regs;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
-static int loongson2_thermal_set(struct loongson2_thermal_data *data,
-					int low, int high, bool enable)
+static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *data,
+				    int ctrl_data, bool low, bool enable)
 {
-	u64 reg_ctrl = 0;
-	int reg_off = data->chip_data->thermal_sensor_sel * 2;
-
-	low = clamp(-40, low, high);
-	high = clamp(125, low, high);
+	int reg_ctrl = 0;
+	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
+	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
 
-	low += HECTO;
-	high += HECTO;
-
-	reg_ctrl = low;
+	reg_ctrl = ctrl_data + HECTO;
 	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_LOW_REG + reg_off);
+	writew(reg_ctrl, data->regs + ctrl_reg + reg_off);
+}
 
-	reg_ctrl = high;
-	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_HI_REG + reg_off);
+static int loongson2_thermal_set(struct loongson2_thermal_data *data,
+				 int low, int high, bool enable)
+{
+	/* Set low temperature threshold */
+	loongson2_set_ctrl_regs(data, clamp(-40, low, high), true, enable);
+
+	/* Set high temperature threshold */
+	loongson2_set_ctrl_regs(data, clamp(125, low, high), false, enable);
 
 	return 0;
 }
@@ -75,8 +79,7 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 	struct thermal_zone_device *tzd = dev;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
 
-	writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data->regs +
-		LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
 
 	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -116,14 +119,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data->regs +
-		LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
 
 	loongson2_thermal_set(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
 		tzd = devm_thermal_of_zone_register(dev, i, data,
-			&loongson2_of_thermal_ops);
+						    &loongson2_of_thermal_ops);
 
 		if (!IS_ERR(tzd))
 			break;
@@ -135,7 +137,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
-			IRQF_ONESHOT, "loongson2_thermal", tzd);
+					IRQF_ONESHOT, "loongson2_thermal", tzd);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
 
@@ -167,4 +169,5 @@ static struct platform_driver loongson2_thermal_driver = {
 module_platform_driver(loongson2_thermal_driver);
 
 MODULE_DESCRIPTION("Loongson2 thermal driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited");
 MODULE_LICENSE("GPL");

