Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D4DC10C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633048AbfJRJdE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 05:33:04 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:32069 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409821AbfJRJdD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 05:33:03 -0400
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 18 Oct 2019
 17:33:01 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: [PATCH v3 4/4] arm64: dts: meson: a1: add secure power domain controller
Date:   Fri, 18 Oct 2019 17:32:47 +0800
Message-ID: <1571391167-79679-5-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571391167-79679-1-git-send-email-jianxin.pan@amlogic.com>
References: <1571391167-79679-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable power domain controller for Meson A1 SoC.

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 7210ad0..081bc31 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/meson-a1-power.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -93,6 +94,13 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			pwrc: power-controller {
+				compatible = "amlogic,meson-a1-pwrc";
+				#power-domain-cells = <1>;
+				secure-monitor = <&sm>;
+				status = "okay";
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.7.4

