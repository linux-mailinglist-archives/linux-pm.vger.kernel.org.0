Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111213BAF8A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGDW6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhGDW6p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97AC061762;
        Sun,  4 Jul 2021 15:56:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a18so29014306lfs.10;
        Sun, 04 Jul 2021 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CprPsljGfJINSjUaFKpwR1cBTW9eXDDrny1kL+eGkO0=;
        b=YiGtbhFjGjTNfepsJaZv/2FPU83EEhlAYzT07Hma7HroErkfGVzPEWWxYkUtRhpDpE
         mkhpYJlzk7K1rFU1IAFIPsz1dI+YstOsbRXMNXnEgECGBksnDIfvU0QXM2UtSCJ52iwc
         hf4IsHc+dY0y8rxZPJNGogEcXbNOwdHGS+puZe2BGjSGwhEVM2YviPdBwQcVOjM5mQuC
         kwU+FEXwvNdyiIc7d97rzaJDd6dLX0ODEmIcuc0ezmfCIJHDngCndaPBBLlmeDI3SfNV
         IZH+k8S/sU1uS/oBKTuujw3Gw7dIfEuk951XxTrl86liC0mq1D2cJjApAkIBWb/BXT5/
         pDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CprPsljGfJINSjUaFKpwR1cBTW9eXDDrny1kL+eGkO0=;
        b=egBmi9HsF0bxphRjYMj7J+2jJXuOjoQIPsDTqTFi6bvL7vboThcEGKrGVzpRsqj7Ph
         eg2Vyw5oejLafZ4kLWVo97t7zqRJpeUPdG5DT+EPDQmFOUspTwDVTRILLqsAteKqU7jd
         eijLOfqo4GY35VCVsWouxDIAftBbZ0pZCvQWkfgDYbuzW6pVtb84gNdVCl1Uqy8iLXVE
         Nu0kiHAAoSYuqvcM75dltqbyCgJrpLWoi8Io+C7ADVxmfjbhNzoLnZlSV6tycolavR/Y
         QZ83zHYLu0dANxkZYQadifU4BIgJrJr+we0g3LguoplwNHxWPkKqoo19iz1TX/obM0U2
         RFGw==
X-Gm-Message-State: AOAM531D5DTZCLcWOaK3M3i34IXSZcilgIXEwaHhioMsCUQw033AISPd
        aZ5aJ56WQkwxmu+AVEAs8TQ=
X-Google-Smtp-Source: ABdhPJzk8jXoCG1nspRLX8ZsW5ridyiawFZ8mt3kZFDU6DTf0HrCxDR072JlXlE5MOkfwVOcauv8Ig==
X-Received: by 2002:a19:86c1:: with SMTP id i184mr8630353lfd.320.1625439367302;
        Sun, 04 Jul 2021 15:56:07 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:07 -0700 (PDT)
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
Subject: [PATCH v3 10/12] arm64: tegra132: Add new properties to USB PHY device-tree node
Date:   Mon,  5 Jul 2021 01:54:31 +0300
Message-Id: <20210704225433.32029-11-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
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
2.32.0

