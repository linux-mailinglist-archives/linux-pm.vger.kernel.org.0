Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AABCB6E4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfJDJBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:01:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50821 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388021AbfJDJBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:01:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so4966775wmg.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U5+Cq6R9X8Ufmg5BHS6gLuKOFiO9TF8ekxmK0Vlflyo=;
        b=viPQ8tCIuO7ifXLvNehlr170Hq0zRhmeOFrDlSW18zUQ5/HH6olShlD6ANOlc4C/vY
         kU+qPChmbAcsbdcDid5YvQRbwpIQ/F253wo7GyfaTLtU2O99Y9XaN7359UKyFVHpU32q
         nKPuj81jP6TMBVySWqi34lgjfNKZaXCClyjw8xigwf3lDiSV4Fe4ww1QKXrR7eAqokMC
         BbwHnam7DBMqgwrDBBafgCPmGvY88qoJb4FsRw2N42Q5hEdkw9L0C95aV6jS6Q1D7Vq/
         1Iwh6bXTp2lhXvBFETZztO/oRRWDsvDXevuT+lZLzsZgA5PfkvfkHly2/hI34UG1NePl
         HScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U5+Cq6R9X8Ufmg5BHS6gLuKOFiO9TF8ekxmK0Vlflyo=;
        b=bxvmoZm+ivPqI8tQyle89bWGbSWF1O4oIN0TJ2JejUdxsSZjV0nYCVWDpO4sJnXUoJ
         ohTW35y2TrkN9wuwio321k9121ROTLmuEsSUYczkTDmJMZJD8VY0Aun6d5pFbdueLkAF
         I9c/BHOEJ6zfJ1+ON9uy0p+03hiyCX7UID5gMnYeZHLdhVb7C7+8mfeych4Jq6lgIOl7
         J4czu/wOqeAYgSHHlLXFM0Tdc0qs6wVDXLS6ZlcoSj5yf9vr9eNxlHkKhNKcfZOugtuP
         Ekmrc66j6fqXJVKNJCHZBKOpoZEiFUs7tqfSMm9B95EIfvQbFY2QJgA/41G7ntVPESZF
         rcgQ==
X-Gm-Message-State: APjAAAVCEEoHQEDzkqM1yupzH0zGQQN734iwF/cXjqf6yeXVsrCDFr+F
        VEoblp+F1KJzbQ6F10l23JvTwg==
X-Google-Smtp-Source: APXvYqx9RmbwsTK8Iq4RgR8Gbz/TiRWN/uUkE7o5hGA2Hoy7bdPG4yIVs2IxmPHUV9GF3MTE7XKdGw==
X-Received: by 2002:a1c:ed02:: with SMTP id l2mr9784178wmh.155.1570179680626;
        Fri, 04 Oct 2019 02:01:20 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:19 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 3/7] arm64: dts: amlogic: g12: add temperature sensor
Date:   Fri,  4 Oct 2019 11:01:10 +0200
Message-Id: <20191004090114.30694-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add cpu and ddr temperature sensors for G12 Socs

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 38d70ce1cfc7..0660d9ef6a86 100644
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

