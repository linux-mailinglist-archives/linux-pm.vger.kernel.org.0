Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889F9139965
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAMS46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 13:56:58 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:54771 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMS46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 13:56:58 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Ml6Zo-1jVahK26do-00lTfi; Mon, 13 Jan 2020 19:56:42 +0100
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
Subject: [PATCH V5 3/4] ARM: dts: bcm2711: Enable thermal
Date:   Mon, 13 Jan 2020 19:56:17 +0100
Message-Id: <1578941778-23321-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:SNWSISItmXIx6eBnLoCptDc6JzOtBscQcH5BvXlshAHdxm/pO/U
 nWGuWALXvxvoi2nUl2x5Bi5mw5ROnHHYRUmjT6GQBGF3ovXlPXW29EN1QuzwMuEF7iMWWvG
 oJorM/yZN5rYbL/0027fpe4I3SxbGTfNvYJMbvklxeW8H9cHpkzV1x8HW/znp2jgkWOOG16
 ci+0JH72mCKwJhY9ujULA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1sUaqkNUY28=:ONGBQllNlMxWag82getHbF
 C9TRj8WODi5/zj5ZssXoX7usomRTx3C6d0JBt+gExp++FSA3PSho3BpyxtHN1Iyd1CiGwa9zj
 e4z2JaiEBTOIVx64KItMokdZNraIsKkPxYdVgGJqEMFOTGjlfxqovj1FMbADRa605CsXW5T3D
 6RiR50kOfCv6Y773oh3TQYjZ45sBmQ9bY8aw1s7yiT4jD8PmF+u8qLMYsfM3kcJe1/hXGCk6w
 6XmAGu/ue0WskYFG9JfHPLVt7fxs4bwrmM1Gg6by8D6UKjR9v2b05QPsQdKCgYfb26Rp5SrDr
 8VLZZhwu34EgughC1Xn3p0wXA0UmT/cAnK5Nd5Fnp8CEUpZByVt2YwX2fMP0PBZQvB5cDlzcW
 G5BoFUU0YjBQG1dBlsAJKheBQvvvqpIEjnH/uD0eywf0k65nLGkH9EEp3UfqAl3bfsuz6r4dn
 nh/CG/IBsgxgQ/Gki0SXjypWYXJz6mzU3l5zRR+a5L3AVWfBPqvqup8Qhodihg45va5cVp0l4
 KNyqZAG+gpOEqP0AKbks5XzDInZsnnmS3Ijs65hFj8xnQKNdF9MSedlaxwiZQ2iXPXLY7IYiq
 2WAzeArBITr/2gQlJVxpYTpmcBvboRoyqKRZym2v5FUL7oZXIz3a7xLMBvb87RWc81MjXCcin
 0sCeyN5PqQKUWna+JSF8JUuWuNqKu/2ea8W8xqOwNCLY8t4Fa/1yOM/4W+cLtC9IfF5cpZHUq
 7eQ6saS4a4C39bNzUMsnNNOef9qUrekTL8BBqOYs0pUF04ekLJ64KBBzTVQatp4k+/VvdNz8K
 KvLclkEQeRGtmn0ycInTaVvlZKbWE4oNxxA2GRVBwu6TlgdciKNGLgLcS1I3GDRznyPIT7qvh
 swdPoGeXY5wyMNNAbwMpIqzD4B13UTKAFD86w2Zlw=
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

