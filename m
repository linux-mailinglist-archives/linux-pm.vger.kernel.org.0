Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B85318973B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 09:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgCRIaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 04:30:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36114 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgCRIaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 04:30:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02I8UjQt041090;
        Wed, 18 Mar 2020 03:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584520245;
        bh=fV9yPr0b7SrHBE3GyD+MrAKcyMNE/+5Bvz6TvlvJFcA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VTZJnlaVB8IZoKUSb4BLXJG5VX4kvH8URvWkWcKY6eZhDKDZM9Yt/5hN8BAW6g/SA
         R3WzqsE/wRhenjUoCoGnjscXL0+NUk90cDz9PTz7Ezcj7UWzggWfrqkiTxa7aAhOvd
         6Ci1uIX+QixsyRrwiLXY/LJWK1xFmOz18SiQIRGE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02I8Uj5G033893
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Mar 2020 03:30:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 03:30:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 03:30:44 -0500
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02I8UQ8I108598;
        Wed, 18 Mar 2020 03:30:41 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [RESEND PATCH v4 4/4] arm64: dts: ti: am6: Add VTM node
Date:   Wed, 18 Mar 2020 14:00:28 +0530
Message-ID: <20200318083028.9984-5-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318083028.9984-1-j-keerthy@ti.com>
References: <20200318083028.9984-1-j-keerthy@ti.com>
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
+	vtm: thermal@42050000 {
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

