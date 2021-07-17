Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1643CC318
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhGQMOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhGQMOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F32C061765;
        Sat, 17 Jul 2021 05:11:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s17so7215800ljo.12;
        Sat, 17 Jul 2021 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7SaHURNXyUBjsQfPYlKAP5ckfuIlCfIy3J3ukz+tBo=;
        b=MPGGjtky5B1QjVnHzZk2Y9tZ5eRCeZDogYDcIrAFBSqneLBpI8uAdKFMV7hnIhZto3
         E4qBBrXTSPk5xSpwWbVo6MiNItgc2UZYRxIWFqDsSLemUgVAMoGxrYHDk3VDQ3EscKRH
         FgyOnn6ktqiSkzDNpfiMVPl3keAxC0MZmXj6hdMaEwwI6TolCQjn0r7xl6MkcdDLN4Hg
         WBgP6pnhnxt3Z4Jpbpn0z04p0FD+WSaWs3dx1MXMCOVAoJ8H5+Bb1shLSjIKv3Q5I7Kt
         QkepzB5OD1Or6iTNdaqwFPiqa4i1t45nXCV75WlaPX1xQPY7Qn0Eff9sqstZlvQhxbhB
         TS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7SaHURNXyUBjsQfPYlKAP5ckfuIlCfIy3J3ukz+tBo=;
        b=kVnphTkLoXxK1KO2fuQDadONZW48G1ZNpWgSAdfj+b9C796+U9AbQXJgt344bPpLfW
         3ghr8JMVNluB+SwbW8FskgeUTTIpZA2b6sViGtsWzOlOz8FgkkrNdp/iC1i7GdfGqQt8
         /VsM6GG3vnMHNT1R04vlk2+m4Y/KUetEpfD8LgHdX8mDEswpUAMbOvERFqI+AnnEvIoV
         D3n30+JB/9bcs3kiaClhFOZiO/4mjlDN/alohOmOjdljZ9ySrvwdwcupFCOG8yMHrb1D
         UlaUNQU7Civ2n/JsfHA2IugF+FELwZHThy6aL6WGDeozduLonBnPa2c3C/tJfpx5d5R7
         bx2g==
X-Gm-Message-State: AOAM53369tH3XJ0x0alDWFGYqDqsGREkNZ+9zWEzVrmZAjAq+y9kWThM
        hubgE5eN5Dr4XuBVPj8ybwM=
X-Google-Smtp-Source: ABdhPJwLtaMqw1TRvMbCm3ekqLeX8D0ZjgQWdCO0U6IJvKNwbj5hgc5XsS0cTxgG7iyGadGOL43arw==
X-Received: by 2002:a05:651c:896:: with SMTP id d22mr13758314ljq.242.1626523895793;
        Sat, 17 Jul 2021 05:11:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:35 -0700 (PDT)
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
Subject: [PATCH v4 12/12] arm64: tegra132: Add new properties to USB PHY device-tree node
Date:   Sat, 17 Jul 2021 15:11:12 +0300
Message-Id: <20210717121112.3248-13-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

