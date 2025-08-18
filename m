Return-Path: <linux-pm+bounces-32575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD57B2AF5D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556875E6D4A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5222334575B;
	Mon, 18 Aug 2025 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NCRGBg4H"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF03469E4;
	Mon, 18 Aug 2025 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537985; cv=none; b=nmJuN6YC6QldhikHuvLuk5K9EE0UT2UkGnGhQFvigYdZf2OXp2cEYqboRlxMpU7DAECLdMkN++KdtwWpwYpkXAzCmSgNOqO3T801baYMkQTHdaVRHLsMyn7wRDqwQi55W/LRs6yFNYZjpTRkBcn00p5/93kpbuKxt3tktDYFwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537985; c=relaxed/simple;
	bh=kLBZWtTKF5vqyW7DfpbIw9wZ5LlhtmsKcMN58rvtmrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GenX0dMLZ8XpF4GiBbdJ76A9YGJV24LP6ZqevPNR3s2+zycgPQ6QGpZa35Hb4zhy3UQJw0Rcb04Co00x8uO6DwZMEfR8pRHadqprTTFo0MD8nqyBBzEt2DryQr1uzepYTdPkvYhqAmHtFKhu3w56GKZkbIBALiqtnVVW/jziny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NCRGBg4H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755537981;
	bh=kLBZWtTKF5vqyW7DfpbIw9wZ5LlhtmsKcMN58rvtmrI=;
	h=From:Date:Subject:To:Cc:From;
	b=NCRGBg4HKPVtNLhj5AvlqKhmfMZCrkb9KbD/elrwv9kbux4zRAToAby+hLn4UHCYP
	 A1Oolnqe6g1AjhOsIwIimqIr32Ek6KG23aJibwlur5s92w73ob2bkXzpHQ3Qi9t65H
	 ycHaSNNsoAMJscHmMx1WJEQWvTXWBwLEjr3H6Uy6P19sgsX2at45gcX1bKkxgAUZ6Z
	 Zfk/UGf/BguMpZQfG0eQcrLniQ6cKTMQaaPLSBtzhYaL6caEAWNZKdxEHUFVR8Meh4
	 gEnzw5DATPsDn7x0KgSGnLWEQmne/FNN3yjFYH1sKSvkA0oApTr0EDqIbYSNHkE1L9
	 GjX1Kn2VVU0Rw==
