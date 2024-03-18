Return-Path: <linux-pm+bounces-5085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7987F241
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 22:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF6A1C2128D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20825A11B;
	Mon, 18 Mar 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VaDHW9Nt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="aPEKY8mf"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DA59B59;
	Mon, 18 Mar 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797684; cv=none; b=ULj+K2EeOM52RWDXFhO27NjbdnCs6XC+evJ5bupz49VjBJaVhlX1WtkYWtWCx8Xs6Kfs5sdp4lwSnqkYp3VmDj5Izbeqxw2LOFxSawi7dWUIVD+TqB6dkQiKL0HQDJy7JOh8l1HpGyBQBEhdoX3o/Sm3JsY+0Gww1iRt0OxrrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797684; c=relaxed/simple;
	bh=X2sRkyjakE0VEnTnqSb6o38pWZf+n5FfGmDjclnooxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpItjZFdl4LVZ+yDBFBYSnLNPpFegUOi7a/hnVxb4HQoFJE7HLEQx7WtB2cTG1AS6mkhc3uF786h7oLaNjHu8TYAEzUaEIFj1RTaocFJW6m7afAlHW4x5LQV83KdYC1teLmGfSitS5WH7xt2oQuClNIYZIS4Mf+RyMBlfoAt2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VaDHW9Nt; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=aPEKY8mf reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 83E7D235ED;
	Mon, 18 Mar 2024 17:34:42 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=X2sRkyjakE0VEnTnqSb6o38pW
	Zf+n5FfGmDjclnooxc=; b=VaDHW9NtGMN1+1+DrZJCpIkawXgF/ABEzxgtTRUiY
	vZJfKWB97b13pNjufrNJbHl3PEdGxXwD8oztUvcXROShEeTRBfr9UW7BOrGcVzxQ
	q+/tXzbBqYLdnx9Mqe55aqQZBIROoNZLLrkRUw2PyG91MC/xmjL4Too3+1xgNuDL
	wA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A03B235EC;
	Mon, 18 Mar 2024 17:34:42 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=biv2CycJifyejMyHV8LrosOmw/5LZ/RLDnuSuMaU8TY=; b=aPEKY8mftOLrs1AjQVirtdckqclSxv+MuIPA/fnsCuvAR+wvYe2FvIwkL1HihGmqyIHNLU9eZfqqlmG4l7nCfH3/dLyIESCqU7NmwQCIO3y66+NCO7Gf3F36bnOEQqVM61QwQO4tT/wQ9GJd56cUYjPv5Wcum1U/UiMuF1E99lM=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 652AB235E8;
	Mon, 18 Mar 2024 17:34:38 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0FE60BE2BB0;
	Mon, 18 Mar 2024 17:24:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH v2 13/13] arm64: dts: mediatek: mt8188: add default thermal zones
Date: Mon, 18 Mar 2024 17:22:15 -0400
Message-ID: <20240318212428.3843952-14-nico@fluxnic.net>
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
 528EAE3A-E56F-11EE-A361-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Nicolas Pitre <npitre@baylibre.com>

Inspired by the vendor kernel but adapted to the upstream thermal
driver version.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 348 +++++++++++++++++++++++
 1 file changed, 348 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
index 5a3c58a77c..ea90ad4baa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -12,6 +12,8 @@
 #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
 #include <dt-bindings/power/mediatek,mt8188-power.h>
 #include <dt-bindings/reset/mt8188-resets.h>
+#include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
=20
 / {
 	compatible =3D "mediatek,mt8188";
@@ -311,6 +313,352 @@ psci {
 		method =3D "smc";
 	};
=20
+	thermal_zones: thermal-zones {
+		cluster0-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_TS1_0>;
+
+			trips {
+				cluster0_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cluster0_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cluster0_alert>;
+					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_TS1_1>;
+
+			trips {
+				cluster1_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cluster1_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cluster1_alert>;
+					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cluster2-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_TS1_2>;
+
+			trips {
+				cluster2_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cluster2_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cluster2_alert>;
+					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cluster3-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_TS1_3>;
+
+			trips {
+				cluster3_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cluster3_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cluster3_alert>;
+					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu_big0-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_TS2_0>;
+
+			trips {
+				cpu_big0_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu_big0_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_big0_alert>;
+					cooling-device =3D <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu_big1-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_TS2_1>;
+
+			trips {
+				cpu_big1_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu_big1_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_big1_alert>;
+					cooling-device =3D <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		apu-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS3_1>;
+
+			trips {
+				apu_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				apu_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS4_0>;
+
+			trips {
+				gpu1_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				gpu1_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		gpu2-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS4_1>;
+
+			trips {
+				gpu2_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				gpu2_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		soc1-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS4_2>;
+
+			trips {
+				soc1_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				soc1_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		soc2-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS5_0>;
+
+			trips {
+				soc2_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				soc2_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		soc3-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS5_1>;
+
+			trips {
+				soc3_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				soc3_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		cam1-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS6_0>;
+
+			trips {
+				cam1_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cam1_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+
+		cam21-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_TS6_1>;
+
+			trips {
+				cam2_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cam2_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+		};
+	};
+
 	timer: timer {
 		compatible =3D "arm,armv8-timer";
 		interrupt-parent =3D <&gic>;
--=20
2.44.0


