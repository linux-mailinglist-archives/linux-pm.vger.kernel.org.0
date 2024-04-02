Return-Path: <linux-pm+bounces-5779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B02D894A0D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D2F286BA7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39458179AB;
	Tue,  2 Apr 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qSVSMIuL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="iktrO/+j"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AF17721;
	Tue,  2 Apr 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028867; cv=none; b=Rn4RSPm93PTuysY2/Y0JQzMfe+JVf2eGdql6kx5J7geu1SPl4LQREU2gCGoV92Dwru6Df4SlXfSJ4pF5+7imU6kXdHKEo1ClcXXJGZOAp0i7xV9KWx8nrQUfX6573LWy15+Pch5ZA3Gy9y8mc5hR6pMu36uEznMYv3/AcqSJmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028867; c=relaxed/simple;
	bh=fbzduesfoi7WBSbK48nDNOKNvy0Xx2fWyeNfaOxED4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeG2lZKDreCW7A9o7d5b87SbYczV+6ZpJSB3djWrNcy8vfmKZgTCNg2M8QCDAd1e/PAImmhguBzyaJqCBBo4jXc2Ij+uOwV29D5gKtZOCPGNlJgB0avoNs8/iJjushKQ9qN+xxXB8ccQWMTH0UPCW89FQrWMS7Jbs1eJqmXlILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qSVSMIuL; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=iktrO/+j reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A49B1EC042;
	Mon,  1 Apr 2024 23:34:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=fbzduesfoi7WBSbK48nDNOKNv
	y0Xx2fWyeNfaOxED4U=; b=qSVSMIuLeyhuHwd47Wyd/V2tOikGs7RP0kAtezgcN
	W+0AFfXWOYWrfiKIiYhpBI0qRdKnwnlesUGLloWUxWh+m9+9ibguNj0esnPsINPv
	NW/gZhgCrFSWixZ+M893r177Vk642lpkkCsjy6R3xh9dQ0TajE/LTe6fSQjInqw8
	bU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E091EC041;
	Mon,  1 Apr 2024 23:34:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=O5G071kShCO6ZVBcYtGhvwuX7G84AfatCEHH9aQAkJQ=; b=iktrO/+jKbdkIJSxpdkVueJydOevmqwQzytw3XWutnt7itCcOwaROWzhBu57tkrzAMPJg1lopRYzLEovg0nxPJWUWo+fhYzoYkYev0fmDYtUfrL8OeL5Di7gWVunHOXfcBnv0dGKxIqLiorx5t4r84c00yupOQxsWcK7Ety+Pe0=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A6391EC040;
	Mon,  1 Apr 2024 23:34:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 75E65C1CED5;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 11/15] thermal/drivers/mediatek/lvts_thermal: allow early empty sensor slots
Date: Mon,  1 Apr 2024 23:25:45 -0400
Message-ID: <20240402032729.2736685-12-nico@fluxnic.net>
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
 E618C734-F0A1-11EE-8F40-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Some systems don't always populate sensor controller slots starting
at slot 0. Use a bitmap instead of a count to indicate valid sensor
slots. Also create a pretty iterator for that.

About that iterator: it causes checkpatch to complain with "ERROR:
Macros with multiple statements should be enclosed in a do - while
loop". However this is not possible here. And many similar iterators
do exist using the same form in the tree already.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 63 +++++++++++++++----------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 00649483bb..ae0c8f265b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -107,10 +107,23 @@ struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
 	int cal_offset[LVTS_SENSOR_MAX];
 	int num_lvts_sensor;
+	u8 valid_sensor_mask;
 	int offset;
 	int mode;
 };
