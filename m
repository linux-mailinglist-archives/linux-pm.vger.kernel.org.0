Return-Path: <linux-pm+bounces-5775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E08949F2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E52873E5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433A16415;
	Tue,  2 Apr 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LQahVYJt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="y5xoScGM"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264914F64;
	Tue,  2 Apr 2024 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028481; cv=none; b=BuO4I80srSvZjtCUIReuch+Zptd6C+OtmmwfhKle6HFCZAeUnnqMgPVJobL1wdlAEaxdcDmHUEmxYyC4tafOpi17pczChRDjhy9+FtPuZ/s7ZoXnp9SNV2C23S3hAO1hRmL2fRrwYlsQAmbkHe4swys3kSJY+8ZgRN7enXq+Zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028481; c=relaxed/simple;
	bh=hnv+5lqAFzI5pxJZW3RU7bliOW+blXUREX66Zq/Kp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoHGzltvf5zO2FIJCVWdpL3hExuFxS/XqD5fCtu/ZcMdWU5JYGPqwQ2ou8kddEDom36EpHuKBp0wsfP7bCeKVzeHzKu30P6ZBh8udk9ITFfwMjasefrj99mCh8+ZNBvXhbzU+qEbc1Ur0OQSrfHNTd7NFjnea0S/YGZxi407Ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LQahVYJt; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=y5xoScGM reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EBAF7219E1;
	Mon,  1 Apr 2024 23:27:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=hnv+5lqAFzI5pxJZW3RU7bliO
	W+blXUREX66Zq/Kp3I=; b=LQahVYJtDH0wrQaod1lytez+MHzzw5y1QNCQ2HKKD
	lRPgWy2mGRy/EiTQA6dXBvPFzt+9T5gBnKw4Sn1Q+lxq9iDhCsmZMfhsW34UMDFu
	0DihXOHk/qvq7lcAOirUZewhqkZONvq0vS8bJIYL+SWsop+w3qC50+zu5HiFsr5T
	58=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E42C2219E0;
	Mon,  1 Apr 2024 23:27:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=XjbTXrciltjltJeNTRs47Q3in+F61CEcfAOGFBj/Kbo=; b=y5xoScGMgjXO+2+vfeEP6RoaNL9a+mujkAREZiA+YcLR2n6AtvWAX+RV61/JqaC+X+hMilx+1hyF3YsJL4nz20JAixk8XHP36GUkjWkNY+i6Od7yePT8UdNitIaJVLTYYnnlZhL6wWgRmfpvftdGixwEkO84ewBmZn7suOQyJyk=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8393219D3;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id AB038C1CECC;
	Mon,  1 Apr 2024 23:27:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 04/15] thermal/drivers/mediatek/lvts_thermal: use offsets for every calibration byte
Date: Mon,  1 Apr 2024 23:25:38 -0400
Message-ID: <20240402032729.2736685-5-nico@fluxnic.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402032729.2736685-1-nico@fluxnic.net>
References: <20240402032729.2736685-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 F9B19AEC-F0A0-11EE-9A50-A19503B9AAD1-78420484!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Current code assumes calibration values are always stored contiguously
in host endian order. A future patch will prove this wrong.

Let's specify the offset for each calibration byte instead.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 164 ++++++++++++++----------
 1 file changed, 99 insertions(+), 65 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 00994a442b..6edb858acf 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -100,6 +100,7 @@ static int golden_temp_offset;
=20
 struct lvts_sensor_data {
 	int dt_id;
+	u8 cal_offsets[3];
 };
=20
 struct lvts_ctrl_data {
@@ -665,8 +666,9 @@ static int lvts_sensor_init(struct device *dev, struc=
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
@@ -674,9 +676,15 @@ static int lvts_calibration_init(struct device *dev,=
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
@@ -1297,23 +1305,29 @@ static void lvts_remove(struct platform_device *p=
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
@@ -1354,32 +1368,37 @@ static int lvts_resume(struct device *dev)
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
@@ -1388,39 +1407,44 @@ static const struct lvts_ctrl_data mt8192_lvts_mc=
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
@@ -1429,30 +1453,35 @@ static const struct lvts_ctrl_data mt8192_lvts_ap=
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
@@ -1460,39 +1489,44 @@ static const struct lvts_ctrl_data mt8195_lvts_mc=
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


