Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6298A2DC099
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 13:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLPM7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 07:59:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38505 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgLPM7I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 07:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608123547; x=1639659547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jJL+6xK3GCy1DGPHyo4X0YDSWP1igMBZDBXgya5hNU8=;
  b=p0rcohWkucV0YUS9BqMsAoIe0+B1v5sxMx17D+kVNHZJGWk3mbghNFXY
   bqnUDpqwo2lLyldaw/t90S+ZlBEe82FkJLR9PxrlTtqvGBT9gFma/rzL1
   I6InOtip3VLQ5h2o8dHCmn4c0FTPjEshaoUEAT7j4jXMXFc76mHjvgRU9
   aDWsRPVCDB1U2n2H4YacBpC6nXG3jNW2UjZJJJo25QapHI81K6TT+B6A3
   jsWTYdCKR7KrPct8qxNU854Z6i23WVegu3PT4lSq4Q2do4Cqx6AuWmKv7
   OOjQnAC0jnhbFpKUw5FuboMUf21N3iL8ywvXMiknsAGGqvXYan227SN3J
   Q==;
IronPort-SDR: dwdnjqRgXtsgtW8TFS/f8ugRZEUihRq+COl9SQaZmlnLN7LWKGyttox2F0yWtPvU6oloe7KZ9t
 bto+0jrBcIUEH8Bi2Vtcj1zmRLcyFT5onpvSsWugJEpfjO0/6rwV9CLGmvWuysHh5dNJng68Qo
 +nwinl90CZOnmewdWgEcI5CANZm/XUaZ5JUgRhPiKZ4U73x3ayvFRRVknqsZiQkrBDUZZ9TQBP
 LmdKLuquwVlK+ITGauW8jB9kL0K2yiTl1yTfo1cteisHDuOONssbz0YP1cWIodPLwyjj3Edw+5
 8tU=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="37618690"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 05:57:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 05:57:51 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Dec 2020 05:57:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] power: reset: at91-sama5d2_shdwc: add support for sama7g5
Date:   Wed, 16 Dec 2020 14:57:33 +0200
Message-ID: <1608123453-1423-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for SAMA7G5 by adding proper struct reg_config structure
and since SAMA7G5 is not currently on LPDDR setups the commit also
avoid the mapping of DDR controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 72 ++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 3996167f676f..a3342c8c3728 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -78,9 +78,15 @@ struct pmc_reg_config {
 	u8 mckr;
 };
 
+struct ddrc_reg_config {
+	u32 type_offset;
+	u32 type_mask;
+};
+
 struct reg_config {
 	struct shdwc_reg_config shdwc;
 	struct pmc_reg_config pmc;
+	struct ddrc_reg_config ddrc;
 };
 
 struct shdwc {
@@ -262,6 +268,10 @@ static const struct reg_config sama5d2_reg_config = {
 	.pmc = {
 		.mckr		= 0x30,
 	},
+	.ddrc = {
+		.type_offset	= AT91_DDRSDRC_MDR,
+		.type_mask	= AT91_DDRSDRC_MD
+	},
 };
 
 static const struct reg_config sam9x60_reg_config = {
@@ -275,6 +285,23 @@ static const struct reg_config sam9x60_reg_config = {
 	.pmc = {
 		.mckr		= 0x28,
 	},
+	.ddrc = {
+		.type_offset	= AT91_DDRSDRC_MDR,
+		.type_mask	= AT91_DDRSDRC_MD
+	},
+};
+
+static const struct reg_config sama7g5_reg_config = {
+	.shdwc = {
+		.wkup_pin_input = 0,
+		.mr_rtcwk_shift = 17,
+		.mr_rttwk_shift = 16,
+		.sr_rtcwk_shift = 5,
+		.sr_rttwk_shift = 4,
+	},
+	.pmc = {
+		.mckr		= 0x28,
+	},
 };
 
 static const struct of_device_id at91_shdwc_of_match[] = {
@@ -285,6 +312,10 @@ static const struct of_device_id at91_shdwc_of_match[] = {
 	{
 		.compatible = "microchip,sam9x60-shdwc",
 		.data = &sam9x60_reg_config,
+	},
+	{
+		.compatible = "microchip,sama7g5-shdwc",
+		.data = &sama7g5_reg_config,
 	}, {
 		/*sentinel*/
 	}
@@ -294,6 +325,7 @@ MODULE_DEVICE_TABLE(of, at91_shdwc_of_match);
 static const struct of_device_id at91_pmc_ids[] = {
 	{ .compatible = "atmel,sama5d2-pmc" },
 	{ .compatible = "microchip,sam9x60-pmc" },
+	{ .compatible = "microchip,sama7g5-pmc" },
 	{ /* Sentinel. */ }
 };
 
@@ -355,30 +387,34 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
-	if (!np) {
-		ret = -ENODEV;
-		goto unmap;
-	}
+	if (at91_shdwc->rcfg->ddrc.type_mask) {
+		np = of_find_compatible_node(NULL, NULL,
+					     "atmel,sama5d3-ddramc");
+		if (!np) {
+			ret = -ENODEV;
+			goto unmap;
+		}
 
-	at91_shdwc->mpddrc_base = of_iomap(np, 0);
-	of_node_put(np);
+		at91_shdwc->mpddrc_base = of_iomap(np, 0);
+		of_node_put(np);
 
-	if (!at91_shdwc->mpddrc_base) {
-		ret = -ENOMEM;
-		goto unmap;
+		if (!at91_shdwc->mpddrc_base) {
+			ret = -ENOMEM;
+			goto unmap;
+		}
+
+		ddr_type = readl(at91_shdwc->mpddrc_base +
+				 at91_shdwc->rcfg->ddrc.type_offset) &
+				 at91_shdwc->rcfg->ddrc.type_mask;
+		if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
+		    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
+			iounmap(at91_shdwc->mpddrc_base);
+			at91_shdwc->mpddrc_base = NULL;
+		}
 	}
 
 	pm_power_off = at91_poweroff;
 
-	ddr_type = readl(at91_shdwc->mpddrc_base + AT91_DDRSDRC_MDR) &
-			 AT91_DDRSDRC_MD;
-	if (ddr_type != AT91_DDRSDRC_MD_LPDDR2 &&
-	    ddr_type != AT91_DDRSDRC_MD_LPDDR3) {
-		iounmap(at91_shdwc->mpddrc_base);
-		at91_shdwc->mpddrc_base = NULL;
-	}
-
 	return 0;
 
 unmap:
-- 
2.7.4

