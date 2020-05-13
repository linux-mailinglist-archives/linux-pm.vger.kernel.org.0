Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8E1D1412
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgEMNJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 09:09:07 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8530 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgEMNJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 09:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589375346; x=1620911346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6u3aV1QGFBSQ0eEelvtWAIoeOAC/vgh59tjbGFX/nI=;
  b=ZuTfzNh9LT3tZw4XmyeNXeo3B0Jm9Y9UMb2M02+3WCl3W54+/U0xGUCf
   q7F3O69E94jZ+Lr5hKXDsYoX2AXjJ8uLaF8hi7uOIN8Ny6W4Bp+LWd5OB
   BFS5WoXD3w6sPthg6KKdjQkP5XNx+tQQM0IMIAErndPzAqZaCkS8yxQee
   sgj3Nbr+egIdRe3CCgJ+GV+momDmfaADtev+XhTlp89DO8v1/qYko1ulv
   NmYOLqdoK+0tFLBMIVycol/ObT7bbuxkwHzVj5K/2XUKNyd8qHOypJ07G
   /8HU18o2nmdKr2ibnOALx7OqGjVfQHOU3q9PVSHTN4BDSZoPnpNNzQ0F0
   g==;
IronPort-SDR: ImLEDdl7AMnyivYjeyLG78XOm3QyPYMEALDQBIoV+dGm4URpVcSdVUf1Di9smzsXclhJWybcZt
 hyHSlC0YFvP7ByXUfKY3xCO49Kqm4ofDJtsn5FeIE5mgVz4zEiZxHL6GhtE6A2rnI9eT2L+g+F
 A2A9TEE60W4trAvOZYGBRV0hoCzrAcRsY4rnuN9mZMgRsSdM6/8fzl4J7aarXou6YVWs5jNzLS
 wNa027v3HdODTTeZMgL/4aE1iA4fm+RoxOjiHQlLmL7j5SZ8xJzJUDsvZH2HRTNaexnh5cFqVs
 MYs=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="75134448"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:09:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:09:06 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:09:04 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/5] arm64: dts: sparx5: Add reset support
Date:   Wed, 13 May 2020 15:08:42 +0200
Message-ID: <20200513130842.24847-6-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513130842.24847-1-lars.povlsen@microchip.com>
References: <20200513130842.24847-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds reset support to the Sparx5 SoC

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index b5cb3d8dc876b..3e94ac9e7dd51 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -106,6 +106,17 @@ gic: interrupt-controller@600300000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		cpu_ctrl: syscon@600000000 {
+			compatible = "microchip,sparx5-cpu-syscon", "syscon";
+			reg = <0x6 0x00000000 0xd0>;
+		};
+
+		reset@611010008 {
+			compatible = "microchip,sparx5-chip-reset";
+			reg = <0x6 0x11010008 0x4>;
+			microchip,reset-switch-core;
+		};
+
 		uart0: serial@600100000 {
 			pinctrl-0 = <&uart_pins>;
 			pinctrl-names = "default";
-- 
2.26.2

