Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421D73B8C4E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhGAC1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbhGAC1Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0992C061756;
        Wed, 30 Jun 2021 19:24:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d16so8908492lfn.3;
        Wed, 30 Jun 2021 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+unlqaajKL+UdtGKZaBkJ1mKCovLdUju0d1rygjTQhE=;
        b=U1f0aL/dsUy1ATWelleHa9rQI5g5jUd+AjxgB+5npU89mZoHOugUN9T8DmQYDgH2Fj
         kStJ7b9KyuFRYJz2MBMIuUpUM3grAkr54sQTsh9+LRK3pM//wzAes2cyf+7Va/VR018D
         TSP2lfHHwTbSU0GZuKGAMHgKTYyIIdIIXF9AzaKs/a39+t88PppneFd3Zjf4O79jIqXA
         liDnW4775e3NagthQAIG2LrcRstkYCOLMWibKxb3BQNuk0RxdVtzqbiF0mgPUkJh+lDb
         G55QTWZ7bQQahv/H4POlpzSHfCakKQh3ooCbCESlktHCEv1s0FiET4i+LrJduqrGOwad
         sebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+unlqaajKL+UdtGKZaBkJ1mKCovLdUju0d1rygjTQhE=;
        b=naCpQgXejg51j8iIFY+NRL6KEUaL35hc+eS7GxlUTbK+olXJbuKy8D12R4G8ts8IiH
         UxIZlUa/aUC8TxY+ul8hDxExBYjf4NGMK7J1eh0InzkAL8ub5NwyzunhLI2IqwjzNHvw
         CRNYYDYkagl4TYw3HnJL1SfAW/UZov0cIMxLFQvJIPhCwyZMMTFr6OlEPZJ65g+/u0zB
         aC7z0zFIBfnhdEYxEJeqQnQ7I7mCQlS5kObGaTaZ7O2xpDjW7/a2OF3EjUm08yMc4zGt
         InfvGkMB6P1GOsRIHmyEqRe38hhRxsaq1CoWMIcJUfHJMOFpXieL9GbDEoSfhjqphSI/
         06Gg==
X-Gm-Message-State: AOAM531NoHgQw8BxVy0fJz+yJVoEx2+g/KzVvWSHPXV07K+VL2FwNmdB
        yBWTUkUPYwPoaO//CyWN3So=
X-Google-Smtp-Source: ABdhPJwRFghxwlHjwBfKGp6n4gvKiwCuXQ94+KGQ/Dq0axXpCaFiWVoPodkv6TpT22lTa+8o/SercQ==
X-Received: by 2002:a05:6512:1048:: with SMTP id c8mr29229001lfb.480.1625106293053;
        Wed, 30 Jun 2021 19:24:53 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 12/12] ARM: tegra: nexus7: Enable USB OTG mode
Date:   Thu,  1 Jul 2021 05:24:05 +0300
Message-Id: <20210701022405.10817-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nexus 7 has OTG-cable microUSB port, enable OTG mode. USB peripheral
devices now can be connected to Nexus 7 using OTG adapter, switching
USB port into host mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 8bc552b09672..c341e8971b2f 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -941,9 +941,29 @@ power_supply: charger@6a {
 			interrupts = <TEGRA_GPIO(V, 1) IRQ_TYPE_EDGE_BOTH>;
 
 			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_PIN_ACTIVE_LOW>;
+			summit,inok-polarity = <SMB3XX_SYSOK_INOK_ACTIVE_LOW>;
 			summit,enable-usb-charging;
 
 			monitored-battery = <&battery_cell>;
+
+			usb_vbus: usb-vbus {
+				regulator-name = "usb_vbus";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-min-microamp = <750000>;
+				regulator-max-microamp = <750000>;
+
+				/*
+				 * SMB347 INOK input pin is connected to PMIC's
+				 * ACOK output, which is fixed to ACTIVE_LOW as
+				 * long as battery voltage is in a good range.
+				 *
+				 * Active INOK disables SMB347 output, so polarity
+				 * needs to be toggled when we want to get the
+				 * output.
+				 */
+				summit,needs-inok-toggle;
+			};
 		};
 	};
 
@@ -1017,12 +1037,13 @@ sdmmc4: mmc@78000600 {
 	usb@7d000000 {
 		compatible = "nvidia,tegra30-udc";
 		status = "okay";
-		dr_mode = "peripheral";
+		dr_mode = "otg";
+		vbus-supply = <&usb_vbus>;
 	};
 
 	usb-phy@7d000000 {
 		status = "okay";
-		dr_mode = "peripheral";
+		dr_mode = "otg";
 		nvidia,hssync-start-delay = <0>;
 		nvidia,xcvr-lsfslew = <2>;
 		nvidia,xcvr-lsrslew = <2>;
-- 
2.30.2

