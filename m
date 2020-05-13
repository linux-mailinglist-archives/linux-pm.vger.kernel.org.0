Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296361D140D
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgEMNJC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 09:09:02 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31166 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgEMNJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 09:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589375341; x=1620911341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykGNljrOL3uL7TOqwtHYrU0bzI70hpjkW9oijaZnkD4=;
  b=dXOISWqYQyAiL/wzO+7dTxALt63iP7XrGtu+F5b6vsoqvtmXCW0eqc1o
   Gg9dbeYKGcnQF2nSdc/265QdqJlZwlB6ke18Vtc7n3QyCCfvxVT/0UZng
   y72nxkI9mnARVYF6KsAYpOefQWezO0JZsCZK7eR3ivc8FtgcRsni38Dyk
   Rd+Gei/iLWpoZ7c2qffjCxdjjbnTkJpOUztVjMIOSGKdC0hUsfXYSD8e3
   UfuxZZQ8v865Marn1uNCcWjbpNlAL5mgpBz7QB5xGBkmD6h08lgutMRq+
   OG8lq5jgwyvAEoU9pwXDzzigHDtYPeQ3+f40xtkNEucORlzYUdnZDEhGY
   g==;
IronPort-SDR: pp4CAtxiOJ18bIMjqxiPSRdDrgZcaeMpLz8CbXkSO+KTloXEVNF1IHYP6QlO1fwOxxW5mRXd1s
 HgqbGO1XEwzb3Wn4qNWElxT+rKYtCLtm9QW9bJkcSHdWJ28KMwovk+0Bn5UoEp4pMb+NLdkoeW
 /LPDUWLUlLoSnARibPtUAA9QsYq9iWa5rWzlVyWIt/u0UpGjIYEaJcEVZj7mqz2cY0D0emTBQ5
 JhBdFIkuo3ZrA0v7ONMMUJa1UpHO6N0OPGIBs3hCx7E1YqaLjsY85HTxEl6gcIbXEemXJk7Rgk
 CX0=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="76497693"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:08:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:08:59 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:08:54 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/5] dt-bindings: reset: ocelot: Add Sparx5 support
Date:   Wed, 13 May 2020 15:08:38 +0200
Message-ID: <20200513130842.24847-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513130842.24847-1-lars.povlsen@microchip.com>
References: <20200513130842.24847-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
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
index 1b4213eb34731..4d530d8154848 100644
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
index 5aa28d6e39d4f..1db598723a1d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11230,6 +11230,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mips/mscc.txt
+F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 F:	arch/mips/boot/dts/mscc/
 F:	arch/mips/configs/generic/board-ocelot.config
 F:	arch/mips/generic/board-ocelot.c
--
2.26.2
