Return-Path: <linux-pm+bounces-6873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ACE8ADBBB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 03:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DAF1C212B7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D317991;
	Tue, 23 Apr 2024 01:59:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A5413AD8;
	Tue, 23 Apr 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837565; cv=none; b=UV24LTxoPUqf8BH4nD1G3uQltQ4IYTtCjnr7MnQzB9tmIR4WBGNsR4AtsULA/l46hhuTg7MGdsNsKxUOiqPqhgK1FyB1Eq5oe7ydJUxF7LRuFS71Yn/4AirfIBDFl3VmK9NBNEedRwV4WmGZLwuwe/UZIqJ/5kFHMEXR7ZkQZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837565; c=relaxed/simple;
	bh=hKPjR5beq93POtSPchZK0wm+9+P4bHNQTn2hmSSDw6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgJG4Qfh0bDAW2lFTYVyZyZWxwhbqdh+Q3gU3HibIFrYVD98/PmS69HCvv7jT0nmu9mRj6UaqUSJspD9tYICJTu4HF/JdeX3abMZvna/gXMX4TY2FpJbBprTUaRSYIk3svh5rM8ArNo2vqenQWhwexNgSoRHXHIzv2Bgerf3J1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Dxd_D2FSdm+h0BAA--.6839S3;
	Tue, 23 Apr 2024 09:59:18 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnlfxFSdmX+EBAA--.2983S3;
	Tue, 23 Apr 2024 09:59:17 +0800 (CST)
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
Subject: [PATCH v4 1/4] thermal: loongson2: Trivial code style adjustment
Date: Tue, 23 Apr 2024 09:59:00 +0800
Message-ID: <ccca50f2ad3fd8c84fcbfcb1f875427ea7f637a0.1713837379.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713837379.git.zhoubinbin@loongson.cn>
References: <cover.1713837379.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnlfxFSdmX+EBAA--.2983S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1DGF48JF4fCFW3JF47trc_yoW7Jryfpr
	WxA3y3KrWUXr4xuw4DZF1rWrWYyw17tasxZFs7Gw1rWr43t34fXryqqFn3XryfAFZrJF17
	Z3yq9F40kayDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYE_NUUUUU=

Here are some minor code style adjustment. Such as fix whitespace code
style; align function call arguments to opening parenthesis.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 65 +++++++++++++++--------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 0f475fe46bc9..5c9cf45a3719 100644
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
-- 
2.43.0


