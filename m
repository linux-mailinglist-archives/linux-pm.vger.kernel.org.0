Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2F109EB8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 14:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKZNNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 08:13:37 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58371 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZNNg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 08:13:36 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: JI9eXQ6zyNY11tbaNslGTcZfXL6Ow1Aw/m1Ola8M/mt7GU8RoPZ+qFssCBrbX2I6qz72UA84Uq
 /bwHrWJ4VQBwG7L3lX72pqujOg5/3BhRDZLkYpY748JGX3XzkkRiPHsuBygdLtW951T03lT9vZ
 qyKtq+Uta/SxTfZlMlXfADrJr2UsKrbjrnUEsovAZ4nmA6W0OAzPp+AFZ1DBSZRMucdR48WLSO
 eX0gv5IroxOP8YY/2G3c08jg2K0pbVKOOnTZl/Z/cTGRm8/uW0L+iLdg+kGNhaVCEDe5lsGJwX
 s4o=
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="59777343"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2019 06:13:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Nov 2019 06:13:05 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 26 Nov 2019 06:13:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 05/17] drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
Date:   Tue, 26 Nov 2019 15:12:09 +0200
Message-ID: <1574773941-20649-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Select POWER_RESET_AT91_SAMA5D2_SHDWC for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 886e60017f4d..ff81d02740c2 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -34,7 +34,7 @@ config POWER_RESET_AT91_RESET
 config POWER_RESET_AT91_SAMA5D2_SHDWC
 	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
 	depends on ARCH_AT91
-	default SOC_SAMA5
+	default SOC_SAM9X60 || SOC_SAMA5
 	help
 	  This driver supports the alternate shutdown controller for some Atmel
 	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
-- 
2.7.4

