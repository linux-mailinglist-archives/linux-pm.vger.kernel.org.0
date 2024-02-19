Return-Path: <linux-pm+bounces-4084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B316485A78E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 16:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532FB1F22006
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603C3A8CC;
	Mon, 19 Feb 2024 15:37:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8E39AC6;
	Mon, 19 Feb 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357024; cv=none; b=SU0oUsIHDNyGmC+FS12zi7oZz0cZStC/hQcKh0kOCOGp6t8H9kANa9DOKmIvC3OSOcf0QnBTW72WoRBeC58/Vy8PChg258QisLbji2F3VrQQP5cuIYGyDP+jPOQKz2WI5cJAabYGuPdmZtSy4TxOw1Dodv5gZ2hnqowcPIKM3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357024; c=relaxed/simple;
	bh=4IoVj7JQ3Zb+xZaIHAa3vEa/dGFnRmv2LKQPw6HAQNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WsnoqklL3wUs9IXmM6i9O0+l4TD2BTNx4SryWUtUmk5LSkLSHzNmNqiFjp7NwyFCRB1pgnTufjNnBP3v0f8zLwR7Q2GjaPX+EPSjFHbkFBMoAcXQCgqe5m1+b7JVNNUCoHGX6daWJ/wd+xRsc+oS469Dymt/eGKtHwQQ8bvydlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E3E21042;
	Mon, 19 Feb 2024 07:37:39 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B15F3F762;
	Mon, 19 Feb 2024 07:36:57 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Botka <martin.botka@somainline.org>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Bob McChesney <bob@electricworry.net>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v5 5/7] thermal: sun8i: add SRAM register access code
Date: Mon, 19 Feb 2024 15:36:37 +0000
Message-Id: <20240219153639.179814-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219153639.179814-1-andre.przywara@arm.com>
References: <20240219153639.179814-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 SoC needs to clear a bit in one register in the SRAM
controller, to report reasonable temperature values. On reset, bit 16 in
register 0x3000000 is set, which leads to the driver reporting
temperatures around 200C. Clearing this bit brings the values down to the
expected range. The BSP code does a one-time write in U-Boot, with a
comment just mentioning the effect on the THS, but offering no further
explanation.

To not rely on firmware to set things up for us, add code that queries
the SRAM controller device via a DT phandle link, then clear just this
single bit.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/thermal/sun8i_thermal.c | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c919b0fd5e169..c157e4fbf963b 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -66,6 +67,7 @@ struct tsensor {
 struct ths_thermal_chip {
 	bool            has_mod_clk;
 	bool            has_bus_clk_reset;
+	bool		needs_sram;
 	int		sensor_num;
 	int		offset;
 	int		scale;
@@ -83,12 +85,16 @@ struct ths_device {
 	const struct ths_thermal_chip		*chip;
 	struct device				*dev;
 	struct regmap				*regmap;
+	struct regmap_field			*sram_regmap_field;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
 	struct clk                              *mod_clk;
 	struct tsensor				sensor[MAX_SENSOR_NUM];
 };
 
+/* The H616 needs to have a bit 16 in the SRAM control register cleared. */
+static const struct reg_field sun8i_ths_sram_reg_field = REG_FIELD(0x0, 16, 16);
+
 /* Temp Unit: millidegree Celsius */
 static int sun8i_ths_calc_temp(struct ths_device *tmdev,
 			       int id, int reg)
@@ -337,6 +343,34 @@ static void sun8i_ths_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node)
+{
+	struct device_node *sram_node;
+	struct platform_device *sram_pdev;
+	struct regmap *regmap = NULL;
+
+	sram_node = of_parse_phandle(node, "allwinner,sram", 0);
+	if (!sram_node)
+		return ERR_PTR(-ENODEV);
+
+	sram_pdev = of_find_device_by_node(sram_node);
+	if (!sram_pdev) {
+		/* platform device might not be probed yet */
+		regmap = ERR_PTR(-EPROBE_DEFER);
+		goto out_put_node;
+	}
+
+	/* If no regmap is found then the other device driver is at fault */
+	regmap = dev_get_regmap(&sram_pdev->dev, NULL);
+	if (!regmap)
+		regmap = ERR_PTR(-EINVAL);
+
+	platform_device_put(sram_pdev);
+out_put_node:
+	of_node_put(sram_node);
+	return regmap;
+}
+
 static int sun8i_ths_resource_init(struct ths_device *tmdev)
 {
 	struct device *dev = tmdev->dev;
@@ -381,6 +415,19 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
+	if (tmdev->chip->needs_sram) {
+		struct regmap *regmap;
+
+		regmap = sun8i_ths_get_sram_regmap(dev->of_node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+		tmdev->sram_regmap_field = devm_regmap_field_alloc(dev,
+						      regmap,
+						      sun8i_ths_sram_reg_field);
+		if (IS_ERR(tmdev->sram_regmap_field))
+			return PTR_ERR(tmdev->sram_regmap_field);
+	}
+
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
 		return ret;
@@ -427,6 +474,10 @@ static int sun50i_h6_thermal_init(struct ths_device *tmdev)
 {
 	int val;
 
+	/* The H616 needs to have a bit in the SRAM control register cleared. */
+	if (tmdev->sram_regmap_field)
+		regmap_field_write(tmdev->sram_regmap_field, 0);
+
 	/*
 	 * The manual recommends an overall sample frequency of 50 KHz (20us,
 	 * 480 cycles at 24 MHz), which provides plenty of time for both the
-- 
2.25.1


