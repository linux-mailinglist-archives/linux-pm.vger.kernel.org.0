Return-Path: <linux-pm+bounces-38625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B2C85EB2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29AC3B3A71
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5A27056F;
	Tue, 25 Nov 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YOFoYx/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCF25CC6C;
	Tue, 25 Nov 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087465; cv=none; b=UraWvSubbSf4iZsvHgxuC/gbdfvpiZU4jWVBBW4l6fTHe0VEqtyP0Z99UURXVdDT9uAI0vaOMMmoLdU0lhEuYv/bg7XB/ukMnz8f572CevPMplUuDcYRoVLwPw6woJSDdkTrLWovzxkR2rgDuL53h2Q4kNI5ka9qoNbmot6f2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087465; c=relaxed/simple;
	bh=IvZa7zhRWNpwBoPxllf4o/k5Yv6j1xQOIvfGVEJKZ38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGjodYZt7g68xTowAQoxUmiH1v0nBOgdJekj4U1CCYEYz6uPXSFvp+7wW93PvY6ZaYm2JmGHqOKgVlBxkvdtJV7pvVXx4IE/89hKZMoj36B0IcuVUnfUiIYch+8VFunixWe7BtzQRFGXkI/S9ThbG5JeVgHyjAlTjjkS1SxlkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YOFoYx/M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087461;
	bh=IvZa7zhRWNpwBoPxllf4o/k5Yv6j1xQOIvfGVEJKZ38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOFoYx/Mctk2VU5VWUBaO8NIU59pep4RCmUa0IYnAgTaHlkMtibDLH0GLoHg7ss2g
	 yIfIVAYt2Im72RSYMn+YkApHYTvs8s+Jp71zgHhWNhiyp8cPCaiIwY7WVSfPsvIO1N
	 +OWJQar7ymo6ZbEpku7+ntiEBOcgkj7vPYR26rL4WmYtA0PRaGrB0NML4y7ySPW0sx
	 KlPza7/UdgOfn1j0AiS29JBzeSLadb3dQNaSNzia6GCf6sYIs0lsC4PBkDqVzUSEFL
	 NER7H3I/si6Dnk1zWw4QJZWjrsPmi/TdoMlNur7HME9etZb7cM4JXGUUZ0PiF2wgp+
	 50OCyqTnVEOFg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5CEEB17E13E0;
	Tue, 25 Nov 2025 17:17:40 +0100 (CET)
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
Subject: [PATCH v5 3/8] thermal/drivers/mediatek/lvts: Add platform ops to support alternative conversion logic
Date: Tue, 25 Nov 2025 17:16:53 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-3-6db7eb903fb7@collabora.com>
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

Introduce lvts_platform_ops struct to support SoC-specific versions of
lvts_raw_to_temp() and lvts_temp_to_raw() conversion functions.

This is in preparation for supporting SoCs like MT8196/MT6991, which
require a different lvts_temp_to_raw() implementation.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 39 ++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index babffdea9a4d..a684f73d3698 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -126,8 +126,14 @@ struct lvts_ctrl_data {
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
@@ -273,7 +279,17 @@ static inline int lvts_debugfs_init(struct device *dev,
 
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
 
@@ -283,7 +299,7 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
 	return temperature;
 }
 
-static u32 lvts_temp_to_raw(int temperature, int temp_factor)
+static u32 lvts_temp_to_raw_mt7988(int temperature, int temp_factor)
 {
 	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
 
@@ -330,7 +346,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (rc)
 		return -EAGAIN;
 
-	*temp = lvts_raw_to_temp(value & 0xFFFF, lvts_data->temp_factor);
+	*temp = lvts_raw_to_temp(value, lvts_data);
 
 	return 0;
 }
@@ -400,8 +416,8 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
 	void __iomem *base = lvts_sensor->base;
 	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
-				       lvts_data->temp_factor);
-	u32 raw_high = lvts_temp_to_raw(high, lvts_data->temp_factor);
+				       lvts_data);
+	u32 raw_high = lvts_temp_to_raw(high, lvts_data);
 	bool should_update_thresh;
 
 	lvts_sensor->low_thresh = low;
@@ -1778,6 +1794,11 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
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
@@ -1789,6 +1810,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1803,6 +1825,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1817,6 +1840,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1831,6 +1855,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1845,6 +1870,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1859,6 +1885,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1873,6 +1900,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1887,6 +1915,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct of_device_id lvts_of_match[] = {

-- 
2.39.5