=20
+#define VALID_SENSOR_MAP(s0, s1, s2, s3) \
+	.valid_sensor_mask =3D (((s0) ? BIT(0) : 0) | \
+			      ((s1) ? BIT(1) : 0) | \
+			      ((s2) ? BIT(2) : 0) | \
+			      ((s3) ? BIT(3) : 0))
+
+#define lvts_for_each_valid_sensor(i, lvts_ctrl_data) \
+	for ((i) =3D 0; (i) < LVTS_SENSOR_MAX; (i)++) \
+		if (!((lvts_ctrl_data)->valid_sensor_mask & BIT(i))) \
+			continue; \
+		else
+
 struct lvts_data {
 	const struct lvts_ctrl_data *lvts_ctrl;
 	int num_lvts_ctrl;
@@ -134,7 +147,6 @@ struct lvts_ctrl {
 	const struct lvts_data *lvts_data;
 	u32 calibration[LVTS_SENSOR_MAX];
 	u32 hw_tshut_raw_temp;
-	int num_lvts_sensor;
 	int mode;
 	void __iomem *base;
 	int low_thresh;
@@ -346,7 +358,7 @@ static bool lvts_should_update_thresh(struct lvts_ctr=
l *lvts_ctrl, int high)
 	if (high > lvts_ctrl->high_thresh)
 		return true;
=20
-	for (i =3D 0; i < lvts_ctrl->num_lvts_sensor; i++)
+	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl)
 		if (lvts_ctrl->sensors[i].high_thresh =3D=3D lvts_ctrl->high_thresh
 		    && lvts_ctrl->sensors[i].low_thresh =3D=3D lvts_ctrl->low_thresh)
 			return false;
@@ -550,6 +562,7 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
 					const struct lvts_ctrl_data *lvts_ctrl_data)
 {
 	struct lvts_sensor *lvts_sensor =3D lvts_ctrl->sensors;
+
 	void __iomem *msr_regs[] =3D {
 		LVTS_MSR0(lvts_ctrl->base),
 		LVTS_MSR1(lvts_ctrl->base),
@@ -566,7 +579,7 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
=20
 	int i;
=20
-	for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
=20
 		int dt_id =3D lvts_ctrl_data->lvts_sensor[i].dt_id;
=20
@@ -606,8 +619,6 @@ static int lvts_sensor_init(struct device *dev, struc=
t lvts_ctrl *lvts_ctrl,
 		lvts_sensor[i].high_thresh =3D INT_MIN;
 	};
=20
-	lvts_ctrl->num_lvts_sensor =3D lvts_ctrl_data->num_lvts_sensor;
-
 	return 0;
 }
=20
@@ -678,7 +689,7 @@ static int lvts_calibration_init(struct device *dev, =
struct lvts_ctrl *lvts_ctrl
 {
 	int i;
=20
-	for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
 		const struct lvts_sensor_data *sensor =3D
 					&lvts_ctrl_data->lvts_sensor[i];
=20
@@ -1101,7 +1112,7 @@ static int lvts_ctrl_start(struct device *dev, stru=
ct lvts_ctrl *lvts_ctrl)
 	u32 *sensor_bitmap =3D lvts_ctrl->mode =3D=3D LVTS_MSR_IMMEDIATE_MODE ?
 			     sensor_imm_bitmap : sensor_filt_bitmap;
=20
-	for (i =3D 0; i < lvts_ctrl->num_lvts_sensor; i++) {
+	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl) {
=20
 		int dt_id =3D lvts_sensors[i].dt_id;
=20
@@ -1324,7 +1335,7 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT7988_ETH2P5G_1,
 			  .cal_offsets =3D { 0x0c, 0x0d, 0x0e } }
 		},
-		.num_lvts_sensor =3D 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset =3D 0x0,
 	},
 	{
@@ -1338,7 +1349,7 @@ static const struct lvts_ctrl_data mt7988_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT7988_ETHWARP_1,
 			   .cal_offsets =3D { 0x20, 0x21, 0x22 } }
 		},
-		.num_lvts_sensor =3D 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset =3D 0x100,
 	}
 };
@@ -1401,7 +1412,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data=
_ctrl[] =3D {
 			{ .dt_id =3D MT8186_CAM,
 			  .cal_offsets =3D { 12, 13, 14 } }
 		},
