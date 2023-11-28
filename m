Return-Path: <linux-pm+bounces-322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD87FAF5A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98BC28166E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0415C5;
	Tue, 28 Nov 2023 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13482135;
	Mon, 27 Nov 2023 17:00:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A7C1650;
	Mon, 27 Nov 2023 17:01:32 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52D233F6C4;
	Mon, 27 Nov 2023 17:00:42 -0800 (PST)
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
Subject: [PATCH v3 3/6] thermal: sun8i: explain unknown H6 register value
Date: Tue, 28 Nov 2023 00:58:46 +0000
Message-Id: <20231128005849.19044-4-andre.przywara@arm.com>
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
index f989b55a8aa8e..44554c3efc96c 100644
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
2.35.8


