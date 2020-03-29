Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A1196E6A
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgC2QXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:23:15 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52648 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgC2QXP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:23:15 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8F89E249A1;
        Sun, 29 Mar 2020 18:23:12 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 9/9] arm: dts: qcom: apq8064-nexus7: Add smb345 charger node
Date:   Sun, 29 Mar 2020 18:21:28 +0200
Message-Id: <20200329162128.218584-10-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add smb345 charger node to Nexus 7 2013 DTS.
Proper charger initialization also prevents battery from overcharging.

Original author: Vinay Simha BN <simhavcs@gmail.com>

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index a701d4bac320..9f14216a22f1 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -3,6 +3,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/power/summit,smb347-charger.h>
 / {
 	model = "Asus Nexus7(flo)";
 	compatible = "asus,nexus7-flo", "qcom,apq8064";
@@ -293,11 +294,30 @@ eeprom@52 {
 					pagesize = <32>;
 				};
 
-				bq27541@55 {
+				bat: battery@55 {
 					compatible = "ti,bq27541";
 					reg = <0x55>;
+					power-supplies = <&power_supply>;
 				};
 
+				power_supply: charger@6a {
+					compatible = "summit,smb345";
+					reg = <0x6a>;
+
+					interrupt-parent = <&tlmm_pinmux>;
+					interrupts = <23 IRQ_TYPE_EDGE_BOTH>;
+
+					summit,max-chg-curr = <1800000>;
+					summit,usb-curr-limit = <500000>;
+
+					summit,chip-temp-threshold = <110>;
+
+					summit,enable-usb-charging;
+					summit,enable-otg-charging;
+
+					summit,enable-chg-ctrl =
+						<SMB3XX_CHG_ENABLE_SW>;
+				};
 			};
 		};
 
-- 
2.25.0

