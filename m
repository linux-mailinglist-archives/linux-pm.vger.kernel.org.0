Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3351441D744
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349774AbhI3KLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 06:11:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63344 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbhI3KLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 06:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632996573; x=1664532573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T+FEBSdR2R1lgPhS9lJEjIF/H3DpmWpTBm+AgCb25Xo=;
  b=0IfrnSCtAfGmc0yGCxHacxmxT/ZVC7W9qb641pag+Sdx+1IaMBrP7b2e
   gznDmowvm0U7AihmSREZAgfv3J/gh9CImyz74iYl27KtyudoSKB4+/q4J
   0ieDljj1izbeMxGXH0/YbBSgAg5LlW8glHrYfOmIE7FM9zB7h0HCKNTED
   uVmBa6rPeAQHZoshPxilvW7M7WFq1xcAtYCDYUGx2IIABeYhp/+kqshG+
   fLpyhu6rT9I8zoJAZlJkB3EBdlsRlfXvyN1inaSamZAYOgD60DoyoOYDN
   mJU+j1mdL2AMgNwNc0YGYtuJgOEx2Nq4EngtQl3NMuvEUH5rScTi9Cs5r
   w==;
IronPort-SDR: q2GFmjCdmqmkf2Nrg+tjSy6vBCLo9jJaZDPJUfdq0eBAizg9SsYUMMthdf9IV7OojkCpuJpO1b
 Wn53rbK2PXM1lYbUTr1z6XnyM8JkpWLydAhTvZw/Aku51udfJ4otc2w/mfSLZZ3jEtoga2QdeT
 tLDqdUEPbS9wovN9a+BFfVYJdGO6wU4GxP/GWwJV5rly+ncfhcOgDH/Z1J782iDbr9LJOhlPdj
 DA8LGoTzu7Ho84iPpJIKPliqPkXDbAqgWGhMAFzxqsDiNxKhJMG2iNsPw5ttWAt4tedNZNgqwP
 FS2pr4C3xMJSJgDr7Ye2411e
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="71214285"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 03:09:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 03:09:32 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 03:09:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sre@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH] power: reset: at91-reset: check properly the return value of devm_of_iomap
Date:   Thu, 30 Sep 2021 13:09:28 +0300
Message-ID: <20210930100928.2211599-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

devm_of_iomap() returns error code or valid pointer. Check its return
value with IS_ERR().

Fixes: bd3127733f2c ("power: reset: at91-reset: use devm_of_iomap")
Reported-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 026649409135..64def79d557a 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -193,7 +193,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	reset->rstc_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
-	if (!reset->rstc_base) {
+	if (IS_ERR(reset->rstc_base)) {
 		dev_err(&pdev->dev, "Could not map reset controller address\n");
 		return -ENODEV;
 	}
@@ -203,7 +203,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 		for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
 			reset->ramc_lpr = (u32)match->data;
 			reset->ramc_base[idx] = devm_of_iomap(&pdev->dev, np, 0, NULL);
-			if (!reset->ramc_base[idx]) {
+			if (IS_ERR(reset->ramc_base[idx])) {
 				dev_err(&pdev->dev, "Could not map ram controller address\n");
 				of_node_put(np);
 				return -ENODEV;
-- 
2.25.1

