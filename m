Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED732DA65
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 20:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCDT3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 14:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhCDT3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 14:29:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1CC06175F
        for <linux-pm@vger.kernel.org>; Thu,  4 Mar 2021 11:28:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p21so45109913lfu.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Mar 2021 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d606i726IOli9oaA/A1UIGosXPZBxIF73t+6qPltjYY=;
        b=W6TcUhVA8o1KNj6cyRxqjLYWI/eYSQkBdTDGOcHvXZYVKQV8RP8itZeHjPmlPTR09P
         3s/rmQi6RAzhnWsppERLi59CV2Wvys81vXH30eAF3Gsj61AB/tmqKhEB5eC/BDGUx7Ed
         vibsYf7C/4tINooKIFU1NOnzSUB734QiyJ1Ozub8o7br2RwwJ7iUxRvDidQmo9FHtyqb
         FjQ0pVt8SNaoydj7uUfMcp7uyKzWVyXpJGlpGpotKlfePCdnCdnMKytfcMKsXLpTvA2K
         5WwO8VrlrtyqxCQMVVtxjmZxm2t9GInhl+lZh1hYSrPkESgZMWQh3a9UhJnmq3B4nwt3
         fG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d606i726IOli9oaA/A1UIGosXPZBxIF73t+6qPltjYY=;
        b=mlFuk8+rbaUKAaKpPOcNNz2gKzPl7IdDzxLV1bjUvzHkXf8eC1ugHUIp/ZVT1KNzLx
         zsPLRJkcX3RZEnD/vY8vFsB7uwQM/3njlHVSi6SrqWUEduKRufWL5Oi2504Ob7WS5aqE
         lTGXwswDcCARoUOkPE7XMPQQPNSPJc7o9S7sbmvPaaP0qNmkqR3SK7q3/kG+AaOUVzYt
         k5nqNbkA/B/gLc4d3QC0qNTLsrkDa/KEx+nukl8yAymnsMJyLt1V2nMCJAZhsuZl/kJ1
         W+fMnz0fkSCwE/OQC0PxnU851GIeOFZ9vB7fgvwC3cGDQehbuHPGXObNLLsRSsvS0Mza
         DJlA==
X-Gm-Message-State: AOAM5326mat8w2R6HGqe33wlL/3OfRF5iAU3WT/V/kIMVvQmiuWH+nBU
        nbmBkU8LmtOKiQnejW9WXezAGQ==
X-Google-Smtp-Source: ABdhPJyjMHuu8+FmTrRPZUxbrIUpNi7K2AS1y2F9oonw9iSrgXQ+QULRweMde5R/ePU4TS/RWzRcQA==
X-Received: by 2002:a05:6512:3a84:: with SMTP id q4mr3094421lfu.382.1614886133558;
        Thu, 04 Mar 2021 11:28:53 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id z6sm34281lfr.34.2021.03.04.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:28:52 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Don't runtime resume devices at genpd_prepare()
Date:   Thu,  4 Mar 2021 20:28:43 +0100
Message-Id: <20210304192843.216829-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Runtime resuming a device upfront in the genpd_prepare() callback, to check
if there is a wakeup pending for it, seems like an unnecessary thing to do.
The PM core already manages these kind of things in a common way in
__device_suspend(), via calling pm_runtime_barrier() and
pm_wakeup_pending().

Therefore, let's simply drop this behaviour from genpd_prepare().

Note that, this change is applicable only for devices that are attached to
a genpd that has the GENPD_FLAG_ACTIVE_WAKEUP set (Renesas, Mediatek, and
Rockchip platforms). Moreover, a driver that needs to restore power for its
device to re-configure it for a system wakeup, may still call
pm_runtime_get_sync(), for example, to do this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 78c310d3179d..b6a782c31613 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1087,34 +1087,6 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 	genpd->status = GENPD_STATE_ON;
 }
 
-/**
- * resume_needed - Check whether to resume a device before system suspend.
- * @dev: Device to check.
- * @genpd: PM domain the device belongs to.
- *
- * There are two cases in which a device that can wake up the system from sleep
- * states should be resumed by genpd_prepare(): (1) if the device is enabled
- * to wake up the system and it has to remain active for this purpose while the
- * system is in the sleep state and (2) if the device is not enabled to wake up
- * the system from sleep states and it generally doesn't generate wakeup signals
- * by itself (those signals are generated on its behalf by other parts of the
- * system).  In the latter case it may be necessary to reconfigure the device's
- * wakeup settings during system suspend, because it may have been set up to
- * signal remote wakeup from the system's working state as needed by runtime PM.
- * Return 'true' in either of the above cases.
- */
-static bool resume_needed(struct device *dev,
-			  const struct generic_pm_domain *genpd)
-{
-	bool active_wakeup;
-
-	if (!device_can_wakeup(dev))
-		return false;
-
-	active_wakeup = genpd_is_active_wakeup(genpd);
-	return device_may_wakeup(dev) ? active_wakeup : !active_wakeup;
-}
-
 /**
  * genpd_prepare - Start power transition of a device in a PM domain.
  * @dev: Device to start the transition of.
@@ -1135,14 +1107,6 @@ static int genpd_prepare(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	/*
-	 * If a wakeup request is pending for the device, it should be woken up
-	 * at this point and a system wakeup event should be reported if it's
-	 * set up to wake up the system from sleep states.
-	 */
-	if (resume_needed(dev, genpd))
-		pm_runtime_resume(dev);
-
 	genpd_lock(genpd);
 
 	if (genpd->prepared_count++ == 0)
-- 
2.25.1

