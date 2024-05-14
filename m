Return-Path: <linux-pm+bounces-7805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E42B8C4F57
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D811C209FA
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9B68002F;
	Tue, 14 May 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqQkgOWh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKGeFQdx"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698341D54D
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681937; cv=none; b=SoFQHl6Q3kRgnRFt/NfxM3DUjBExGMxhN7RSPSXermj3vyYlYdD7KrT4Bdu4ON9nKDymUvxLVLmkrZJo26VatKSLmxmfarLP1CnXaAGWqrCBoLbW/RmLyFiXsiulGcjL7/BW0wNbf8CeiKaR2FaP41EOsZ7WDZZrkOqQbQgZiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681937; c=relaxed/simple;
	bh=e20//QE4kXK3g9RoNICFSm3NJQ2TxQicJ1WvD0zL+Gs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FxD3wSUbX3UAYjutzxFceqdwxh9yuB6YT5SVY5XMvp/BUK9PU2SEHWTQrbSnAH64lR5A1sQddntoRJONzihfxZpSeRJjZiattUsjEjgFDdPG4pHeEdFI75MNXeBQSCnpaV6mUeQwyHI/jgS/cg/gGoUYvRCl0joUvIFpwFWNtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqQkgOWh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKGeFQdx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6YmXlOpF9rKGO8MzReZyBM0uQTsBT8fjc1K2H8aPW0=;
	b=xqQkgOWhEkqjxCyEiNDLp4Xanjeg3mG/y96LyeoATxqnCItRyaPY7PMr/f6lQ2QQJ6YibI
	opibws9479xCJQYZwXZBbDFoi6bTsOGejSYJrCyv28NFH5HsEGNFi+R4Snq8eTAiPiuNAQ
	Osa112lzjsBKJjUyOIkuJaFgT7Fszu8GdtVOr07nuYrj7WGG71HpvWouccmstkOBK1RGWm
	g9qLYCGceUDXTSqyq2PXzmyvJrYT5K77x2NiT4vEq6J6reZiYpfiZeum5mCwroO+G5wPjL
	psONdLKH2H9iEqRqcDP6j/ZFaCPvFnVWOCc3ymPDkQSS28BpeDA2Fra3F6b5WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6YmXlOpF9rKGO8MzReZyBM0uQTsBT8fjc1K2H8aPW0=;
	b=BKGeFQdx72oxzHg2xyzNTG/I0w8vFTQ5RvMD5m5FJdRGm4/iNsyQoYnH8p+HdYq2NKawAA
	/tJr3sSTzuz2JHAg==
From: "thermal-bot for Binbin Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/loongson2: Add
 Loongson-2K2000 support
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: =?utf-8?q?=3Cfdbfdcc3231a36a4ee0bcf1377ddcbd6f8c944b5=2E17138?=
 =?utf-8?q?37379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
References: =?utf-8?q?=3Cfdbfdcc3231a36a4ee0bcf1377ddcbd6f8c944b5=2E171383?=
 =?utf-8?q?7379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193278.10875.306330812154607766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     734b5def91b594d3aa1147d60c45eded139ce2eb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//734b5def91b594d3aa1147d60c45eded139ce2eb
Author:        Binbin Zhou <zhoubinbin@loongson.cn>
AuthorDate:    Tue, 23 Apr 2024 09:59:26 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

thermal/drivers/loongson2: Add Loongson-2K2000 support

The Loongson-2K2000 and Loongson-2K1000 have similar thermal sensors,
except that the temperature is read differently.

In particular, the temperature output registers of the Loongson-2K2000
are defined in the chip configuration domain and are read in a different
way.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/fdbfdcc3231a36a4ee0bcf1377ddcbd6f8c944b5.1713837379.git.zhoubinbin@loongson.cn
---
 drivers/thermal/loongson2_thermal.c | 64 ++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 5c9cf45..2d6b75b 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -30,12 +30,20 @@
 					 LOONGSON2_THSENS_INT_HIGH)
 #define LOONGSON2_THSENS_OUT_MASK	0xFF
 
+/*
+ * This flag is used to indicate the temperature reading
+ * method of the Loongson-2K2000
+ */
+#define LS2K2000_THSENS_OUT_FLAG	BIT(0)
+
 struct loongson2_thermal_chip_data {
 	unsigned int thermal_sensor_sel;
+	unsigned int flags;
 };
 
 struct loongson2_thermal_data {
-	void __iomem *regs;
+	void __iomem *ctrl_reg;
+	void __iomem *temp_reg;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
@@ -48,7 +56,7 @@ static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *data,
 
 	reg_ctrl = ctrl_data + HECTO;
 	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->regs + ctrl_reg + reg_off);
+	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
 }
 
 static int loongson2_thermal_set(struct loongson2_thermal_data *data,
@@ -63,13 +71,24 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
 	return 0;
 }
 
-static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int val;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+
+	val = readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG);
+	*temp = ((val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+
+	return 0;
+}
+
+static int loongson2_2k2000_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	u32 reg_val;
+	int val;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	reg_val = readl(data->regs + LOONGSON2_THSENS_OUT_REG);
-	*temp = ((reg_val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+	val = readl(data->temp_reg);
+	*temp = ((val & 0xffff) * 820 / 0x4000 - 311) * KILO;
 
 	return 0;
 }
@@ -79,7 +98,7 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 	struct thermal_zone_device *tzd = dev;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
 	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -93,8 +112,8 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, 
 	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
 }
 
-static const struct thermal_zone_device_ops loongson2_of_thermal_ops = {
-	.get_temp = loongson2_thermal_get_temp,
+static struct thermal_zone_device_ops loongson2_of_thermal_ops = {
+	.get_temp = loongson2_2k1000_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
 };
 
@@ -111,15 +130,24 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 	data->chip_data = device_get_match_data(dev);
 
-	data->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->regs))
-		return PTR_ERR(data->regs);
+	data->ctrl_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->ctrl_reg))
+		return PTR_ERR(data->ctrl_reg);
+
+	/* The temperature output register is separate for Loongson-2K2000 */
+	if (data->chip_data->flags & LS2K2000_THSENS_OUT_FLAG) {
+		data->temp_reg = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(data->temp_reg))
+			return PTR_ERR(data->temp_reg);
+
+		loongson2_of_thermal_ops.get_temp = loongson2_2k2000_get_temp;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
 	loongson2_thermal_set(data, 0, 0, false);
 
@@ -148,6 +176,12 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
 	.thermal_sensor_sel = 0,
+	.flags = 0,
+};
+
+static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
+	.thermal_sensor_sel = 0,
+	.flags = LS2K2000_THSENS_OUT_FLAG,
 };
 
 static const struct of_device_id of_loongson2_thermal_match[] = {
@@ -155,6 +189,10 @@ static const struct of_device_id of_loongson2_thermal_match[] = {
 		.compatible = "loongson,ls2k1000-thermal",
 		.data = &loongson2_thermal_ls2k1000_data,
 	},
+	{
+		.compatible = "loongson,ls2k2000-thermal",
+		.data = &loongson2_thermal_ls2k2000_data,
+	},
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_loongson2_thermal_match);

