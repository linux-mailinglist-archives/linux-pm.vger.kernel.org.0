Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B3A15D237
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 07:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgBNGfJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 01:35:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48920 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgBNGfJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 01:35:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01E6Z0Im004806;
        Fri, 14 Feb 2020 00:35:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581662100;
        bh=80xh0h8pACz/IVpvrVTCly13JX92MOXmYJWMW+UciE4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dU7ylKx6Azf38JMbLPeW6nzVSOWTaHeXPJTU90CAA4RxXOreLehwgyHbKidp2P2h+
         vVaunrfmX+CFug4TvkVONQ0HJQc1X6vYY4eeMcNUsmm+p2VZnBYWryCgwrwm/1Eeap
         KIf0Qd3FsVl8KLSPdUv4WoU2ntf6bMPfgmItwvv8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01E6Z0Ns034018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Feb 2020 00:35:00 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 00:34:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 00:34:59 -0600
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E6YdP6028331;
        Fri, 14 Feb 2020 00:34:56 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: am6: Add VTM node
Date:   Fri, 14 Feb 2020 12:04:43 +0530
Message-ID: <20200214063443.23589-5-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214063443.23589-1-j-keerthy@ti.com>
References: <20200214063443.23589-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VTM stands for voltage and thermal management. Add the vtm node and
the associated thermal zones on the SoC.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index f4227e2743f2..e7ef96b621b3 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -89,4 +89,15 @@
 		clocks = <&k3_clks 59 0>;
 		clock-names = "gpio";
 	};
+
+	wkup_vtm0: wkup_vtm0@42050000 {
+		compatible = "ti,am654-vtm";
+		reg = <0x42050000 0x25c>;
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-am654-industrial-thermal.dtsi"
+	};
 };
-- 
2.17.1

