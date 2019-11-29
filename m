Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72CC10D657
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfK2NwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:52:13 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63849 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfK2NwN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 08:52:13 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VLjiEHMhVooaEJZvUCF+u5HVW70oJT3m9hfrMVv4n9tp2g523C0+R3e05P0z/pWOpuTBQVFSZC
 A5QG5BdFJTEHJ25WxxavC2G+5H2a3X+zq+qkEU08Vx64/ovuDT6Ds+RrwTg2jgbe9LORfJUQ3b
 +j6Q/ZqIdhwXgNF6XaNCSsRfX+xrMawLTsRzoyLVSVwisxb3txme9BP/IyBap9QWa8Z558Kkt3
 mSoZmHBPxGzWHHcfcFbd+kjLPRy2qHT+gZshfovhL6VP8PYY15SatAzRFqh4V5DwI7uLP0v7uG
 +5k=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="58778681"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 06:52:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 06:52:07 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Nov 2019 06:52:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 5/9] power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
Date:   Fri, 29 Nov 2019 15:51:41 +0200
Message-ID: <1575035505-6310-6-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
References: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Select POWER_RESET_AT91_RESET for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c721939767eb..886e60017f4d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
 config POWER_RESET_AT91_RESET
 	tristate "Atmel AT91 reset driver"
 	depends on ARCH_AT91
-	default SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
 	help
 	  This driver supports restart for Atmel AT91SAM9 and SAMA5
 	  SoCs
-- 
2.7.4

