Return-Path: <linux-pm+bounces-3705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11884F7CE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E24BB2465F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED969DE9;
	Fri,  9 Feb 2024 14:42:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF3669962;
	Fri,  9 Feb 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489764; cv=none; b=FrBweRT1UDZjZ3Yn75zUkX4tojrLOtKcDuWF89dLs5XA2OkOTQRI6Sjz2EtlkaamOE4TmeLnlejNh3SPTsFqEaXPy+rtLg+EreuNFRjxoQaYjKB8WgsQ2nVp6H4c3jabFsWLp1tqmCsztsUdb12WdVRtR0e/ZuWJKKbQL7bt4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489764; c=relaxed/simple;
	bh=yn/RfUE+kqc2SGtm6xCvVEK+7TdEWc0iOq/sGPLgF0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6HEzYNH9q6w8m8k8XsndHgqGgQS2C3Kp7MPGZB9eoJy2UTHz8e6sxXSILuoKi1HQyM5xWfkkaCV0ggYM+ewJcCmH2TDq91qmO9DRMvbi82TxGMltsh1kESADGIXJNzFz3l76jl7gO3tzFVkcW0MhWQ4a3VhtRg1TrXF8kLl4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85CB0FEC;
	Fri,  9 Feb 2024 06:43:23 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F045D3F5A1;
	Fri,  9 Feb 2024 06:42:38 -0800 (PST)
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
Subject: [PATCH v4 5/7] thermal: sun8i: add SRAM register access code
Date: Fri,  9 Feb 2024 14:42:19 +0000
Message-Id: <20240209144221.3602382-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209144221.3602382-1-andre.przywara@arm.com>
References: <20240209144221.3602382-1-andre.przywara@arm.com>
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
 drivers/thermal/sun8i_thermal.c | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c919b0fd5e169..8a9d2bdc71ece 100644
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
@@ -83,6 +85,7 @@ struct ths_device {
 	const struct ths_thermal_chip		*chip;
 	struct device				*dev;
 	struct regmap				*regmap;
+	struct regmap_field			*sram_regmap_field;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
 	struct clk                              *mod_clk;
@@ -337,6 +340,34 @@ static void sun8i_ths_reset_control_assert(void *data)
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
@@ -381,6 +412,21 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
+	if (tmdev->chip->needs_sram) {
+		const struct reg_field sun8i_sram_reg_field =
+			REG_FIELD(0x0, 16, 16);
+		struct regmap *regmap;
+
+		regmap = sun8i_ths_get_sram_regmap(dev->of_node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+		tmdev->sram_regmap_field = devm_regmap_field_alloc(dev,
+						      regmap,
+						      sun8i_sram_reg_field);
+		if (IS_ERR(tmdev->sram_regmap_field))
+			return PTR_ERR(tmdev->sram_regmap_field);
+	}
+
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
 		return ret;
@@ -427,6 +473,10 @@ static int sun50i_h6_thermal_init(struct ths_device *tmdev)
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


