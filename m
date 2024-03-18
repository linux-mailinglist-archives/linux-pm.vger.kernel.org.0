Return-Path: <linux-pm+bounces-5082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28287F239
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1704F282812
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB758ACA;
	Mon, 18 Mar 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M6D6HzCb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="PibOmOXz"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE985A0E9;
	Mon, 18 Mar 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797681; cv=none; b=lRHhnNOkj83GP4zDx285CPiDTa5kI7RhfjOorosgVxC8zLvTlzI1pmfNojTGwApNyuwN5VlLYtQ45o876rnNtD9h63jNfprrO7S5puetGlVK0QiZFZ3n5IA5L430cj3iopb0ChCLxj0uhITdNXc516CFD1fzUyW+m0GQm66r3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797681; c=relaxed/simple;
	bh=rOtLsph6Q8c5b1SVtGdeg7bNPI+m727ryiDtorHRqRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgqqINrjNf5NLYZqdJIpzfJupvmm3H3jUcTfAyp5vl6iWCW9Ay4gtdja8DHGtiiHzeJZLfAf5P/j1USZdlOV+0fyoUzncrVMARMObsrFPtFguzZR1t4ksl5IaGHiuxx4lga5LHo0hqkjEPwukfhcaj0yJuIMt/Zy6iIhYvQCTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M6D6HzCb; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=PibOmOXz reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B2B11D10B3;
	Mon, 18 Mar 2024 17:34:38 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=rOtLsph6Q8c5b1SVtGdeg7bNP
	I+m727ryiDtorHRqRg=; b=M6D6HzCbUMG1Xxwk9EPt7DJcVwnPFmCod21QUv3jl
	AG+cdhjrzON2IyN1QGraBWpQhpvBE3c2Jk1O5y/zeTUzjWDk6OhnAA6tOip2Ai4C
	n1eLxZhksDpSDw+zzisytsmFPGoLX6J9o3Ru+ntnuFD8hBqFFYj25b/lOq9FK9Sr
	6Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 118291D10B1;
	Mon, 18 Mar 2024 17:34:38 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=zzdQgQ+ujmN/+VszAJaXnWpW7T2/ksvp8o6qRRSrnTg=; b=PibOmOXzX2uZGz/Zjj/baC4zAHKNDJr8hPZXezRy5tyuOSG0hSs918O67sfV8rGBON1WZr1FLF8tf3e9OUU1AvQOxTGupFo/HugGqC/j+yYFT6IvxmwAJl49nPkQvF12h2g528mRi6dbeBFs61oirjqIIi3tCMkFvHB4D552Al0=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B94F1D10B0;
	Mon, 18 Mar 2024 17:34:37 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E66CABE2BAE;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 12/13] thermal/drivers/mediatek/lvts_thermal: add MT8188 support
Date: Mon, 18 Mar 2024 17:22:14 -0400
Message-ID: <20240318212428.3843952-13-nico@fluxnic.net>
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
 51F09F42-E56F-11EE-B5CD-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi |  35 ++++++++
 drivers/thermal/mediatek/lvts_thermal.c  | 102 +++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
index b4315c9214..5a3c58a77c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
+#include <dt-bindings/reset/mt8188-resets.h>
=20
 / {
 	compatible =3D "mediatek,mt8188";
@@ -357,6 +358,7 @@ infracfg_ao: syscon@10001000 {
 			compatible =3D "mediatek,mt8188-infracfg-ao", "syscon";
 			reg =3D <0 0x10001000 0 0x1000>;
 			#clock-cells =3D <1>;
+			#reset-cells =3D <1>;
 		};
=20
 		pericfg: syscon@10003000 {
@@ -491,6 +493,17 @@ spi0: spi@1100a000 {
 			status =3D "disabled";
 		};
=20
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible =3D "mediatek,mt8188-lvts-ap";
+			reg =3D <0 0x1100b000 0 0x1000>;
+			interrupts =3D <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks =3D <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets =3D <&infracfg_ao MT8188_INFRA_RST1_THERMAL_CTRL_RST>;
+			nvmem-cells =3D <&lvts_efuse_data1>;
+			nvmem-cell-names =3D "lvts_calib_data1";
+			#thermal-sensor-cells =3D <1>;
+		};
+
 		spi1: spi@11010000 {
 			compatible =3D "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
 			#address-cells =3D <1>;
@@ -604,6 +617,17 @@ mmc1: mmc@11240000 {
 			status =3D "disabled";
 		};
=20
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible =3D "mediatek,mt8188-lvts-mcu";
+			reg =3D <0 0x11278000 0 0x1000>;
+			interrupts =3D <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks =3D <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets =3D <&infracfg_ao MT8188_INFRA_RST1_THERMAL_MCU_RST>;
+			nvmem-cells =3D <&lvts_efuse_data1>;
+			nvmem-cell-names =3D "lvts_calib_data1";
+			#thermal-sensor-cells =3D <1>;
+		};
+
 		i2c0: i2c@11280000 {
 			compatible =3D "mediatek,mt8188-i2c";
 			reg =3D <0 0x11280000 0 0x1000>,
@@ -827,6 +851,17 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
 			#clock-cells =3D <1>;
 		};
=20
+		efuse: efuse@11f20000 {
+			compatible =3D "mediatek,mt8188-efuse", "mediatek,efuse";
+			reg =3D <0 0x11f20000 0 0x1000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+
+			lvts_efuse_data1: lvts1-calib@1ac {
+				reg =3D <0x1ac 0x40>;
+			};
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible =3D "mediatek,mt8188-mfgcfg";
 			reg =3D <0 0x13fbf000 0 0x1000>;
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index a23a93fc82..46882df640 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1448,6 +1448,90 @@ static const struct lvts_ctrl_data mt8186_lvts_dat=
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
+		VALID_SENSOR_MAP(1, 1, 1, 1),
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
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset =3D 0x100,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	}
+};
+
+static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+
+			{ /* unused */ },
+			{ .dt_id =3D MT8188_AP_TS3_1,
+			  .cal_offsets =3D { 40, 41, 42 } },
+		},
+		VALID_SENSOR_MAP(0, 1, 0, 0),
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
+		VALID_SENSOR_MAP(1, 1, 1, 0),
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
+		VALID_SENSOR_MAP(1, 1, 0, 0),
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
+		VALID_SENSOR_MAP(1, 1, 0, 0),
+		.offset =3D 0x300,
+		.hw_tshut_temp =3D 117000,
+		.mode =3D LVTS_MSR_FILTERED_MODE,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
 		.lvts_sensor =3D {
@@ -1645,6 +1729,22 @@ static const struct lvts_data mt8186_lvts_data =3D=
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
@@ -1676,6 +1776,8 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
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


