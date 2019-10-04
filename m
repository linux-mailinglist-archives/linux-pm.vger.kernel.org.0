Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C38CB6DC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbfJDJBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:01:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388129AbfJDJBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:01:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so5331232wrq.10
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhXs6wUTS9va5GBBPxgaGywhOz0cCImkUJC6MQ6iTnU=;
        b=JfzUU/55kQq5nD+ZLn3bLOI0F2/3jkG6qDmgUNVl1g7jdDYai2si2/JGxcZAIkjIvL
         wYoroINmrbRvQI8o02a5ng5aZPBf6AMNSCbIt2lxZMUdFy1aQewhJ6abmtICuikfg+TO
         rUr+Lml6iaUznsO5dMUSIoVB46b7426KBe3J12sx6HORU9Aqr8lsnU899mjeEXFX4bRr
         7Ww5+jvRb/Oev2fiMRcYrLfA1AFZbKN0VUdO8ssCPkS8qNACthwlVDV0R9gDcSjG2Tmn
         5XdCEsBflBo+3vnU87piw5PS0ihoDaUb9/JjfKErcxKBB6mLCPm9aNI8gPPYheqrby5B
         VRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hhXs6wUTS9va5GBBPxgaGywhOz0cCImkUJC6MQ6iTnU=;
        b=Sf5Frd2Wwj0s23CyXo7aF7TdMMMxpF7dxVB56HsaYYOq8uVJxIKK0Ym0Jd0dhQagY3
         cE6sk+OuzsbhZHBSJxL0knRTOS5D9fig0U1CE3OC7E+a1Fno8GmNXUiewp7ySjiL/tCw
         WGJUf3npWACSvfOedYKBnBHbq4EysahSN3Sna7YcT6gE0UhABVz71uz6jo1x1GLEzW0r
         KmsN0JX89u31SFs8/+vK/619HDEDKB0duh/HFxT55C/D8UTcBX1zfsWZfdmjzM66hO42
         enUEVnXa0skqoSbqwx9iwvOVucjs3oqq4bx5oTKfLyPRk7PtrqkfAE7h44QNTUgYIEbN
         Zw6w==
X-Gm-Message-State: APjAAAVd3fMljM3hxfMaAPYsjTVrPXCx7n5dTXvQEWsAOOBPboRbVCzJ
        xg2bc5hUrp9HgqAflX+Q0f5ZtQ==
X-Google-Smtp-Source: APXvYqx3ANd3JSC4dmn8iEi+vP/O2TkbdGEiwSZ7uKVt38ptoDgZ9MC6kne/ujlpccqO7cuphtXGFg==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr11388390wrn.16.1570179682980;
        Fri, 04 Oct 2019 02:01:22 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:22 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 5/7] arm64: dts: amlogic: g12a: add cooling properties
Date:   Fri,  4 Oct 2019 11:01:12 +0200
Message-Id: <20191004090114.30694-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing #colling-cells field for G12A SoC
Add cooling-map for passive and hot trip point

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

