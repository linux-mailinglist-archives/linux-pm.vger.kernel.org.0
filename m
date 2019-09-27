Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A7C0B7D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 20:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfI0SoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 14:44:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33102 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfI0SoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 14:44:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so9249585wme.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9YGH/6YIzv9K3Mh8Ek1+NGOAz5VU0/WuYChxnvTMt8w=;
        b=WEICmolGZnHioZ2LKuulr44gm97tGO6qyIie0Dkm+XjLmXc0kV7+6t2izQ3Wivgxga
         fq/QxZp2uEf3U4jM0aAub/ITgU6nLYMXMz2glcf36hmEUiOppQieDaC6c9l/XlSZ9Vyz
         OUzPyFz/S0j7Zg0DkDBGX4ZzY0/qi9NEl2ZJc4mMozcfg5Mvj0fPAQV4HQXtJLdbRJj9
         awvOmNRVU3GRzJprxNAGrlEepy7A2OehkmR07xfbONk9bdVB+ED0rB0jnWMWFjSzsTs0
         5WgKeK7ttHWswt5rUqy7+fulvI7/4mXHxWKpYBXj84y/wdHbfxTg/2xBBgOr7W667Pj6
         2fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YGH/6YIzv9K3Mh8Ek1+NGOAz5VU0/WuYChxnvTMt8w=;
        b=QWSOlWch73By4fMcTKi64L3MBKXrDgu0px0OhlbHFOMJSp3FTt0cm96o/RdC5y16Wk
         a3DMj8bHinGh2CZ27LUg8M1C6rMYy6T9XNtTCDc6qA32ZRaXg8+dAxy6EfXSk4FO5gAT
         vVRXwVrJ29SwZX49tawdyNcfHK79Afc8RmgO0e3T7RMruvSITD7h4qW49CGLywYPMerP
         j7z9ubt8LYOqbgYF40IGA8ETFdI/GNoFBkoJf5ZpyijuwRmnqSSQglHUFYBAYxnHCeAV
         2QcgjVOXGhybXkrGdC0H1zchrRlckmd8425cht1sQ19BFtcrjbH16AaA43cuLRcoYGVC
         XXag==
X-Gm-Message-State: APjAAAVGTWoS3IO05j0Pnf7FXVa0QMD2H7ip/MViG8OHkFFBjn0Hfwjp
        e2xD0h3H1apdbHSyIF++ncCLIhTIswzT3A==
X-Google-Smtp-Source: APXvYqxqffnDkxG9M65OGWfltXuU1gnJ7LKfol3TlQRN/9OZh/LC3gDhhik8C1KMNChtRxbOE9lVRw==
X-Received: by 2002:a1c:4384:: with SMTP id q126mr9000036wma.153.1569609842442;
        Fri, 27 Sep 2019 11:44:02 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:44:01 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 6/7] arm64: dts: amlogic: g12b: add cooling properties
Date:   Fri, 27 Sep 2019 20:43:51 +0200
Message-Id: <20190927184352.28759-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927184352.28759-1-glaroque@baylibre.com>
References: <20190927184352.28759-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing #colling-cells field for G12B SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
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

