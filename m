Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4E13824A
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2020 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgAKQQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jan 2020 11:16:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbgAKQQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 11:16:17 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAxLT-1iwc0f1XRZ-00BKky; Sat, 11 Jan 2020 17:15:52 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V4 3/4] ARM: dts: bcm2711: Enable thermal
Date:   Sat, 11 Jan 2020 17:15:41 +0100
Message-Id: <1578759342-4550-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
References: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:0IUicZLxdYp4qHZTyX6kmYwbihuuzvekhpMT2zBM5MdAzJFI8Zb
 TnyIvYP83Sd6Q1mNIZClhRa8DgoepMjtak3u/3UC2PvTJmhvKg3bOobmKjRNuX3Ct6zVOib
 4MZj57j1ValZPtjVGT6916Kct6VP+7X7KmoUzAzbBAtxzozfuE54d7Dp7jg/s3tZkWDDzhr
 O0pRr8746i+6ag5larC/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PG4FVKCkg8o=:p72Bcm07B31S0vAEPP3C86
 pvVcGFbOsQmqlyiyCFi8u4/QcSZ12aNgOePNixWnVmNS43xMhc6AwZ1tbkcopV1d3TyZY7nJp
 stfc0RO3zPWkGXHejh4Beg+PVoiZKNuzUEm/L711hKjGyWBsrNZUnOqjQPdY0UMPH7SekX6OB
 XJGsBDbvF6CGZ3f2NpSis5xmV4Bb4lfJBLPIuFSUzZxHDXQRkeT2Oh9SGROvogfojcq3RjPCd
 CmCafC+JsEF6hfeMOqtDGVJoUx1yaX4zox5SAnANVNB5V+dxFHV+5FzNsQ76BzJr8nH0qJ9yQ
 JCZ/iwnsuGB+10NS85x58oDGDTawCy7LEEYiDW1Kh/Nrf8FALg9bRE54llfWv6pExV39numVO
 KgSO+LUoisGO0ehBkjWNCPDoZ2eyihsH2iyYSZqDzQltuQPYJgMdwJBY85Gw4iyREktWPjnm8
 f99GqOiVjleHPOWigwV9XnYoDON4Xc7OV8p55Kzox2Y4zmXArBeummyn3o1k9ghss9u1NA+T/
 oK5izKsf1SGZK5gxh1ewEiu2AIskARqqo6L43Tf8a3m/t7hMb2sPRE9ZSKHKbU170d1iO225W
 CtxngFJtKhV1X+uebG1W25w6q9cIxrKb8dBLZFkKeiUpxfoi5dUSm7TLrZlaeyhy2C/N5h57I
 8Cl1C/XcB3HITsiSYfkHeMXJHcC0lKCzJea9xxBsmC2l9h6U530wsY5ddBplZ95bIfxDB3l7r
 egNDPMvZZOr+buA8iBcNRTZuCRjxQJnbfjZWC0fupJB3veiDZxeCnkOfQC5QNygRNWoEpx/Mr
 QJl4Y06GbntfFN1lz08k0RAwEIKAplo4dtuJv1WAQOrCows68pjYWMILRXJFoTvx0dGkpevui
 AtsY/W8p5s9TFG6LUTe1gdFLiM54Ojwm0PeJYwHxU=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This enables thermal for the BCM2711 (used on Raspberry Pi 4) by adding
the AVS monitor and a subnode for the thermal part.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 961bed8..96f341d 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -66,6 +66,17 @@
 						 IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		avs_monitor: avs-monitor@7d5d2000 {
+			compatible = "brcm,bcm2711-avs-monitor",
+				     "syscon", "simple-mfd";
+			reg = <0x7d5d2000 0xf00>;
+
+			thermal: thermal {
+				compatible = "brcm,bcm2711-thermal";
+				#thermal-sensor-cells = <0>;
+			};
+		};
+
 		dma: dma@7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xb00>;
@@ -363,6 +374,7 @@
 
 &cpu_thermal {
 	coefficients = <(-487) 410040>;
+	thermal-sensors = <&thermal>;
 };
 
 &dsi0 {
-- 
2.7.4

