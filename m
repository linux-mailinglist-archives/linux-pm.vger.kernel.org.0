Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECCB3B9991
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhGAXqe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbhGAXqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B81C061764;
        Thu,  1 Jul 2021 16:44:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so14928405lfk.2;
        Thu, 01 Jul 2021 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+unlqaajKL+UdtGKZaBkJ1mKCovLdUju0d1rygjTQhE=;
        b=iniODsK0ILiq3O7K8T4TiBZfT1PmucBVW8O4a4XrldImMkT/pH4rdIMZIv/rnxaN6Z
         8cT2qoUxV9l503ixbCNjxRirhsRrtswiTtSuHCIAxYIJ1XfrDkbltoShIbuSykqsUS/J
         E0IlVVoa4cxI/QYpsHs0gDycrLyXBBQCV+aikY32FsoGWQiWlFfuITJrvlgdRJCJwahi
         ArIWDg5j4wtNgMuRU3fP2TBvGPz/yXIB8DXycKo9wzYsGfChzy1v2N94bQSUlMCJA0EI
         nMmqUc92KwEBElSIL1XNQoat3rkpdsjKrXNYKZm7hi7FZ+JT8LKNzW8gmjI5ZO5NHPwC
         s8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+unlqaajKL+UdtGKZaBkJ1mKCovLdUju0d1rygjTQhE=;
        b=rsC8BjKFc/U1jyhFts07+g+tAQ1DgnLTqgzq4lSEHuCAof3f90Lr+52M/0xe2Ys+Jc
         5olN06WaOqXI8Xxu99psV31E3pMNLb8mbxl4k8wL9heKANu4OJcgD7bJdN7g1LXHOXF/
         VMfV3eSQL54WyYH0AEVuS7XpNTMcMfcmyN3DMynAoR1lDnzjBgOw/hnTUkdI+8riWP71
         AMGinjSl+jaQmrDK/qUmHIn1GvX8M0O6W8LfUR9ySAC2Bk8hMrQDcSFjq5gTn6zHDbrx
         HTJjS0ZYRve9WPmqRf+4OlHHRaZm0bHdK/oZD6fCVgwFpbAe3Sk2b1n8Ra3WSrL9VrYh
         v0GA==
X-Gm-Message-State: AOAM5328paSS2HR0GJb8w9KSo7kuWSnD88OVwO+Ws0jaEcjotaGUYUea
        JEq5F37Ku8YNKBqBg6xDHHY=
X-Google-Smtp-Source: ABdhPJyzCGwhxPL7ezuvAI2EmCZef0N2hJNcfbkPSe8ZUsqC4JKcehVh34cy4nu0b/W+JkVQGFe4Gg==
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr1570723lfq.355.1625183039264;
        Thu, 01 Jul 2021 16:43:59 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:58 -0700 (PDT)
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
Subject: [PATCH v2 12/12] ARM: tegra: nexus7: Enable USB OTG mode
Date:   Fri,  2 Jul 2021 02:43:17 +0300
Message-Id: <20210701234317.26393-13-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
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

