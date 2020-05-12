Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B71CF465
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgELMcD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:32:03 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:18649 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgELMcC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:32:02 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 4357E482CFB;
        Tue, 12 May 2020 20:31:57 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v3] memory/samsung: reduce protected code area in IRQ
Date:   Tue, 12 May 2020 05:31:49 -0700
Message-Id: <20200512123149.40162-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCT0xCQkJCTk9JSUhNSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46GAw6Pzg8CTIMIRQ6MD8L
        KBcKCzdVSlVKTkNCSUNNTEpCTkpNVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUlCSjcG
X-HM-Tid: 0a7208dec7fa93bakuws4357e482cfb
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This change will speed-up a bit this IRQ processing and there
is no need to protect return value or printing.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
Changes since v1:
*change release lock before the if statement.
*revert dmc->df->lock mutex lock to protect function
exynos5_dmc_perf_events_check

Changes since v2:
*Improve subject and commit message

Link for V1:
*https://lore.kernel.org/patchwork/patch/1238888/
---
 drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 22a43d662833..25196d6268e2 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1346,15 +1346,13 @@ static irqreturn_t dmc_irq_thread(int irq, void *priv)
 	struct exynos5_dmc *dmc = priv;
 
 	mutex_lock(&dmc->df->lock);
-
 	exynos5_dmc_perf_events_check(dmc);
-
 	res = update_devfreq(dmc->df);
+	mutex_unlock(&dmc->df->lock);
+
 	if (res)
 		dev_warn(dmc->dev, "devfreq failed with %d\n", res);
 
-	mutex_unlock(&dmc->df->lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.26.2

