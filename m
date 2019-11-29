Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3710110D65A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2NwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:52:16 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63849 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfK2NwN (ORCPT
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
IronPort-SDR: xvlMphDs0TlfNu/RfTZx44E1DcmsQqjkS73YDt210XqSOpykm7FLW1dvxtqR9+UmNqghUvZuu7
 CAz5U5VqJgbku/HFjaewXQWAdGZnrrnmS54i0JZRlMggMrdBq6yWVPn16OyOOalYknyprHQdX6
 FqwE30ZDzms8tc+oVfJK31tWaKHu2MJBMHpkCUgxpln6exaaULNKMNlXMhLh7tWgrLdshc6Xux
 WWA5hc03Ui2xq4sI8LW2sqHNCW8R3Du073zpSRARbWj1wUxUiGJiHW8LVn7n6MC9iBTq4EZrv2
 uIw=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="58778682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 06:52:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 06:52:12 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Nov 2019 06:52:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 7/9] ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
Date:   Fri, 29 Nov 2019 15:51:43 +0200
Message-ID: <1575035505-6310-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
References: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Select DEBUG_AT91_RM9200_DBGU for SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/Kconfig.debug | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8bcbd0cd739b..b70d7debf5ca 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -147,14 +147,14 @@ choice
 		    0x80024000      | 0xf0024000     | UART9
 
 	config DEBUG_AT91_RM9200_DBGU
-		bool "Kernel low-level debugging on AT91RM9200, AT91SAM9 DBGU"
+		bool "Kernel low-level debugging on AT91RM9200, AT91SAM9, SAM9X60 DBGU"
 		select DEBUG_AT91_UART
-		depends on SOC_AT91RM9200 || SOC_AT91SAM9
+		depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAM9X60
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on the DBGU port of:
 		    at91rm9200, at91sam9260, at91sam9g20, at91sam9261,
-		    at91sam9g10, at91sam9n12, at91sam9rl64, at91sam9x5
+		    at91sam9g10, at91sam9n12, at91sam9rl64, at91sam9x5, sam9x60
 
 	config DEBUG_AT91_SAM9263_DBGU
 		bool "Kernel low-level debugging on AT91SAM{9263,9G45,A5D3} DBGU"
-- 
2.7.4

