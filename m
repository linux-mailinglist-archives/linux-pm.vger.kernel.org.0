Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6592852CF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgJFUDm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 16:03:42 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:24438 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFUDm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 16:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602014621; x=1633550621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7BXCajxhGO2RKQWwE9sCw07Gt6S0v/iP/4MJXAOe4dU=;
  b=e1mUOum19E6P6a5T15/8wO4nZXumZVdlaikr9XinHgmDVv0SICt41Dlb
   c+jcUZDrc7EGhoVhPwA+16WAKqNt7uBVdQBBT5y+Tuos7gxc0UgqZIeC7
   2VMNr/yzgcp0kHG0xxwqfpBMkOll352wU7CAxMjP1fLsiGbW873huA3Fz
   BZI8G2CaAg+4JicODdgSaogH/Jb2ul2qUluqhIeMkF3EXxtaajjulWSIz
   fGNheesZdOCyHluDgev8kbAqxYa0+9smkV/CHzOPwv71BhCk1JLNudKWI
   9wDR87curSpAKwSTbmOi9o/ZEUdFdI9Zhno/bpEf4szDwjNYcQgQHt8gi
   g==;
IronPort-SDR: ujWoXHm0CCpH1Y4y9K1fFUPpRyLpYwd0wcu+Oj4WAeIv+bPhv9+I9i29GsV3ZLIvcdPBMQFzna
 VcQRqnv/JNd2OlscZ0wjgH/s6AmlRd6p4NeEqu9jNHa5olnX8722kghD+IxurblyN2gZdYc81z
 5HSCicqqPClS5+GOE+zMviNi0pgcXs2X80OqTOZwxIA73jN2ot0gEnbG00IP5nuB6c6FPRwpUA
 Z3e+v2GJHIr4SUWvRGwVtoVwcFLVp47dJLL37Q2QFXW4mbEkJbNHgkzfg9iBdUeWoJ5EO3gloo
 AF0=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="89329645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 13:03:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 13:03:28 -0700
Received: from soft-dev10.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 6 Oct 2020 13:03:38 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/3] dt-bindings: reset: ocelot: Add Sparx5 support
Date:   Tue, 6 Oct 2020 22:03:14 +0200
Message-ID: <20201006200316.2261245-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006200316.2261245-1-lars.povlsen@microchip.com>
References: <20201006200316.2261245-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the support for the Sparx5 SoC.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt       | 7 +++++--
 MAINTAINERS                                                | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
index 1b4213eb3473..4d530d815484 100644
--- a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -1,10 +1,13 @@
 Microsemi Ocelot reset controller

 The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
-SoC MIPS core.
+SoC core.
+
+The reset registers are both present in the MSCC vcoreiii MIPS and
+microchip Sparx5 armv8 SoC's.

 Required Properties:
- - compatible: "mscc,ocelot-chip-reset"
+ - compatible: "mscc,ocelot-chip-reset" or "microchip,sparx5-chip-reset"

 Example:
 	reset@1070008 {
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..cc70e3ab428b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11516,6 +11516,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mips/mscc.txt
+F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 F:	arch/mips/boot/dts/mscc/
 F:	arch/mips/configs/generic/board-ocelot.config
 F:	arch/mips/generic/board-ocelot.c
--
2.25.1
