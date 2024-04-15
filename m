Return-Path: <linux-pm+bounces-6381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC58A46FE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 04:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ACD1C21ED2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 02:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9125F14F6C;
	Mon, 15 Apr 2024 02:32:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209115E9B;
	Mon, 15 Apr 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148324; cv=none; b=EGZgeLrrJP/1hRK9An5QlxN0hR6OlZzMlfjmEN6sDLCykF4MTLQ+UO/kw0357lVZ0cX9pHsnFGwxCWJXw2jhmzk8ldCMg3MXbWS9xrEbKTwKCdWhTdHwUuCsySV6/2XFOTLxI5fx9+7vRv5JnGArASnmva9Eki86WzqqlJ9hwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148324; c=relaxed/simple;
	bh=4HfiDJYJPKc2uNTlZn92xDC19YzzrHiZlY9tOSTHOSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfEioQoS8bOI8Rbgv6gtlmeeVxPMTuojUZqDMySbY5oRtITr25nm1yPQKfDIQkpCQRfKSJSUBm5DqL15AabaCQUHO9P4qB0bP8yrMnsZMjIEubj80FHC0pUg3+j0NEtkbB+NfTbAt2OuY88NNRK3hJV50XAmD7cMjP1YSSWqWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxdbmhkRxmqY4nAA--.8923S3;
	Mon, 15 Apr 2024 10:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxlhGekRxmBh17AA--.27951S2;
	Mon, 15 Apr 2024 10:31:59 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 4/4] thermal: loongson2: Add Loongson-2K2000 support
Date: Mon, 15 Apr 2024 10:31:57 +0800
Message-ID: <1004a4c46e83ed5bf3cb7158755aaef3f1517693.1713147645.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713147645.git.zhoubinbin@loongson.cn>
References: <cover.1713147645.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxlhGekRxmBh17AA--.27951S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw45Jr1xCr4kJrWUAr1DurX_yoWrurW3p3
	47C3y5KrZ8Xr4Du3s8Aw1kZF4Yyry3ta9xZFs7Gw1fWrZ3t343Wry5KF10vrWSkFZ8JFy5
	ZrZ0vFWxC3WDW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6rWY6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0XdjtUUUUU==

The Loongson-2K2000 and Loongson-2K1000 have similar thermal sensors,
except that the temperature is read differently.

In particular, the temperature output registers of the Loongson-2K2000
are defined in the chip configuration domain and are read in a different
way.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 50 +++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index d77d829c8b55..d803b6bc35b7 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -29,12 +29,20 @@
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
@@ -65,11 +73,16 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
 
 static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	u32 reg_val;
+	int val;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	reg_val = readl(data->regs + LOONGSON2_THSENS_OUT_REG);
-	*temp = ((reg_val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+	if (data->chip_data->flags) {
+		val = readl(data->temp_reg);
+		*temp = ((val & 0xffff) * 820 / 0x4000 - 311) * KILO;
+	} else {
+		val = readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG);
+		*temp = ((val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+	}
 
 	return 0;
 }
@@ -79,7 +92,7 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 	struct thermal_zone_device *tzd = dev;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
 	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -112,15 +125,22 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 	data->chip_data = device_get_match_data(dev);
 
-	data->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->regs))
-		return PTR_ERR(data->regs);
+	data->ctrl_reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->ctrl_reg))
+		return PTR_ERR(data->ctrl_reg);
+
+	/* The temperature output register is separate for Loongson-2K2000 */
+	if (data->chip_data->flags) {
+		data->temp_reg = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(data->temp_reg))
+			return PTR_ERR(data->temp_reg);
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
 	loongson2_thermal_set(data, 0, 0, false);
 
@@ -147,6 +167,12 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
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
@@ -154,6 +180,10 @@ static const struct of_device_id of_loongson2_thermal_match[] = {
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
-- 
2.43.0


