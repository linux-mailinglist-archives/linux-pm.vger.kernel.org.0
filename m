Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF8BEF87
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfIZKZp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 06:25:45 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:7162 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfIZKZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 06:25:44 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kuTEBVO5mat0bWcf8a4WUFA2aMY97JikdthveT3f7hfCRrFI6dxZimH9+Ggbq37CCurs4kZuq1
 n20IDb0F/EZESYspkqd53q3qEvfnA2iDUKzmBESHmKbTyy369vzKNx43tB6q/KPjFVPmj+JGlJ
 spItzd1r66BppXGV6cAqYN5fbt6aSuRfSn5zW6IfFEY5gyDjtIfCn+VHiyOR9jawoSZAanr7iv
 TWn6rTz7xRoFsJPu4Zpn1Gw0qhu8hN1F6JKJd3OZTfpuldGHw00QvvQkXHG7xxcdxuLLNpu4eu
 lWQ=
X-IronPort-AV: E=Sophos;i="5.64,551,1559545200"; 
   d="scan'208";a="50409875"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2019 03:25:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Sep 2019 03:25:43 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 26 Sep 2019 03:25:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] power: reset: at91-poweroff: lookup for proper PMC DT node
Date:   Thu, 26 Sep 2019 13:25:37 +0300
Message-ID: <1569493537-7612-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver has been enabled also for SAM9X60. At the moment the patch which did
this has been sent to mainline the PMC for SAM9X60 wasn't integrated.
SAM9X60 has a new PMC compatible (see commit 01e2113de9a5
("clk: at91: add sam9x60 pmc driver")). Do to this we have to
look for proper PMC compatible here, in SHDWC driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index e341cc5c0ea6..1c18f465a245 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -269,6 +269,12 @@ static const struct of_device_id at91_shdwc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, at91_shdwc_of_match);
 
+static const struct of_device_id at91_pmc_ids[] = {
+	{ .compatible = "atmel,sama5d2-pmc" },
+	{ .compatible = "microchip,sam9x60-pmc" },
+	{ /* Sentinel. */ }
+};
+
 static int __init at91_shdwc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -313,7 +319,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 
 	at91_shdwc_dt_configure(pdev);
 
-	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-pmc");
+	np = of_find_matching_node(NULL, at91_pmc_ids);
 	if (!np) {
 		ret = -ENODEV;
 		goto clk_disable;
-- 
2.7.4

