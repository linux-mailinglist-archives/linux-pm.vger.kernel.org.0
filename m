Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120F3109EA5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKZNNK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 08:13:10 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57006 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfKZNNK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 08:13:10 -0500
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
IronPort-SDR: X5XRdjIRH6rUZG20jT9xLXmORZLqvGFuypEdGUw0cQ4NXvDMlzeWOoJnVpR6qCI5N73VsaW6G8
 Z0hWHXseT+VHHB62FcEXkdZCrCCNJp7BtLihcXPE43NyQEtoRnz2Ik4QjhuTCJWYWXbTePWvbp
 Iro5Vy7lN/+MO7GXBKTTlQkJry1cBSyxmV3syUlFIhycexKeL092Y8ZfkMb10vdFAXARdMvuAq
 r+Q/eNm6PHPL7tyb596ExKMunVlYOpbdPJcmlEXUS25febwH8wxTRkKdL3iKQdcv1d4iaihRqZ
 JLQ=
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="58391094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2019 06:13:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 Nov 2019 06:13:00 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 26 Nov 2019 06:12:57 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 03/17] drivers: soc: atmel: move sam9x60 under its own config flag
Date:   Tue, 26 Nov 2019 15:12:07 +0200
Message-ID: <1574773941-20649-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move SAM9X60 under its own config flag.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/soc/atmel/soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 096a83cf0caf..55a1f57a4d8c 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -66,8 +66,9 @@ static const struct at91_soc __initconst socs[] = {
 	AT91_SOC(AT91SAM9XE128_CIDR_MATCH, 0, "at91sam9xe128", "at91sam9xe128"),
 	AT91_SOC(AT91SAM9XE256_CIDR_MATCH, 0, "at91sam9xe256", "at91sam9xe256"),
 	AT91_SOC(AT91SAM9XE512_CIDR_MATCH, 0, "at91sam9xe512", "at91sam9xe512"),
-	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_EXID_MATCH,
-		 "sam9x60", "sam9x60"),
+#endif
+#ifdef CONFIG_SOC_SAM9X60
+	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_EXID_MATCH, "sam9x60", "sam9x60"),
 #endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
-- 
2.7.4

