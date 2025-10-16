Return-Path: <linux-pm+bounces-36266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F7BE3E2E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 466EA507BE7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FEA34165E;
	Thu, 16 Oct 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GOkEEjZ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2363340DB3;
	Thu, 16 Oct 2025 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624569; cv=none; b=P6O849HhucfxtXctn0qn/KdaGRDmr9Z3EIj7nNCcwV5DKRqF9aV+73DlEdbUToMTLm+OWi3K2zvQx3KYU2EoCDyybnaWuO5y3q0mpGAdbZsDp4nnQRgTRcNT4qGwj9fqHnHY5kh6t8CgkLTKsKCqhhXLP6andrmVKDSa+0WXOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624569; c=relaxed/simple;
	bh=biBxkajL32/FnUxOxa3duUoDPZDPgENKCfeD3nyU3cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oaAT7xMLzJLEBuLYv1zMbjnfZjYywWuJuxrEhbp2wQG1ZislWIe3i1lbhXsDtZbg9AhX7TobiH8v2D03k5F3d9Z5iS6LhRK7r/tbKPDaO/B38UatZ+18zcOrUBuNO7JazoR5QCXuKLjhMuRF4LfW98UcQYdPqX75MjWxO4Vlfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GOkEEjZ1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760624566;
	bh=biBxkajL32/FnUxOxa3duUoDPZDPgENKCfeD3nyU3cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOkEEjZ1TMt1jZzMTbPtmtuzQ8NJcyoPmM5mmbw4mw8czdS/UQs5ia2PjZHAAQvmU
	 EgItV9Edb3tRlq+S04gfxIMNShEm/yHewkSWs8GwLMWfQTjgZSiUcYGLS1abDWcoYS
	 I/zeWknoom9suAgHCHAka3pq1YqwozPdYDCyugrAEj7BoMcjTtPsBb7Gt81FhJl7zb
	 psoa1PZE3EKXejh7VkYpZMc9R7Do9vlsCf5cye8YnDgTjc3QOZEy+wJoxTeGUnVFZY
	 AK72SQdht6NhzUDsr+A+xvvhPxYf9FR1CoQl+Hrs7EFJ0Paw7CZpCPD6nHdvYmbRaB
	 I57gIjLck16Ug==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:655a:5eaa:d2ad:4ee4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E76CD17E1418;
	Thu, 16 Oct 2025 16:22:44 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>,
	Fei Shao <fshao@chromium.org>
Subject: [PATCH RESEND v3 4/9] thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
Date: Thu, 16 Oct 2025 16:21:53 +0200
Message-Id: <20251016142158.740242-5-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016142158.740242-1-laura.nao@collabora.com>
References: <20251016142158.740242-1-laura.nao@collabora.com>
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

Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 27 ++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 4ef549386add..df1c0f059ad0 100644
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
@@ -300,6 +306,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	struct lvts_ctrl *lvts_ctrl = container_of(lvts_sensor, struct lvts_ctrl,
 						   sensors[lvts_sensor->id]);
 	const struct lvts_data *lvts_data = lvts_ctrl->lvts_data;
+	const struct lvts_platform_ops *ops = lvts_data->ops;
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
+	const struct lvts_platform_ops *ops = lvts_data->ops;
 	void __iomem *base = lvts_sensor->base;
-	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
+	u32 raw_low = ops->lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
 				       lvts_data->temp_factor);
-	u32 raw_high = lvts_temp_to_raw(high, lvts_data->temp_factor);
+	u32 raw_high = ops->lvts_temp_to_raw(high, lvts_data->temp_factor);
 	bool should_update_thresh;
 
 	lvts_sensor->low_thresh = low;
@@ -1763,6 +1771,11 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] = {
 	}
 };
 
+static const struct lvts_platform_ops lvts_platform_ops_v1 = {
+	.lvts_raw_to_temp = lvts_raw_to_temp,
+	.lvts_temp_to_raw = lvts_temp_to_raw,
+};
+
 static const struct lvts_data mt7988_lvts_ap_data = {
 	.lvts_ctrl	= mt7988_lvts_ap_data_ctrl,
 	.conn_cmd	= mt7988_conn_cmds,
@@ -1774,6 +1787,7 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7988,
 	.gt_calib_bit_offset = 24,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8186_lvts_data = {
@@ -1788,6 +1802,7 @@ static const struct lvts_data mt8186_lvts_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 19000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8188_lvts_mcu_data = {
@@ -1802,6 +1817,7 @@ static const struct lvts_data mt8188_lvts_mcu_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8188_lvts_ap_data = {
@@ -1816,6 +1832,7 @@ static const struct lvts_data mt8188_lvts_ap_data = {
 	.gt_calib_bit_offset = 20,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8192_lvts_mcu_data = {
@@ -1830,6 +1847,7 @@ static const struct lvts_data mt8192_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
@@ -1844,6 +1862,7 @@ static const struct lvts_data mt8192_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {
@@ -1858,6 +1877,7 @@ static const struct lvts_data mt8195_lvts_mcu_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct lvts_data mt8195_lvts_ap_data = {
@@ -1872,6 +1892,7 @@ static const struct lvts_data mt8195_lvts_ap_data = {
 	.gt_calib_bit_offset = 24,
 	.def_calibration = 35000,
 	.num_cal_offsets = 3,
+	.ops = &lvts_platform_ops_v1,
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.39.5


