Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF623529E9
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKua (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 06:50:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61680 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKua (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 06:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617360630; x=1648896630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+hFB1fZnifLkBRCu8m8oE8PjCj413ujdaqs2fWQwwIA=;
  b=GIvBcBJK1zMRu+LuN2yYyUvI6bdjY+HI4fyPe78CDnNLPvx03k9+VYTy
   WhohuZXnC+DiKnoD8qgRB1FpzxMoRCgeF71ayRh1GR8nt6bz2noU14Y0/
   WxmiMpFVFf8uVLCYu0TkKoPGxEGDy5WUKRQUeyl/bOFc2TksdQT4unJCR
   mJv3wIYKpvwLaOey12fwfoQsueS06JqWHUkAMWjslSM3VMkFwAhsPrFBA
   H0vt4Kq5BGnIi13LB4ETLDTl5ggsRAZAt3K68XTh5U9FBuLB5U5UZ46hC
   XXJlxinWRAFGvGNl7m3OJ0wSGjbSjW3ZuVEJBBiLu6sg/kqI+RKg8ShP4
   g==;
IronPort-SDR: DmlQURt0aJ7/F5PN6pMUPZw+IyVWj5f8d1Ck3bG8yTCHvABwg0aGkrmLNQoUrUlwg51FRyTgIz
 jOUoCoKPPkSCrIbaBTk/A9U6+mxAnQjMyMqXET3M0c2Rq4iW7VM623+Owi7i6TKOEmatuYcuXo
 8BYI3Hq/4ObA5FtqfZmdndi0fw4ubT3Kn2ZTe7eFsBZekbThpjqMjGzx5bFZxzWchbCymTcpqO
 NdXpBd4jFsh5MlCEWPRyCaunMhPAIV/EBMjo56Pdf/I0noFNEcbwN5+6a+6ktf/2vIMHqg9aYl
 pqc=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="112251059"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 03:50:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 03:50:29 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 2 Apr 2021 03:50:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sre@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: [PATCH v2 1/1] power: reset: at91-reset: use devm_of_iomap
Date:   Fri, 2 Apr 2021 13:50:18 +0300
Message-ID: <20210402105018.2212-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_of_iomap() to map resources. This will avoid the necessity to
track the mapped resources and free them on failure path or on remove.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- use devm_of_iomap()
- change commit description and title to match to the new approach
- add Suggested-by tag

 drivers/power/reset/at91-reset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3ff9d93a5226..026649409135 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -192,7 +192,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	if (!reset)
 		return -ENOMEM;
 
-	reset->rstc_base = of_iomap(pdev->dev.of_node, 0);
+	reset->rstc_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (!reset->rstc_base) {
 		dev_err(&pdev->dev, "Could not map reset controller address\n");
 		return -ENODEV;
@@ -202,7 +202,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 		/* we need to shutdown the ddr controller, so get ramc base */
 		for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
 			reset->ramc_lpr = (u32)match->data;
-			reset->ramc_base[idx] = of_iomap(np, 0);
+			reset->ramc_base[idx] = devm_of_iomap(&pdev->dev, np, 0, NULL);
 			if (!reset->ramc_base[idx]) {
 				dev_err(&pdev->dev, "Could not map ram controller address\n");
 				of_node_put(np);
-- 
2.25.1

