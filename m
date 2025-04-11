Return-Path: <linux-pm+bounces-25195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF7A850A9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774481B684D7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC81F92A;
	Fri, 11 Apr 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwRoH2T0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84C17C68;
	Fri, 11 Apr 2025 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332008; cv=none; b=I0P3fzi3jwE8wXtrSkg5bw5Sm7ecbNPWTbHxPxtAec9KsCkXW8Ik3T/Li6lgxSEwRaY9UZfVQk0AJP9MP6lc+gwpKod/PAGdsg9L/PeNCGYR2T8zM7Qnuh9Tb7v56NwJGFhRtnBQGv+8HrQW74GYATvmRAZt/Zakxx0FW/ehWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332008; c=relaxed/simple;
	bh=z60GVKKnq+EBoMPOIQiGwthlZL/5bB21DgiBmuXlxlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCCRHwRlMPWbY9gVLcEjEd//pEpXbHvx2Qr1utPCIDU/Ord9hO0Z9GEbwzgSZtuC9ugRqIHuIiyCGrFp3K4EAtoMBHgClfuKng9+P/Ilzb0aecaxj1oVLz2/c+76HPJFfs9UpLEqrOpAqAr0tcHyvusK5U0znPiTOTr+Hm8Rs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwRoH2T0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30de488cf81so13525221fa.1;
        Thu, 10 Apr 2025 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744332004; x=1744936804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+rSfwK2IdMno7cgyqb3eYYWrYZbiRnVldmhW9L6vWA=;
        b=YwRoH2T0svzvS2d7UZyTZvyQpEMA6i46/VT6YHT0mB+zOLre3rq6O7shEnH+xuGA0q
         LZRLzCekXhPQvbKyS39NLf1aAU/WIxnx1pNmHOoRH/nsJrbKWb2tForhbP23cRVQps34
         jo41i/No99XlvFRPDJ+yFGeeFdksaIB6KeZQ/T8YnmRQvcD6UkdAkgbfkp3AhGfT/1gu
         ERpUfvOC0IQ2cFLxQbDzxr27q7WK9Ig6MeXK3FY9pdqwz55Ky1Zg4O1Fy3cQTLPLrLeH
         u33GVLaclcY8XZEv9vzHg6+gsFffoLTdH5iNQkYFYs4dlKTWsVSLzMKvXhEA41SjrxSN
         GWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744332004; x=1744936804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+rSfwK2IdMno7cgyqb3eYYWrYZbiRnVldmhW9L6vWA=;
        b=LZxLI32bRO/hszrFwXKol4wUB9uYcs025NROvVFwlbsU0bzk9fMsIMteXF+UT7czx2
         TQtOt0xM/+rGzQNavjo1p2/ct2V7YRtO94J3YMylFaWEkNo+J8WFuLE+l1CDl2Qj8hEb
         9RZ2QReqeUl9dWh7oVpSMmAyQ8BSvww+Ejda+Yr0lVnwGy2du7yzvmv/fw3Y69Yh8vbd
         Mihjz6lKzS1flT6aye/9fABEPqzCarxFVCaBFhVd+st9Iof7ew3/KKEKbfp9j6PZm06z
         gY+xZEb5fON1aVKXDegN3x3+e2vthKSldMT026h4POaQEg4tOr8tFc+mXbqzPWuYFaKy
         IVfA==
X-Forwarded-Encrypted: i=1; AJvYcCUbV6lOVNRWOY6EdvKB4Ie51uposW3zLkg4SMgpPL4cyq1edg7wcxEeXXjfm7Lou8hNLYBjtxftSX/yeBQL@vger.kernel.org, AJvYcCWHyRyG+KYbUGm9FvhHeSKnYSrnHuPsK8hfa09ag6ntYVdztz6v/0YiJgtEAIYuE2wXgOWHv3fy7tY=@vger.kernel.org, AJvYcCWnu2kjJq8zeZJ1UF/FOqFTI8PblMHjSei5DFZjKHC1ZN/9T3afuKDGDgt30VHEuNo3++Cu8hcelE0B@vger.kernel.org
X-Gm-Message-State: AOJu0YypON2s8Ptgp+72uqmXkYXc2xYSx7OFJTV/jV14X6iFRvIEBiVV
	lLFqngICR0WfZjs+LWp0Fo+i5NyAcSr29y0XrCOrz1KXZPFthwdt
X-Gm-Gg: ASbGncsDVoY3QxMWIZ8IHEZWONA3NiBCEQBFtdQiuQxeWgwItms83OQR0iQ6JsWuN2C
	GxLio0IAJGRcPIYPrE1vTnAfilg2C2ch2oVHH/5AnaZpWzxHsi+CYF1plqYp2R+66eED0iYxfzd
	/gfXsvaHSCq2HLCqSjXceAPSRGUMULsz6WRPbcvx5SXNJlIgJca4Hett9+sznQ1vHIUNTtUB+Y7
	HURLAwtcmvbwHxKxZvLe1Vu/crXBjG8/VaRnyIgCqudj90YHzWb8s6u32P8TR9KmNw0WQ4aK4hk
	sh28kPjpm89bDNjNVhZ6L7JPReh4XExH0MiYrWhbpo4CWvMVcA==
X-Google-Smtp-Source: AGHT+IEHx3pLyyA7RUjJFQMZKlcC6nirFWEfuuk3UQ55sdEchAVrUtO52D2wnKHHqYnoHtifKxO3Bg==
X-Received: by 2002:a2e:ab18:0:b0:30c:7a7:e87c with SMTP id 38308e7fff4ca-31049a9a9f5mr2279391fa.35.1744332003965;
        Thu, 10 Apr 2025 17:40:03 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:40:03 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 3/6] thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
