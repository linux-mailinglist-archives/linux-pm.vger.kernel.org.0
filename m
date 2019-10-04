Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33702CBE90
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbfJDPHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 11:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPHt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 11:07:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F257521D81;
        Fri,  4 Oct 2019 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201668;
        bh=qYioEzDmICb0pDIcd2sao32iGGG/DdI1z0g1uD+bG7w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QxMOULfhqAHILdyIZyGrilDN3NMOHFLVFs1DQK2m3A3Kgc53Sy9lrgf6WfAxseFC7
         z/lVWyJmrLK/sgW43+7YUZGRN5UNjWPy69Cgt2uB4Pdv/a3PxmdjvZmBIc5ZgVPMqg
         1nZLHnCqZVXtqEkiGjZZ4X0sMtIH74tEyFJS6YWA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 2/3] power: supply: ab8500_fg: Do not free non-requested IRQs in probe's error path
Date:   Fri,  4 Oct 2019 17:07:37 +0200
Message-Id: <20191004150738.6542-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004150738.6542-1-krzk@kernel.org>
References: <20191004150738.6542-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When requesting interrupt fails, free only interrupts already requested,
not all of them.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as cc-stable as this was not reproduced and not tested.
---
 drivers/power/supply/ab8500_fg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 36bbb8ea05da..7d879589adc2 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3158,7 +3158,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		if (ret != 0) {
 			dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
 				ab8500_fg_irq_th[i].name, irq, ret);
-			goto free_irq;
+			goto free_irq_th;
 		}
 		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 			ab8500_fg_irq_th[i].name, irq, ret);
@@ -3173,7 +3173,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
 			ab8500_fg_irq_bh[0].name, irq, ret);
-		goto free_irq;
+		goto free_irq_th;
 	}
 	dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 		ab8500_fg_irq_bh[0].name, irq, ret);
@@ -3215,7 +3215,9 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* We also have to free all registered irqs */
 	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
 	free_irq(irq, di);
-	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
+free_irq_th:
+	while (--i >= 0) {
+		/* Last assignment of i from primary interrupt handlers */
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
 		free_irq(irq, di);
 	}
-- 
2.17.1

