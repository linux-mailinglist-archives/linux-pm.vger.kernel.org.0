Return-Path: <linux-pm+bounces-9653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AC910035
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94999B20C0B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262794AEE9;
	Thu, 20 Jun 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JB6Rp7YD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07519DF6C
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875395; cv=none; b=Q9Ov9Biswwd7hYei4Ls0Xm8wKtjvAr3eScslPIXzP8WCfvQsM7NJ5VVeTs9/6dUSMfJespL4bEqO9vxZACm/NorCJUpeV50O7sxLLHOs0yEJrPQ7eJzPQAPH1k7r3LtM6p0AcqHRWVif8R5LJ2w2g+DrhT0VOZ2nQ+JjVtj3lLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875395; c=relaxed/simple;
	bh=NuPDUWIRZf/8Tye0d5C7wcsBP1Z7rW595BqKKgapVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Il/Orj2H8tpoE398SkTEky9H8WBlSrKYdT5A8McLBgbwQcK1MnkofIATM6IE9fLbxb/ROTPmOlcouZXroNe3b06LBX8D/tInFr6i6bnOL8Ts/MeOrC0UopMb2fQ/WYQndMskQj728sQsWGysHmrjkXGrppGcsWOOFTztLm+xAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JB6Rp7YD; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d361cf5755so370910b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718875392; x=1719480192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTOvxtIiI/1rSVsnyqK5ede7Xf3BGz8mkXjO1sfkrcE=;
        b=JB6Rp7YDo/PiGR7hEctW02ic+eFP/kj7KHmAKdCeD+GrwGF0RF2x8Cg1jIT5moE5vn
         9rNVenkQOP0ylf4wEh03Vj8jXpr+ltRlcNYZTnnC7sOsRPTaGjY2QHG1MEHHftC3WOGz
         1sV0bHO6mY0XUWlzcohwILGXE8PYjMO5yqsro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718875392; x=1719480192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTOvxtIiI/1rSVsnyqK5ede7Xf3BGz8mkXjO1sfkrcE=;
        b=NUV2xQlmkCpZfG2UrQanQuRZhsMeg+2JCYB8tPJXWtsytDvSbRFtj6eFv+e9a/6B+R
         xFBWHS7h4ztZbd94GxbIlcIY/nHAtG60hQMgcsnOf/KKmOO+sMzJWv/X2XYbTAbGSoTp
         ti6DJE2/G4QFPsavjCxi41G0nMpfrIZNhFqUny/f0DpQVDgV1BmvdemRl1FWmQIEJYpj
         fjvogR1wrbRT9i5NxcYoqHp6f4nkfYbWuue7D6hreWieZu8kkLTvZDtfZQEvAyV4HLYt
         BRCqS3fJk5IQlslRBMPmtFY9JgGyxyHC/N3OlzgysisdTf9KyDXn6IDB826cneAvQ9c8
         dDww==
X-Forwarded-Encrypted: i=1; AJvYcCVuzSk/R5vY0xdmJC74qA7E/P4Dd19tDvvmLcStDt78WFlYJfd44Btl2Ij8l4CUU+HmRMLmpx25DHJTSvfiFznqz1kxPV2vFOA=
X-Gm-Message-State: AOJu0YzKpBa1dJdTZ5cJ6ztq2hibCdYH2hxcrWXUfrR5JxzFXTzlOiwz
	Z9JyTgKeaBGbt/JJ8YLa2TmiRpT/KejuJ9Y4W8As62Vrzltvdd1Zh3HXRgmbRA==
X-Google-Smtp-Source: AGHT+IHG1Qywf1NHXqmplHsfBSGZmQpZMD312c+7WzkDmSDb1JUiu8ehCBtziKheqH469mAnY8PkLQ==
X-Received: by 2002:a05:6871:586:b0:25c:be22:8ae2 with SMTP id 586e51a60fabf-25cbe2290eamr1168729fac.33.1718875392592;
        Thu, 20 Jun 2024 02:23:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96aee8sm11950339b3a.73.2024.06.20.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:23:12 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Julien Panis <jpanis@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Provide default calibration data
Date: Thu, 20 Jun 2024 17:23:03 +0800
Message-ID: <20240620092306.2352606-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some pre-production hardware, the SoCs do not contain calibration
data for the thermal sensors. The downstream drivers provide default
values that sort of work, instead of having the thermal sensors not
work at all.

Port the default values to the upstream driver. These values are from
the ChromeOS kernels, which sadly do not cover the MT7988.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 34 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 73148bd8da1f..1997e91bb3be 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -128,6 +128,7 @@ struct lvts_data {
 	int temp_factor;
 	int temp_offset;
 	int gt_calib_bit_offset;
+	unsigned int def_calibration;
 };
 
 struct lvts_sensor {
@@ -689,6 +690,10 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 					size_t calib_len)
 {
 	int i;
+	u32 gt;
+
+	/* A zero value for gt means that device has invalid efuse data */
+	gt = (((u32 *)efuse_calibration)[0] >> lvts_ctrl->lvts_data->gt_calib_bit_offset) & 0xff;
 
 	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 		const struct lvts_sensor_data *sensor =
@@ -699,10 +704,17 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 		    sensor->cal_offsets[2] >= calib_len)
 			return -EINVAL;
 
-		lvts_ctrl->calibration[i] =
-			(efuse_calibration[sensor->cal_offsets[0]] << 0) +
-			(efuse_calibration[sensor->cal_offsets[1]] << 8) +
-			(efuse_calibration[sensor->cal_offsets[2]] << 16);
+		if (gt) {
+			lvts_ctrl->calibration[i] =
+				(efuse_calibration[sensor->cal_offsets[0]] << 0) +
+				(efuse_calibration[sensor->cal_offsets[1]] << 8) +
+				(efuse_calibration[sensor->cal_offsets[2]] << 16);
+		} else if (lvts_ctrl->lvts_data->def_calibration) {
+			lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
+		} else {
+			dev_err(dev, "efuse contains invalid calibration data and no default given.\n");
+			return -ENODATA;
+		}
 	}
 
 	return 0;
@@ -770,14 +782,13 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
 	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
 	/* A zero value for gt means that device has invalid efuse data */
-	if (!gt)
-		return -ENODATA;
-
-	if (gt < LVTS_GOLDEN_TEMP_MAX)
+	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
 	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
 
+	dev_info(dev, "%sgolden temp=%d\n", gt ? "" : "fake ", golden_temp);
+
 	return 0;
 }
 
@@ -1701,6 +1712,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 19000,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1709,6 +1721,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1717,6 +1730,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1725,6 +1739,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1733,6 +1748,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1741,6 +1757,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1749,6 +1766,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT8195,
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
+	.def_calibration = 35000,
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.45.2.741.gdbec12cfda-goog


