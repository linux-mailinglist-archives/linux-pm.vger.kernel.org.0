Return-Path: <linux-pm+bounces-32091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBCB1F9E1
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 14:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D9044E165E
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A372512C3;
	Sun, 10 Aug 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FuO/LNNt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184562586C7
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828509; cv=none; b=kCe8CGlDTJSCOYuz9YzZKhavtGjfqLmhVhOpbd3Vfu6kBZlcn0hzNU/3XlCwTJM86ruSUnSLkSQdsCeuEot7kGPJTV8weFH/s/CkE8ETtyRXGT0D27euNAyfhpYA5MvmPdSzzw5g4A6UieAJhYsr4GOR6KT2NKUmnMz1C0QBttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828509; c=relaxed/simple;
	bh=iTQFHP39FE3WpDLqzx5etZHG59YzOhgdZXjfCTF7D4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6wdXVKDrs9GDm8PRfuh/t5gKUiByfF9rKTt66zATfRQL2Slb1XGDv92aZFF0tJ84QXRGFAqmxotJbsuxgzyCQo6gqEf6l5VIrV5INeuGnkGA8SUlYdtpceVhYzHMFJkI9exPHXDEEIH6Ydy3Uz7kI4QgNQHU1u8vZlse+SLt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FuO/LNNt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61530559887so5664450a12.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754828506; x=1755433306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czkhJoG2Gc/7FyisTMqLRYvCWAiMp1iGp7hQ46B82n8=;
        b=FuO/LNNtb9AL7ex5Xq0ehWh1O4WK/foeQ9v+WFrZUJkhohPDdK+zM0ppOSYLMYTxiK
         89BXDWBaWdCPQvjOGCHhMMCxFPjkUqrIcdwD+AGiB0s5sn/lC/bsGh4/oTQznHlEQHVF
         BEmiPqYsI91yLG0Px2wQV20EtrmMwc5X3fg8jDfmGQD/I28M0chpAiQLp7Gnq3dGLg65
         jcosbfjWPu/al/plgAqRzvy4q3kiHF4A7far0Q3Dr2La8NuwGwqfcIDxPDvYtWu+G3c7
         XR6pn27E8CdP6tj6LK9IFe8nlrjJMAyPoaUFKBRCPOqT+lqqP+1+FZ+N6WFOJLqbpvN7
         dT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828507; x=1755433307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czkhJoG2Gc/7FyisTMqLRYvCWAiMp1iGp7hQ46B82n8=;
        b=NRpjz43P6+j9UmcVqTq1Z2e6oCbOf0NeE5XnWjyXRy4hzLRnNBZ78B3iQUBGry61dS
         8NuNrDb1KZ2y1mm0RZ8oK/ndKnK0r/ogLFLLmZql3uWekV4R2XR/ugXufSXb62EPampr
         0ajBxR8sH15OswvbVm1HU8DwHb5zFVIiiTQelw6HNB/yjtHkYxxGACyDyk9ojIuApHNC
         hwUEiay0LfmQRHnFxBa8oTVxuL+u6iI08JjWBF4euBxOIawAt7F9kFs+7vrCx2Ms93PL
         V8KV7BUduH02n038nVL50WYi4DZtMEB4Xjo/uz+kXmVThyecHIMOCqjM/aAXcuyh6rFs
         WrpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLTazQgFEDrqurjFSO187lNTciLxIR2YFU6AAvCdlcXMOcsafiY7/9e92grcMNbUREDfZSikaV2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtWolMcDSwqHlRJiFr9TQghIFdvJi+IiOc4spBkMoxCub/9WF
	M8G8SnUWU6zlx+qM5NmX2EJgnTHmQuMKkB/NGC4lN0RrpZSoCSPLe1/XA1V00oRw5ZI=
X-Gm-Gg: ASbGncusrLuaOF7qYcAW56w/t+aLxxcXfBNh2+RQbHb9xlX1X0OahvTF0lH1r3Ft5Wj
	39DjX9FeeFuWFUzpsEV09jUqSG44Rs3xQGW7RgjhzXxSL8KigbEg8HVkkbHQPcxdFcS0kxtg7Pp
	p6Z/ildXY2JTEQJUcx/iIiB+1FW/4di/xKaPHMt8dCir2poh2sPu97jAyhyErxa28fdYnT+E0x7
	Bqz89MMucqw2EfqrP2OYB3GHhUn6xFalGdP/dzwgndgiZaWD1jW3JVlDRO58Uo5CcHswpiSDJwF
	2VjN+yYjnWsfErjzMJ0Ru+DMLWmdUg7hl6mxACcA0fP0N603aCnxkeMCNwFn6YRbn/wbe1Ty+/Z
	IWs1gkh+Hqmuzl2CR9QPxq2zaqnWtglM4HbUQh54jBta8MYRo8dYD
X-Google-Smtp-Source: AGHT+IEtxors3X7Rdp3bYfeRsAV85kpmN7w+thRk3VDKj4rUsmhSECv/3nQi8r+6f+zFV+oHk5YoZw==
X-Received: by 2002:a17:907:d23:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-af9c6518c68mr911773766b.54.1754828506589;
        Sun, 10 Aug 2025 05:21:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm16611897a12.0.2025.08.10.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:21:45 -0700 (PDT)
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
	niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 3/4] arm64: dts: renesas: r9a08g045: Add TSU node
Date: Sun, 10 Aug 2025 15:21:24 +0300
Message-ID: <20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v4:
- none

Changes in v3:
- none

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


