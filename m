Return-Path: <linux-pm+bounces-2134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28B82B721
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 23:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEFCB2374F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jan 2024 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F195F9E6;
	Thu, 11 Jan 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l3Qy/d1o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="esLxWW3+"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC4EADC
	for <linux-pm@vger.kernel.org>; Thu, 11 Jan 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 272F31D3A57;
	Thu, 11 Jan 2024 17:30:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=cmcJsO5C6pAmN7NPdCLy6I2nx
	rdvCuIr26PkZTFT7d8=; b=l3Qy/d1oLqdfDSDWfHOy+2OJLkEIBvtrfUIXq3g8i
	uZ9i1azzWKWvOCEEd0WLYxKtECyqnFkU2kLmTSTuU8FDBVWzluydHZ4u5XfXTsNz
	8O26ztQBreG+wTA66lnVpDKVmcL18B8JW2sh4f8H1DlVIDO229vODzRDWITJUtRe
	TY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F4CE1D3A56;
	Thu, 11 Jan 2024 17:30:33 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=35Zw/M02+JwlCQ6URD4awsGvq+mE+Fe/G9BDOm23JO8=; b=esLxWW3+UdtKeg7Vk7n43DjeezU8rKV8L2gRk3WWygCHQc/Z2wVT5Yi9e4uaOAn5j6IjEed1N6VCBcx8yJnjoRqbTVxskiMYwWbu49M4qECrv7LzCdpcijEa79JGj2v/Qp2bXWdP1qWpjZp6/QK7iSCIEikiAZEhEe9kp8UdMgQ=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FF4C1D3A55;
	Thu, 11 Jan 2024 17:30:32 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CF86DAD5A66;
	Thu, 11 Jan 2024 17:30:30 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 5/9] thermal/drivers/mediatek/lvts_thermal: add MT8186 support
Date: Thu, 11 Jan 2024 17:30:02 -0500
Message-ID: <20240111223020.3593558-6-nico@fluxnic.net>
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
 08202A54-B0D1-11EE-97EC-78DCEB2EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        |  2 +
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 20 ++++++
 drivers/thermal/mediatek/lvts_thermal.c       | 67 +++++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           | 10 +++
 4 files changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-therma=
l.yaml
index e6665af52e..4173bae530 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yam=
l
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt7988-lvts-ap
+      - mediatek,mt8186-lvts
       - mediatek,mt8192-lvts-ap
       - mediatek,mt8192-lvts-mcu
       - mediatek,mt8195-lvts-ap
@@ -75,6 +76,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8186-lvts
               - mediatek,mt8195-lvts-ap
               - mediatek,mt8195-lvts-mcu
     then:
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8186.dtsi
index df0c04f2ba..8fc563dce6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1355,6 +1355,18 @@ spi0: spi@1100a000 {
 			status =3D "disabled";
 		};
