Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA423B998F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhGAXqd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhGAXqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41459C0613E2;
        Thu,  1 Jul 2021 16:43:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w11so10930571ljh.0;
        Thu, 01 Jul 2021 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1qDl3BGg6VpIYc8VXbw9H+0wY0xY/SOujcU5elyW2g=;
        b=cpICum/fxWscly74MyaLuOZYF4sKEDMY1fWtzY56jDGptCaUfSFTzlFErcduoAjTcL
         BjVHrNt2GsvnkNRMVmW1k9LmJUTf1LGuRlUJ/vf/LbIo/ssvKV4LjbXkUiwh9Ehpn/wk
         85x3eGg//aqP1bdrVHjoRGFY1hmLbnvQ95huQb8OLlsQw+rMa2qYgRarg2A9TDv/bG2V
         dTfUjjh4t6GkqTcJ+jeiBX2FLwUtxS58a0v/5KSKcWS65MKvkj10A9g0q44F/Smpee8W
         OFfoHpOkKh02MCMcYPKBAbrsTpPCOfyCdjLiHOh82NS/HbLBVaBzm5inbkbxhHDMj92L
         XU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1qDl3BGg6VpIYc8VXbw9H+0wY0xY/SOujcU5elyW2g=;
        b=NoDEUEYE2nnJoNH3id/6FV9uu6QSurPtpWbT5cLfkO8cU5H8qJT06l7W14XCc7ntAU
         dumFokJ6lRPs/TF+PfvvgXzlMLAQXj5bBYh4k1v+qS+ZYboXVOISLUopKX3gs8CpEY8/
         Z+4ZKsxD5KbSL/vResZzDB+/7/4fBrf54U5SLjMzbEsMQZn/FLWGxKYTUSFpGvwPXAtK
         A9ebHIn4bsFxBA5IFGjELTcFGjdQqcR3JzG/IJnkGrSDAD+EcqxBD+lFrZwlipPkWRCp
         jJwkAldrKUjPU+n5B8URxctEO7a53KDAzlT1OX+fkV5CnODQBkigD/8c3rvYZh+qRhb+
         YGFA==
X-Gm-Message-State: AOAM531ZlXq0Vgc5tHWutUv9+2plM9hep/7VMc8G1b2A0wc0azgxn+E2
        dLs4b66CWfPuIEj2RYrIVEU=
X-Google-Smtp-Source: ABdhPJw6RrwM3wb57uDPc8M68q1Viw3RuWVodVE2AQGhTG9micW585YzcYsOdlN+IYEPKlUsVVVv/w==
X-Received: by 2002:a2e:9806:: with SMTP id a6mr1508173ljj.498.1625183037684;
        Thu, 01 Jul 2021 16:43:57 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:57 -0700 (PDT)
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
Subject: [PATCH v2 10/12] arm64: tegra132: Add new properties to USB PHY device-tree node
Date:   Fri,  2 Jul 2021 02:43:15 +0300
Message-Id: <20210701234317.26393-11-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new properties to USB PHYs needed for enabling USB OTG mode.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 9928a87f593a..fa3bab8138f5 100644
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
@@ -1142,6 +1143,8 @@ phy1: usb-phy@7d000000 {
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
 		nvidia,has-utmi-pad-registers;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <0>;
 		status = "disabled";
 	};
 
@@ -1162,6 +1165,7 @@ phy2: usb-phy@7d004000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d004000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB2>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1180,6 +1184,8 @@ phy2: usb-phy@7d004000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <1>;
 		status = "disabled";
 	};
 
@@ -1200,6 +1206,7 @@ phy3: usb-phy@7d008000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x0 0x7d008000 0x0 0x4000>,
 		      <0x0 0x7d000000 0x0 0x4000>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB3>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -1218,6 +1225,8 @@ phy3: usb-phy@7d008000 {
 		nvidia,hssquelch-level = <2>;
 		nvidia,hsdiscon-level = <5>;
 		nvidia,xcvr-hsslew = <12>;
+		nvidia,pmc = <&tegra_pmc>;
+		nvidia,phy-instance = <2>;
 		status = "disabled";
 	};
 
-- 
2.30.2

