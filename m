Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139B21CF314
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgELLIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 07:08:46 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:24010 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgELLIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 07:08:46 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 06A8A482D55;
        Tue, 12 May 2020 19:08:39 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] memory/samsung: reduce unnecessary mutex lock area
Date:   Tue, 12 May 2020 04:08:27 -0700
Message-Id: <20200512110827.39475-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VITEtCQkJDSkhLTEJDSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46LCo*UTg8GTJWFAI1Sk1P
        OjYKCRNVSlVKTkNCSUNKTElJSUNDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUlPTjcG
X-HM-Tid: 0a720892839793bakuws06a8a482d55
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Maybe dmc->df->lock seems not needed to protect "if (ret)
& dev_warn" branch. Maybe this change speed up the code a bit.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
----
Changes since v1:
*change release lock before the if statement.
*revert dmc->df->lock mutex lock to protect function
exynos5_dmc_perf_events_check
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