Date: Fri, 11 Apr 2025 08:38:23 +0800
Message-ID: <20250411003827.782544-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, THS0 and THS1.
THS0 has only one temperature sensor, which is located in the DRAM.

THS1 does have 3 sensors:
ths1_0 - "big" cores
ths1_1 - "little" cores
ths1_2 - gpu

The datasheet mentions a fourth sensor in the NPU, but lacks any registers
for operation other than calibration registers. The vendor code reads the
value from ths1_2, but uses separate calibration data, so we get two
different values from real one.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 134 ++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index dc4055c9c..919b05a96 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -116,6 +116,15 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
+static int sun55i_a523_calc_temp(struct ths_device *tmdev,
+					int id, int reg)
+{
+	if (reg >= 0x7c8)
+		return tmdev->chip->scale * (tmdev->chip->offset - reg);
+	else
+		return 65 * (2825 - reg);
+}
+
 static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct tsensor *s = thermal_zone_device_priv(tz);
@@ -208,6 +217,100 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+
+/*
+ * The A523 nvmem calibration values. The ths1_3 is not used as it
+ * doesn't have its own sensor and doesn't have any internal switch.
+ * Instead, the value from the ths1_2 sensor is used, which gives the
+ * illusion of an independent sensor for NPU and GPU when using
+ * different calibration values.
+ *
+ * efuse layout 0x38-0x3F (caldata[0..3]):
+ *     caldata[0]      caldata[1]      caldata[2]      caldata[3]
+ * 0               16      24      32  36          48          60 64
+ * +---------------+---------------+---------------+---------------+
+ * |               |       |   temp    |  ths1_0   |  ths1_1   |   +
+ * +---------------+---------------+---------------+---------------+
+ *
+ * efuse layout 0x40-0x43 (caldata[4..5]) - not in use
+ *
+ * efuse layout 0x44-0x4B (caldata[6..9]):
+ *     caldata[6]      caldata[7]      caldata[8]      caldata[9]
+ * 0           12  16      24      32  36          48             64
+ * +---------------+---------------+---------------+---------------+
+ * |  ths1_2   |  ths1_3   |  ths0_0   |           |               +
+ * +---------------+---------------+---------------+---------------+
+ */
+static int sun55i_a523_ths_calibrate(struct ths_device *tmdev,
+				   u16 *caldata, int callen)
+{
+	struct device *dev = tmdev->dev;
+	int i, ft_temp;
+
+	if (!caldata[0])
+		return -EINVAL;
+
+	ft_temp = (((caldata[2] << 8) | (caldata[1] >> 8)) & FT_TEMP_MASK) * 100;
+
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		int sensor_reg, sensor_temp, cdata, offset;
+		/*
+		 * Chips ths0 and ths1 have common parameters for value
+		 * calibration. To separate them we can use the number of
+		 * temperature sensors on each chip.
+		 * For ths0 this value is 1.
+		 */
+		if (tmdev->chip->sensor_num == 1) {
+			sensor_reg = ((caldata[7] >> 8) | (caldata[8] << 8)) & TEMP_CALIB_MASK;
+		} else {
+			switch (i) {
+			case 0:
+				sensor_reg = (caldata[2] >> 4) & TEMP_CALIB_MASK;
+				break;
+			case 1:
+				sensor_reg = caldata[3] & TEMP_CALIB_MASK;
+				break;
+			case 2:
+				sensor_reg = caldata[6] & TEMP_CALIB_MASK;
+				break;
+			default:
+				sensor_reg = 0;
+				break;
+			}
+		}
+
+		sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
+
+		/*
+		 * Calibration data is CALIBRATE_DEFAULT - (calculated
+		 * temperature from sensor reading at factory temperature
+		 * minus actual factory temperature) * X (scale from
+		 * temperature to register values)
+		 */
+		cdata = CALIBRATE_DEFAULT -
+			((sensor_temp - ft_temp) / tmdev->chip->scale);
+
+		if (cdata & ~TEMP_CALIB_MASK) {
+			/*
+			 * Calibration value more than 12-bit, but calibration
+			 * register is 12-bit. In this case, ths hardware can
+			 * still work without calibration, although the data
+			 * won't be so accurate.
+			 */
+			dev_warn(dev, "sensor%d is not calibrated.\n", i);
+			continue;
+		}
+
+		offset = (i % 2) * 16;
+		regmap_update_bits(tmdev->regmap,
+				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
+				   TEMP_CALIB_MASK << offset,
+				   cdata << offset);
+	}
+
+	return 0;
+}
+
 static int sun8i_h3_ths_calibrate(struct ths_device *tmdev,
 				  u16 *caldata, int callen)
 {
@@ -721,6 +824,35 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+/* The A523 has a shared reset line for both chips */
+static const struct ths_thermal_chip sun55i_a523_ths0 = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.has_gpadc_clk = true,
+	.ft_deviation = 5000,
+	.offset = 2736,
+	.scale = 74,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun55i_a523_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun55i_a523_calc_temp,
+};
+
+static const struct ths_thermal_chip sun55i_a523_ths1 = {
+	.sensor_num = 3,
+	.has_bus_clk_reset = true,
+	.has_gpadc_clk = true,
+	.ft_deviation = 5000,
+	.offset = 2736,
+	.scale = 74,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun55i_a523_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun55i_a523_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -731,6 +863,8 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
+	{ .compatible = "allwinner,sun55i-a523-ths0", .data = &sun55i_a523_ths0 },
+	{ .compatible = "allwinner,sun55i-a523-ths1", .data = &sun55i_a523_ths1 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.49.0


