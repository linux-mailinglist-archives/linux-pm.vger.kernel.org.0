Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A063CC564
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhGQS0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhGQS0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78FC0613E1;
        Sat, 17 Jul 2021 11:23:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s13so113929lfi.12;
        Sat, 17 Jul 2021 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhtGFKsHUzTaL2MCRyNEETLxWQghXk5mgR3qIkfiMRo=;
        b=Gg1diUprWAc2cZdVHQx9WoS1B1Ow8Z6j8TYp/Syk+Vg8KxAR2Uz1vYgh5TMs6CsePI
         OPRKKnRdb73OuhHHABSo4QtQKvBtPHNyPMCDnliytMhEGp90S2YxoW/3xc4eCxQ30dPG
         ZqupQYCkPz0ydqkALLSL50V3XEtFNElGapG1Gd/JP8vXDtCo2F3Ah86Q7GQGlscyHCBU
         8XNgOCP9vpVqbUIvSU0L76mKpt5adxtW/ejJjhc35Hs0qlQ/7/ef3W+7rWXqFHPgAP/s
         jUKAFZ7//0g0CwYNefNDAIcevqpeRuHM1z6wHx9HLNNwM03yynjv1dYnwv4JFJjxzE2D
         wBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhtGFKsHUzTaL2MCRyNEETLxWQghXk5mgR3qIkfiMRo=;
        b=evS+CYNDH6hGEU7fSm5VfiZgFWxEw6A9M5oIc/6HY8s9D8+7ZVi7bL95RrenSEhUMF
         Y3gfFx7eQEl4HnYoAnf4scUWUHSH6IWJBBvL2LW6EZaIcj/N85/7O1zmm2pPOcWujgc1
         Jm520octtPcVGq4wT2HSnhxJDa6qnL43SD7HbznpkZy1AS1J980GG+tD2X+v84Xvi8o1
         esExSZSltQ3OUE4DTITOTeXUkEmV39QclaiFLi+dPRXr8ImBHoSvGxuWjqaqvM1h441F
         eTWRQ/Apo7gsnMCDVZ5BW0QeYJoKwn14xypNwRz2OsP935hlarLd1jF6Y4HrOHrRWeIj
         WDlQ==
X-Gm-Message-State: AOAM530ht2s3zXL8AfwO2ElpVWVujLAtxtQxn5oKE7UZPkFVDQfBbQr4
        p3En7wvgOMi+dvkueiEBxmc=
X-Google-Smtp-Source: ABdhPJwDYGsO2a8K+7QLiUFVN9dM4bo/qtFUTx5RxuTAoLWALSfmJFbFs1uk2NfD59eYCpsQEmygZA==
X-Received: by 2002:a19:6a09:: with SMTP id u9mr12345853lfu.119.1626546190562;
        Sat, 17 Jul 2021 11:23:10 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:10 -0700 (PDT)
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
Subject: [PATCH v5 11/12] ARM: tegra: nexus7: Enable USB OTG mode
Date:   Sat, 17 Jul 2021 21:21:33 +0300
Message-Id: <20210717182134.30262-12-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
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
index 4f116c26f6ce..798ac22a50d2 100644
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
2.32.0

