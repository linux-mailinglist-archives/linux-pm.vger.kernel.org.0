Return-Path: <linux-pm+bounces-6378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE98A46F9
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 04:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E4CB223CB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C317556;
	Mon, 15 Apr 2024 02:31:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DD4C81;
	Mon, 15 Apr 2024 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148315; cv=none; b=RLf5Cu0dn61mDRHjpyB5TD8pJmqqb2NLl2vzplpiLYADfNzcOv0wOZZPGO6eMX0O7oxO9asdvQqvC79YcE0KWpgs5uzdE3uyc+FeskGIjOg+3aORFipz/IkMFTd/JxjN3JT4up/ebwZ6N1JjI34avhZy9v/y0rQJ6FLtIYmeCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148315; c=relaxed/simple;
	bh=F/P2HI1X8mKyj+MWVME6cB1q17xL5qnLb8qZ2Lplcls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HENNMO3wq2u7jkJl3IMGbruUQ9HKkTqzLQcTdgYu1Wy+BO59MifTvjinkT5gP+VcDjjR2LCq0een4m41zPpQ2bR7nXSlA7pA4Pe2xFoIdBbexlhJ6uyY2DJVmaQh7Wn/g0fhlw+rZCC2bfd0gsZ1CId/c8RXoJ954Lq3KEe3Pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxdbmXkRxmgY4nAA--.8921S3;
	Mon, 15 Apr 2024 10:31:51 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxRRGRkRxm+Bx7AA--.27668S3;
	Mon, 15 Apr 2024 10:31:49 +0800 (CST)
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
Subject: [PATCH v2 1/4] thermal: loongson2: Trivial code style adjustment
Date: Mon, 15 Apr 2024 10:31:30 +0800
Message-ID: <f77f740164ec573dffcf24558a0ac371e098e0f3.1713147645.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:AQAAf8AxRRGRkRxm+Bx7AA--.27668S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF1DGF48Ar18Jr1xGF18CrX_yoW7Gr17p3
	yxA3y3KrWDXr4xuw1UZrn5WrWYkr17tasxZFs7Gw1rWr43t343XryqqF1fJryfCFZrJFy3
	Z3yq9F48CayDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Here are some minor code style adjustment. Such as fix whitespace code
style; align function call arguments to opening parenthesis, and add
devm_thermal_add_hwmon_sysfs() return value checking.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 69 +++++++++++++++--------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 0f475fe46bc9..d77d829c8b55 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -16,45 +16,49 @@
 #include <linux/units.h>
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
+	int reg_ctrl = 0;
+	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
+	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG :
+		       LOONGSON2_THSENS_CTRL_HI_REG;
+
+	reg_ctrl = ctrl_data + HECTO;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->regs + ctrl_reg + reg_off);
+}
 
+static int loongson2_thermal_set(struct loongson2_thermal_data *data,
+				 int low, int high, bool enable)
+{
 	low = clamp(-40, low, high);
 	high = clamp(125, low, high);
 
-	low += HECTO;
-	high += HECTO;
-
-	reg_ctrl = low;
-	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_LOW_REG + reg_off);
-
-	reg_ctrl = high;
-	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->regs + LOONGSON2_THSENS_CTRL_HI_REG + reg_off);
+	loongson2_set_ctrl_regs(data, low, true, enable);
+	loongson2_set_ctrl_regs(data, high, false, enable);
 
 	return 0;
 }
@@ -75,15 +79,15 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 	struct thermal_zone_device *tzd = dev;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
 
-	writeb(LOONGSON2_THSENS_INT_LO | LOONGSON2_THSENS_INT_HIGH, data->regs +
-		LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_EN, data->regs + LOONGSON2_THSENS_STATUS_REG);
 
 	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
 
-static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+static int loongson2_thermal_set_trips(struct thermal_zone_device *tz,
+				       int low, int high)
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
@@ -116,14 +120,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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
@@ -135,13 +138,11 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
-			IRQF_ONESHOT, "loongson2_thermal", tzd);
+					IRQF_ONESHOT, "loongson2_thermal", tzd);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
 
-	devm_thermal_add_hwmon_sysfs(dev, tzd);
-
-	return 0;
+	return devm_thermal_add_hwmon_sysfs(dev, tzd);
 }
 
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
-- 
2.43.0


