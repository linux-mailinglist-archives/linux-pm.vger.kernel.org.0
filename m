Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2364735D39B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 01:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbhDLXDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 19:03:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbhDLXDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 19:03:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B9AD41F453CD
Received: by jupiter.universe (Postfix, from userid 1000)
        id E19464800C8; Tue, 13 Apr 2021 01:03:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/6] ARM: dts: ux500: Fix interrupt cells
Date:   Tue, 13 Apr 2021 01:03:16 +0200
Message-Id: <20210412230320.382885-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412230320.382885-1-sebastian.reichel@collabora.com>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix interrupt cells in DT AB8500/AB8505 source files. The
compiled DTB files will stay the same.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/ste-ab8500.dtsi | 26 +++++++++++++-------------
 arch/arm/boot/dts/ste-ab8505.dtsi | 22 +++++++++++-----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab8500.dtsi
index 4fd09997a2b9..5c5a5a2dadfc 100644
--- a/arch/arm/boot/dts/ste-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-ab8500.dtsi
@@ -42,15 +42,15 @@ ab8500_gpio: ab8500-gpio {
 
 				ab8500-rtc {
 					compatible = "stericsson,ab8500-rtc";
-					interrupts = <17 IRQ_TYPE_LEVEL_HIGH
-						      18 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
+						     <18 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "60S", "ALARM";
 				};
 
 				gpadc: ab8500-gpadc {
 					compatible = "stericsson,ab8500-gpadc";
-					interrupts = <32 IRQ_TYPE_LEVEL_HIGH
-						      39 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
+						     <39 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "HW_CONV_END", "SW_CONV_END";
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
 					#address-cells = <1>;
@@ -219,13 +219,13 @@ ab8500_chargalg {
 
 				ab8500_usb {
 					compatible = "stericsson,ab8500-usb";
-					interrupts = < 90 IRQ_TYPE_LEVEL_HIGH
-						       96 IRQ_TYPE_LEVEL_HIGH
-						       14 IRQ_TYPE_LEVEL_HIGH
-						       15 IRQ_TYPE_LEVEL_HIGH
-						       79 IRQ_TYPE_LEVEL_HIGH
-						       74 IRQ_TYPE_LEVEL_HIGH
-						       75 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <90 IRQ_TYPE_LEVEL_HIGH>,
+						     <96 IRQ_TYPE_LEVEL_HIGH>,
+						     <14 IRQ_TYPE_LEVEL_HIGH>,
+						     <15 IRQ_TYPE_LEVEL_HIGH>,
+						     <79 IRQ_TYPE_LEVEL_HIGH>,
+						     <74 IRQ_TYPE_LEVEL_HIGH>,
+						     <75 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "ID_WAKEUP_R",
 							  "ID_WAKEUP_F",
 							  "VBUS_DET_F",
@@ -242,8 +242,8 @@ ab8500_usb {
 
 				ab8500-ponkey {
 					compatible = "stericsson,ab8500-poweron-key";
-					interrupts = <6 IRQ_TYPE_LEVEL_HIGH
-						      7 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH>,
+						     <7 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
 				};
 
diff --git a/arch/arm/boot/dts/ste-ab8505.dtsi b/arch/arm/boot/dts/ste-ab8505.dtsi
index cc045b2fc217..3380afa74c14 100644
--- a/arch/arm/boot/dts/ste-ab8505.dtsi
+++ b/arch/arm/boot/dts/ste-ab8505.dtsi
@@ -39,8 +39,8 @@ ab8505_gpio: ab8505-gpio {
 
 				ab8500-rtc {
 					compatible = "stericsson,ab8500-rtc";
-					interrupts = <17 IRQ_TYPE_LEVEL_HIGH
-						      18 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
+						     <18 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "60S", "ALARM";
 				};
 
@@ -182,13 +182,13 @@ ab8500_chargalg {
 
 				ab8500_usb: ab8500_usb {
 					compatible = "stericsson,ab8500-usb";
-					interrupts = < 90 IRQ_TYPE_LEVEL_HIGH
-						       96 IRQ_TYPE_LEVEL_HIGH
-						       14 IRQ_TYPE_LEVEL_HIGH
-						       15 IRQ_TYPE_LEVEL_HIGH
-						       79 IRQ_TYPE_LEVEL_HIGH
-						       74 IRQ_TYPE_LEVEL_HIGH
-						       75 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <90 IRQ_TYPE_LEVEL_HIGH>,
+						     <96 IRQ_TYPE_LEVEL_HIGH>,
+						     <14 IRQ_TYPE_LEVEL_HIGH>,
+						     <15 IRQ_TYPE_LEVEL_HIGH>,
+						     <79 IRQ_TYPE_LEVEL_HIGH>,
+						     <74 IRQ_TYPE_LEVEL_HIGH>,
+						     <75 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "ID_WAKEUP_R",
 							  "ID_WAKEUP_F",
 							  "VBUS_DET_F",
@@ -205,8 +205,8 @@ ab8500_usb: ab8500_usb {
 
 				ab8500-ponkey {
 					compatible = "stericsson,ab8500-poweron-key";
-					interrupts = <6 IRQ_TYPE_LEVEL_HIGH
-						      7 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <6 IRQ_TYPE_LEVEL_HIGH>,
+						     <7 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
 				};
 
-- 
2.30.2

