Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB91E648533
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiLIP1B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiLIP0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611018F732
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:34 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IzlNcnDfxQAsW2ypH8CsWH34L8dWt8xCsNqhHcS+mOw=;
        b=DV6g7bAqYmHCeNTeZc2/u5ovikc+SYBPiNkcffS4Fcy4nnNqYC85bVdo0IeXKqIRzRNNOp
        Excfzp03zWNA7TQ5ZLsn9arsI4jhq1u2M9vNsMiyauQFBzTz7DzJRKuQRW8Z5Au0yIb7Cf
        KP05kEe56sNs2qO28lr+/v1PeAtV9jrrTmXa3GsS+FtOwJ66BXd0sf8ZHW4vKztO+vU3qW
        fK1VqQ8M3xu/brcc5mO7PccBFPJ4ILviDURHgNJtk8fO/LcRO+vxFWGxWeVXTXk3ff2cVy
        Zo9xMB3KcEBzzhGPa3Zlw7iLREloax3zwOryKH7OXJ3ae/75YwpxxQ5LAwjntA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IzlNcnDfxQAsW2ypH8CsWH34L8dWt8xCsNqhHcS+mOw=;
        b=UkjA1yuDtJtoxjaUKqIIHCIyteeaRnltkQXNc7KYRrOZeIOUlFoB2VvsJyLe0OMulC8hAw
        59N9OyPI8iqUZiDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/exynos: Fix NULL pointer
 dereference when getting the critical temp
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959099.4906.10741139027772891408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4092d74e0e33f0a1ccb1f4560b4d77eeff05b8d1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4092d74e0e33f0a1ccb1f4560b4d77eeff05b8d1
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 15:29:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/exynos: Fix NULL pointer dereference when getting the critical temp

The driver is assuming the get_critical temperature exists as it is
inherited by the thermal of ops. But this one has been removed in
favor of the generic one.

Use the generic thermal_zone_get_crit_temp() function instead

Fixes: 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp(")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5a1ffe2..37465af 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -264,9 +264,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	unsigned int status;
 	int ret = 0, temp;
 
-	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
-		ret = tzd->ops->get_crit_temp(tzd, &temp);
-	if (ret) {
+	ret = thermal_zone_get_crit_temp(tzd, &temp);
+	if (ret && data->soc != SOC_ARCH_EXYNOS5433) { /* FIXME */
 		dev_err(&pdev->dev,
 			"No CRITICAL trip point defined in device tree!\n");
 		goto out;
