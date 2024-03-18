Return-Path: <linux-pm+bounces-5074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C087F201
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A21F21BC5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF758ADC;
	Mon, 18 Mar 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dCp/Y6EA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DSUnM8BZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189C58218;
	Mon, 18 Mar 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797095; cv=none; b=nsRQ7hx6UMFIMvaA4R5zGAOe6Paf234QH3j9/N/PRFpCF8TlIL07jGlkWggtKzc1XcgVOz40PepGdRF9rIZqx/BeGlIurkdL2QaCnQ/7Bt/bMI0yi5ePIEkQzHXSbbB1omwsE14nKvCZjlKH3DOiM2Y5Jkl9I3z70e5wJO7SqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797095; c=relaxed/simple;
	bh=fjH3v9lUYOCHLYg/wxlBXzCQD4vQ5R5fYy3nQWJXnb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrpR36pMhJ+Cu0odJ9xDhDf2GzF+O5dykSM6z+Qk62WVXdFV8B2RqjD2QXoCHnjuU16MyHGGlPZ19cXDlapnVvUUvUw9vEJqcaWAj7UFK19UG/LatLfBO3sNg42KOD+R6Dlrr9TDAg7X8TQ7SOtg84IKAznkgEyeGOeRtnPYix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dCp/Y6EA; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DSUnM8BZ reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B947F1EA519;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=fjH3v9lUYOCHLYg/wxlBXzCQD
	4vQ5R5fYy3nQWJXnb8=; b=dCp/Y6EAuxIFh9O4lJCoLa1b/bUNntW45acFdfO2r
	GmLcfgwqO14ZEnounoR53e5la6nkKoEleYGUM97Q0O74rEzEZ0Ceok2Epjh3KbLd
	n7Jv36xYgzvsC6AJLkVgcP3CO/hXzMcsoHKaqFse93zO6fXd3oMJYZg5zRVN/SL0
	P8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B10BA1EA518;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=PFrKZ3JxTnWeaYuZKg5QTI2xLnaKbtv+w5mmpVYZI7E=; b=DSUnM8BZJzY1Ih9D/3YlqNc5w++AHH+XoJvvzmdZBIrJ6mXDGbSir7oKGWlaHYeN3IrRi4tNT3rl9/ibjUykzJh53tNUtmn3591sYW958Wj3UqLDyoQ7OUNdI+iAxaOjgAlA4FyttqxYA3LI2I6B2cIOA1IlLZ0HZuAv7MwW6AI=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 226931EA516;
	Mon, 18 Mar 2024 17:24:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 4BB8DBE2BA6;
	Mon, 18 Mar 2024 17:24:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 06/13] arm64: dts: mediatek: mt8186: add lvts definitions
Date: Mon, 18 Mar 2024 17:22:08 -0400
Message-ID: <20240318212428.3843952-7-nico@fluxnic.net>
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
 F51D6422-E56D-11EE-921F-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Values extracted from vendor source tree.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8186.dtsi
index 2fec6fd1c1..7b7a517a41 100644
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
--=20
2.44.0


