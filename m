Return-Path: <linux-pm+bounces-5770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAFD8949E9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68852871E7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137815E89;
	Tue,  2 Apr 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lFgisjo0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="V7d3ojbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845B14AB7;
	Tue,  2 Apr 2024 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028471; cv=none; b=qkDG0ZolT7Ok/NIK62UEOvktKi29g1tUYj8V5JPvQJVsNGffPpXOevYLgc0c6iAw1zSnWYcBXKPnQsmJ5cXCqDMQpJUaZuGS0sjl6zkkLOzvy5JF0bW3veZoAUHk9MiuJMKQwWo/dmtQl3QIBh6xCpaMCDfASnxZ1lduUdhY9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028471; c=relaxed/simple;
	bh=ScwN+eL5Iy7BALIJYLXFDSBD9VouoWmZ+JLjnDMkDm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD0XPuuZisddP7lxbS2Dz5X7vpbj2AdOaPERNYDiO/EgkHBiNiDqj2qbMqbFAMrZmJ2X7IDoXBucPDX8JzLgEQDimZjMJZ4GEw0RFMNUhDXG6X/+0BQyMkERqkKs5UDXlk/kfZtVXo25gw92uA3rO6hq5G3wvKTN3qBLS1YHicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lFgisjo0; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=V7d3ojbu reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FC961DBD7C;
	Mon,  1 Apr 2024 23:27:48 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ScwN+eL5Iy7BALIJYLXFDSBD9
	VouoWmZ+JLjnDMkDm8=; b=lFgisjo0MgDYa83l0yluEPrlyMffFxrXuFxD+4BcN
	JeFwxQWmiIadb8sRRR5BztCyJIVrtigk84MBJIaw07ndRMThZ67nmLR+rWLr0D65
	S4zvDPNOV/4k2O73vTuGE2rNGm1SP31alNIMeqRM8y0NeaRGo3IWp6MdSirUeliU
	Q0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 760A01DBD7B;
	Mon,  1 Apr 2024 23:27:48 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=KRLolNlFAREnWbcdTG3kKhk4k/XmV5J2nlwZY29mbd4=; b=V7d3ojbug0JFrc1ZbiXTyb7i/1TJfogRInYQ9QgYFOwAVkaCG5+YvX82kvlko9wFqRcoc/vBojeJqzg511b1XiSr7Kpuhf7N5/5pLFNUiDuCOr+My9GlRaypZvvHZHE6lj5Ray4Y0KZfP+lB/zPy4VGhYHll1+rwfc2jRKnAfwA=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB8411DBD7A;
	Mon,  1 Apr 2024 23:27:47 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 10DDFC1CED0;
	Mon,  1 Apr 2024 23:27:45 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 07/15] arm64: dts: mediatek: mt8186: add lvts definitions
Date: Mon,  1 Apr 2024 23:25:41 -0400
Message-ID: <20240402032729.2736685-8-nico@fluxnic.net>
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
 FA4CA5A0-F0A0-11EE-85E4-25B3960A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Values extracted from vendor source tree.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8186.dtsi
index 2fec6fd1c1..cef8244007 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1355,6 +1355,18 @@ spi0: spi@1100a000 {
 			status =3D "disabled";
 		};
=20
+		lvts: thermal-sensor@1100b000 {
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


