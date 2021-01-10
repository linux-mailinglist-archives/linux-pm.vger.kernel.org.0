Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0532F0A68
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbhAJX3U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 18:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAJX3U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 18:29:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF3C061794;
        Sun, 10 Jan 2021 15:28:39 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id w26so1453355ljo.4;
        Sun, 10 Jan 2021 15:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gmTSjSeyUWQmPkotNjgjdIHP/fEVm6ggDFHMD/YD1ts=;
        b=hFfhMSm6L+RIZcO73W69XnCqWlYC5WZap3JcD+9ZD1RKoDnFraA1me0FPYbxCNAPRf
         GZIJ70uhQvQyJT5/Q7Qou+P3f2k+DUoq923iqDc0waWolvjDi1uwWx7HTzRo8ciIYv5h
         rOypS1xiFFhqCji6tYAVKgk1cfpXdfE56xUFC+mgK0gAi7NKAKbQfHy5T5veosfz8RJc
         IdNxG9G08YTrTDV6m1YQAxklln1qkophXvkP8O8XQ/56LgWXfcqlbEvskig46NHKNdoR
         An9NbQMSyYOLcsw/YZb1JWtLSnKydLsDpH12mUN5CP5flbNFF1srww0BRb6svtlyg59F
         KNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gmTSjSeyUWQmPkotNjgjdIHP/fEVm6ggDFHMD/YD1ts=;
        b=ggDCL8cfEa0EZNK5SkFgtfEkTcS27m3KfH/4nuA/qfOb7lsYtL1r4wCpmxDDYGBUd3
         8FfIQjvdh8EPGyJxsQ00Bbowc8NQV9TJXlwo6VrMrtsbHd/PFlHRM02jeObtUegygAlW
         kEPiCfxR8HMw+kvMF6r+QOJAa04ZLvg5vSGE5hEzOfB3IEtU/d19plIG0/D7hzFn0kon
         Hwab8foaWYKgHlJlSRWLCtHCa+nF8eTgWOz/su24WZmC6rNtlPwe5fOYp06LxHLPaNqN
         k8ZtZu3bXVErBrUyanHnKfRvNwzdLVG3eh2+gLHwq3Ud8Yog4Xr2nk4aId5LOJ1FwDFY
         q4Rg==
X-Gm-Message-State: AOAM530ch5BH4+z+VXhSPp2byKgkOIH7m7VyUGCPMOmEcWTOPYCmR/t3
        fzVyYvWFxweSvyJL6FhdWGQ=
X-Google-Smtp-Source: ABdhPJz//Mv/RJyC9CZ93smyAEujTwC2Q0Oxx0c4wuPDDbR3gBg8sKl77o8tNFj3po49jgIGpaFA5Q==
X-Received: by 2002:a2e:9988:: with SMTP id w8mr5852507lji.107.1610321317867;
        Sun, 10 Jan 2021 15:28:37 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id s27sm3220563ljd.25.2021.01.10.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:28:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 2/2] cpuidle: tegra: Remove do_idle firmware call
Date:   Mon, 11 Jan 2021 02:27:05 +0300
Message-Id: <20210110232705.20658-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110232705.20658-1-digetx@gmail.com>
References: <20210110232705.20658-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The do_idle firmware call is unused by all Tegra SoCs, hence remove it in
order to keep driver's code clean.

Tested-by: Anton Bambura <jenneron@protonmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 49531939f24b..e8f92e4d5739 100644
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

