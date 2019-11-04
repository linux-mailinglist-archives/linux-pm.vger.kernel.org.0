Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70569EDDE9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 12:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfKDLra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 06:47:30 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:27110 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDLr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 06:47:29 -0500
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 4 Nov 2019
 19:47:38 +0800
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
Subject: [PATCH v4 4/4] arm64: dts: meson: a1: add secure power domain controller
Date:   Mon, 4 Nov 2019 19:47:08 +0800
Message-ID: <1572868028-73076-5-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com>
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
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 7210ad0..6fdc0dd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/meson-a1-power.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -93,6 +94,12 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			pwrc: power-controller {
+				compatible = "amlogic,meson-a1-pwrc";
+				#power-domain-cells = <1>;
+				status = "okay";
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.7.4

