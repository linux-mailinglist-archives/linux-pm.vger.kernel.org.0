Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE124C0B85
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfI0So1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 14:44:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40564 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfI0SoD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 14:44:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so4312317wru.7
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bn1Yyb+y0E2XtXZ6uMo4FglNk7nmGiqm3716bVhGUbI=;
        b=takF3d8TQ23XIGxuLOV8EzoCgdq2Cx3gSbMfwoy8dm4JOeV1XPOcGDt36yHf/TI7T+
         FtbvWKEknxgAIutpiIolDXxparFuO4OfaK8AzTK97b0LKYe0SDv37m3nJ8nkhGqKqX+l
         ajQyWxbLHv32CSr7pUKgba6XKx+DcFNKw1+DFc6ufE+etxrYBfXlb+f4nP8LZ1bOapM/
         NC8bBmCjPgyuLG2UVTsEA2vzrupBytvvOiKvTboLnyCM6wxZJX1jMAWJU3qpS097AxuV
         yLpcWtGm7n+t1ZhZedjLWOVxe+aXapZhHwoYnea03QmYlH7hDqjSMG/eA+/c/ixE0Ogp
         3jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bn1Yyb+y0E2XtXZ6uMo4FglNk7nmGiqm3716bVhGUbI=;
        b=iaqSIHVSFmCR+oeCZeZGQGgyFi3YmaX1kwjIoql8eLWWhQa/9E6HeQmkzx235IQqyH
         uNa0GGWC2ycN53w/ubqiyp1HPs3yn/9DvzV+rKJfPPzI2j9zRdJtu+UqaZKfTJ1RP3Yc
         QthpF4csL7Z+Qp6VLinSc8Y8QcOr0PGvbffix/T7GHJMCDQrJspkj5HoXC54cLA+aLp0
         Xd1Q2x+KT0LXKxrVFGM8UekCF/MYbtOmu/CWYGf8g7/LdNNx50JUaBFuct5jswom6fBj
         so2kA6C1G/hjnHPFZlhIeQls2nsWGCV4zvdoqN7YR++KUli94fp4knPJFcELooA2rvyj
         LxGg==
X-Gm-Message-State: APjAAAUKdMTeTs/QlE56hCQg26o1+Qc8jyHlLOK8OzUk8qcTHq7Qh2qD
        bWbcKRdJrrB1FN0Ueg+qrAKtIw==
X-Google-Smtp-Source: APXvYqwwmzGMJt5+RoC/OswzZ5EMENUYAm3d/ZFwKGTbNtLuc52z5Dcy/qT1fzKqYHzwCMtLhVptNg==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr4414380wrr.355.1569609841286;
        Fri, 27 Sep 2019 11:44:01 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:44:00 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 5/7] arm64: dts: amlogic: g12a: add cooling properties
Date:   Fri, 27 Sep 2019 20:43:50 +0200
Message-Id: <20190927184352.28759-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927184352.28759-1-glaroque@baylibre.com>
References: <20190927184352.28759-1-glaroque@baylibre.com>
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

