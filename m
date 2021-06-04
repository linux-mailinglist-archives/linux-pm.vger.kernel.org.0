Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECA39B722
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDKcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:32:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52138 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230162AbhFDKcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:32:11 -0400
X-UUID: 02f8f739c7d54e27b5deacc50860e8d0-20210604
X-UUID: 02f8f739c7d54e27b5deacc50860e8d0-20210604
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 249028057; Fri, 04 Jun 2021 18:30:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Jun 2021 18:30:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 18:30:13 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH V10 10/12] arm64: dts: mt8192: add dvfsrc related nodes
Date:   Fri, 4 Jun 2021 18:29:57 +0800
Message-ID: <20210604102959.13807-11-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210604102959.13807-1-dawei.chien@mediatek.com>
References: <20210604102959.13807-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

Add DDR EMI provider dictating dram interconnect bus performance found on
MT8183-based platforms

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c70a3bf744fa..ab3dabcc722e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -5,6 +5,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/interconnect/mtk,mt6873-emi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
@@ -286,6 +287,7 @@
 			compatible = "mediatek,mt8192-dvfsrc",
 				     "mediatek,mt6873-dvfsrc";
 			reg = <0 0x10012000 0 0x1000>;
+			#interconnect-cells = <1>;
 		};
 
 		systimer: timer@10017000 {
-- 
2.14.1

