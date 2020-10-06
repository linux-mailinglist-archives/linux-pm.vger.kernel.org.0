Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910DE2852D5
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgJFUD5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 16:03:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59469 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFUD5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 16:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602014637; x=1633550637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFt8H3tiQdKJme5Ezi3eTjp27f810vgWER+RZvdSWz8=;
  b=J+Y9uXAgjSrkyL/AE7atUFLmeR9ZAyK3BI9xE69Q9RI2ocq3n7k+Kx2w
   nkgRAoINMNh+i9+9WfuZagEyGiPHTJJOZzKWZ3lRNbziw7jyeVYVLyRR4
   eh4q3Loe76Cs058MH0TSseR1nXm3nPVEMfTTL+i3OB8rgoae5uEHsWo3T
   gS0meaNzhD3iGmuCLdA/LbHKOX/HAIRXTtlWjTBX9V61xkjCYwPzQwadz
   McEwaGbajrcY4PTu5tKd4dhpq5oBS5KPeQGmwNhuFLFG51JHGaK+8EWxx
   QcpFDv6L6Ik6R3sOQF5k0n9/mFu84wmNfK929d7kaTuHbnzs5tSJK89Ra
   g==;
IronPort-SDR: HimIamFIHSYsKJWcbtGx7BoicFyTCArkf7FWTVPPuEgklbdtF6u+PMCgy2ODy3//eyMxYLeVGg
 q6k/fg70k4Co/DeLbJjKqboiQ7nLZIXxX53nGlsmwckgJqhnlVLgouLKTlQZ09k5cvklz1EfPU
 aaauVcXITegDQUR0Q0pb4iY440wqYmw7KAXf3ci0a+33UK33lknI2euLNrvfjSKpVv0gGDtWSW
 ZCVaiWNF/pM53W1/Fw2om+NsDQ19hw/YtfK4yD837YCLP1WYZQdWMceuFCLhkh50C+UUrvy+6k
 xcM=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="93635019"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 13:03:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 13:03:56 -0700
Received: from soft-dev10.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 6 Oct 2020 13:03:54 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/3] arm64: dts: sparx5: Add reset support
Date:   Tue, 6 Oct 2020 22:03:16 +0200
Message-ID: <20201006200316.2261245-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006200316.2261245-1-lars.povlsen@microchip.com>
References: <20201006200316.2261245-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds reset support to the Sparx5 SoC DT.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index a84ffd3069d4..016be6d27a6b 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -118,6 +118,16 @@ gic: interrupt-controller@600300000 {
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
+		};
+
 		uart0: serial@600100000 {
 			pinctrl-0 = <&uart_pins>;
 			pinctrl-names = "default";
--
2.25.1
