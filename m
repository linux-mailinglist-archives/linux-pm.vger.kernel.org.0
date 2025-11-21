Return-Path: <linux-pm+bounces-38356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED2C78BD9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AE5F354CAE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449A349AF7;
	Fri, 21 Nov 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RVuXquJ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAD2F690A;
	Fri, 21 Nov 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723838; cv=none; b=mFtAWeBRVzDchlO/Q60QtujUWUfpzIm/oV1jJXB5cAM2GOqAAV9veaPF3LbDAv3geeQ1Crn5YXroTUhHKtzp0FuRAoyXo1SFedCP3Qwz/p1fV6P+7UiTcidixuJ4RqCtADPZ/uPsNT7CMmfCu2EnT5RF8THKvyxezdL0ZMIhF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723838; c=relaxed/simple;
	bh=8h0CFC4hcjoXQqZWOG7FkphbZyR+191MEAMrW1ExjnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLU3aTc/y8UF865F3pIw6c+oM2L3mdFmZ2xIq3Lz9DrZw7+24PwK0gfOQPOQ7H4tGof6Ya4Sb/X+d81bhw7WD6XFqrm/dP4kl0TZQXlvCN+Zk/hnB+rYAs5BA+JB4+sGX1/rKg2ceIU2mA1lvNK/z5dbk89LwtNyVvBmb2AEK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RVuXquJ/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763723828;
	bh=8h0CFC4hcjoXQqZWOG7FkphbZyR+191MEAMrW1ExjnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVuXquJ/9tLHTTsob1It3qBbysppwXZcZUbyxXAJcobgM93kJ0Z9MAWmnM7CAvWwz
	 ezMFEn2gam7j5YmSWszWF35jNMBTxCMqgdEiCqtgs4+CgeNww9ni90kJ/qIOiPrFMB
	 dn2Ls7KpEvZrjXkb4f5DdW5562wrFZpj88PO3y9nrYEbqY2YUMO6M2cqMtu0XGq+5P
	 AutezsUhLqg3OYPkxISB1CW+GwesMnkPu+9Jc8OjaN5yMlCj/199AFEn2RiPO2usHx
	 BVoa1PXRom/PKhRWUuxBSafPs5FPr6d2j69zWaXvPv1rcNg9vo+oAmusQxcMYn3NJk
	 UxEmTaeYCG7rw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:c4bf:9969:6e1c:dc69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4786517E153D;
	Fri, 21 Nov 2025 12:17:07 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v4 4/9] thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
Date: Fri, 21 Nov 2025 12:16:37 +0100
Message-Id: <20251121-mt8196-lvts-v4-v4-4-357f955a3176@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Introduce lvts_platform_ops struct to support SoC-specific versions of
lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.

This is in preparation for supporting SoCs like MT8196/MT6991, which
require a different lvts_temp_to_raw() implementation.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 39 ++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index b49441d82ffd..d713c46c21fc 100644
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
+	const struct lvts_platform_ops *ops;
 	const u32 *conn_cmd;
 	const u32 *init_cmd;
 	int num_cal_offsets;
@@ -272,7 +278,17 @@ static inline int lvts_debugfs_init(struct device *dev,
 
 #endif
 
-static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
+static int lvts_raw_to_temp(u32 raw_temp, const struct lvts_data *lvts_data)
+{
+	return lvts_data->ops->lvts_raw_to_temp(raw_temp & 0xFFFF, lvts_data->temp_factor);
+}
+
+static u32 lvts_temp_to_raw(int temperature, const struct lvts_data *lvts_data)
+{
+	return lvts_data->ops->lvts_temp_to_raw(temperature, lvts_data->temp_factor);
+}
+
+static int lvts_raw_to_temp_mt7988(u32 raw_temp, int temp_factor)
 {
 	int temperature;
 
@@ -282,7 +298,7 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
 	return temperature;
 }
 
-static u32 lvts_temp_to_raw(int temperature, int temp_factor)
+static u32 lvts_temp_to_raw_mt7988(int temperature, int temp_factor)
 {
 	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
 
@@ -329,7 +345,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (rc)
 		return -EAGAIN;
 
-	*temp = lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
+	*temp = lvts_raw_to_temp(value, lvts_data);
 
 	return 0;
 }
@@ -399,8 +415,8 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 	void __iomem *base = lvts_sensor->base;
 	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
-				       lvts_data->temp_factor);
-	u32 raw_high = lvts_temp_to_raw(high, lvts_data->temp_factor);
+				       lvts_data);
+	u32 raw_high = lvts_temp_to_raw(high, lvts_data);
 	bool should_update_thresh;
 
 	lvts_sensor->low_thresh = low;
@@ -1762,6 +1778,11 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_platform_ops lvts_platform_ops_mt7988 = {
+	.lvts_raw_to_temp = lvts_raw_to_temp_mt7988,
+	.lvts_temp_to_raw = lvts_temp_to_raw_mt7988,
+};
+
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
 	.conn_cmd	= mt7988_conn_cmds,
@@ -1773,6 +1794,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1787,6 +1809,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1801,6 +1824,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1815,6 +1839,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1829,6 +1854,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1843,6 +1869,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1857,6 +1884,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1871,6 +1899,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct of_device_id lvts_of_match[] = {

-- 
2.39.5

