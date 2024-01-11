Return-Path: <linux-pm+bounces-2135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4131982B720
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582701C235CB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F455F9E9;
	Thu, 11 Jan 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sZXn9UQ9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="D+a4a1qb"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3922EADE
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 875A61DD75D;
	Thu, 11 Jan 2024 17:30:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=EczEMbJUlr3C5mM/r4hoIkTXP
	TSbjw1j4uty5nzgphQ=; b=sZXn9UQ9uOMBM8z1/tH5ye79RPgURJCVarfo/Mc8m
	xbHZ1IUv88Yoxb33CQa1X1vEN7/l3rdWCtXzIAlj1xogyAITI38pSWK3CWaIw7ql
	SIxTC01sP37wy+8IAAam+q+sH9z5DhhSrpjwre3iDuFhOZiW2hvlFeGvZPofFuph
	PM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 802191DD75C;
	Thu, 11 Jan 2024 17:30:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=fNYVWdH7pxy5fs03BSTY57TbqHhRT8LGqIYMBSy4bZg=; b=D+a4a1qbAd8UXukcvvZZ5+jMIi5HQ3vN9sL0b/CKM17ksS+fkOdaUIIaY5KgsrC0wrvXByZf6b0yls/4PVCgIwmGryRbTB2UNBWMqKVlomK6zwTcZpjI5f2g29756qQ9mLxXbiGWf4qDKvKjVQaoU/YFd8zNWIhMEzIkf8ItHNk=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04F361DD759;
	Thu, 11 Jan 2024 17:30:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8E6A1AD5A6C;
	Thu, 11 Jan 2024 17:30:31 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 9/9] thermal/drivers/mediatek/lvts_thermal: add MT8188 support
Date: Thu, 11 Jan 2024 17:30:06 -0500
Message-ID: <20240111223020.3593558-10-nico@fluxnic.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111223020.3593558-1-nico@fluxnic.net>
References: <20240111223020.3593558-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 086208D4-B0D1-11EE-9E10-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        |   4 +
 drivers/thermal/mediatek/lvts_thermal.c       | 101 ++++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           |  16 +++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-therma=
l.yaml
index 4173bae530..331cf4e662 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
@@ -20,6 +20,8 @@ properties:
     enum:
       - mediatek,mt7988-lvts-ap
       - mediatek,mt8186-lvts
+      - mediatek,mt8188-lvts-ap
+      - mediatek,mt8188-lvts-mcu
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
@@ -61,6 +63,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8188-lvts-ap
+              - mediatek,mt8188-lvts-mcu
               - mediatek,mt8192-lvts-ap
               - mediatek,mt8192-lvts-mcu
     then:
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index 473ef91ea3..8942b50d84 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1441,6 +1441,89 @@ static const struct lvts_ctrl_data mt8186_lvts_dat=
a_ctrl[] =3D {
 	}
 };
=20
+static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_MCU_TS1_0,
+			  .cal_offsets =3D { 22, 23, 24 } },
+			{ .dt_id =3D MT8188_MCU_TS1_1,
+			  .cal_offsets =3D { 25, 26, 27 } },
+			{ .dt_id =3D MT8188_MCU_TS1_2,
+			  .cal_offsets =3D { 28, 29, 30 } },
+			{ .dt_id =3D MT8188_MCU_TS1_3,
+			  .cal_offsets =3D { 31, 32, 33 } },
+		},
+		.num_lvts_sensor =3D 4,
+		.offset =3D 0x0,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_MCU_TS2_0,
+			  .cal_offsets =3D { 34, 35, 36 } },
+			{ .dt_id =3D MT8188_MCU_TS2_1,
+			  .cal_offsets =3D { 37, 38, 39 } },
+		},
+		.num_lvts_sensor =3D 2,
+		.offset =3D 0x100,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_TS3_1,
+			  .cal_offsets =3D { 40, 41, 42 } },
+		},
+		.num_lvts_sensor =3D 1,
+		.skipped_sensors =3D 1,
+		.offset =3D 0x0,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_TS4_0,
+			  .cal_offsets =3D { 43, 44, 45 } },
+			{ .dt_id =3D MT8188_AP_TS4_1,
+			  .cal_offsets =3D { 46, 47, 48 } },
+			{ .dt_id =3D MT8188_AP_TS4_2,
+			  .cal_offsets =3D { 49, 50, 51 } },
+		},
+		.num_lvts_sensor =3D 3,
+		.offset =3D 0x100,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_TS5_0,
+			  .cal_offsets =3D { 52, 53, 54 } },
+			{ .dt_id =3D MT8188_AP_TS5_1,
+			  .cal_offsets =3D { 55, 56, 57 } },
+		},
+		.num_lvts_sensor =3D 2,
+		.offset =3D 0x200,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8188_AP_TS6_0,
+			  .cal_offsets =3D { 58, 59, 60 } },
+			{ .dt_id =3D MT8188_AP_TS6_1,
+			  .cal_offsets =3D { 61, 62, 63 } },
+		},
+		.num_lvts_sensor =3D 2,
+		.offset =3D 0x300,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
 		.lvts_sensor =3D {
@@ -1638,6 +1721,22 @@ static const struct lvts_data mt8186_lvts_data =3D=
 {
 	.gt_calib_bit_offset =3D 24,
 };
=20
+static const struct lvts_data mt8188_lvts_mcu_data =3D {
+	.lvts_ctrl	=3D mt8188_lvts_mcu_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8188_lvts_mcu_data_ctrl),
+	.temp_factor	=3D -250460,
+	.temp_offset	=3D 250460,
+	.gt_calib_bit_offset =3D 20,
+};
+
+static const struct lvts_data mt8188_lvts_ap_data =3D {
+	.lvts_ctrl	=3D mt8188_lvts_ap_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8188_lvts_ap_data_ctrl),
+	.temp_factor	=3D -250460,
+	.temp_offset	=3D 250460,
+	.gt_calib_bit_offset =3D 20,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1669,6 +1768,8 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
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
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/includ=
e/dt-bindings/thermal/mediatek,lvts-thermal.h
index 3197ca6087..04fa9d7821 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -26,6 +26,22 @@
 #define MT8186_TS3_1		7
 #define MT8186_TS3_2		8
=20
+#define MT8188_MCU_TS1_0	0
+#define MT8188_MCU_TS1_1	1
+#define MT8188_MCU_TS1_2	2
+#define MT8188_MCU_TS1_3	3
+#define MT8188_MCU_TS2_0	4
+#define MT8188_MCU_TS2_1	5
+
+#define MT8188_AP_TS3_1		0
+#define MT8188_AP_TS4_0		1
+#define MT8188_AP_TS4_1		2
+#define MT8188_AP_TS4_2		3
+#define MT8188_AP_TS5_0		4
+#define MT8188_AP_TS5_1		5
+#define MT8188_AP_TS6_0		6
+#define MT8188_AP_TS6_1		7
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
--=20
2.42.0


