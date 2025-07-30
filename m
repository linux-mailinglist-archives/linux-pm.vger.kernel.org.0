Return-Path: <linux-pm+bounces-31625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86EB16393
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C78E172434
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468A2DE6E4;
	Wed, 30 Jul 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FiStfqBj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390542DCC13;
	Wed, 30 Jul 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888953; cv=none; b=uMKrCYDP38yF+P/hAOhGYrYGJs+12xP+cRt1KP/PbWGeCIYG6cmN4M2cRcW/rOwlm1leCcCCJvs8/OJ3mG+Bvx2RKHtT3U2iTz/8IlaGVGpzWqmF6IS2MotHu9sk4dp+orXPLRdJ9IlKOZG1V++vXOQo/1qKowfv3nfYRdzIwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888953; c=relaxed/simple;
	bh=6yZ3TjDwGcaMED/emvt1bnTeL/8aEu0VXnrMFQ6bTHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6Pk/TCZv6JkQ2iftJ7wJdhcK+jervIkOEU5grNO8+8YXICqSa6/nKW6QSYSu/+wmVJ7iAlIG8sRq3/1u1RN3JuBr2qDI8iKf7bUjQkwp849VRLUcVU/P9/wpJnwRPXrUUuAd+8O9D/wzVIXu2x1S3sqONdUkHkulbshrknnzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FiStfqBj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753888949;
	bh=6yZ3TjDwGcaMED/emvt1bnTeL/8aEu0VXnrMFQ6bTHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FiStfqBjQKdzp2FvtSeXLBzr6YbBVOSaUzKw+9CLubrL3TnIQetLie1+XPLW7conN
	 LgCYHr7ASveSbaljlXmpWrVJF/TxogEaPYVpu0BzmjsTjEQ9elJRGKeTk4xAuNdVj6
	 lhXdnUkNin5qsK+mIFcxV/DwNKIzLIUv8uXBTJCSekNphy15WBcEF+lJ71z7DoOcs1
	 cPMrKOfU71S9pDDVmHB/Da4wjejdN4CsyEi9UjQBpWexGCTY6d4CMfnNULWTyMLOc7
	 dPgwaBs/x5Q51qDpMTq6+ERPljwb9f3Y3siUB9E0torhUnIH7a2wsludqBWt4FeORD
	 B+71eDmBRO7cw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:41d5:bfd6:7c6f:85ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27CA717E1321;
	Wed, 30 Jul 2025 17:22:28 +0200 (CEST)
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
Subject: [PATCH v2 2/9] thermal/drivers/mediatek/lvts: Make number of calibration offsets configurable
Date: Wed, 30 Jul 2025 17:21:21 +0200
Message-Id: <20250730152128.311109-3-laura.nao@collabora.com>
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

MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
supported by the driver rely on 3 bytes. Make the number of calibration
bytes per sensor configurable, enabling support for SoCs with varying
calibration formats.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 32 +++++++++++++++++--------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index f4d1e66d7db9..05aa8895ccce 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -96,12 +96,14 @@
 
 #define LVTS_MINIMUM_THRESHOLD		20000
 
+#define LVTS_MAX_CAL_OFFSETS		3
+
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int golden_temp_offset;
 
 struct lvts_sensor_data {
 	int dt_id;
-	u8 cal_offsets[3];
+	u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
 };
 
 struct lvts_ctrl_data {
@@ -127,6 +129,7 @@ struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
 	const u32 *conn_cmd;
 	const u32 *init_cmd;
+	int num_cal_offsets;
 	int num_lvts_ctrl;
 	int num_conn_cmd;
 	int num_init_cmd;
@@ -711,7 +714,7 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 					u8 *efuse_calibration,
 					size_t calib_len)
 {
-	int i;
+	int i, j;
 	u32 gt;
 
 	/* A zero value for gt means that device has invalid efuse data */
@@ -720,17 +723,18 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 		const struct lvts_sensor_data *sensor =
 					&lvts_ctrl_data->lvts_sensor[i];
+		u32 calib = 0;
 
-		if (sensor->cal_offsets[0] >= calib_len ||
-		    sensor->cal_offsets[1] >= calib_len ||
-		    sensor->cal_offsets[2] >= calib_len)
-			return -EINVAL;
+		for (j = 0; j < lvts_ctrl->lvts_data->num_cal_offsets; j++) {
+			u8 offset = sensor->cal_offsets[j];
+
+			if (offset >= calib_len)
+				return -EINVAL;
+			calib |= efuse_calibration[offset] << (8 * j);
+		}
 
 		if (gt) {
-			lvts_ctrl->calibration[i] =
-				(efuse_calibration[sensor->cal_offsets[0]] << 0) +
-				(efuse_calibration[sensor->cal_offsets[1]] << 8) +
-				(efuse_calibration[sensor->cal_offsets[2]] << 16);
+			lvts_ctrl->calibration[i] = calib;
 		} else if (lvts_ctrl->lvts_data->def_calibration) {
 			lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
 		} else {
@@ -1763,6 +1767,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1776,6 +1781,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1789,6 +1795,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1802,6 +1809,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1815,6 +1823,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1828,6 +1837,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1841,6 +1851,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = 3,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1854,6 +1865,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = 3,
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.39.5