=20
+		lvts: lvts@1100b000 {
+			compatible =3D "mediatek,mt8186-lvts";
+			#thermal-sensor-cells =3D <1>;
+			reg =3D <0 0x1100b000 0 0x1000>;
+			interrupts =3D <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks =3D <&infracfg_ao CLK_INFRA_AO_THERM>;
+			clock-names =3D "lvts_clk";
+			resets =3D <&infracfg_ao MT8186_INFRA_THERMAL_CTRL_RST>;
+			nvmem-cells =3D <&lvts_e_data1 &lvts_e_data2>;
+			nvmem-cell-names =3D "e_data1","e_data2";
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible =3D "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm"=
;
 			reg =3D <0 0x1100e000 0 0x1000>;
@@ -1668,6 +1680,14 @@ efuse: efuse@11cb0000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
=20
+			lvts_e_data1: data1 {
+				reg =3D <0x1cc 0x14>;
+			};
+
+			lvts_e_data2: data1-1 {
+				reg =3D <0x2f8 0x14>;
+			};
+
 			gpu_speedbin: gpu-speedbin@59c {
 				reg =3D <0x59c 0x4>;
 				bits =3D <0 3>;
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
index ed1888fb24..e923d22c17 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -80,6 +80,8 @@
 #define LVTS_SENSOR_MAX				4
 #define LVTS_GOLDEN_TEMP_MAX		62
 #define LVTS_GOLDEN_TEMP_DEFAULT	50
+#define LVTS_COEFF_A_MT8186			-204650
+#define LVTS_COEFF_B_MT8186			204650
 #define LVTS_COEFF_A_MT8195			-250460
 #define LVTS_COEFF_B_MT8195			250460
 #define LVTS_COEFF_A_MT7988			-204650
@@ -92,6 +94,7 @@
 #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
=20
 #define LVTS_HW_SHUTDOWN_MT7988		105000
+#define LVTS_HW_SHUTDOWN_MT8186		105000
 #define LVTS_HW_SHUTDOWN_MT8192		105000
 #define LVTS_HW_SHUTDOWN_MT8195		105000
=20
@@ -1377,6 +1380,62 @@ static int lvts_resume(struct device *dev)
 	return 0;
 }
=20
+/*
+ * The MT8186 calibration data is stored as packed 3-byte little-endian
+ * values using a weird layout that makes sense only when viewed as a 32=
-bit
+ * hexadecimal word dump. Let's suppose SxBy where x =3D sensor number a=
nd
+ * y =3D byte number where the LSB is y=3D0. We then have:
+ *
+ *   [S0B2-S0B1-S0B0-S1B2] [S1B1-S1B0-S2B2-S2B1] [S2B0-S3B2-S3B1-S3B0]
+ *
+ * However, when considering a byte stream, those appear as follows:
+ *
+ *   [S1B2] [S0B0[ [S0B1] [S0B2] [S2B1] [S2B2] [S1B0] [S1B1] [S3B0] [S3B=
1] [S3B2] [S2B0]
+ *
+ * Hence the rather confusing offsets provided below.
+ */
+static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] =3D {
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_TS1_0,
+			  .cal_offsets =3D { 5, 6, 7 } },
+			{ .dt_id =3D MT8186_TS1_1,
+			  .cal_offsets =3D { 10, 11, 4 } },
+			{ .dt_id =3D MT8186_TS1_2,
+			  .cal_offsets =3D { 15, 8, 9 } },
+			{ .dt_id =3D MT8186_TS1_3,
+			  .cal_offsets =3D { 12, 13, 14 } }
+		},
+		.num_lvts_sensor =3D 4,
+		.offset =3D 0x0,
+		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8186,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_TS2_0,
+			  .cal_offsets =3D { 22, 23, 16 } },
+			{ .dt_id =3D MT8186_TS2_1,
+			  .cal_offsets =3D { 27, 20, 21 } }
+		},
+		.num_lvts_sensor =3D 2,
+		.offset =3D 0x100,
+		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8186,
+	},
+	{
+		.lvts_sensor =3D {
+			{ .dt_id =3D MT8186_TS3_0,
+			  .cal_offsets =3D { 29, 30, 31 } },
+			{ .dt_id =3D MT8186_TS3_1,
+			  .cal_offsets =3D { 34, 35, 28 } },
+			{ .dt_id =3D MT8186_TS3_2,
+			  .cal_offsets =3D { 39, 32, 33 } }
+		},
+		.num_lvts_sensor =3D 3,
+		.offset =3D 0x200,
+		.hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8186,
+	}
+};
+
 static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] =3D {
 	{
 		.lvts_sensor =3D {
@@ -1565,6 +1624,13 @@ static const struct lvts_data mt7988_lvts_ap_data =
=3D {
 	.temp_offset	=3D LVTS_COEFF_B_MT7988,
 };
=20
+static const struct lvts_data mt8186_lvts_data =3D {
+	.lvts_ctrl	=3D mt8186_lvts_data_ctrl,
+	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8186_lvts_data_ctrl),
+	.temp_factor	=3D LVTS_COEFF_A_MT8186,
+	.temp_offset	=3D LVTS_COEFF_B_MT8186,
+};
+
 static const struct lvts_data mt8192_lvts_mcu_data =3D {
 	.lvts_ctrl	=3D mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	=3D ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
@@ -1591,6 +1657,7 @@ static const struct lvts_data mt8195_lvts_ap_data =3D=
 {
=20
 static const struct of_device_id lvts_of_match[] =3D {
 	{ .compatible =3D "mediatek,mt7988-lvts-ap", .data =3D &mt7988_lvts_ap_=
data },
+	{ .compatible =3D "mediatek,mt8186-lvts", .data =3D &mt8186_lvts_data }=
,
 	{ .compatible =3D "mediatek,mt8192-lvts-mcu", .data =3D &mt8192_lvts_mc=
u_data },
 	{ .compatible =3D "mediatek,mt8192-lvts-ap", .data =3D &mt8192_lvts_ap_=
data },
 	{ .compatible =3D "mediatek,mt8195-lvts-mcu", .data =3D &mt8195_lvts_mc=
u_data },
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/includ=
e/dt-bindings/thermal/mediatek,lvts-thermal.h
index 997e2f5512..3197ca6087 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -16,6 +16,16 @@
 #define MT7988_ETHWARP_0	6
 #define MT7988_ETHWARP_1	7
=20
+#define MT8186_TS1_0		0
+#define MT8186_TS1_1		1
+#define MT8186_TS1_2		2
+#define MT8186_TS1_3		3
+#define MT8186_TS2_0		4
+#define MT8186_TS2_1		5
+#define MT8186_TS3_0		6
+#define MT8186_TS3_1		7
+#define MT8186_TS3_2		8
+
 #define MT8195_MCU_BIG_CPU0     0
 #define MT8195_MCU_BIG_CPU1     1
 #define MT8195_MCU_BIG_CPU2     2
--=20
2.42.0


