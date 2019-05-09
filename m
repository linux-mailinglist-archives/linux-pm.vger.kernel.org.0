Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245C519480
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEIVTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:42 -0400
Received: from shell.v3.sk ([90.176.6.54]:45844 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEIVTm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 763F057F2F;
        Thu,  9 May 2019 23:19:40 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FXU6NnfE1peR; Thu,  9 May 2019 23:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0573C10402C;
        Thu,  9 May 2019 23:19:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9aOyP7FwSBZ1; Thu,  9 May 2019 23:19:20 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 37EA857F2F;
        Thu,  9 May 2019 23:19:19 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 7/7] ARM: dts: mmp2: Add GPU core
Date:   Thu,  9 May 2019 23:19:11 +0200
Message-Id: <20190509211911.17998-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The base address, clock and power domain gotten from the OLPC OS kernel;
the data sheet is not available.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 8ad3e6673e1f..2f1d9fa8064f 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -8,6 +8,7 @@
  */
=20
 #include <dt-bindings/clock/marvell,mmp2.h>
+#include <dt-bindings/power/marvell,mmp2.h>
=20
 / {
 	#address-cells =3D <1>;
@@ -41,6 +42,17 @@
 			reg =3D <0xd4200000 0x00200000>;
 			ranges;
=20
+			gpu: gpu@d420d000 {
+				compatible =3D "vivante,gc";
+				reg =3D <0xd420d000 0x4000>;
+				interrupts =3D <8>;
+				status =3D "disabled";
+				clocks =3D <&soc_clocks MMP2_CLK_GPU_GC>,
+					 <&soc_clocks MMP2_CLK_GPU_BUS>;
+				clock-names =3D "core", "bus";
+				power-domains =3D <&soc_clocks MMP2_POWER_DOMAIN_GPU>;
+			};
+
 			intc: interrupt-controller@d4282000 {
 				compatible =3D "mrvl,mmp2-intc";
 				interrupt-controller;
--=20
2.21.0

