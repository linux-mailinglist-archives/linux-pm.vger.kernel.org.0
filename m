Return-Path: <linux-pm+bounces-5783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F297894A15
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20851F21CFE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FC17C60;
	Tue,  2 Apr 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTfKCNnl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="JHxO5ghM"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51961171B6;
	Tue,  2 Apr 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028870; cv=none; b=mllFll0fOQ9d1Jbwu+9Q7IF9B0Tm1Ae+SMp9J7bNRUn9r7K8oKMtOHJJyDjOyHor68nlQD8h/rGWYHK52qwYZ1CQADfMfNEwBJjtGrSm8rCFZrI1lcViZbobyTPWZtaCqOXC/jiTOHxe4unnAnmawEZeK9JYZi0/YMX3JZIFBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028870; c=relaxed/simple;
	bh=rTvrEZ65j4kYINrGDrXQm7sDnjqIptBM8U6bohiAAs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBJ+SqVS1AhWYTWvCRc2tMb7GQN93RuElLJLU/A1bXoa26gkt4MhyRB6DJZ0/JSYzlL48HsKQI+lCjE9/ZEKeMb2ItgYi0NHNed91PtFEc9PGsbYLxXIUlIVGu4EKnLNm4AE/w4QVadPgp9PUkShRJDJjnhMl3yUEy/vlUU1JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTfKCNnl; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=JHxO5ghM reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E68B0250D9;
	Mon,  1 Apr 2024 23:34:28 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=rTvrEZ65j4kYINrGDrXQm7sDn
	jqIptBM8U6bohiAAs8=; b=BTfKCNnl8c+92gTye8jn+Yt9Q+N/g2ZXdc51iTcAM
	H4CJi4smAmU1jXt2QEzgiKfNaEL1KdwMqNn5AwQVP3ovj6W+Rsu+jg8ADDxOMwMj
	BOnovnyVKfo2pQxlfFfwHv/pHCN588oKMrrG6XZh3uYf721vMXWhBaACZYLKQvLQ
	8k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DF0E5250D8;
	Mon,  1 Apr 2024 23:34:28 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=0wToczV/1O2aHSAMhacxFcFPX/l7HUJsFN4ve25Y6XA=; b=JHxO5ghMLyrtYzUjb1IWc20lgrVqRKyiHf9KvYu4MKeJiLMhHbqlViRiATh+w02CThiC32DdTRMB8hNR5g8+IekWIjO8brHJ3HtJ8++KXBUR8I5xZbLJauM5Y31i+v+WFm1DLuPfymwBUUF0WPk6V9GdHB5BEpvDlkqpErWd2H0=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9865250D5;
	Mon,  1 Apr 2024 23:34:24 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id ED6B8C1CED7;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 13/15] arm64: dts: mediatek: mt8188: add lvts definitions
Date: Mon,  1 Apr 2024 23:25:47 -0400
Message-ID: <20240402032729.2736685-14-nico@fluxnic.net>
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
 E6D7A668-F0A1-11EE-8378-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Various values extracted from the vendor's kernel driver.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
index b4315c9214..101c9c9f4b 100644
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
+			reg =3D <0 0x1100b000 0 0xc00>;
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
--=20
2.44.0


