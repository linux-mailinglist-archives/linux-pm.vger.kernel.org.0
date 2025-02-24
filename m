Return-Path: <linux-pm+bounces-22829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8133A429E5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE91890CBC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A8265CC6;
	Mon, 24 Feb 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="leDzknSq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A81265CAE
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418328; cv=none; b=GP6Xvl20zNAbrbRe2gvkmsZFeHvywioGd+18e89YVOjOuGVxnssD3ecshDsvOfHnfQexqmz2jDtnw+2+CMx9eahUw8HpM2ETlb22S/C6nTLcwEKJoOQWavyfF+/o8KEuCkL68BXXFsCwmqY8sTp2Os2fMml7MS7LvQZ8lugI5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418328; c=relaxed/simple;
	bh=JTUCCbCCWqHuncZ5oHBOQmD62rGMndm5FqoLy/lZso8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD/85J5DJQOeVl7f7qmK0irBA9GSwCNFwaDjqfYQR4tRL1wmNtmOQx4QSucUZr8tcS8Tu6YqIKTEX6TH24Xm0+rOdRX84T/A1BPmI7vj+eiCYnTpoejDTh1g8ipKIqxLNK/VTO6V7ukAaIK/nG23j32WRU/Tdc3Dgb95+JiHlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=leDzknSq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso5708478a12.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740418325; x=1741023125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1yo3qtSfIhFeGAEiRzmVMQo73ZalEAsSnX/cJq79kA=;
        b=leDzknSqCqtMKvI2s5QNRZEAmzUK7/zFE1HCb4C9M9pdUjBxLVSAFDWI/k7bUoxiCq
         9TP+LX+26cTn4Vgo3ZB9xvKYQrRG5FYGP7fYYrIt2acEiMXB5l5u83mUPGZR9glr+W9D
         jwZ1rlQ0GkLW5TuFEuB8Kt6meJlqEesbGSLXD3To/oTjlgre3w4VXRDv/VmFs66Gr/gS
         AHcxITptoU6Ox+4y/BsW6bN/68yNVe5RrE1n+kLhCdEl3vAA/PlvF+4GJ36i62sFFgcQ
         JCzBjK1/YDxlLdPJslxZWLS+th6+F4YjmODsxm8uEwgPkAiXdHT9TTTooTU17f4dZw1W
         tfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418325; x=1741023125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1yo3qtSfIhFeGAEiRzmVMQo73ZalEAsSnX/cJq79kA=;
        b=mbieL35qGlhku3EOYIpmCBNJgVDeFWJ/MxTAX9YZqIfouIfo+fcLYPC59FnHC6Biy+
         zLsxYd3kXzX2qwo605UoMFQDjoRJ1zRu6HLa3G3HFdb75OvHDnDfUzBdpANxFxXO26z8
         Z7fi/gbvWFbKAZCK869WQZac1bHg1uE+uL4DIXD8jVIE6/ZPlr7Aj5tAxKPdA9aFPhVC
         /Ct/avK+q7QXXLrtgLd0yEkI7PaH4z/woK8/9+Q1NbrW0NNjDWrJ8GadLgznBgzB/l8P
         Sy6FhtTkp0Ri/ulvcHojqO/aKNwWIfHQ6cfWgIzv54+c2d9NbK40vKZi3ErLGkO74a5v
         MYYg==
X-Forwarded-Encrypted: i=1; AJvYcCVFo1GjOvMASk3OKowwiyW2bVlG8AQvrYYfqseBr6h6CkA3DKFW9ZryGn/SPWwhJjizgUOCHFIw+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ex7rNLQjc1A4EBxiopXanSULxSDdGrdre6oPF3UQH1qmC15i
	mvwQj2CQEzTauzCQoTxoQ8WH/+/0hc2KQ8N99SST3Wo4NgX4KDpqfh2EhLhtjcY=
X-Gm-Gg: ASbGncv0TEsECZuCtjcR+O59rlSF1lgKvCgRehL50Ek0ITZ9FerWCTv/V3oGOnvWaTG
	eHWPgJUceOB2Yxu98ZxBgIa6ZDqz3WANvZY1sd48toWkkyaYo/OJA+RkPd7YQGA5UyKqYPVxYL9
	9xxZVVBz/2yYXGB0PeZYyJwNd1zKtDszFWNbgowj+F9vqCrCohiuW+L3oPF/4h2VQYkSMEQAyqr
	FSCbv9gtebpNJj+ACeg7RUSWoX8np1UCL3OMNpu6v1GDu5AtPxstFukUee8MKKFciEGkutDG7tP
	t9qO5qXQ+N1b4rXCJdjv1/v3khF3l16rZL5NN4QIV/prj+PxRHFDp2A=
X-Google-Smtp-Source: AGHT+IEvfXereLG4YfzIby0vL8BC3Kca01jNjsC9KnxwSBKk7fKmr/umERW/k7CxUdOT/iVLoKfvqg==
X-Received: by 2002:a17:907:6d02:b0:ab7:b5d6:2696 with SMTP id a640c23a62f3a-abc09b1470amr1217759666b.32.1740418325327;
        Mon, 24 Feb 2025 09:32:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a7fsm18674357a12.58.2025.02.24.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:32:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 3/4] arm64: dts: renesas: r9a08g045: Add TSU node
Date: Mon, 24 Feb 2025 19:31:43 +0200
Message-ID: <20250224173144.1952801-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
The temperature reported by the TSU can only be read through channel 8 of
the ADC. Therefore, enable the ADC by default.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected Geert's tag
- adjusted the trip points temperature as suggested in the review
  process
- added cpu_alert1 passive trip point as suggested in the review
  process; along with it changed the trip point nodes and label names

Hi, Geert,

I kept your Rb tag. Please let me know if it should be dropped.

Thank you,
Claudiu

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 49 ++++++++++++++++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  4 --
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 0364f89776e6..3f56fff7d9b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -233,7 +233,6 @@ adc: adc@10058000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			status = "disabled";
 
 			channel@0 {
 				reg = <0>;
@@ -272,6 +271,17 @@ channel@8 {
 			};
 		};
 
+		tsu: thermal@10059000 {
+			compatible = "renesas,r9a08g045-tsu";
+			reg = <0 0x10059000 0 0x1000>;
+			clocks = <&cpg CPG_MOD R9A08G045_TSU_PCLK>;
+			resets = <&cpg R9A08G045_TSU_PRESETN>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			io-channels = <&adc 8>;
+			io-channel-names = "tsu";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
@@ -717,6 +727,43 @@ timer {
 				  "hyp-virt";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsu>;
+			sustainable-power = <423>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 0 2>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				cpu_crit: cpu-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu_alert1: trip-point1 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				cpu_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vbattb_xtal: vbattb-xtal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..6f25ab617982 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -84,10 +84,6 @@ x3_clk: x3-clock {
 	};
 };
 
-&adc {
-	status = "okay";
-};
-
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.43.0


