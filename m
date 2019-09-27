Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7214AC0594
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfI0MsX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 08:48:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55333 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfI0Mr7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 08:47:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so6446177wma.5
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bn1Yyb+y0E2XtXZ6uMo4FglNk7nmGiqm3716bVhGUbI=;
        b=K9an5A5Gt5DdTP1cbKeOnKPTzPSiEKvpVGCm8o+7tsv9wzJAzXCZQBkX6JTSgHJ3Iy
         DPThePWfO71M0t+mxHEuEsRhkwldfeXD1BaL8mC/W6JKaUnbKMuInIXBTEV7efhLceyo
         58mKE6MqQ+fKAbEq0Qvoms8kWyqEzkdaSC7bjdiQnDtU9bdL9J1j6uB5mt4V0z5BjJSp
         mZnYJHg65mnQCBv67lKtmfTJsFQG0JL9F8DRFVW8T6IOiVEDmEkHNSVeaOS1pdwSnRD0
         TDWHkBhhgCdux/1r1YwrjhbyufN74ljk8VlruZdl4fsfZGa/EazKqD6ZS/P+FkEPJfQ+
         5/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bn1Yyb+y0E2XtXZ6uMo4FglNk7nmGiqm3716bVhGUbI=;
        b=DhXlVKy8biwUKyaYZ9CPDzrTll2oVCNJiLf5fWU/Ap+GYYDSMPQSZa7W9kuGxZbASf
         QdYs+1Xe5JnA6XPgGieQq4zerYtfxhJCzta5YfVnUVSQMFAunCBG2PYjlH6L1lmKi0vL
         V06GSrwr0WpE4+wWl6xwdTU95M8v0MQuwMFrnAGgl+29I5/9H90hOrc8xmCSd+/DSsWi
         OGbgvCA1LX3XzZc11WzqPM0lmohN7IIxl56aiu3ayGPsAptfoV/hCGWQHHVKY0thE+8+
         cU4SzHY2j3t0OF0j2mdzyWfkKZ/wmCsYfPOBC3duDFWjzmdppSJzaK5+CEvE0OBDYYbc
         tozQ==
X-Gm-Message-State: APjAAAWqnYi1Fo5VzOuOB1TL2UAGohgKwCeAJFU0dc36X2fpveCxhgS0
        s5+p/OEe6YIIHQZgDGz6FujnVg==
X-Google-Smtp-Source: APXvYqyPHf/pDWgxGEyU6SfHL1TSMLHW+AfoTa4Fd6D5uufSUoyA3g3A7r6lbvJjccaS5BMtCqLChw==
X-Received: by 2002:a1c:4945:: with SMTP id w66mr6962094wma.40.1569588477438;
        Fri, 27 Sep 2019 05:47:57 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:47:56 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 5/7] arm64: dts: amlogic: g12a: add cooling properties
Date:   Fri, 27 Sep 2019 14:47:46 +0200
Message-Id: <20190927124750.12467-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing #colling-cells field for G12A SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 733a9d46fc4b..3ab6497548ca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -18,6 +18,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -26,6 +27,7 @@
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -34,6 +36,7 @@
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -42,6 +45,7 @@
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
 		};
 
 		l2: l2-cache0 {
@@ -113,3 +117,23 @@
 &sd_emmc_a {
 	amlogic,dram-access-quirk;
 };
+
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			trip = <&cpu_passive>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+
+		map1 {
+			trip = <&cpu_hot>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
-- 
2.17.1

