Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39851CA4E1
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 09:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEHHM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 03:12:29 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:37547 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgEHHM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 03:12:29 -0400
Received: from localhost.localdomain ([93.23.14.114])
        by mwinf5d01 with ME
        id c7CQ2200A2Tev1p037CQVC; Fri, 08 May 2020 09:12:26 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 08 May 2020 09:12:26 +0200
X-ME-IP: 93.23.14.114
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     milo.kim@ti.com, sre@kernel.org, anton.vorontsov@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] power: supply: lp8788: Fix an error handling path in 'lp8788_charger_probe()'
Date:   Fri,  8 May 2020 09:11:50 +0200
Message-Id: <20200508071150.204974-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In case of error, resources allocated in 'lp8788_setup_adc_channel()' must
be released.

Add a call to 'lp8788_release_adc_channel()' as already done in the remove
function.

Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/lp8788-charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 84a206f42a8e..641815eb24bc 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -719,13 +719,17 @@ static int lp8788_charger_probe(struct platform_device *pdev)
 
 	ret = lp8788_psy_register(pdev, pchg);
 	if (ret)
-		return ret;
+		goto err_release_adc_channel;
 
 	ret = lp8788_irq_register(pdev, pchg);
 	if (ret)
 		dev_warn(dev, "failed to register charger irq: %d\n", ret);
 
 	return 0;
+
+err_release_adc_channel:
+	lp8788_release_adc_channel(pchg);
+	return ret;
 }
 
 static int lp8788_charger_remove(struct platform_device *pdev)
-- 
2.25.1

