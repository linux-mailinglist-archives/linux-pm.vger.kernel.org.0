Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01263046E9
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 19:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbhAZRTe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 12:19:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35889 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389679AbhAZIF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 03:05:27 -0500
X-UUID: 70ea73ebbb174647bf02e0b4b4975cc0-20210126
X-UUID: 70ea73ebbb174647bf02e0b4b4975cc0-20210126
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 935099361; Tue, 26 Jan 2021 16:03:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Jan 2021 16:03:57 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 16:03:57 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V8 09/12] arm64: dts: mt8183: add dvfsrc related nodes
Date:   Tue, 26 Jan 2021 16:03:51 +0800
Message-ID: <1611648234-15043-10-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1611648234-15043-1-git-send-email-henryc.chen@mediatek.com>
References: <1611648234-15043-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add DDR EMI provider dictating dram interconnect bus performance found on
MT8192-based platforms

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 062afe8..e862078 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/gce/mt8173-gce.h>
+#include <dt-bindings/interconnect/mtk,mt8183-emi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/memory/mt8183-larb-port.h>
@@ -500,6 +501,7 @@
 		ddr_emi: dvfsrc@10012000 {
 			compatible = "mediatek,mt8183-dvfsrc";
 			reg = <0 0x10012000 0 0x1000>;
+			#interconnect-cells = <1>;
 		};
 
 		pwrap: pwrap@1000d000 {
-- 
1.9.1

