Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073D03CC312
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhGQMOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhGQMOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D86C06175F;
        Sat, 17 Jul 2021 05:11:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x25so20567372lfu.13;
        Sat, 17 Jul 2021 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhtGFKsHUzTaL2MCRyNEETLxWQghXk5mgR3qIkfiMRo=;
        b=Pyf+duse+B325RhIuZ6bn5vcs4z/uDq91/4eJysesxl4YEdzytnTQCe+tonw9LdF8z
         EJc3FBd/5KPLL4vCskkamJDpKISTa8me6Ym41Ztgcs0RbATyBR5/ejNz7uqNMPbSsoxr
         fRWoolCjQq3OKdCcC4nFFJLW1HbOwIFkgKGJWzxIP9lmr/nbsmj7/j9scLqK/i4KNjBi
         ELMrU5Cnm++H58kWnoaYq/O8hUhqcVNsecqFRx743UjW8NFcvnVlZS84D4YiSNF/r3H1
         SfVI2K4w4Go1R+MyUSa4CyL8NLkQlK6aGoqg5AKC9afeN08ER7jEUEgtfYMhlWrkcWe1
         Atpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhtGFKsHUzTaL2MCRyNEETLxWQghXk5mgR3qIkfiMRo=;
        b=aR4KWXXK4+N3Rew1sQh8WyE85xf2IvXPuZbL31j4Ao1yXiRlfyCPncESTZQThD92A/
         HfZmP+i1XoxUT6jQ3Du1bxZbweIKe0vlpTCHko0q+44YigK1H1nG5dW2eoY+lNpDWEkr
         MaOU7yYg5NIsHvGKsD6+nXgi9c2MGdk18WM3kQEfpYRvlvQe0yMiIiTy709JWY5U0RvP
         ZUX2AoRAEHV8UU88YUf6qJK0Gd8jMobRbU+u+CPUh8RtNupG+Wv4s5WUPP3j/Yfu0PLD
         ZWn48HNcxTZ/dDHDlDKO7yWV216mE5ZnGMkgXaxJLKIunpphHJJUIJX0Gk14CWrKamrv
         ko+g==
X-Gm-Message-State: AOAM531qCmLrtah6oiaacnpQbsWVfQhgDgnWSK493nEB7U4HOP+skM3B
        JygCSOLnqf9CrkA5CqHJdA0=
X-Google-Smtp-Source: ABdhPJx1qT5F1hsh8G/3nFguyAr/P4fsjXEl16/uHxhXsiJFSR3jFtISsrodmcHvZiR8eVuPf07+kQ==
X-Received: by 2002:ac2:5dec:: with SMTP id z12mr5714088lfq.310.1626523894971;
        Sat, 17 Jul 2021 05:11:34 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:34 -0700 (PDT)
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
Subject: [PATCH v4 11/12] ARM: tegra: nexus7: Enable USB OTG mode
Date:   Sat, 17 Jul 2021 15:11:11 +0300
Message-Id: <20210717121112.3248-12-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

