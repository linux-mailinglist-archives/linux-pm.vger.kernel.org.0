Return-Path: <linux-pm+bounces-31177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5840BB0BE8D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C04E3B9721
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1F288C2D;
	Mon, 21 Jul 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FDsHqgap"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E42877CF;
	Mon, 21 Jul 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085785; cv=none; b=nPm/3mY9tgN0BDYuj2oeVBB0Ls0NJ+tIxcNcRwf4leMmg6U/gx2vRf8x6PhC9HeAYeMvRG4kW+LHUlgQIw3TDZ/z1cPEbXLjo+EdHI5lQhyTDbSwo04Xg6LvLbRgc9p5e/G0KvJAIXpyPIpizjISqyjz2//cWn9Qa06XtSJTi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085785; c=relaxed/simple;
	bh=UdWu+G1mayLNOq+LRtzhCX9nU6UsOGyouXKigDoIKz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cv4TOmGFJ2KBj9sUKAtb+l/MKDg5z5Nt1M2wdWEsMzN2f9W+tDO7FcPHI/MP3edsW2uLwFyRjm2Ekk6dROnAmwpHyZKrgEBUmNGCn08y7G49fEBJrt8b1odMiQfOQcF8QbssZpWfmGJzFu434aavOeLxx64phLzrc5U+DPxu5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FDsHqgap; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753085781;
	bh=UdWu+G1mayLNOq+LRtzhCX9nU6UsOGyouXKigDoIKz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDsHqgapD1h51Q088eohb25j23NrBSWtQOCbM/1kGdUsakFFdMuGkWicXgFBUyJAB
	 AHBctInQsY+Z/ECcZbhLdi7icuJro9SJ6T8f+Im78yfL8Qvg+OrwiMOiOrD42uMEdX
	 2FqVi5uhxMWdP0AiBfOLdGrY20yji+sEr0lAbNmfj+YuElJB02EzyRDWj/1RGk8Mee
	 HrnnLZvy7bj0e6ZSlODXH0C7gO/2BgELNelsZq11rN22hFpYc6vlAImXA+vrI+XyX4
	 Hkz6Rrb8NwPg1VD1ArtTNIxw6nPN/eCClmRL6eFTNymoiAhR5w9HC54D1m+sWY/goY
	 CtrmpXOMweQJg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4487:69c6:40a:81be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED9C017E1576;
	Mon, 21 Jul 2025 10:16:19 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 4/9] thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
Date: Mon, 21 Jul 2025 10:14:54 +0200
Message-Id: <20250721081459.16278-5-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721081459.16278-1-laura.nao@collabora.com>
References: <20250721081459.16278-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce lvts_platform_ops struct to support SoC-specific versions of
lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.

This is in preparation for supporting SoCs like MT8196/MT6991, which
have a positive temp_factor and need a different lvts_temp_to_raw()
implementation.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 46 +++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b80c2929ae74..db83137c7537 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -125,8 +125,14 @@ struct lvts_ctrl_data {
 			continue; \
 		else
 
+struct lvts_platform_ops {
+	int (*lvts_raw_to_temp)(u32 raw_temp, int temp_factor);
+	u32 (*lvts_temp_to_raw)(int temperature, int temp_factor);
+};
+
 struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
+	struct lvts_platform_ops ops;
 	int num_cal_offsets;
 	int num_lvts_ctrl;
 	int temp_factor;
@@ -296,6 +302,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
 						   sensors[lvts_sensor->id]);
 	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+	const struct lvts_platform_ops *ops = &lvts_data->ops;
 	void __iomem *msr = lvts_sensor->msr;
 	u32 value;
 	int rc;
@@ -328,7 +335,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (rc)
 		return -EAGAIN;
 
-	*temp = lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
+	*temp = ops->lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
 
 	return 0;
 }
@@ -396,10 +403,11 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
 						   sensors[lvts_sensor->id]);
 	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+	const struct lvts_platform_ops *ops = &lvts_data->ops;
 	void __iomem *base = lvts_sensor->base;
-	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
+	u32 raw_low = ops->lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
 				       lvts_data->temp_factor);
-	u32 raw_high = lvts_temp_to_raw(high, lvts_data->temp_factor);
+	u32 raw_high = ops->lvts_temp_to_raw(high, lvts_data->temp_factor);
 	bool should_update_thresh;
 
 	lvts_sensor->low_thresh = low;
@@ -1751,6 +1759,10 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1761,6 +1773,10 @@ static const struct lvts_data mt8186_lvts_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1771,6 +1787,10 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1781,6 +1801,10 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1791,6 +1815,10 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1801,6 +1829,10 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1811,6 +1843,10 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1821,6 +1857,10 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.39.5


