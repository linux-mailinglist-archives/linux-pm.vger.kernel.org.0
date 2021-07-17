Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833A83CC555
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhGQS0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhGQS0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23A4C061766;
        Sat, 17 Jul 2021 11:23:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g22so9691536lfu.0;
        Sat, 17 Jul 2021 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7SaHURNXyUBjsQfPYlKAP5ckfuIlCfIy3J3ukz+tBo=;
        b=SaXxFTfEqC7NQlicWHSd03MNyG0RY/znqNOu4rKxPWPMT0ZQh8EUVnKZA1kpZw7MYo
         gMmTSBmrOtbO70/O/pRvEBTehOafvb1TYOzBqqVvsfLUir6/g4T+ZhcHrnYqeVILHoU3
         kUqy8YrgPCwFY+AhW3jjdRmJStzEabxuBOJxG9S/qOTY0JW+VZxyeWmg9x+mlgrbVLgb
         A2ci7JvQXzeac1GoEq1MgO84reNM6bIURlghKdyH8cKX9I7kVktxW5p6wV+wP96TH49H
         nYjY5CrNc94G0uT2C8ibJc72V3BnwVZItcTepsUIE84a4FJfjFZRRtMSTNAKiePjd7vM
         7T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7SaHURNXyUBjsQfPYlKAP5ckfuIlCfIy3J3ukz+tBo=;
        b=C71Y+UavVW+qJIRegTWGIgVC7FxUUfRvtcQc9rFiEaRLW2gQDfJIE6UXRhwsIulYLV
         dvtjnHpoCGVSzA8CH6ySOiAIg+IpYmBuoRQKNYNPuLO7RuZmY84sTNcHe2w+3K2u38No
         VvBVzPoOdbf0icVmkZe2Oi8UJalJYDQoZ+JE2RToZa+MR7tjvW5JXHt1qhv2t18uLqNs
         OxiqW4oTRozE9/v2wSmtIWc4LiT80hzNsFB70dtoU+cgRzF1r9qT3p+wMRbS5ghins9e
         cxm4RWSC1KogNl4tvpToGakodc+YTtu5TTdbFovyRmTPp8TFeMIzG7fEGGTp/sNPrIy/
         lpDA==
X-Gm-Message-State: AOAM533HabSKwygI4zEUluc5O7qdfxwHuJEZ5s2YqoSmehyLSwNngg/O
        d60D5nq+wNlZb4M7jq66O0k=
X-Google-Smtp-Source: ABdhPJx6kt3p/8AdTmBN/YG3dBRZZZ/0Uc//D7ucLTcZ1BioGC5bY11m6kaP7JckoOWhwxwWmO47CA==
X-Received: by 2002:a05:6512:16a6:: with SMTP id bu38mr12308203lfb.92.1626546191314;
        Sat, 17 Jul 2021 11:23:11 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:11 -0700 (PDT)
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
Subject: [PATCH v5 12/12] arm64: tegra132: Add new properties to USB PHY device-tree node
Date:   Sat, 17 Jul 2021 21:21:34 +0300
Message-Id: <20210717182134.30262-13-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new properties to USB PHYs needed for enabling USB OTG mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 9928a87f593a..f79a66226457 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -1123,6 +1123,7 @@ phy1: usb-phy@7d000000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d000000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USBD>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1142,6 +1143,7 @@ phy1: usb-phy@7d000000 {
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc 0>;
 		status = "disabled";
 	};
 
@@ -1162,6 +1164,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d004000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB2>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1180,6 +1183,7 @@ phy2: usb-phy@7d004000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc 1>;
 		status = "disabled";
 	};
 
@@ -1200,6 +1204,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d008000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB3>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1218,6 +1223,7 @@ phy3: usb-phy@7d008000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc 2>;
 		status = "disabled";
 	};
 
-- 
2.32.0

