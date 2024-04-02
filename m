Return-Path: <linux-pm+bounces-5782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765C894A13
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E191C23241
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620B17BA7;
	Tue,  2 Apr 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mgxy4P7K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="kIOECA8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285F17BA5;
	Tue,  2 Apr 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712028869; cv=none; b=SwW99sl06SIWL7d+vO4d5R0bJeN90LskL3LOWqTLvNPt3kqnYWSG9m/4RflWuS/C0cHh7gfyMCsy0ykKWZkMfbL7RagxxYvF+lMVpcIV0BBwcQ9ZfJcGsqgW92C1OdxGoLiDS+TJOQTsmVVOeEFnqDz/p9eV/goZ6SJaM9JhTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712028869; c=relaxed/simple;
	bh=YD53FIMSNhmKy6veQFEgq13wFF2wke3yYidvl5FoGbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNm4avo3L+sfZQ5Q4SamRe0e1vLfKZLxunVZbtmKoytG5DBD93Ibn65JQlD0djVcPSvq5RP9hM8EFooydmblAx/Kezna9x9KCjYhLI+jbIUZ/L10bQFOfWIC3iTAvOQOaX7gGYVuGKXeLR6cdh+gLp+ZuIGxkBXcBZEot9BDIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mgxy4P7K; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=kIOECA8S reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A276F250D7;
	Mon,  1 Apr 2024 23:34:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=YD53FIMSNhmKy6veQFEgq13wF
	F2wke3yYidvl5FoGbQ=; b=Mgxy4P7K6naTNp7hZEcKw9BRF+eeLyH/XjkFjzFXR
	ECIUYF+chM6WnBzHyECwwoh4gNt63iB7ZflHlha2u7F9vfx669mMMV7tW4+BIDps
	jTDYCtntIgz7viKdnhOYpjOfrvAtcVUI4Zlaqvzoq5l+84P2QxQvkLLEND+sknQv
	0E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ACB4250D6;
	Mon,  1 Apr 2024 23:34:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=HZopFeX8NiLDsAr5t76/L/Cxak+6Mp/JkdbfcBRoQB4=; b=kIOECA8SRxftYCE7MXbRFOaIQpn8BVbB4OWanvn5cuOEo0vFzvhqsKcqLZ21rHFdKUzlBaeLscofb/pYOo8kIVa0eso+LCT/cM4d14ZT6RrSyO5l/Xz+kEdZEKfQ/EohouTfNe4rin9IQYH/xk9+VnzuFoC+bRvZ2qfdbyoMDtU=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7872C250D3;
	Mon,  1 Apr 2024 23:34:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3B641C1CEDB;
	Mon,  1 Apr 2024 23:27:46 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 15/15] arm64: dts: mediatek: mt8188: add default thermal zones
Date: Mon,  1 Apr 2024 23:25:49 -0400
Message-ID: <20240402032729.2736685-16-nico@fluxnic.net>
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
 E60D618C-F0A1-11EE-8A1C-F515D2CDFF5E-78420484!pb-smtp20.pobox.com
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
index 101c9c9f4b..1101dd1b75 100644
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
+		cpu-little0-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
+
+			trips {
+				cpu_little0_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu_little0_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_little0_alert>;
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
+		cpu-little1-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
+
+			trips {
+				cpu_little1_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu_little1_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_little1_alert>;
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
+		cpu-little2-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
+
+			trips {
+				cpu_little2_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu_little2_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_little2_alert>;
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
+		cpu-little3-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
+
+			trips {
+				cpu_little3_alert: trip-alert {
+					temperature =3D <85000>;
+					hysteresis =3D <2000>;
+					type =3D "passive";
+				};
+
+				cpu_little3_crit: trip-crit {
+					temperature =3D <100000>;
+					hysteresis =3D <2000>;
+					type =3D "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip =3D <&cpu_little3_alert>;
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
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_BIG_CPU0>;
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
+			thermal-sensors =3D <&lvts_mcu MT8188_MCU_BIG_CPU1>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_APU>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_GPU1>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_GPU2>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_SOC1>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_SOC2>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_SOC3>;
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
+			thermal-sensors =3D <&lvts_ap MT8188_AP_CAM1>;
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
+		cam2-thermal {
+			polling-delay =3D <1000>;
+			polling-delay-passive =3D <250>;
+			thermal-sensors =3D <&lvts_ap MT8188_AP_CAM2>;
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


