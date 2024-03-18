Return-Path: <linux-pm+bounces-5073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2387F200
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E451F21582
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310F58AAF;
	Mon, 18 Mar 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S7AXxJvu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="SneuMGCb"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DC535C1;
	Mon, 18 Mar 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797095; cv=none; b=WfW52tk5YTZRUFp7af1Vua3hw+h9fvRECRyql6UCJ9gPmNLjOrIqud0y2CfpkA7pwqjjDcT3LC2iIru7MINSFAQ5oJShN26T8+uqkCaGdPuac/feSBNGlbjVbLsq+S+o/vgVQtM5tD1PraqnWIHPtvyS2IPi0Nf5FkAWiokctNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797095; c=relaxed/simple;
	bh=Oifljb81w1KY82KtMYvU5z2araSCRNtHp36zHW2YRiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1BoEmYQTzg5YGGGbqKvBz00fMb53EmIAx5pqV/LzZ9m77eIVYsNrad6FU6wbWYlsIHfwdGQ6aKGYySN8X5W2J7dSnM5gbouCY2/upFyLYtQ+rrxv1YOu9Ola2zo2tmiMhZxZnNLsQ1znpAGaN0M6D1Y7yBcWY41XPTv8aEraik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S7AXxJvu; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=SneuMGCb reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF1021EA515;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Oifljb81w1KY82KtMYvU5z2ar
	aSCRNtHp36zHW2YRiI=; b=S7AXxJvuZFneS5JdE8c3QORc5fXuv4UwvYMhyueeg
	0pxClnPSLy+2EbLHB/qG/tYkXWdHlykvQ0XqEC4/60Uvykx/7HELWQULcEq016xZ
	zaSPaZoa0ZcJZlloTGgRlcdWRi8R07qHby+xW3heEHGQaopQGAT5FX7dQOhiWQ0d
	uQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A54071EA514;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=efbPpN8LSuunoCFt+jB8DmcOPtf8iqNhM8L7DXYYv/Q=; b=SneuMGCb7GbVpdhobwYHgFzPICRgXovK88+iiSBpPU6zdrR4QManlFNncWmqeKxhCfDyAvO7F2eg6qarmN5PSr591bHhsXq458aB/hdUgCEvc3HhKQkI6d1F11wfZ243pZaQm6w6apIxxpFHcVqjiE6/7P4v/H1LombeEKD2kX4=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 068C91EA513;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 04927BE2BA2;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 03/13] thermal/drivers/mediatek/lvts_thermal: use offsets for every calibration byte
Date: Mon, 18 Mar 2024 17:22:05 -0400
Message-ID: <20240318212428.3843952-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318212428.3843952-1-nico@fluxnic.net>
References: <20240318212428.3843952-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F472DC50-E56D-11EE-AC9F-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Current code assumes calibration values are always stored contiguously
in host endian order. A future patch will prove this wrong.

Let's specify the offset for each calibration byte instead.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 165 ++++++++++++++----------
 1 file changed, 99 insertions(+), 66 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 73ca2be0f5..2c346ea7c6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -102,11 +102,11 @@ static int golden_temp_offset;
=20
 struct lvts_sensor_data {
 	int dt_id;
+	u8 cal_offsets[3];
 };
=20
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
-	int cal_offset[LVTS_SENSOR_MAX];
 	int hw_tshut_temp;
 	int num_lvts_sensor;
 	int offset;
@@ -668,8 +668,9 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
  * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
  *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
  *
- * The data description gives the offset of the calibration data in
- * this bytes stream for each sensor.
+ * Note: In some cases, values don't strictly follow a little endian ord=
ering.
+ * The data description gives byte offsets constituting each calibration=
 value
+ * for each sensor.
  */
 static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *l=
