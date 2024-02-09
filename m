Return-Path: <linux-pm+bounces-3703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F30C84F7C9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAD6B240AC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4F3F9FD;
	Fri,  9 Feb 2024 14:42:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925DB69D02;
	Fri,  9 Feb 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489758; cv=none; b=a0K8NWa6MAkzp/7/27GvOB1+TlAdIkALROzHWHTX/OpHsse9/9Jsr00mBb/gAAyqM5y08gZDwWm22OKtZIRV6jwqyL2URkcee39y4rNOS1/UxxFktB5sr1hcz9IWg072iwTKnMM0MVX2X4xN/km1NxQtzptkY8LEWRjogVdBuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489758; c=relaxed/simple;
	bh=8bTp6shJWwOdv8lHE66OVCjbgzN0eafCUQtzrDkZ9ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NuGezacfv8ZaX23e/5W+PKA312IVsnhAbaktE3MyCoCZd7+DFO5aNCx/gQl5TeHnqfVv33luVv3tTdE4g3By7Jl1OlAnBTuV8QocDBL2QRfMrsBBsaFLxkIYONhacI47ZboZYn8LUjZS0e5NOLejNeokbiZOpbx1wWRmkgL/lw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6D5FEC;
	Fri,  9 Feb 2024 06:43:18 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794503F5A1;
	Fri,  9 Feb 2024 06:42:33 -0800 (PST)
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
Subject: [PATCH v4 3/7] thermal: sun8i: explain unknown H6 register value
Date: Fri,  9 Feb 2024 14:42:17 +0000
Message-Id: <20240209144221.3602382-4-andre.przywara@arm.com>
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

So far we were ORing in some "unknown" value into the THS control
register on the Allwinner H6. This part of the register is not explained
in the H6 manual, but the H616 manual details those bits, and on closer
inspection the THS IP blocks in both SoCs seem very close:
- The BSP code for both SoCs writes the same values into THS_CTRL.
- The reset values of at least the first three registers are the same.

Replace the "unknown" value with its proper meaning: "acquire time",
most probably the sample part of the sample & hold circuit of the ADC,
according to its explanation in the H616 manual.

No functional change, just a macro rename and adjustment.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/thermal/sun8i_thermal.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 6a8e386dbc8dc..42bee03c4e507 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -50,7 +50,8 @@
 #define SUN8I_THS_CTRL2_T_ACQ1(x)		((GENMASK(15, 0) & (x)) << 16)
 #define SUN8I_THS_DATA_IRQ_STS(x)		BIT(x + 8)
 
-#define SUN50I_THS_CTRL0_T_ACQ(x)		((GENMASK(15, 0) & (x)) << 16)
+#define SUN50I_THS_CTRL0_T_ACQ(x)		(GENMASK(15, 0) & ((x) - 1))
+#define SUN50I_THS_CTRL0_T_SAMPLE_PER(x)	((GENMASK(15, 0) & ((x) - 1)) << 16)
 #define SUN50I_THS_FILTER_EN			BIT(2)
 #define SUN50I_THS_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
 #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
@@ -410,25 +411,27 @@ static int sun8i_h3_thermal_init(struct ths_device *tmdev)
 	return 0;
 }
 
-/*
- * Without this undocumented value, the returned temperatures would
- * be higher than real ones by about 20C.
- */
-#define SUN50I_H6_CTRL0_UNK 0x0000002f
-
 static int sun50i_h6_thermal_init(struct ths_device *tmdev)
 {
 	int val;
 
 	/*
-	 * T_acq = 20us
-	 * clkin = 24MHz
-	 *
-	 * x = T_acq * clkin - 1
-	 *   = 479
+	 * The manual recommends an overall sample frequency of 50 KHz (20us,
+	 * 480 cycles at 24 MHz), which provides plenty of time for both the
+	 * acquisition time (>24 cycles) and the actual conversion time
+	 * (>14 cycles).
+	 * The lower half of the CTRL register holds the "acquire time", in
+	 * clock cycles, which the manual recommends to be 2us:
+	 * 24MHz * 2us = 48 cycles.
+	 * The high half of THS_CTRL encodes the sample frequency, in clock
+	 * cycles: 24MHz * 20us = 480 cycles.
+	 * This is explained in the H616 manual, but apparently wrongly
+	 * described in the H6 manual, although the BSP code does the same
+	 * for both SoCs.
 	 */
 	regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
-		     SUN50I_H6_CTRL0_UNK | SUN50I_THS_CTRL0_T_ACQ(479));
+		     SUN50I_THS_CTRL0_T_ACQ(48) |
+		     SUN50I_THS_CTRL0_T_SAMPLE_PER(480));
 	/* average over 4 samples */
 	regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
 		     SUN50I_THS_FILTER_EN |
-- 
2.25.1


