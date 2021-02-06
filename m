Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD5311CD8
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBFLSB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Feb 2021 06:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFLSB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 6 Feb 2021 06:18:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5771964E5F;
        Sat,  6 Feb 2021 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612610240;
        bh=UVaykrGaFKk8Qu59885F5o+xsLHdmSO/46BUYOQ0qEA=;
        h=From:To:Subject:Date:From;
        b=I62NUtL4JWss4jsAvfFWFY7ZXStwhvIvzaz+VE+CglgYfMe135VmYUkQ35s56UBoG
         Ds0gwh2112rF/dijl6t1wcl5hzWLRqeyaP682CNfa7cpNnztIgCHwbtfHGdkuAss0i
         8y6uky+xcLJl8MpzIMaTItr13+YFEyTfkEHVSlp3uTkSfnd2OLaPEwMskIDTGcBwNV
         90DcEceyDwZvZWL+7U/p1hRS83dk+lo3KcBrjt22qRQyFYVcQsuefU/sUNPNWggpOs
         /BqrnMtE+igGmRPRNn5NOMDR9lyKUM4aA1BxvBxzaDSInnMv4Bj/Bfl0x3AGbOYPSU
         I7Yo9QiBRwL+g==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: samsung: exynos5422-dmc: Correct function names in kerneldoc
Date:   Sat,  6 Feb 2021 12:17:15 +0100
Message-Id: <20210206111715.20774-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Correct kerneldoc to fix W=1 warnings:

    drivers/memory/samsung/exynos5422-dmc.c:290: warning:
        expecting prototype for find_target_freq_id(). Prototype was for find_target_freq_idx() instead
    drivers/memory/samsung/exynos5422-dmc.c:1015: warning:
        expecting prototype for exynos5_dmc_align_initial_frequency(). Prototype was for exynos5_dmc_align_init_freq() instead

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index c5ee4121a4d2..1dabb509dec3 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -278,7 +278,7 @@ static int exynos5_counters_disable_edev(struct exynos5_dmc *dmc)
 }
 
 /**
- * find_target_freq_id() - Finds requested frequency in local DMC configuration
+ * find_target_freq_idx() - Finds requested frequency in local DMC configuration
  * @dmc:	device for which the information is checked
  * @target_rate:	requested frequency in KHz
  *
@@ -998,7 +998,7 @@ static struct devfreq_dev_profile exynos5_dmc_df_profile = {
 };
 
 /**
- * exynos5_dmc_align_initial_frequency() - Align initial frequency value
+ * exynos5_dmc_align_init_freq() - Align initial frequency value
  * @dmc:	device for which the frequency is going to be set
  * @bootloader_init_freq:	initial frequency set by the bootloader in KHz
  *
-- 
2.25.1