vts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data,
@@ -677,9 +678,15 @@ static int lvts_calibration_init(struct device *dev,=
 struct lvts_ctrl *lvts_ctrl
 {
 	int i;
=20
-	for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
-		memcpy(&lvts_ctrl->calibration[i],
-		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 3);
+	for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+		const struct lvts_sensor_data *sensor =3D
+					&lvts_ctrl_data->lvts_sensor[i];
+
+		lvts_ctrl->calibration[i] =3D
+			(efuse_calibration[sensor->cal_offsets[0]] << 0) +
+			(efuse_calibration[sensor->cal_offsets[1]] << 8) +
+			(efuse_calibration[sensor->cal_offsets[2]] << 16);
+	}
=20
 	return 0;
 }
@@ -1300,24 +1307,30 @@ static void lvts_remove(struct platform_device *p=
dev)
=20
 static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] =3D {
 	{
-		.cal_offset =3D { 0x00, 0x04, 0x08, 0x0c },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT7988_CPU_0 },
-			{ .dt_id =3D MT7988_CPU_1 },
-			{ .dt_id =3D MT7988_ETH2P5G_0 },
-			{ .dt_id =3D MT7988_ETH2P5G_1 }
+			{ .dt_id =3D MT7988_CPU_0,
+			  .cal_offsets =3D { 0x00, 0x01, 0x02 } },
+			{ .dt_id =3D MT7988_CPU_1,
+			  .cal_offsets =3D { 0x04, 0x05, 0x06 } },
+			{ .dt_id =3D MT7988_ETH2P5G_0,
+			  .cal_offsets =3D { 0x08, 0x09, 0x0a } },
+			{ .dt_id =3D MT7988_ETH2P5G_1,
+			  .cal_offsets =3D { 0x0c, 0x0d, 0x0e } }
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x0,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT7988,
 	},
 	{
-		.cal_offset =3D { 0x14, 0x18, 0x1c, 0x20 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT7988_TOPS_0},
-			{ .dt_id =3D MT7988_TOPS_1},
-			{ .dt_id =3D MT7988_ETHWARP_0},
-			{ .dt_id =3D MT7988_ETHWARP_1}
+			{ .dt_id =3D MT7988_TOPS_0,
+			   .cal_offsets =3D { 0x14, 0x15, 0x16 } },
+			{ .dt_id =3D MT7988_TOPS_1,
+			   .cal_offsets =3D { 0x18, 0x19, 0x1a } },
+			{ .dt_id =3D MT7988_ETHWARP_0,
+			   .cal_offsets =3D { 0x1c, 0x1d, 0x1e } },
+			{ .dt_id =3D MT7988_ETHWARP_1,
+			   .cal_offsets =3D { 0x20, 0x21, 0x22 } }
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x100,
@@ -1359,10 +1372,11 @@ static int lvts_resume(struct device *dev)
=20
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
-		.cal_offset =3D { 0x04, 0x08 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_MCU_BIG_CPU0 },
-			{ .dt_id =3D MT8192_MCU_BIG_CPU1 }
+			{ .dt_id =3D MT8192_MCU_BIG_CPU0,
+			  .cal_offsets =3D { 0x04, 0x05, 0x06 } },
+			{ .dt_id =3D MT8192_MCU_BIG_CPU1,
+			  .cal_offsets =3D { 0x08, 0x09, 0x0a } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
@@ -1370,10 +1384,11 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
u_data_ctrl[] =3D {
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	},
 	{
-		.cal_offset =3D { 0x0c, 0x10 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_MCU_BIG_CPU2 },
-			{ .dt_id =3D MT8192_MCU_BIG_CPU3 }
+			{ .dt_id =3D MT8192_MCU_BIG_CPU2,
+			  .cal_offsets =3D { 0x0c, 0x0d, 0x0e } },
+			{ .dt_id =3D MT8192_MCU_BIG_CPU3,
+			  .cal_offsets =3D { 0x10, 0x11, 0x12 } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
@@ -1381,12 +1396,15 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
u_data_ctrl[] =3D {
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	},
 	{
-		.cal_offset =3D { 0x14, 0x18, 0x1c, 0x20 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_MCU_LITTLE_CPU0 },
-			{ .dt_id =3D MT8192_MCU_LITTLE_CPU1 },
-			{ .dt_id =3D MT8192_MCU_LITTLE_CPU2 },
-			{ .dt_id =3D MT8192_MCU_LITTLE_CPU3 }
+			{ .dt_id =3D MT8192_MCU_LITTLE_CPU0,
+			  .cal_offsets =3D { 0x14, 0x15, 0x16 } },
+			{ .dt_id =3D MT8192_MCU_LITTLE_CPU1,
+			  .cal_offsets =3D { 0x18, 0x19, 0x1a } },
+			{ .dt_id =3D MT8192_MCU_LITTLE_CPU2,
+			  .cal_offsets =3D { 0x1c, 0x1d, 0x1e } },
+			{ .dt_id =3D MT8192_MCU_LITTLE_CPU3,
+			  .cal_offsets =3D { 0x20, 0x21, 0x22 } }
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x200,
@@ -1396,42 +1414,47 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
u_data_ctrl[] =3D {
 };
=20
 static const struct lvts_ctrl_data mt8192_lvts_ap_data_ctrl[] =3D {
-		{
-		.cal_offset =3D { 0x24, 0x28 },
+	{
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_AP_VPU0 },
-			{ .dt_id =3D MT8192_AP_VPU1 }
+			{ .dt_id =3D MT8192_AP_VPU0,
+			  .cal_offsets =3D { 0x24, 0x25, 0x26 } },
+			{ .dt_id =3D MT8192_AP_VPU1,
+			  .cal_offsets =3D { 0x28, 0x29, 0x2a } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset =3D { 0x2c, 0x30 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_AP_GPU0 },
-			{ .dt_id =3D MT8192_AP_GPU1 }
+			{ .dt_id =3D MT8192_AP_GPU0,
+			  .cal_offsets =3D { 0x2c, 0x2d, 0x2e } },
+			{ .dt_id =3D MT8192_AP_GPU1,
+			  .cal_offsets =3D { 0x30, 0x31, 0x32 } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset =3D { 0x34, 0x38 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_AP_INFRA },
-			{ .dt_id =3D MT8192_AP_CAM },
+			{ .dt_id =3D MT8192_AP_INFRA,
+			  .cal_offsets =3D { 0x34, 0x35, 0x36 } },
+			{ .dt_id =3D MT8192_AP_CAM,
+			  .cal_offsets =3D { 0x38, 0x39, 0x3a } },
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x200,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8192,
 	},
 	{
-		.cal_offset =3D { 0x3c, 0x40, 0x44 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8192_AP_MD0 },
-			{ .dt_id =3D MT8192_AP_MD1 },
-			{ .dt_id =3D MT8192_AP_MD2 }
+			{ .dt_id =3D MT8192_AP_MD0,
+			  .cal_offsets =3D { 0x3c, 0x3d, 0x3e } },
+			{ .dt_id =3D MT8192_AP_MD1,
+			  .cal_offsets =3D { 0x40, 0x41, 0x42 } },
+			{ .dt_id =3D MT8192_AP_MD2,
+			  .cal_offsets =3D { 0x44, 0x45, 0x46 } }
 		},
 		.num_lvts_sensor =3D 3,
 		.offset =3D 0x300,
@@ -1441,32 +1464,37 @@ static const struct lvts_ctrl_data mt8192_lvts_ap=
_data_ctrl[] =3D {
=20
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] =3D {
 	{
-		.cal_offset =3D { 0x04, 0x07 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_MCU_BIG_CPU0 },
-			{ .dt_id =3D MT8195_MCU_BIG_CPU1 }
+			{ .dt_id =3D MT8195_MCU_BIG_CPU0,
+			  .cal_offsets =3D { 0x04, 0x05, 0x06 } },
+			{ .dt_id =3D MT8195_MCU_BIG_CPU1,
+			  .cal_offsets =3D { 0x07, 0x08, 0x09 } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
-		.cal_offset =3D { 0x0d, 0x10 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_MCU_BIG_CPU2 },
-			{ .dt_id =3D MT8195_MCU_BIG_CPU3 }
+			{ .dt_id =3D MT8195_MCU_BIG_CPU2,
+			  .cal_offsets =3D { 0x0d, 0x0e, 0x0f } },
+			{ .dt_id =3D MT8195_MCU_BIG_CPU3,
+			  .cal_offsets =3D { 0x10, 0x11, 0x12 } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
-		.cal_offset =3D { 0x16, 0x19, 0x1c, 0x1f },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_MCU_LITTLE_CPU0 },
-			{ .dt_id =3D MT8195_MCU_LITTLE_CPU1 },
-			{ .dt_id =3D MT8195_MCU_LITTLE_CPU2 },
-			{ .dt_id =3D MT8195_MCU_LITTLE_CPU3 }
+			{ .dt_id =3D MT8195_MCU_LITTLE_CPU0,
+			  .cal_offsets =3D { 0x16, 0x17, 0x18 } },
+			{ .dt_id =3D MT8195_MCU_LITTLE_CPU1,
+			  .cal_offsets =3D { 0x19, 0x1a, 0x1b } },
+			{ .dt_id =3D MT8195_MCU_LITTLE_CPU2,
+			  .cal_offsets =3D { 0x1c, 0x1d, 0x1e } },
+			{ .dt_id =3D MT8195_MCU_LITTLE_CPU3,
+			  .cal_offsets =3D { 0x1f, 0x20, 0x21 } }
 		},
 		.num_lvts_sensor =3D 4,
 		.offset =3D 0x200,
@@ -1475,42 +1503,47 @@ static const struct lvts_ctrl_data mt8195_lvts_mc=
u_data_ctrl[] =3D {
 };
=20
 static const struct lvts_ctrl_data mt8195_lvts_ap_data_ctrl[] =3D {
-		{
-		.cal_offset =3D { 0x25, 0x28 },
+	{
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_AP_VPU0 },
-			{ .dt_id =3D MT8195_AP_VPU1 }
+			{ .dt_id =3D MT8195_AP_VPU0,
+			  .cal_offsets =3D { 0x25, 0x26, 0x27 } },
+			{ .dt_id =3D MT8195_AP_VPU1,
+			  .cal_offsets =3D { 0x28, 0x29, 0x2a } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x0,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
-		.cal_offset =3D { 0x2e, 0x31 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_AP_GPU0 },
-			{ .dt_id =3D MT8195_AP_GPU1 }
+			{ .dt_id =3D MT8195_AP_GPU0,
+			  .cal_offsets =3D { 0x2e, 0x2f, 0x30 } },
+			{ .dt_id =3D MT8195_AP_GPU1,
+			  .cal_offsets =3D { 0x31, 0x32, 0x33 } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x100,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
-		.cal_offset =3D { 0x37, 0x3a, 0x3d },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_AP_VDEC },
-			{ .dt_id =3D MT8195_AP_IMG },
-			{ .dt_id =3D MT8195_AP_INFRA },
+			{ .dt_id =3D MT8195_AP_VDEC,
+			  .cal_offsets =3D { 0x37, 0x38, 0x39 } },
+			{ .dt_id =3D MT8195_AP_IMG,
+			  .cal_offsets =3D { 0x3a, 0x3b, 0x3c } },
+			{ .dt_id =3D MT8195_AP_INFRA,
+			  .cal_offsets =3D { 0x3d, 0x3e, 0x3f } }
 		},
 		.num_lvts_sensor =3D 3,
 		.offset =3D 0x200,
 		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
 	},
 	{
-		.cal_offset =3D { 0x43, 0x46 },
 		.lvts_sensor =3D {
-			{ .dt_id =3D MT8195_AP_CAM0 },
-			{ .dt_id =3D MT8195_AP_CAM1 }
+			{ .dt_id =3D MT8195_AP_CAM0,
+			  .cal_offsets =3D { 0x43, 0x44, 0x45 } },
+			{ .dt_id =3D MT8195_AP_CAM1,
+			  .cal_offsets =3D { 0x46, 0x47, 0x48 } }
 		},
 		.num_lvts_sensor =3D 2,
 		.offset =3D 0x300,
--=20
2.44.0


