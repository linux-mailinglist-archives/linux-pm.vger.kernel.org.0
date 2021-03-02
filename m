Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9332B313
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhCCDmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577819AbhCBJzX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 04:55:23 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F99C061788;
        Tue,  2 Mar 2021 01:54:41 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y12so10217385ljj.12;
        Tue, 02 Mar 2021 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjEBUk2Yo9yzSMN/siG4OfzfOZCC1KPOlvofjcM1PCE=;
        b=NP3M9/Gjok7e32SgvQIhO7aPojvZStlELiulysU+JGJtAuSlCHa0wuWsVFGyxWyjJs
         fUnuL3LOabTm5yS09LXxWtAzAGfCK8RXkD19r4vOYeNHMvODZBl3zlMfWfI6/wuRUhvK
         oRZJgriugXl2EfdbL9pO3weJzIMd7Z69Y911OJYc37L32A3WHbAaa2Vd8nimmWceYyXv
         vpDcfnBkn7Scd5O9Y2rpCdRUJoPgpmOGUy6TZFa126NtiJ2fYmPEasO3slG2Wub71Q0F
         W7lrIUYRdFtP2BKuD5JKAneX+22O8Wzxd7AzcTf4cki2Kn/0Geqj2nP303AH86PXfQxT
         G9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjEBUk2Yo9yzSMN/siG4OfzfOZCC1KPOlvofjcM1PCE=;
        b=mzAPtkf+ykwdIYnHq9lAIFWE9omUp99bxn2ZXB8vwOlbUU7a89wFEIi9qsgpCnBPSA
         6e5WY069miuf0T1P0uZLFFQvvqIF4uXoyw/UZuvVXwDlT9OL6bcmAqIGgH0NagCLaMEc
         H+qbqyxCeBuwfb8mCx3ttMX1DgRFZ1/0MyYwlGERaoEsALESUNyj14WkIMJaYUQF74ru
         e5HJ7gucRKRKALGzuN/dn8vo9KRuKFbzFPBtpuB5HrrIvYVc2pKQzAcfQfUuFrwA5E8P
         UIp2U3iwEHOn/4dftGpRHbR2zTSjqiv6hOVg/YSel72x20+/w+1YTFgcH0cc5C0NhZIL
         /utw==
X-Gm-Message-State: AOAM5311i5eGBwn0DQHWx7fg0sqbWNiWLprj99Jv0UAIrRkebXSgxS0e
        HXaDmVhW9MbLIYSdmw+fxNPzblvtL0U=
X-Google-Smtp-Source: ABdhPJyDEQEayqTWPWdpFEkalUr46xUob9kwVIHASWllkKN4v22CYf9cnzvyUvLT0WOwLeJdNciTEg==
X-Received: by 2002:a2e:998d:: with SMTP id w13mr5673321lji.424.1614678880404;
        Tue, 02 Mar 2021 01:54:40 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id y16sm2783451ljg.83.2021.03.02.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:54:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] cpuidle: tegra: Fix C7 idling state on Tegra114
Date:   Tue,  2 Mar 2021 12:54:04 +0300
Message-Id: <20210302095405.28453-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trusted Foundation firmware doesn't implement the do_idle call and in
this case suspending should fall back to the common suspend path. In order
to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
C7 idling, like it was done by the older Tegra114 cpuidle driver.

Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
Cc: stable@vger.kernel.org # 5.7+
Reported-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - No changes. V1 got no attention, hence re-sending.

 drivers/cpuidle/cpuidle-tegra.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 191966dc8d02..29c5e83500d3 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -135,13 +135,13 @@ static int tegra_cpuidle_c7_enter(void)
 {
 	int err;
 
-	if (tegra_cpuidle_using_firmware()) {
-		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
-		if (err)
-			return err;
+	err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
+	if (err && err != -ENOSYS)
+		return err;
 
-		return call_firmware_op(do_idle, 0);
-	}
+	err = call_firmware_op(do_idle, 0);
+	if (err != -ENOSYS)
+		return err;
 
 	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
 }
-- 
2.29.2

