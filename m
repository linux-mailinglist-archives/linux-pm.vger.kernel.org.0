Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4281CAF0C
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgEHNNw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:13:52 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:24511 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgEHNNv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 09:13:51 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id EC4A1482C00;
        Fri,  8 May 2020 21:13:44 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] memory/samsung: reduce unnecessary mutex lock area
Date:   Fri,  8 May 2020 06:13:38 -0700
Message-Id: <20200508131338.32956-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVMSU5CQkJDSElKTkhISVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Dgw*TTgrMz4*Txc0TDE5
        TFEaCj1VSlVKTkNDQk9ITUlOSkxCVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUpNTjcG
X-HM-Tid: 0a71f46b9b9093bakuwsec4a1482c00
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Maybe dmc->df->lock is unnecessary to protect function
exynos5_dmc_perf_events_check(dmc). If we have to protect,
dmc->lock is more better and more effective.
Also, it seems not needed to protect "if (ret) & dev_warn"
branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 22a43d662833..88e8ac8b5327 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1345,16 +1345,14 @@ static irqreturn_t dmc_irq_thread(int irq, void *priv)
 	int res;
 	struct exynos5_dmc *dmc = priv;
 
-	mutex_lock(&dmc->df->lock);
-
 	exynos5_dmc_perf_events_check(dmc);
 
+	mutex_lock(&dmc->df->lock);
 	res = update_devfreq(dmc->df);
+	mutex_unlock(&dmc->df->lock);
 	if (res)
 		dev_warn(dmc->dev, "devfreq failed with %d\n", res);
 
-	mutex_unlock(&dmc->df->lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.26.2

