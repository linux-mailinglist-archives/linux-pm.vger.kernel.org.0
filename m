Return-Path: <linux-pm+bounces-3706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2466684F7CF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 15:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D221F253E7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C469D02;
	Fri,  9 Feb 2024 14:42:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD06994A;
	Fri,  9 Feb 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489766; cv=none; b=HyflwiWXpf/iwjLiJJB63zjr1ueptR5fo3ZAEgkNhLSN2Dx8pjNL6v4NAJasf3Z3y/mFzdIYwK5Uiq+kIcUfqaY32raOt7rRL8BOIaNAayxC4GON5tU0Ire/ociXZ+zh/EC27S5DsXhlEFP9+Xaf0FLN+5AhzcTPXoDeFYl0oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489766; c=relaxed/simple;
	bh=UUttNuWYCqRtEnBm21AteVfJTZyUkW9rRPFo4rC8qmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W23zsRwrDSfF5VHRXjbV1njALAL6sPIb+1NgO6UYH8qpTa9v1zYLN6Bf9nn8hkZha0E9jxdvcn25oGIECiq82WfOsVx2apH3zURxch1psbz0P4vdQfwvsS7EMBQtveg7rEEOViQ5pfymBrpgxV98JXxB1vti5VD517OAqFO/NoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46BB1DA7;
	Fri,  9 Feb 2024 06:43:26 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19143F5A1;
	Fri,  9 Feb 2024 06:42:41 -0800 (PST)
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
Subject: [PATCH v4 6/7] thermal: sun8i: add support for H616 THS controller
Date: Fri,  9 Feb 2024 14:42:20 +0000
Message-Id: <20240209144221.3602382-7-andre.przywara@arm.com>
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

From: Martin Botka <martin.botka@somainline.org>

Add support for the thermal sensor found in H616 SoCs, is the same as
the H6 thermal sensor controller, but with four sensors.
Also the registers readings are wrong, unless a bit in the first SYS_CFG
register cleared, so set exercise the SRAM regmap to take care of that.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/thermal/sun8i_thermal.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 8a9d2bdc71ece..172410a9e0274 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -683,6 +683,20 @@ static const struct ths_thermal_chip sun20i_d1_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun50i_h616_ths = {
+	.sensor_num = 4,
+	.has_bus_clk_reset = true,
+	.needs_sram = true,
+	.ft_deviation = 8000,
+	.offset = 263655,
+	.scale = 810,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h6_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -692,6 +706,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
+	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.25.1


