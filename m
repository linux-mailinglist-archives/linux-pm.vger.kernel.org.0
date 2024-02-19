Return-Path: <linux-pm+bounces-4082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBC85A788
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 16:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F87128419B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F938F9F;
	Mon, 19 Feb 2024 15:36:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0108383BE;
	Mon, 19 Feb 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357019; cv=none; b=iqzbA3+c3cLVeYkiKRJdbJcgGsCSiMaexJPYPgjn3oS62+foP0Ek387pNuP7PlWsAGVsWSv4j4hn812553jlIgIqznzE/PxrbYt5ur3l8RP5lJFtsfBDZMfDvCJOrlFa3HdEKj5Li+CLJWzR64JrYnB8jxwsO9VyM8DEpD/ffEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357019; c=relaxed/simple;
	bh=tY9bzxyljYD2bqhnC+lbyk9SRKc3xauFDxiotOL9zAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBlRs0S4PiBN4YNYMOGEvv3Erq9YPvprNU7MH/JKR9HNmok+2JQ2tcZx60VihRDMqilBzBIn54iEQJlWpbnnVasxNGmrNQWTnlfrnmqBbf9Bl7LrXtfDfO5g5Fd16ontMoKkItq1ggchNW/UI8nhhVqO9SdaXh106TPoov4+70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D1D1007;
	Mon, 19 Feb 2024 07:37:36 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905293F762;
	Mon, 19 Feb 2024 07:36:54 -0800 (PST)
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
Subject: [PATCH v5 4/7] thermal: sun8i: extend H6 calibration to support 4 sensors
Date: Mon, 19 Feb 2024 15:36:36 +0000
Message-Id: <20240219153639.179814-5-andre.przywara@arm.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

The H616 SoC resembles the H6 thermal sensor controller, with a few
changes like four sensors.

Extend sun50i_h6_ths_calibrate() function to support calibration of
these sensors.

Co-developed-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 42bee03c4e507..c919b0fd5e169 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -222,16 +222,21 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	struct device *dev = tmdev->dev;
 	int i, ft_temp;
 
-	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
+	if (!caldata[0])
 		return -EINVAL;
 
 	/*
 	 * efuse layout:
 	 *
-	 *	0   11  16	 32
-	 *	+-------+-------+-------+
-	 *	|temp|  |sensor0|sensor1|
-	 *	+-------+-------+-------+
+	 * 0      11  16     27   32     43   48    57
+	 * +----------+-----------+-----------+-----------+
+	 * |  temp |  |sensor0|   |sensor1|   |sensor2|   |
+	 * +----------+-----------+-----------+-----------+
+	 *                      ^           ^           ^
+	 *                      |           |           |
+	 *                      |           |           sensor3[11:8]
+	 *                      |           sensor3[7:4]
+	 *                      sensor3[3:0]
 	 *
 	 * The calibration data on the H6 is the ambient temperature and
 	 * sensor values that are filled during the factory test stage.
@@ -244,9 +249,16 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-		int sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
-		int cdata, offset;
-		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
+		int sensor_reg, sensor_temp, cdata, offset;
+
+		if (i == 3)
+			sensor_reg = (caldata[1] >> 12)
+				     | ((caldata[2] >> 12) << 4)
+				     | ((caldata[3] >> 12) << 8);
+		else
+			sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
+
+		sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
 
 		/*
 		 * Calibration data is CALIBRATE_DEFAULT - (calculated
-- 
2.25.1


