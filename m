Return-Path: <linux-pm+bounces-38624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B054C85EE2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F26603490F8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0370626C3BC;
	Tue, 25 Nov 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VooVnKiv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF924397A;
	Tue, 25 Nov 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087463; cv=none; b=RmtW6YLiyRJBREa6V/I/yktHHlv1CDLRcxzcjliUjCGsNUU08XSPfF+53qNRCWeQdg3mboKIVWLKtSFgU17Lzpv6P94Im+sEVrvRNe85Z8ofvCOptr5D2LtctHalKGZCalRUgA6lW35e68JcQ8nwToxmftMUObD9qOP8sf8BGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087463; c=relaxed/simple;
	bh=QvdZw2B8XbxQS//hiFICE90RRNKTXPSR/l/8lFZlen4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPUMYTEolvq84o9OQbbswnCHUwRRsBG3Bj2C9AOKcUYcDjz52D60oKTMjvjJLkH4K8TqRsJP6BNa5eoI2QF4j0WZgOA/AAKuZt8LXF9AmJ30p7+/kV1YAdls7jWoxpQ00z1dH3VK69iZ54YNykltWcz8PAON7Xhwdc14vBGXNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VooVnKiv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087460;
	bh=QvdZw2B8XbxQS//hiFICE90RRNKTXPSR/l/8lFZlen4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VooVnKivDx7LlbvJNPQGq4eQyQWJjD6Qx9XqqEesJVlwZccJMcr01/4JiqNwA04uc
	 z1fc1ljLNk4P19On9JoVwKLN20Jpa/wftfAlwjkkIaRNqaMNO4y3zHdH9d1k3y0TbI
	 +HK9gAr2D4pM5EN+xJhP6DK4Ndl0dElZTm+aX2srKxRYm9U5U6kZ7qh1xT3bWN4fde
	 LGVWAhXuFMuzU5jVkJeqQz7S0El11tqgebK84EvzqR7+o5JB5/kXfh1aYgosvSnVvB
	 qbRqb8kwa/JH9UaQQ5qtlPW5IlxKE3Lqnm/7vAFrRnPBfhKV4ssdwSjwvt3+Zi7YW0
	 24dn7qTnEyg8A==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0C0B17E13CD;
	Tue, 25 Nov 2025 17:17:38 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v5 2/8] thermal/drivers/mediatek/lvts: Make number of calibration offsets configurable
Date: Tue, 25 Nov 2025 17:16:52 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-2-6db7eb903fb7@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
supported by the driver rely on 3 bytes. Make the number of calibration
bytes per sensor configurable, enabling support for SoCs with varying
calibration formats.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 55 ++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index ab55b20cda47..babffdea9a4d 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -96,12 +96,15 @@
 
 #define LVTS_MINIMUM_THRESHOLD		20000
 
+#define LVTS_MAX_CAL_OFFSETS		3
+#define LVTS_NUM_CAL_OFFSETS_MT7988	3
+
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int golden_temp_offset;
 
 struct lvts_sensor_data {
 	int dt_id;
-	u8 cal_offsets[3];
+	u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
 };
 
 struct lvts_ctrl_data {
@@ -127,6 +130,7 @@ struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
 	const u32 *conn_cmd;
 	const u32 *init_cmd;
+	int num_cal_offsets;
 	int num_lvts_ctrl;
 	int num_conn_cmd;
 	int num_init_cmd;
@@ -646,6 +650,26 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 	return 0;
 }
 
+static int lvts_decode_sensor_calibration(const struct lvts_sensor_data *sensor,
+					const u8 *efuse_calibration, u32 calib_len,
+					u8 num_offsets, u32 *calib)
+{
+	int i;
+	u32 calib_val = 0;
+
+	for (i = 0; i < num_offsets; i++) {
+		u8 offset = sensor->cal_offsets[i];
+
+		if (offset >= calib_len)
+			return -EINVAL;
+		// Pack each calibration byte into the correct position
+		calib_val |= efuse_calibration[offset] << (8 * i);
+	}
+
+	*calib = calib_val;
+	return 0;
+}
+
 /*
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
@@ -711,26 +735,27 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 					u8 *efuse_calibration,
 					size_t calib_len)
 {
-	int i;
+	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+	int i, ret;
 	u32 gt;
 
 	/* A zero value for gt means that device has invalid efuse data */
-	gt = (((u32 *)efuse_calibration)[0] >> lvts_ctrl->lvts_data->gt_calib_bit_offset) & 0xff;
+	gt = (((u32 *)efuse_calibration)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
 	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 		const struct lvts_sensor_data *sensor =
 					&lvts_ctrl_data->lvts_sensor[i];
+		u32 calib = 0;
 
-		if (sensor->cal_offsets[0] >= calib_len ||
-		    sensor->cal_offsets[1] >= calib_len ||
-		    sensor->cal_offsets[2] >= calib_len)
-			return -EINVAL;
+		ret = lvts_decode_sensor_calibration(sensor, efuse_calibration,
+						     calib_len,
+						     lvts_data->num_cal_offsets,
+						     &calib);
+		if (ret)
+			return ret;
 
 		if (gt) {
-			lvts_ctrl->calibration[i] =
-				(efuse_calibration[sensor->cal_offsets[0]] << 0) +
-				(efuse_calibration[sensor->cal_offsets[1]] << 8) +
-				(efuse_calibration[sensor->cal_offsets[2]] << 16);
+			lvts_ctrl->calibration[i] = calib;
 		} else if (lvts_ctrl->lvts_data->def_calibration) {
 			lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
 		} else {
@@ -1763,6 +1788,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_factor	= LVTS_COEFF_A_MT7988,
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1776,6 +1802,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1789,6 +1816,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1802,6 +1830,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1815,6 +1844,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1828,6 +1858,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1841,6 +1872,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1854,6 +1886,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT8195,
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
 };
 
 static const struct of_device_id lvts_of_match[] = {

-- 
2.39.5

