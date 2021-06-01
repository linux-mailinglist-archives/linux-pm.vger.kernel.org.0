Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C166396DC6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 09:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFAHNO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 03:13:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47881 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230326AbhFAHNN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 03:13:13 -0400
X-UUID: 285d1d2dc337453583df6c746df1d982-20210601
X-UUID: 285d1d2dc337453583df6c746df1d982-20210601
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 68701233; Tue, 01 Jun 2021 15:11:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 15:11:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 15:11:20 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [RESEND 2/2] dt-bindings: cpufreq: update cpu type and clock name for MT8173 SoC
Date:   Tue, 1 Jun 2021 15:10:42 +0800
Message-ID: <20210601071042.31349-2-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210601071042.31349-1-seiya.wang@mediatek.com>
References: <20210601071042.31349-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the cpu type of cpu2 and cpu3 since MT8173 used Cortex-a72.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index ea4994b35207..ef68711716fb 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -202,11 +202,11 @@ Example 2 (MT8173 SoC):
 
 	cpu2: cpu@100 {
 		device_type = "cpu";
-		compatible = "arm,cortex-a57";
+		compatible = "arm,cortex-a72";
 		reg = <0x100>;
 		enable-method = "psci";
 		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+		clocks = <&infracfg CLK_INFRA_CA72SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
 		operating-points-v2 = <&cpu_opp_table_b>;
@@ -214,11 +214,11 @@ Example 2 (MT8173 SoC):
 
 	cpu3: cpu@101 {
 		device_type = "cpu";
-		compatible = "arm,cortex-a57";
+		compatible = "arm,cortex-a72";
 		reg = <0x101>;
 		enable-method = "psci";
 		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+		clocks = <&infracfg CLK_INFRA_CA72SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
 		operating-points-v2 = <&cpu_opp_table_b>;
-- 
2.14.1

