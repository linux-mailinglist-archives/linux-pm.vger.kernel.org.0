Return-Path: <linux-pm+bounces-323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB47FAF5B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23C2281AB8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84317E6;
	Tue, 28 Nov 2023 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7DD11B8;
	Mon, 27 Nov 2023 17:00:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 181E12F4;
	Mon, 27 Nov 2023 17:01:35 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B1C3F6C4;
	Mon, 27 Nov 2023 17:00:44 -0800 (PST)
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
	Bob McChesney <bob@electricworry.net>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 4/6] thermal: sun8i: add syscon register access code
Date: Tue, 28 Nov 2023 00:58:47 +0000
Message-Id: <20231128005849.19044-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231128005849.19044-1-andre.przywara@arm.com>
References: <20231128005849.19044-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 SoC needs to clear a bit in one register in the SRAM
controller (exported as a syscon), to report reasonable temperature
values. On reset, bit 16 in register 0x3000000 is set, which leads to the
driver reporting temperatures around 200C. Clearing this bit brings the
values down to the expected range. The BSP code does a one-time write in
U-Boot, with a comment just mentioning the effect on the THS, but offering
no further explanation.

To not rely on firmware to set things up for us, add code that queries
the syscon device via a DT phandle link, then clear just this single
bit.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/thermal/sun8i_thermal.c | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 44554c3efc96c..920e419ce7343 100644
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
+	bool		needs_syscon;
 	int		sensor_num;
 	int		offset;
 	int		scale;
@@ -83,6 +85,7 @@ struct ths_device {
 	const struct ths_thermal_chip		*chip;
 	struct device				*dev;
 	struct regmap				*regmap;
+	struct regmap_field			*syscon_regmap_field;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
 	struct clk                              *mod_clk;
@@ -325,6 +328,34 @@ static void sun8i_ths_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static struct regmap *sun8i_ths_get_syscon_regmap(struct device_node *node)
+{
+	struct device_node *syscon_node;
+	struct platform_device *syscon_pdev;
+	struct regmap *regmap = NULL;
+
+	syscon_node = of_parse_phandle(node, "syscon", 0);
+	if (!syscon_node)
+		return ERR_PTR(-ENODEV);
+
+	syscon_pdev = of_find_device_by_node(syscon_node);
+	if (!syscon_pdev) {
+		/* platform device might not be probed yet */
+		regmap = ERR_PTR(-EPROBE_DEFER);
+		goto out_put_node;
+	}
+
+	/* If no regmap is found then the other device driver is at fault */
+	regmap = dev_get_regmap(&syscon_pdev->dev, NULL);
+	if (!regmap)
+		regmap = ERR_PTR(-EINVAL);
+
+	platform_device_put(syscon_pdev);
+out_put_node:
+	of_node_put(syscon_node);
+	return regmap;
+}
+
 static int sun8i_ths_resource_init(struct ths_device *tmdev)
 {
 	struct device *dev = tmdev->dev;
@@ -369,6 +400,21 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
+	if (tmdev->chip->needs_syscon) {
+		const struct reg_field sun8i_syscon_reg_field =
+			REG_FIELD(0x0, 16, 16);
+		struct regmap *regmap;
+
+		regmap = sun8i_ths_get_syscon_regmap(dev->of_node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+		tmdev->syscon_regmap_field = devm_regmap_field_alloc(dev,
+						      regmap,
+						      sun8i_syscon_reg_field);
+		if (IS_ERR(tmdev->syscon_regmap_field))
+			return PTR_ERR(tmdev->syscon_regmap_field);
+	}
+
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
 		return ret;
@@ -415,6 +461,10 @@ static int sun50i_h6_thermal_init(struct ths_device *tmdev)
 {
 	int val;
 
+	/* The H616 needs to have a bit in the SRAM control register cleared. */
+	if (tmdev->syscon_regmap_field)
+		regmap_field_write(tmdev->syscon_regmap_field, 0);
+
 	/*
 	 * The manual recommends an overall sample frequency of 50 KHz (20us,
 	 * 480 cycles at 24 MHz), which provides plenty of time for both the
-- 
2.35.8


