Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC9135D39D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 01:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbhDLXDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 19:03:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbhDLXDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 19:03:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AFFDC1F453CB
Received: by jupiter.universe (Postfix, from userid 1000)
        id E43B44800D9; Tue, 13 Apr 2021 01:03:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/6] ARM: dts: ux500: Rename gpio-controller node
Date:   Tue, 13 Apr 2021 01:03:17 +0200
Message-Id: <20210412230320.382885-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412230320.382885-1-sebastian.reichel@collabora.com>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename the AB8500 gpio controller node from ab8500-gpio to
ab8500-gpiocontroller, since -gpio is a common suffix for
gpio consumers.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/ste-ab8500.dtsi      | 2 +-
 arch/arm/boot/dts/ste-ab8505.dtsi      | 2 +-
 arch/arm/boot/dts/ste-href-ab8500.dtsi | 2 +-
 arch/arm/boot/dts/ste-href.dtsi        | 2 +-
 arch/arm/boot/dts/ste-snowball.dts     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab8500.dtsi
index 5c5a5a2dadfc..00765c1c111d 100644
--- a/arch/arm/boot/dts/ste-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-ab8500.dtsi
@@ -34,7 +34,7 @@ ab8500_clock: clock-controller {
 					#clock-cells = <1>;
 				};
 
-				ab8500_gpio: ab8500-gpio {
+				ab8500_gpio: ab8500-gpiocontroller {
 					compatible = "stericsson,ab8500-gpio";
 					gpio-controller;
 					#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/ste-ab8505.dtsi b/arch/arm/boot/dts/ste-ab8505.dtsi
index 3380afa74c14..0defc15b9bbc 100644
--- a/arch/arm/boot/dts/ste-ab8505.dtsi
+++ b/arch/arm/boot/dts/ste-ab8505.dtsi
@@ -31,7 +31,7 @@ ab8500_clock: clock-controller {
 					#clock-cells = <1>;
 				};
 
-				ab8505_gpio: ab8505-gpio {
+				ab8505_gpio: ab8505-gpiocontroller {
 					compatible = "stericsson,ab8505-gpio";
 					gpio-controller;
 					#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 4946743de7b9..3ccb7b5c7162 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -9,7 +9,7 @@ / {
 	soc {
 		prcmu@80157000 {
 			ab8500 {
-				ab8500-gpio {
+				ab8500-gpiocontroller {
 					/* Hog a few default settings */
 					pinctrl-names = "default";
 					pinctrl-0 = <&gpio2_default_mode>,
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 83b179692dff..7566b4963ef6 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -202,7 +202,7 @@ msp3: msp@80125000 {
 
 		prcmu@80157000 {
 			ab8500 {
-				ab8500-gpio {
+				ab8500-gpiocontroller {
 				};
 
 				ab8500_usb {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b344b3748143..40f1d7c9c1d4 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -376,7 +376,7 @@ spi@80002000 {
 
 		prcmu@80157000 {
 			ab8500 {
-				ab8500-gpio {
+				ab8500-gpiocontroller {
 					/*
 					 * AB8500 GPIOs are numbered starting from 1, so the first
 					 * index 0 is what in the datasheet is called "GPIO1", and
-- 
2.30.2

