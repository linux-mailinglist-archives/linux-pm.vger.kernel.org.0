Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AB244094
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHMVeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHMVen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CD3C061383;
        Thu, 13 Aug 2020 14:34:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so7779026ljc.8;
        Thu, 13 Aug 2020 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NW2Q8QyAC78Di/n3r7tUYO+X21vGGqNAbxETdGTQ/s4=;
        b=ga1eSlCgNIQqjyKkNoHyFOMNd7eZ0bntSeuLg6psM+R2q/UKb/44fN51fnAbSwcJ7d
         B2pNAp6Bf3BKUNnROkJiwaJABK0vuZPsZ9BquV64IUq1sMlt4Cz/iViZvOEquEG/L51F
         T9RFJ+1n5UZly2+EOAVvUVVb2w0xz5r1IoTNg156/WrVJt/6DOpBmqurx7xcY+qCQ8XX
         SS5T1niE+cfqQVZEJ49ZP2PP8wnX4OpNnKHNxU2QndSMXrsM85a+E4SvxtU/pgzmhlMA
         gqQOJonOkjCrhkQ6/X5UTzOcUK4xqqSvK4UK3WqFu5BZUz0Y5ub8UJIW3jXtbjK7Yvde
         ZmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NW2Q8QyAC78Di/n3r7tUYO+X21vGGqNAbxETdGTQ/s4=;
        b=SghftJVaVW8VOd0g/E9fF9cn9hYZ4JSOV+Lvm1iW3SlauJheQPVRQqaRXhWRqis5J2
         2QXsYKQeC02Sfw8VMe1z/pgJPKziNQbbWJomdzEgta/KSbLPf2nyfPSweihLP48ACEMo
         bt3h1daghibT6a3/rF2RsGrgOe3rTUKS+mY8pGzrtolUyfpkZOeG6va4hj1cdkpDLt5T
         It/Q2+qq3e0GtdeBVdDifGaVLn0iYtGUpmeGSP7xQNEZaLfFGUV0SjF20nmgzvsRxW0V
         EYNlAsYIHTSRjBBayTX9UfG/lefDoMDnFMgjHcOAKwKTkvvTkQgKCv2jnlWbStJkw3IT
         t98Q==
X-Gm-Message-State: AOAM531iY1h4xAyMtT5n5NR39bYzPnJkthAVnieiq33XRPO/uFjzwP2k
        cvFk0tYtn1RqsQT5/7Y9oPg=
X-Google-Smtp-Source: ABdhPJxffWEq5zLwVT/WMICj481TkdoYo3I3X7+ZiyjNO7oBDSABTz3CnwcUNuBjRHK8KqBarUZtXQ==
X-Received: by 2002:a2e:9899:: with SMTP id b25mr2652637ljj.178.1597354481284;
        Thu, 13 Aug 2020 14:34:41 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 09/10] ARM: dts: qcom: apq8064-nexus7: Add SMB345 battery charger
Date:   Fri, 14 Aug 2020 00:34:08 +0300
Message-Id: <20200813213409.24222-10-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Add SMB345 charger node to Nexus 7 2013 DTS.
Proper charger configuration prevents battery from overcharging.

Original author: Vinay Simha BN <simhavcs@gmail.com>

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index a701d4bac320..0c126df20417 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -3,6 +3,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
 / {
 	model = "Asus Nexus7(flo)";
 	compatible = "asus,nexus7-flo", "qcom,apq8064";
@@ -56,6 +57,12 @@ volume_down {
 		};
 	};
 
+	battery_cell: battery-cell {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <1800000>;
+		operating-range-celsius = <0 45>;
+	};
+
 	soc {
 		rpm@108000 {
 			regulators {
@@ -296,8 +303,25 @@ eeprom@52 {
 				bq27541@55 {
 					compatible = "ti,bq27541";
 					reg = <0x55>;
+					power-supplies = <&power_supply>;
+					monitored-battery = <&battery_cell>;
 				};
 
+				power_supply: charger@6a {
+					compatible = "summit,smb345";
+					reg = <0x6a>;
+
+					interrupt-parent = <&tlmm_pinmux>;
+					interrupts = <23 IRQ_TYPE_EDGE_BOTH>;
+
+					summit,chip-temperature-threshold-celsius = <110>;
+					summit,usb-current-limit-microamp = <500000>;
+					summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+					summit,enable-usb-charging;
+					summit,enable-otg-charging;
+
+					monitored-battery = <&battery_cell>;
+				};
 			};
 		};
 
-- 
2.27.0

