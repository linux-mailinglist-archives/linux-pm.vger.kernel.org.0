Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F601C88FA
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgEGLy0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 07:54:26 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:44732 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGLy0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 07:54:26 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 07:54:26 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 2BEEA482B3F;
        Thu,  7 May 2020 19:45:22 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] memory/samsung: Maybe wrong triming parameter
Date:   Thu,  7 May 2020 04:45:14 -0700
Message-Id: <20200507114514.11589-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VOS0JCQkJMTklLT09NQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6Gjo5NTg0GT8wSyNCHzMv
        IkwwCRJVSlVKTkNDQ05KQkhISkxJVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUtMTDcG
X-HM-Tid: 0a71eef455f993bakuws2beea482b3f
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In function create_timings_aligned, all the max is to use
dmc->min_tck->xxx, aligned with val dmc->timings->xxx.
But the dmc->timings->tFAW use dmc->min_tck->tXP?
Maybe this point is wrong parameter useing.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 81a1b1d01683..22a43d662833 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1091,7 +1091,7 @@ static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
 	/* power related timings */
 	val = dmc->timings->tFAW / clk_period_ps;
 	val += dmc->timings->tFAW % clk_period_ps ? 1 : 0;
-	val = max(val, dmc->min_tck->tXP);
+	val = max(val, dmc->min_tck->tFAW);
 	reg = &timing_power[0];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
-- 
2.26.2

