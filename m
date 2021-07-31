Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399673DC764
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhGaRjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhGaRjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC87C0617BD;
        Sat, 31 Jul 2021 10:39:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m13so24899993lfg.13;
        Sat, 31 Jul 2021 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7SaHURNXyUBjsQfPYlKAP5ckfuIlCfIy3J3ukz+tBo=;
        b=MQujzLlEnO36raJBMAT9fzpDdMWfWGz1uVH0Uu5hA9Xx1PD1KBkSvTCXaTZMVdczJB
         lPupngVIb+yocPz38kxOOSTCE2JuW4FRTpSclkb/trtdWTNtAjdVZjK51KeNSywI91rZ
         B2XbRpZVcZqDPgNRmOIIha3gZLsqf/W3CT5mbGXSqXgk98fLFSpdJY+VbOQIi6ZWLwgz
         hainLQYoyk/fmAg2fjkY90VcNOOYaX4en/B5cB1Pv0qO1Li9IiTIKBDa73v6gSJtlDk4
         XhSpd2nbbrhi4oQkM5PZVblNumQ//dq2x5BoewCUDF7XgCwaCcRoXbECCg5T+8LWFW4+
         JhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7SaHURNXyUBjsQfPYlKAP5ckfuIlCfIy3J3ukz+tBo=;
        b=X+p2iCkQ4eH2ELzeiK++M37yU8rKL9ZC7peved9rcbUNFPrgztXlmaYKteXsg3EgWP
         ROkqo64XyQQ+WCQRwQRh7Mw9hziKPfl0xW8JlhvoXZQVJn4EfG42LAkqoODYmtuXcm6/
         bjkMyqCxvN9qJa3FpJp/LlHkjRc3pX+fz8epmQMjf5T6vAoHb5n0qxddLWL8irSG0AZy
         fncW6C86nyYkQ2u9rC596oYDLP6WcgG3uFF7O3+4omuR53e5eCVE313MTt9IlHgblSqV
         eTKQ7Jjc9WEUilbpMfhdElYBrULD1LKL1LMEJ8Sz+SAmrVnDtz/pTRY+y28P65aSbiPz
         vGdg==
X-Gm-Message-State: AOAM531sWc7m8e8EMVGH+YhSvQYh0ks1VbwCtrG60oKcpWGy5vVmbTXA
        VFqhiS6T8a2XX8bGa1XSun8=
X-Google-Smtp-Source: ABdhPJzUMpYaCzhlyTvF2sPmwQ/o7m7NJzBlbqGXRAIBp7NvEr3VJpCMhBpsb2K0T7fhVbLfBds4Yg==
X-Received: by 2002:a05:6512:3ca6:: with SMTP id h38mr6292523lfv.94.1627753146135;
        Sat, 31 Jul 2021 10:39:06 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:39:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 12/12] arm64: tegra132: Add new properties to USB PHY device-tree node
Date:   Sat, 31 Jul 2021 20:38:42 +0300
Message-Id: <20210731173842.19643-13-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
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

