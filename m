Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7125E32A2AA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Mar 2021 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376885AbhCBIRD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 03:17:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1574809AbhCBDux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 22:50:53 -0500
X-UUID: ed293cd5f42643aba58c6ee7b139805d-20210302
X-UUID: ed293cd5f42643aba58c6ee7b139805d-20210302
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1317654723; Tue, 02 Mar 2021 11:47:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Mar 2021 11:47:45 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Mar 2021 11:47:45 +0800
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
Subject: [PATCH V9 06/12] arm64: dts: mt8192: add dvfsrc related nodes
Date:   Tue, 2 Mar 2021 11:47:37 +0800
Message-ID: <1614656863-8530-7-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
References: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable dvfsrc on mt8192 platform.

Change-Id: I5c5cf1b0b22358034af5b482b6e46553398591e6
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 8252143..dbefc0d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -464,6 +464,12 @@
 			#clock-cells = <1>;
 		};
 
+		ddr_emi: dvfsrc@10012000 {
+			compatible = "mediatek,mt8192-dvfsrc",
+				     "mediatek,mt6873-dvfsrc";
+			reg = <0 0x10012000 0 0x1000>;
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8192-timer",
 				     "mediatek,mt6765-timer";
-- 
1.9.1

