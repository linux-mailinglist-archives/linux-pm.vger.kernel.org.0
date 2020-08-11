Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92D24197E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgHKKQx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 06:16:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgHKKQx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 06:16:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69E331B;
        Tue, 11 Aug 2020 03:16:52 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4AE23F22E;
        Tue, 11 Aug 2020 03:16:50 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org
Cc:     kgene@kernel.org, b.zolnierkie@samsung.com, lukasz.luba@arm.com
Subject: [PATCH] memory: samsung: exynos5422-dmc: Additional locking for 'curr_rate'
Date:   Tue, 11 Aug 2020 11:16:33 +0100
Message-Id: <20200811101633.3845-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'curr_rate' is protected by local 'dmc->lock' in various places, but
not in a function exynos5_dmc_get_status(). The lock protects frequency
(and voltage) change process and the corresponding value stored in
'curr_rate'. Add the locking mechanism to protect the 'curr_rate' reading
also in the exynos5_dmc_get_status().

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index b9c7956e5031..952bc61e68f4 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -908,7 +908,10 @@ static int exynos5_dmc_get_status(struct device *dev,
 	int ret;
 
 	if (dmc->in_irq_mode) {
+		mutex_lock(&dmc->lock);
 		stat->current_frequency = dmc->curr_rate;
+		mutex_unlock(&dmc->lock);
+
 		stat->busy_time = dmc->load;
 		stat->total_time = dmc->total;
 	} else {
-- 
2.17.1

