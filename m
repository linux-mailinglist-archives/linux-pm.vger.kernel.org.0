Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCF109EB7
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKZNNg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 08:13:36 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58371 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfKZNNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 08:13:35 -0500
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
IronPort-SDR: AQzjhkv+SaQLIPoobzzor6IBEarP1+46b50vziCMwO1f4M3BBMmvrEWVA1lGOtBdf4R81jyuAR
 jXzoaTy8qr4k5gFLpTAs2ov0AtSxEgNFD83/UU8B4scIUTqS61Ph4KIw+7uE2HprqOP0rhr25j
 UAywhlTQ5cdYLtOc/bvHAlsFj0L1QYUX37ugU93gk4YxNpkcPAK4vkKE3S2Lb+1MudY6lTdjAE
 9TWH6MtLhu8qAm2fft8wGwDGnwOfQ9DIo0R5rdZZox6/p5PnxZd8hT1ZoNA97seN559uVeI5GG
 FcM=
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="59777355"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2019 06:13:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Nov 2019 06:13:08 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 26 Nov 2019 06:13:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 06/17] ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
Date:   Tue, 26 Nov 2019 15:12:10 +0200
Message-ID: <1574773941-20649-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
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

