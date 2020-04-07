Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA31A06C1
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 07:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgDGFvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 01:51:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40118 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgDGFvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 01:51:43 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0375paDA057107;
        Tue, 7 Apr 2020 00:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586238696;
        bh=XlwAhj90g8grb5C9iPhm2dECmDg936udnuO9gnrpPck=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gulHNAR4uPpKKHVONl/11matpqIXbSPUauTPB+eTifK8tUavpjaMdOIFJg6xtbTM8
         XCKlOP+n1/SwVxO6WKYknY8kpPa/63z2YV4F+GXGLnMzMHi+8Du0J1fSsbqqdiglmb
         PTxwbBPiaed/VoQy095OjowoSSh7xr3noMPuyRu8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0375pa3J006453;
        Tue, 7 Apr 2020 00:51:36 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Apr
 2020 00:51:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Apr 2020 00:51:36 -0500
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0375pLdO017972;
        Tue, 7 Apr 2020 00:51:33 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH v6 3/4] arm64: dts: ti: am65-wakeup: Add VTM node
Date:   Tue, 7 Apr 2020 11:21:15 +0530
Message-ID: <20200407055116.16082-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407055116.16082-1-j-keerthy@ti.com>
References: <20200407055116.16082-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VTM stands for voltage and thermal management.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index f4227e2743f2..98b89cf0ccdf 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -89,4 +89,11 @@
 		clocks = <&k3_clks 59 0>;
 		clock-names = "gpio";
 	};
+
+	wkup_vtm0: thermal@42050000 {
+		compatible = "ti,am654-vtm";
+		reg = <0x42050000 0x25c>;
+		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
-- 
2.17.1

