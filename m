Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3129098743
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfHUWYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 18:24:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbfHUWY3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 18:24:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id c5so3505141wmb.5
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNEVJNmyyHrsV6A+ZpoAhZq6Wlxyq2Rn2IfeLizyW5M=;
        b=RmAQt0yrk4yeu8kHxu/ofDAzx+2cZEAdXYgfQpVRpzX8n+bKfVdHMRgTXXwQI5Vsp+
         z7/jDTXj1cY7aS1BFV3pDZPhCEB6zBkXuYpZXMq0P3/+WyAI6ypnOPtrOXb+1CvyLAz3
         6dyE7riK+GIKQijiJ3Rz+VM1K+xOhtwHY/xDnrMckeDGRbBLfWKZB2vR4ezsaxmNgKfo
         zM6I2ZzMRxgRGDbRcsquifk7qo/iHXbusGPEj2IcD0H8/+Hno7lVvO6koZCH/cE/bVj0
         BND/kPghyoQwXYDSp9XXs3BcfVeXnMUZb3hY2HW9SyC7tLmsItkw6pOLSLACjpOqq5mA
         qbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNEVJNmyyHrsV6A+ZpoAhZq6Wlxyq2Rn2IfeLizyW5M=;
        b=A7+6qAjSzXx2POxlpr1C0e+pjn6unyGN3/QrUiZpd39yU81Pc9LpI+PRmstUwZQCfa
         7KAyA/a6L11yQRYBHol5v6MFedPbg4XXD+OehyN7keXOthmA5NmQway8hl4Ge5pninQD
         Q6+F9vSbr/GZ2ZTcHdHcN+n19+8MhaolcON7inV2So1xvcyvMxAsMyjXxHTkSqxemV2s
         WYbR01yuPhmpS14pXnwKYzX1Wp8fRyS43FqiJ4GDTohCelCqUlbtlX2ABPeSuuBxzm1P
         KpHM72gYC4RJtbMJK3/WuynWPt+pk5tK09BFjUffAEPX4shwMhNMhW+hqTlJ5U1WUHWT
         /w9A==
X-Gm-Message-State: APjAAAW1/f1/kAspDVVEkOckQYylRnhheAv07XKO+VO477sZwrDjdptQ
        o/ujYDJpR3Amnl86hFwDLBTOJQ==
X-Google-Smtp-Source: APXvYqzutcbJ1b6zo56rETKZr1zpTfUALmnpdpQJw6EUBhIgUTQ10movHoix6xnpijh+pYUNRfaXDw==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr2507957wmf.14.1566426267351;
        Wed, 21 Aug 2019 15:24:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:26 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 3/6] arm64: dts: amlogic: g12: add temperature sensor
Date:   Thu, 22 Aug 2019 00:24:18 +0200
Message-Id: <20190821222421.30242-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 06e186ca41e3..ce13c7c2e454 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1353,6 +1353,26 @@
 				};
 			};
 
+			cpu_temp: temperature-sensor@34800 {
+				compatible = "amlogic,g12a-cpu-thermal",
+					     "amlogic,g12a-thermal";
+				reg = <0x0 0x34800 0x0 0x50>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
+			ddr_temp: temperature-sensor@34c00 {
+				compatible = "amlogic,g12a-ddr-thermal",
+					     "amlogic,g12a-thermal";
+				reg = <0x0 0x34c00 0x0 0x50>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc CLKID_TS>;
+				#thermal-sensor-cells = <0>;
+				amlogic,ao-secure = <&sec_AO>;
+			};
+
 			usb2_phy0: phy@36000 {
 				compatible = "amlogic,g12a-usb2-phy";
 				reg = <0x0 0x36000 0x0 0x2000>;
-- 
2.17.1

