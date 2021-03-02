Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9947B32B311
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhCCDmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577817AbhCBJzH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 04:55:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FADC061356;
        Tue,  2 Mar 2021 01:54:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 18so21751256lff.6;
        Tue, 02 Mar 2021 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9j1HsnymgCA8/9Sl0iXz8e81BDwl/5z9VxLb7DJwAA=;
        b=eHoUhvBNjSX1FX3ZdaC9CJirXCvqj7d0gIxx5qDBVt9B5tCP8nHmjEBWvWUGX8UaRM
         aFd8SbjVy7/n2c2zwvhtzK8jJnNCsWD+5wYUvnGqlLS/A4TyXiYl6SyAmWaLziLsOamS
         F/Dgc7SzLJs+xW01JKUmBBanFudb9mh1nfTSluBu8tiXmyhDx0C1KtF1DPNSFhOfBVK/
         mxiQzegLSpK9gujZLRRH34skar5sJxp1m7dYuVV0be7+BW8zX6W3UlbirODVxaNFxXxJ
         50hkDLv6fSlup1I5G8Qrdcj0cgYemU2xQwWilAwmuvmfzt3kMnDbRwHvgc1XcLfHNhqI
         lh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9j1HsnymgCA8/9Sl0iXz8e81BDwl/5z9VxLb7DJwAA=;
        b=RTfRw5AKvtc5BjDQ8gv1LtuWlAcugpPLV6BOErgxeBXZf+Zv6kylCs1gSN/Xw8RiyX
         fppQll9WO1fWLpTFPXUCwvH+BpoMWF3Akuakk0TBepLxlanO1IYrgD2rjBf6pJ+e9rIu
         c7mqONDeC+169DCavbKz4i3QPGckNJlRpJblyFan2VSPRDrWssn8ZVNwG9j9YnXZp2VX
         6ybpu606lH7IrFArPsxXXyCt1MTCY5LuE26N4eIBif/3Wm1nuex/CB+CWNwRDBTglv3r
         JQbM0whEuGlBtXWdhYHf6lMXrp0mGwAvPy6IYybgzTKXbmDBhNqsj71z3XiKmj0ApRv5
         Ru/w==
X-Gm-Message-State: AOAM532J13zLqdy/VZq84QXIdc3ufpHeDaUdXAIEhS4OGrumSQmmCCXU
        RupC0yXhlXvBCrhejiZTlvM=
X-Google-Smtp-Source: ABdhPJy8CEf4buuUuXeSpENaB8KF73iTgVULqKkY8FcROf64M2981wA+CuKOpAiwelB8dsoT7sFixg==
X-Received: by 2002:a05:6512:1315:: with SMTP id x21mr11916068lfu.511.1614678881213;
        Tue, 02 Mar 2021 01:54:41 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id y16sm2783451ljg.83.2021.03.02.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 01:54:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH RESEND v2 2/2] cpuidle: tegra: Remove do_idle firmware call
Date:   Tue,  2 Mar 2021 12:54:05 +0300
Message-Id: <20210302095405.28453-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302095405.28453-1-digetx@gmail.com>
References: <20210302095405.28453-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The do_idle firmware call is unused by all Tegra SoCs, hence remove it in
order to keep driver's code clean.

Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - No changes. V1 got no attention, hence re-sending.

 drivers/cpuidle/cpuidle-tegra.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 29c5e83500d3..508bd9f23792 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -48,11 +48,6 @@ enum tegra_state {
 static atomic_t tegra_idle_barrier;
 static atomic_t tegra_abort_flag;
 
-static inline bool tegra_cpuidle_using_firmware(void)
-{
-	return firmware_ops->prepare_idle && firmware_ops->do_idle;
-}
-
 static void tegra_cpuidle_report_cpus_state(void)
 {
 	unsigned long cpu, lcpu, csr;
@@ -139,10 +134,6 @@ static int tegra_cpuidle_c7_enter(void)
 	if (err && err != -ENOSYS)
 		return err;
 
-	err = call_firmware_op(do_idle, 0);
-	if (err != -ENOSYS)
-		return err;
-
 	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
 }
 
@@ -356,9 +347,7 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 	 * is disabled.
 	 */
 	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
-		if (!tegra_cpuidle_using_firmware())
-			tegra_cpuidle_disable_state(TEGRA_C7);
-
+		tegra_cpuidle_disable_state(TEGRA_C7);
 		tegra_cpuidle_disable_state(TEGRA_CC6);
 	}
 
-- 
2.29.2

