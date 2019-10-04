Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71516CB6DD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfJDJBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:01:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52924 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbfJDJB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:01:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so4960569wmh.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5p5TZdfu3c5JamI9H4kBW65H5B1r53e+p3e9L3D7UU=;
        b=HXhD6/b3g46QaTJ0rfpB3K4p1enaijiJaNjpzh3iqTrbojoWc322br0ZE4fu74y4Bo
         ew+dbCn+cRNR1RXAKjF8eA0cotL6IdqdbJ++nJBwfDLKWACSZ3F0ZBXVKSPw09uvYcdc
         f4ZEslZx17QSDT+8H3oagrvU77HvhR/zHaLyEEvZKo6BybCOPGXao9t/ilum3zkTO+n9
         k+mGhPRrcwz8ZbbFmCWUeKOZSbvBStSepye0eyQwOELYxOkUx4nKk79IVLuemlZx8t/6
         WlYbJbSwJmFDlL8mbjEPoAFtALBieInYnKeRslS4xZadxcvCgVmUaAVsTS4GPsc4hdcL
         lZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5p5TZdfu3c5JamI9H4kBW65H5B1r53e+p3e9L3D7UU=;
        b=Z7rjbtw3MoFnmdt8ge47IF+yCiYSBxlJ3S6+HGQtlbaOEE7sx7/dOe63NtmdI/wk3E
         N6010sKwLVD63FY36v9Yu2OcdRDP0yORhQxDvSBo6IuMiDyIcjVIuAq3l7x11H3T6b2+
         SzXlT01sCrr7pnBHizaV58q+lElMoJUcOPstm/TQLaCut8Tgrkdm1I0TuoaQ/XBW5tll
         IpV1/gWM6VTDoOkb2UR1cR/+iRxidMkUReQIhTKry71pVQ8yM0EKvS4LTl/MMCO9Qxyp
         oHw4n+HX392fznqQK+IMlYRbzvuDiDfQsb571OK+SGZDpFK9yfNDbF+dk//4LWHisHL4
         HCXQ==
X-Gm-Message-State: APjAAAU8xBc2VWBsgAS6CY+piEEov2V6qKYfbp2XdVHujR0KrxzGeM+w
        R9Tgd3N9hGZ9Vv293V0ts0BRxA==
X-Google-Smtp-Source: APXvYqx6hT7Mt9IcrA0cYDoSMEivg/dkChQ3Dkjk4SFkHc0I5XcK4X1WIZJ1l19R9jm4yIxaNblaQg==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr10530902wmi.142.1570179684267;
        Fri, 04 Oct 2019 02:01:24 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:23 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 6/7] arm64: dts: amlogic: g12b: add cooling properties
Date:   Fri,  4 Oct 2019 11:01:13 +0200
Message-Id: <20191004090114.30694-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing #colling-cells field for G12B SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 98ae8a7c8b41..4bb89bce758f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -49,6 +49,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -57,6 +58,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu100: cpu@100 {
@@ -65,6 +67,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu101: cpu@101 {
@@ -73,6 +76,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu102: cpu@102 {
@@ -81,6 +85,7 @@
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu103: cpu@103 {
@@ -89,6 +94,7 @@
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
@@ -219,3 +225,26 @@
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
+
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_passive>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
-- 
2.17.1

