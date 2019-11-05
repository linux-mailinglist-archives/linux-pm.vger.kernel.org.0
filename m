Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7617EF3DD
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 04:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfKEDRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 22:17:34 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:52114 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfKEDRe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 22:17:34 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 38B1E6EF97;
        Tue,  5 Nov 2019 11:17:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5865T139886076045056S1572923844811932_;
        Tue, 05 Nov 2019 11:17:29 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <39eafcc51070a9bf90540959ec41f9dc>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     amit.kucheria@verdurent.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 3/3] ARM64: dts: rockchip: rk3308: add tsadc node
Date:   Tue,  5 Nov 2019 11:17:26 +0800
Message-Id: <1572923846-23310-4-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572923846-23310-1-git-send-email-zhangqing@rock-chips.com>
References: <1572923846-23310-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch add a tsadc device node for rk3308.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 8bdc66c62975..7023df31046d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -513,6 +513,26 @@
 		status = "disabled";
 	};
 
+	tsadc: tsadc@ff1f0000 {
+		compatible = "rockchip,rk3308-tsadc";
+		reg = <0x0 0xff1f0000 0x0 0x100>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		assigned-clocks = <&cru SCLK_TSADC>;
+		assigned-clock-rates = <50000>;
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&tsadc_otp_gpio>;
+		pinctrl-1 = <&tsadc_otp_gpio>;
+		pinctrl-2 = <&tsadc_otp_gpio>;
+		#thermal-sensor-cells = <1>;
+		rockchip,hw-tshut-temp = <120000>;
+		status = "disabled";
+	};
+
 	amba {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.1