-		.num_lvts_sensor =3D 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset =3D 0x0,
 	},
 	{
@@ -1411,7 +1422,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data=
_ctrl[] =3D {
 			{ .dt_id =3D MT8186_BIG_CPU1,
 			  .cal_offsets =3D { 27, 20, 21 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x100,
 	},
 	{
@@ -1423,7 +1434,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data=
_ctrl[] =3D {
 			{ .dt_id =3D MT8186_MFG,
 			  .cal_offsets =3D { 39, 32, 33 } }
 		},
-		.num_lvts_sensor =3D 3,
+		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset =3D 0x200,
 	}
 };
@@ -1436,7 +1447,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
 			{ .dt_id =3D MT8192_MCU_BIG_CPU1,
 			  .cal_offsets =3D { 0x08, 0x09, 0x0a } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x0,
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	},
@@ -1447,7 +1458,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
 			{ .dt_id =3D MT8192_MCU_BIG_CPU3,
 			  .cal_offsets =3D { 0x10, 0x11, 0x12 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x100,
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	},
@@ -1462,7 +1473,7 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
 			{ .dt_id =3D MT8192_MCU_LITTLE_CPU3,
 			  .cal_offsets =3D { 0x20, 0x21, 0x22 } }
 		},
-		.num_lvts_sensor =3D 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset =3D 0x200,
 		.mode =3D LVTS_MSR_FILTERED_MODE,
 	}
@@ -1476,7 +1487,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8192_AP_VPU1,
 			  .cal_offsets =3D { 0x28, 0x29, 0x2a } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x0,
 	},
 	{
@@ -1486,7 +1497,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8192_AP_GPU1,
 			  .cal_offsets =3D { 0x30, 0x31, 0x32 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x100,
 	},
 	{
@@ -1496,7 +1507,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8192_AP_CAM,
 			  .cal_offsets =3D { 0x38, 0x39, 0x3a } },
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x200,
 	},
 	{
@@ -1508,7 +1519,7 @@ static const struct lvts_ctrl_data mt8192_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8192_AP_MD2,
 			  .cal_offsets =3D { 0x44, 0x45, 0x46 } }
 		},
-		.num_lvts_sensor =3D 3,
+		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset =3D 0x300,
 	}
 };
@@ -1521,7 +1532,7 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_=
data_ctrl[] =3D {
 			{ .dt_id =3D MT8195_MCU_BIG_CPU1,
 			  .cal_offsets =3D { 0x07, 0x08, 0x09 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x0,
 	},
 	{
@@ -1531,7 +1542,7 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_=
data_ctrl[] =3D {
 			{ .dt_id =3D MT8195_MCU_BIG_CPU3,
 			  .cal_offsets =3D { 0x10, 0x11, 0x12 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x100,
 	},
 	{
@@ -1545,7 +1556,7 @@ static const struct lvts_ctrl_data mt8195_lvts_mcu_=
data_ctrl[] =3D {
 			{ .dt_id =3D MT8195_MCU_LITTLE_CPU3,
 			  .cal_offsets =3D { 0x1f, 0x20, 0x21 } }
 		},
-		.num_lvts_sensor =3D 4,
+		VALID_SENSOR_MAP(1, 1, 1, 1),
 		.offset =3D 0x200,
 	}
 };
@@ -1558,7 +1569,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8195_AP_VPU1,
 			  .cal_offsets =3D { 0x28, 0x29, 0x2a } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x0,
 	},
 	{
@@ -1568,7 +1579,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8195_AP_GPU1,
 			  .cal_offsets =3D { 0x31, 0x32, 0x33 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x100,
 	},
 	{
@@ -1580,7 +1591,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8195_AP_INFRA,
 			  .cal_offsets =3D { 0x3d, 0x3e, 0x3f } }
 		},
-		.num_lvts_sensor =3D 3,
+		VALID_SENSOR_MAP(1, 1, 1, 0),
 		.offset =3D 0x200,
 	},
 	{
@@ -1590,7 +1601,7 @@ static const struct lvts_ctrl_data mt8195_lvts_ap_d=
ata_ctrl[] =3D {
 			{ .dt_id =3D MT8195_AP_CAM1,
 			  .cal_offsets =3D { 0x46, 0x47, 0x48 } }
 		},
-		.num_lvts_sensor =3D 2,
+		VALID_SENSOR_MAP(1, 1, 0, 0),
 		.offset =3D 0x300,
 	}
 };
--=20
2.44.0


