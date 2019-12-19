Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927621264A2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLSO2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:28:11 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55167 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSO2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 09:28:10 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 716QACWpHXQhHFc1YhI9RUu0gEWCGiBtXPRH9c8qaISRAtJPpVGX79XyHMkJx7ZwCT9ItZUAx9
 Ka6jvRJnmNnJH5be3tEO6B0xj/o9FOtHREMRj99j2gCeNN3n1zLGjPduKcwhtlpE+TfvozjyHW
 Kuf/ul5qeO7B1wPwkx3FV7g/gXNdaTOXJ327q3No2os8XrdnCOMIzMDzlMDkuFV/rpESkJBJJj
 tnQb4GyAbg+uDz4C/rqoRSb+cSFsiZl+iL7iddYOcJPmrPm0KD68btGpBeE79grcx074z1tnL+
 udA=
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="60355288"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Dec 2019 07:28:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Dec 2019 07:28:09 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 19 Dec 2019 07:28:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] power: reset: at91-sama5d2_shdwc: use proper master clock register offset
Date:   Thu, 19 Dec 2019 16:27:54 +0200
Message-ID: <1576765674-22070-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576765674-22070-1-git-send-email-claudiu.beznea@microchip.com>
References: <1576765674-22070-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SAM9X60's PMC uses different offset for master clock register.
Add a member of type struct pmc_reg_config in struct reg_config,
fill it correspondingly for SAMA5D2 and SAM9X60 and use it in
poweroff() function.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 836957f17169..7ad89c0dd164 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -74,8 +74,13 @@ struct shdwc_reg_config {
 	u8 sr_rttwk_shift;
 };
 
+struct pmc_reg_config {
+	u8 mckr;
+};
+
 struct reg_config {
 	struct shdwc_reg_config shdwc;
+	struct pmc_reg_config pmc;
 };
 
 struct shdwc {
@@ -136,9 +141,10 @@ static void at91_poweroff(void)
 		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
 
 		/* Switch the master clock source to slow clock. */
-		"1:	ldr	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
+		"1:	add	r5, %4, %5\n\t"
+		"	ldr	r6, [r5]\n\t"
 		"	bic	r6, r6,  #" __stringify(AT91_PMC_CSS) "\n\t"
-		"	str	r6, [%4, #" __stringify(AT91_PMC_MCKR) "]\n\t"
+		"	str	r6, [r5]\n\t"
 		/* Wait for clock switch. */
 		"2:	ldr	r6, [%4, #" __stringify(AT91_PMC_SR) "]\n\t"
 		"	tst	r6, #"	    __stringify(AT91_PMC_MCKRDY) "\n\t"
@@ -153,8 +159,9 @@ static void at91_poweroff(void)
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc->shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW),
-		  "r" (at91_shdwc->pmc_base)
-		: "r6");
+		  "r" (at91_shdwc->pmc_base),
+		  "r" (at91_shdwc->rcfg->pmc.mckr)
+		: "r5", "r6");
 }
 
 static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
@@ -253,6 +260,9 @@ static const struct reg_config sama5d2_reg_config = {
 		.sr_rtcwk_shift = 5,
 		.sr_rttwk_shift = SHDW_CFG_NOT_USED,
 	},
+	.pmc = {
+		.mckr		= 0x30,
+	},
 };
 
 static const struct reg_config sam9x60_reg_config = {
@@ -263,6 +273,9 @@ static const struct reg_config sam9x60_reg_config = {
 		.sr_rtcwk_shift = 5,
 		.sr_rttwk_shift = 4,
 	},
+	.pmc = {
+		.mckr		= 0x28,
+	},
 };
 
 static const struct of_device_id at91_shdwc_of_match[] = {
-- 
2.7.4

