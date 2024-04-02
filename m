Return-Path: <linux-pm+bounces-5777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A9894A0A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B96B24486
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4915E96;
	Tue,  2 Apr 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DIwk83uf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="P1Xe8lrR"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FC17731;
	Tue,  2 Apr 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028865; cv=none; b=ARq5hI0LGUmtJarBSZvFlgXyW1A9DiE96oiK38YNJEmppDYAPUYjGApk+PKtR/sfi6eu5ElB7VsbYvzSM367rpUKz5QBxU9CEbphTlJMhLZRayepRjsWmoiuzhLOafpUGXYRXbwQe7wuUEam2krkc2zz03d9PZJna4qqpXf7yQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028865; c=relaxed/simple;
	bh=QMOwqjxnZseTdo4gaCCD68XT906ZpR/cOYPc5z1rVOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofVbigXzTurhqF3bLPA5/ZhzD9HjP3CRbAle+uG4m5UaNYB1+CPNBJGZ07P7ediSbbe6t6GnBlkpMA/iw8r2rLsrTgukDW0CadujDrb0tl7KRjXe04/ygp+AK+Nl187pdDf4yxvm8dFA2+AyRdsn6E4CPy9k0XLCSgrkSK7hZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DIwk83uf; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=P1Xe8lrR reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA6AF1DBE48;
	Mon,  1 Apr 2024 23:34:22 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=QMOwqjxnZseTdo4gaCCD68XT9
	06ZpR/cOYPc5z1rVOc=; b=DIwk83uf276YMgVgLkNnV4qepOkOS0oMndYURUxdR
	p808nquf3OglmslwhU82lnrNkcgoU+zyehBBChBMHieR3gD+vmeEAcZbxDFCTMGD
	JqT2A94sijIKmTaFnFGn1c0PsZ8XtNASQeXA1VLKb/8nbfTgbDNewq0Z/hiI530H
	rg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D2B3F1DBE47;
	Mon,  1 Apr 2024 23:34:22 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=z9sLPxyc4NMA8XRGQCFGghPoIcaO7E+YbcLd4Xx7mVs=; b=P1Xe8lrRVtgeyzXwv0kaSDJVmX1JFnvgHi8hsEWhytZPguKTbPiiLcHiLsYL6dlzjEt4oegOLVeJ+ZMwXPxLDnLRKNE1bKYX1MPkw7VfWkcSfnkHhmsbbSGoAPje/QYpccnYdVMgAn++xNHki7tAtjexzJ45gT2klENvl+5rev4=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34EA01DBE44;
	Mon,  1 Apr 2024 23:34:22 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 145F4C1CEDA;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 14/15] thermal/drivers/mediatek/lvts_thermal: add MT8188 support
Date: Mon,  1 Apr 2024 23:25:48 -0400
Message-ID: <20240402032729.2736685-15-nico@fluxnic.net>
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
 E54B4084-F0A1-11EE-9BBD-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 96 +++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index ae0c8f265b..03ff5d12e5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1439,6 +1439,84 @@ static const struct lvts_ctrl_data mt8186_lvts_dat=
a_ctrl[] =3D {
 	}
 };
=20
+static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_MCU_LITTLE_CPU0,
+			  .cal_offsets =3D { 22, 23, 24 } },
+			{ .dt_id =3D MT8188_MCU_LITTLE_CPU1,
+			  .cal_offsets =3D { 25, 26, 27 } },
+			{ .dt_id =3D MT8188_MCU_LITTLE_CPU2,
+			  .cal_offsets =3D { 28, 29, 30 } },
+			{ .dt_id =3D MT8188_MCU_LITTLE_CPU3,
+			  .cal_offsets =3D { 31, 32, 33 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 1),
+		.offset =3D 0x0,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_MCU_BIG_CPU0,
+			  .cal_offsets =3D { 34, 35, 36 } },
+			{ .dt_id =3D MT8188_MCU_BIG_CPU1,
+			  .cal_offsets =3D { 37, 38, 39 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset =3D 0x100,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+
+			{ /* unused */ },
+			{ .dt_id =3D MT8188_AP_APU,
+			  .cal_offsets =3D { 40, 41, 42 } },
+		},
+		VALID_SENSOR_MAP(0, 1, 0, 0),
+		.offset =3D 0x0,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_GPU1,
+			  .cal_offsets =3D { 43, 44, 45 } },
+			{ .dt_id =3D MT8188_AP_GPU2,
+			  .cal_offsets =3D { 46, 47, 48 } },
+			{ .dt_id =3D MT8188_AP_SOC1,
+			  .cal_offsets =3D { 49, 50, 51 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 1, 0),
+		.offset =3D 0x100,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_SOC2,
+			  .cal_offsets =3D { 52, 53, 54 } },
+			{ .dt_id =3D MT8188_AP_SOC3,
+			  .cal_offsets =3D { 55, 56, 57 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset =3D 0x200,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_CAM1,
+			  .cal_offsets =3D { 58, 59, 60 } },
+			{ .dt_id =3D MT8188_AP_CAM2,
+			  .cal_offsets =3D { 61, 62, 63 } },
+		},
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset =3D 0x300,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
 		.lvts_sensor =3D {
@@ -1622,6 +1700,22 @@ static const struct lvts_data mt8186_lvts_data =3D=
 {
 	.gt_calib_bit_offset =3D 24,
 };
=20
+static const struct lvts_data mt8188_lvts_mcu_data =3D {
+	.lvts_ctrl	=3D mt8188_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8188_lvts_mcu_data_ctrl),
+	.temp_factor	=3D LVTS_COEFF_A_MT8195,
+	.temp_offset	=3D LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset =3D 20,
+};
+
+static const struct lvts_data mt8188_lvts_ap_data =3D {
+	.lvts_ctrl	=3D mt8188_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8188_lvts_ap_data_ctrl),
+	.temp_factor	=3D LVTS_COEFF_A_MT8195,
+	.temp_offset	=3D LVTS_COEFF_B_MT8195,
+	.gt_calib_bit_offset =3D 20,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1653,6 +1747,8 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
 {
 static const struct of_device_id lvts_of_match[] =3D {
 	{ .compatible =3D "mediatek,mt7988-lvts-ap", .data =3D &mt7988_lvts_ap_=
data },
 	{ .compatible =3D "mediatek,mt8186-lvts", .data =3D &mt8186_lvts_data }=
,
+	{ .compatible =3D "mediatek,mt8188-lvts-mcu", .data =3D &mt8188_lvts_mc=
u_data },
+	{ .compatible =3D "mediatek,mt8188-lvts-ap", .data =3D &mt8188_lvts_ap_=
data },
 	{ .compatible =3D "mediatek,mt8192-lvts-mcu", .data =3D &mt8192_lvts_mc=
u_data },
 	{ .compatible =3D "mediatek,mt8192-lvts-ap", .data =3D &mt8192_lvts_ap_=
data },
 	{ .compatible =3D "mediatek,mt8195-lvts-mcu", .data =3D &mt8195_lvts_mc=
u_data },
--=20
2.44.0


