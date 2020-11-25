Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A02C3A2F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgKYHeS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 02:34:18 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48076 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgKYHeS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 02:34:18 -0500
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 84BFD3BAD17
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 07:20:01 +0000 (UTC)
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 80E1C24000A;
        Wed, 25 Nov 2020 07:19:38 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 3/3] MIPS: dts: mscc: add reset support for Luton and Jaguar2
Date:   Wed, 25 Nov 2020 08:19:20 +0100
Message-Id: <20201125071920.126978-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125071920.126978-1-gregory.clement@bootlin.com>
References: <20201125071920.126978-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow Luton and Jaguar2 SoCs to use reset feature by adding the reset
node.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/boot/dts/mscc/jaguar2.dtsi | 5 +++++
 arch/mips/boot/dts/mscc/luton.dtsi   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/jaguar2.dtsi b/arch/mips/boot/dts/mscc/jaguar2.dtsi
index 42b2b0a51ddc..7032fe550277 100644
--- a/arch/mips/boot/dts/mscc/jaguar2.dtsi
+++ b/arch/mips/boot/dts/mscc/jaguar2.dtsi
@@ -60,6 +60,11 @@ cpu_ctrl: syscon@70000000 {
 			reg = <0x70000000 0x2c>;
 		};
 
+		reset@71010008 {
+			compatible = "mscc,jaguar2-chip-reset";
+			reg = <0x71010008 0x4>;
+		};
+
 		intc: interrupt-controller@70000070 {
 			compatible = "mscc,jaguar2-icpu-intr";
 			reg = <0x70000070 0x94>;
diff --git a/arch/mips/boot/dts/mscc/luton.dtsi b/arch/mips/boot/dts/mscc/luton.dtsi
index 2a170b84c5a9..4a26c2874386 100644
--- a/arch/mips/boot/dts/mscc/luton.dtsi
+++ b/arch/mips/boot/dts/mscc/luton.dtsi
@@ -56,6 +56,11 @@ cpu_ctrl: syscon@10000000 {
 			reg = <0x10000000 0x2c>;
 		};
 
+		reset@00070090 {
+			compatible = "mscc,luton-chip-reset";
+			reg = <0x70090 0x4>;
+		};
+
 		intc: interrupt-controller@10000084 {
 			compatible = "mscc,luton-icpu-intr";
 			reg = <0x10000084 0x70>;
-- 
2.29.2

