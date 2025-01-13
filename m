Return-Path: <linux-pm+bounces-20331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB378A0B81B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506C33A4F6F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99E288A2;
	Mon, 13 Jan 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PNLbx066"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4322318;
	Mon, 13 Jan 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774888; cv=none; b=LYAE9rs4LQfiZ1SBH8B+nBBDiB3q1rJEBDvB1FnvBmQVWdl757yg4cN7Kd4sS5Ygmdpj+NMUv86rZsuNiS2GFJrE0DsWiMH/u54KjLwjd99jq1LBe2Ev+zSrN+TbbpMXO2k4K+CtHnGCHwlTag0z2V6SQsVvADE8RKPFZb8OCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774888; c=relaxed/simple;
	bh=vEIDXIbkeYyVL5RhjAFFnU72bWHMybRsLnqNbiv0BGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwhwsGNSQmGM7jVryMj4XpjAB2fpK4RZ6hgEJ83L1ab0lUtA7UwBFug9T8Sj66ZLQ2ZcH8lLUV2YeCK8DIoZADvCu28OvBVfOejBwtdiBku1vyCbTlVATY7fOc25H73QKQGcwlVANkiTHAkVFMZbFDqMB+SK2brDj1TzspU9gCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PNLbx066; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736774884;
	bh=vEIDXIbkeYyVL5RhjAFFnU72bWHMybRsLnqNbiv0BGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PNLbx066YYR9h8fsaS05opAPQMNgc7SJjwUPjniLx3laMm0UkMVLB3rQPEeGddJXN
	 KGm80CvrsYFntNwBancnn5jBNDJWeBaVdRykgo3Jk9XCt0THJvGTrlOS/iDAhFODR3
	 TdZ2Y+uUFXYHGMGYG9ckAHJerYxZvUAz3w9gCHOuJH0SFPqSlMQhLZrGF1SP7EAyeq
	 WaeKE3CQ5HyOcpVBUR9rtK+Nk1W0fU7zvvmYVQIiUnsuO7/LfabbwyABSNyGk12C9a
	 UUepPXJ4r8lXIAl8IcOGRA9BEj4jTk8M0yqEny7ZzL5v7/iqukHYs6+BlTgJw+ZVPE
	 Fa5oy6+HTpWZg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9392517E0E9D;
	Mon, 13 Jan 2025 14:28:00 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 13 Jan 2025 10:27:13 -0300
Subject: [PATCH RESEND v2 2/5] thermal/drivers/mediatek/lvts: Disable Stage
 3 thermal threshold
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-mt8192-lvts-filtered-suspend-fix-v2-2-07a25200c7c6@collabora.com>
References: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
In-Reply-To: <20250113-mt8192-lvts-filtered-suspend-fix-v2-0-07a25200c7c6@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

The Stage 3 thermal threshold is currently configured during
the controller initialization to 105 Celsius. From the kernel
perspective, this configuration is harmful because:
* The stage 3 interrupt that gets triggered when the threshold is
  crossed is not handled in any way by the IRQ handler, it just gets
  cleared. Besides, the temperature used for stage 3 comes from the
  sensors, and the critical thermal trip points described in the
  Devicetree will already cause a shutdown when crossed (at a lower
  temperature, of 100 Celsius, for all SoCs currently using this
  driver).
* The only effect of crossing the stage 3 threshold that has been
  observed is that it causes the machine to no longer be able to enter
  suspend. Even if that was a result of a momentary glitch in the
  temperature reading of a sensor (as has been observed on the
  MT8192-based Chromebooks).

For those reasons, disable the Stage 3 thermal threshold configuration.

Cc: stable@vger.kernel.org
Reported-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Closes: https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/
Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a1a438ebad33c1fff8ca9781e12ef9e278eef785..0aaa44b734ca43e6abfd97b2ca4ce34dc6f15826 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -65,7 +65,7 @@
 #define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x8300318C
+#define LVTS_MONINT_CONF			0x0300318C
 
 #define LVTS_MONINT_OFFSET_SENSOR0		0xC
 #define LVTS_MONINT_OFFSET_SENSOR1		0x180
@@ -91,8 +91,6 @@
 #define LVTS_MSR_READ_TIMEOUT_US	400
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
 
-#define LVTS_HW_TSHUT_TEMP		105000
-
 #define LVTS_MINIMUM_THRESHOLD		20000
 
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
@@ -145,7 +143,6 @@ struct lvts_ctrl {
 	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
-	u32 hw_tshut_raw_temp;
 	u8 valid_sensor_mask;
 	int mode;
 	void __iomem *base;
@@ -837,14 +834,6 @@ static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
 		 */
 		lvts_ctrl[i].mode = lvts_data->lvts_ctrl[i].mode;
 
-		/*
-		 * The temperature to raw temperature must be done
-		 * after initializing the calibration.
-		 */
-		lvts_ctrl[i].hw_tshut_raw_temp =
-			lvts_temp_to_raw(LVTS_HW_TSHUT_TEMP,
-					 lvts_data->temp_factor);
-
 		lvts_ctrl[i].low_thresh = INT_MIN;
 		lvts_ctrl[i].high_thresh = INT_MIN;
 	}
@@ -919,7 +908,6 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 *         10 : Selected sensor with bits 19-18
 	 *         11 : Reserved
 	 */
-	writel(BIT(16), LVTS_PROTCTL(lvts_ctrl->base));
 
 	/*
 	 * LVTS_PROTTA : Stage 1 temperature threshold
@@ -932,8 +920,8 @@ static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
 	 *
 	 * writel(0x0, LVTS_PROTTA(lvts_ctrl->base));
 	 * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
+	 * writel(0x0, LVTS_PROTTC(lvts_ctrl->base));
 	 */
-	writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
 
 	/*
 	 * LVTS_MONINT : Interrupt configuration register

-- 
2.47.1


