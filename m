Return-Path: <linux-pm+bounces-31627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C39EFB1639A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 339E27B3C6F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA92DECD2;
	Wed, 30 Jul 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BFGf2TEk"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD52DEA6B;
	Wed, 30 Jul 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888956; cv=none; b=lmSWuw3LmU0tD4lTYN87xkb6E/WY4dwPWRFwuY4PWRjM0t9CI/hAbyxrwPi2BRD1mw79QoE5Rot+92sOiTJEFn5Q2b/9drJacByByxf8/QYzCKYnUZw+A0B0cB9D7ntxBQExoNGdKsGjroa0wrfRY339a0X2z4PEc8LqRWUycHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888956; c=relaxed/simple;
	bh=Q3cA3pX+1WE7CaAypi/uX/17iUDzaFYwPBaN7mhKPzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZXV5xvDIbovD8NbwjIRtBv3XYGJhZLJlJIDLlLk8bkg4ZP4QK10Pi09yQkC1dUemeO5U/6SoEzvlPlmJJ/62aJLR0/iMJ/tBS64zwLfRXnAXT5/JSssMaydOeQ9NnTAxD6m2QcEfsn9r46VAoIstaZx1AWqWCYd+LYFUqLaS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BFGf2TEk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753888952;
	bh=Q3cA3pX+1WE7CaAypi/uX/17iUDzaFYwPBaN7mhKPzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFGf2TEkexEMHZ3if4oUDW+fgJ1ItuvC85Rc/VRT+UoW1JcVJCnuJwjdEyiXbb84P
	 bU8MT7aD0YGOrFRSPzb2uG7/n/D8zF1sYjHAvOmwoSAXjWVwRU9Ms3DMhlQmhO1mhP
	 +wp1VGJMXUTqgzdbRQDFIj3I6VfsG9UTl0ZpblAqF0ik3dz8xS/lZjAlw2pkCqg8Nt
	 l0Ki+aeCs1yc03ChHh91RyGjOB5ebXxeV5XV7BO/luVON3H9Nrf/6SXUQm0UxXGC7E
	 Q3x460J3IydAJYT9nNUld6YW15y1/7vAiR0agLKzF+fqvIpoo7bKjfaKHpvmEzd4RS
	 K9GZNXAn3U8Lw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:41d5:bfd6:7c6f:85ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C38817E15A8;
	Wed, 30 Jul 2025 17:22:31 +0200 (CEST)
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
Cc: wenst@chromium.org,
	nfraprado@collabora.com,
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
Subject: [PATCH v2 4/9] thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
Date: Wed, 30 Jul 2025 17:21:23 +0200
Message-Id: <20250730152128.311109-5-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730152128.311109-1-laura.nao@collabora.com>
References: <20250730152128.311109-1-laura.nao@collabora.com>
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
require a different lvts_temp_to_raw() implementation.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 46 +++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8398af657ba2..6e4a35ecaf34 100644
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
 	const u32 *conn_cmd;
 	const u32 *init_cmd;
 	int num_cal_offsets;
@@ -300,6 +306,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
 						   sensors[lvts_sensor->id]);
 	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+	const struct lvts_platform_ops *ops = &lvts_data->ops;
 	void __iomem *msr = lvts_sensor->msr;
 	u32 value;
 	int rc;
@@ -332,7 +339,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (rc)
 		return -EAGAIN;
 
-	*temp = lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
+	*temp = ops->lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
 
 	return 0;
 }
@@ -400,10 +407,11 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
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
@@ -1774,6 +1782,10 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1788,6 +1800,10 @@ static const struct lvts_data mt8186_lvts_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1802,6 +1818,10 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1816,6 +1836,10 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1830,6 +1854,10 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1844,6 +1872,10 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1858,6 +1890,10 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = {
+		.lvts_raw_to_temp = lvts_raw_to_temp,
+		.lvts_temp_to_raw = lvts_temp_to_raw,
+	}
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1872,6 +1908,10 @@ static const struct lvts_data mt8195_lvts_ap_data = {
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