Received: from jupiter.universe (dyndsl-091-248-210-167.ewe-ip-backbone.de [91.248.210.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 163D117E0488;
	Mon, 18 Aug 2025 19:26:21 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id C7E82480044; Mon, 18 Aug 2025 19:26:20 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 18 Aug 2025 19:26:15 +0200
Subject: [PATCH] thermal: rockchip: shut up GRF warning
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
X-B4-Tracking: v=1; b=H4sIADZio2gC/x3MQQrDIBAAwK+EPXdBBRPJV0IOYldd2hhZS1oI+
 Xslx7nMCY2EqcE8nCB0cOO9dOjHACH7kgj52Q1GGaucdvjJJJt/o+zhFTJXTBLx66VwSahsnKI
 djRu9gV5Uoci/u1/W6/oD0yedI24AAAA=
X-Change-ID: 20250818-thermal-rockchip-grf-warning-05f7f56286a2
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6544; i=sre@kernel.org;
 h=from:subject:message-id; bh=kLBZWtTKF5vqyW7DfpbIw9wZ5LlhtmsKcMN58rvtmrI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGijYjwi/gDS+tjH8A93NibYB/LYsKmYcEaxd
 voJZFTKCJrJYYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoo2I8AAoJENju1/PI
 O/qaLaEP/A+VPe1DhkuPoP6SHmAzAI1jbnGYGxJhqlmJzlPGkk3RLheB7FeGsUozCNKrLxr+nYg
 /8NdoYgJ7/F+va8yS6hB3Ucifu/Mr7JLW5WBo5q8x0T815XMKy4KZi0+TEd1qrawytBoHgTR2Bm
 kBNID4fIBFqNaoTKZ00Xhq3+3fuwxO6o/ROu8IGfvtI9rhMkqR0Kmb+ZIdAAFeeMV12mmFkQTFc
 s8tcaq9uzO8RBmj8xWQyzvHK48K6Lz6p+dm4yuTssBleL1Uipdhj7svS3cpwI0KVMQQxy64S411
 dXluwAjQXmi+dJCPwVcixV82NFUMUXZFsIAweq3weg/teQVRyeGNBJP73NP3SKUKCDf3IGk5DDX
 eOLzDQvwrPfVamcVEHC9/O5ytvPEyX+OtlKfTH2eNa+wGHwAmrpr1LhEkOzxN7EjLB/1yHWyW+j
 cdou/4/+47QBh+/BhvUewdKq6NJkNO0yKlY5HTyC7R23DAkWQBxbUiWNSnDYnCXD2jFqhIhcFyX
 CFgJa/bD1tGupIsluLbxH0s4owyMNF7Av15PkKEYBjB0TQr892LpYj85Rzq5PYagNzfC/6NExLS
 x0IiD19GOK6MIpLRw8SMeF14xWl0b+2S/WOQZWiooRSx+htiYvg+1NqzLftuohn2c768Xb1Eb9Z
 nzZBj837z08FT3dpV5dwyPw==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Most of the recent Rockchip devices do not have a GRF associated
with the tsadc IP. Let's avoid printing a warning on those devices.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 53 +++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 3beff9b6fac3abe8948b56132b618ff1bed57217..1e8091cebd6673ab39fa0c4dee835c68aeb7e8b5 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -50,6 +50,18 @@ enum adc_sort_mode {
 	ADC_INCREMENT,
 };
 
+/*
+ * The GRF availability depends on the specific SoC
+ * GRF_NONE: the SoC does not have a GRF associated with the tsadc
+ * GRF_OPTIONAL: the SoC has a GRF, but the driver can work without it
+ * GRF_MANDATORY: the SoC has a GRF and it is required for proper operation
+ */
+enum tsadc_grf_mode {
+	GRF_NONE,
+	GRF_OPTIONAL,
+	GRF_MANDATORY,
+};
+
 #include "thermal_hwmon.h"
 
 /**
@@ -97,6 +109,9 @@ struct rockchip_tsadc_chip {
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
 
+	/* GRF availability */
+	enum tsadc_grf_mode grf_mode;
+
 	/* Chip-wide methods */
 	void (*initialize)(struct regmap *grf,
 			   void __iomem *reg, enum tshut_polarity p);
@@ -1099,6 +1114,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 2, /* 2 channels for tsadc */
 
+	.grf_mode = GRF_MANDATORY,
+
 	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
 	.tshut_temp = 95000,
 
@@ -1123,6 +1140,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 1, /* one channel for tsadc */
 
+	.grf_mode = GRF_NONE,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1148,6 +1167,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 1, /* one channel for tsadc */
 
+	.grf_mode = GRF_NONE,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1173,6 +1194,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	.chn_offset = 1,
 	.chn_num = 2, /* two channels for tsadc */
 
+	.grf_mode = GRF_NONE,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1198,6 +1221,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 1, /* one channels for tsadc */
 
+	.grf_mode = GRF_NONE,
+
 	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
 	.tshut_temp = 95000,
 
@@ -1222,6 +1247,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
+	.grf_mode = GRF_OPTIONAL,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1247,6 +1274,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
+	.grf_mode = GRF_NONE,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1272,6 +1301,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
+	.grf_mode = GRF_OPTIONAL,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1297,6 +1328,8 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	.chn_offset = 0,
 	.chn_num = 2, /* two channels for tsadc */
 
+	.grf_mode = GRF_OPTIONAL,
+
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1321,6 +1354,7 @@ static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
 	/* top, big_core, little_core, ddr, npu, gpu */
 	.chn_offset = 0,
 	.chn_num = 6, /* six channels for tsadc */
+	.grf_mode = GRF_NONE,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1345,6 +1379,7 @@ static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
 	/* top, big_core0, big_core1, little_core, center, gpu, npu */
 	.chn_offset = 0,
 	.chn_num = 7, /* seven channels for tsadc */
+	.grf_mode = GRF_NONE,
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
 	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
 	.tshut_temp = 95000,
@@ -1572,7 +1607,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 				      struct device_node *np,
 				      struct rockchip_thermal_data *thermal)
 {
-	u32 shut_temp, tshut_mode, tshut_polarity;
+	u32 shut_temp, tshut_mode, tshut_polarity, ret;
 
 	if (of_property_read_u32(np, "rockchip,hw-tshut-temp", &shut_temp)) {
 		dev_warn(dev,
@@ -1621,12 +1656,16 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* The tsadc wont to handle the error in here since some SoCs didn't
-	 * need this property.
-	 */
-	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(thermal->grf))
-		dev_warn(dev, "Missing rockchip,grf property\n");
+	if (thermal->chip->grf_mode != GRF_NONE) {
+		thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+		if (IS_ERR(thermal->grf)) {
+			ret = PTR_ERR(thermal->grf);
+			if (thermal->chip->grf_mode == GRF_OPTIONAL)
+				dev_warn(dev, "Missing rockchip,grf property\n");
+			else
+				return dev_err_probe(dev, ret, "Missing rockchip,grf property\n");
+		}
+	}
 
 	rockchip_get_trim_configuration(dev, np, thermal);
 

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-thermal-rockchip-grf-warning-05f7f56286a2

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


