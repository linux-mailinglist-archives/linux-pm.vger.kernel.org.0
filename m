Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE83B8C30
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhGAC10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhGAC1Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DC8C0617AD;
        Wed, 30 Jun 2021 19:24:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w11so6257247ljh.0;
        Wed, 30 Jun 2021 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1qDl3BGg6VpIYc8VXbw9H+0wY0xY/SOujcU5elyW2g=;
        b=llyUKUEYLXfK/mvpYetmnxMfHkv7mjz9f0mVPWIEgvL/2TyVfXFWY1sbCwlyN9i5VM
         yAva91G58QPMCISifewL/KsAcAmbDuvt9z6CQer4+OKXJyhI9DdOJz0mUNBmxipfW7BH
         8vsAZtLI5VQGW4mjPn2OF0RI4qet9BAyO6u6ty3XAhmASDD7Mh0VCtYVB99KJvt/h2p1
         d9pwkvtIvjpKVt8ntzlx/ZqyLjegNwLTExxkO1oldV/8RrgJjLZJ6ESJGVmK63PbcJ3u
         a00wnjoP9EnWdTQTQEtmgv/jWMXnRrdXcYH4GWDtZC9pfwmJccuelBEMERGqslNTAnKd
         7QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1qDl3BGg6VpIYc8VXbw9H+0wY0xY/SOujcU5elyW2g=;
        b=NMOUiCgbRjJeIO/TtrMRl/f+F6hLf1AmWX9NKTA5aqdNp82SRph/HqGldK9yRjO7WM
         LUjA8gLg8pZkJk2T93+SPWy3IWgQEGIRiu4SBAi87jBZbaGr7ThI15605qaczcYnd886
         ShsC/iAWwgJhapdF4YQiYMFnAtiP9d1b185750OU7Lqa3Cdrus2si3VruQUWrqIOvH2L
         K8kUbOZIJ7iLUOIAVxyKDP1XStT+ipC/MsdbagOwAgYiBG5ZHv2qX5qUb4KzLUNnmPpd
         OEr/Xhdbf3KOsbV+XEJNDegS2QFfyD8ozaTUutWX3YHaeJ6D7TTWMYo2BYHfBuUk/lu4
         lhVQ==
X-Gm-Message-State: AOAM533bPjMqG+7yBd5cEO0Ben8HgSQvos8pb5dp0eBdMgx8hTdKCoUy
        uVrDZtmM6yi1WCDNpJUTB+NphyyyMfE=
X-Google-Smtp-Source: ABdhPJyWvfLD//V91ooz/zecvhztMt3jYPs5bNUMXL+gkyospPojtT2PVih0a57M8ka+x0hRncuLMw==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr10412300ljq.181.1625106291669;
        Wed, 30 Jun 2021 19:24:51 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:51 -0700 (PDT)
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
Subject: [PATCH v1 10/12] arm64: tegra132: Add new properties to USB PHY device-tree node
Date:   Thu,  1 Jul 2021 05:24:03 +0300
Message-Id: <20210701022405.10817-11-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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

