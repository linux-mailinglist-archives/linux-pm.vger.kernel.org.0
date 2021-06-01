Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848C9397CE6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 01:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhFAXL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhFAXL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 19:11:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74BFC061574;
        Tue,  1 Jun 2021 16:10:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i9so255936lfe.13;
        Tue, 01 Jun 2021 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRuetqj60vCol0jIW7eqdwzeG6NNor0Vk1d2LV6pFl0=;
        b=DPRn3nvK9VUuZIY0y7bcpXwEBSbxUxXkbm7+tKfMV9NKIGV/DrM5yNJn7VyKoEhznJ
         jyrwPUClZ5zclgQlt7xHQyjmWM1YPkIjGKdQUAoOuWKc0rwsinhkg5vMJRsbxZIlyg87
         QAsVYg9AqBlEzABFMnFKJfUsXA8zPLhwAYv+COfqqWGenRXwJEnv+GOlKcs/2N2RwX6J
         w+fc1H7G1WRifIwMtHe5hHm3G6mHkk4xbtQKnN/YNm71oY6f+0R3tb8cYWf4U9g32nnK
         cUPTKGXMB4eZYBTBgPBo7huuU2z99gpHA4s013zwbss23mDsIkLL3NupVGZIsTfoYAW8
         8gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRuetqj60vCol0jIW7eqdwzeG6NNor0Vk1d2LV6pFl0=;
        b=HUjTB8MiBDbN9NknfLTCcup0VLK699ifWh9MyTKZ2xzgtnZZwPtVGH7MobjyIvQkeh
         PeFom0XwxY3+OndJUiygjTT6/kWk92oqAiE5TWaiWGXd2S9066BEVpmb3S+pJRdjjSiB
         3Haupk2oUGLiuTtHr/g4isztOwR3ibDz1e4VHT+UZyzqRf7gZsfAzZso3kVB2mbS5XNf
         jJWnIARwfrzog4DJ7glrlMC6pbIidEZxFanZvVsa9hyX84SniqDYz2xycGrBtRP8Q/74
         5sXDpvREOn0E0/Z171XIbD5qackjSlsLkzj33csbziyjoJiu972UFxc5zyM8dbcnKo8s
         l5gg==
X-Gm-Message-State: AOAM532f/ORzu2JJl7iAf17n+GgxaX0ZedmWlJM00L+jW8KSFGAoeXpd
        f4C9Dd+q+A3LU9o3wELHWEc=
X-Google-Smtp-Source: ABdhPJy6hpbqg9/mq+2o8H8eC+O+t3sLyZUIWV/3C9vxrxompKPjdpJsdUKZeDD0cDMrT7ZfVOEg6g==
X-Received: by 2002:ac2:5084:: with SMTP id f4mr12870728lfm.466.1622589014237;
        Tue, 01 Jun 2021 16:10:14 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id s9sm1813574lfr.231.2021.06.01.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:10:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 2/2] soc/tegra: pmc: Remove usage of lockdep_set_class()
Date:   Wed,  2 Jun 2021 02:10:03 +0300
Message-Id: <20210601231003.9845-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601231003.9845-1-digetx@gmail.com>
References: <20210601231003.9845-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The lockdep_set_class() will become necessary only if we will have a
nested toggling of core / PMC power domains that will happen if we will
add RPM and OPP support to Tegra CCF driver. Ulf Hansson has concerns
about whether this is the best approach. He suggested to remove the
lockdep class annotation until we will agree on how the OPP support of
clocks should be implemented, hence remove it for now.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d317532130c3..ea62f84d1c8b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1344,7 +1344,6 @@ tegra_pmc_core_pd_opp_to_performance_state(struct generic_pm_domain *genpd,
 
 static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 {
-	static struct lock_class_key tegra_core_domain_lock_class;
 	struct generic_pm_domain *genpd;
 	const char *rname = "core";
 	int err;
@@ -1368,15 +1367,6 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		return err;
 	}
 
-	/*
-	 * We have a "PMC pwrgate -> Core" hierarchy of the power domains
-	 * where PMC needs to resume and change performance (voltage) of the
-	 * Core domain from the PMC GENPD on/off callbacks, hence we need
-	 * to annotate the lock in order to remove confusion from the
-	 * lockdep checker when a nested access happens.
-	 */
-	lockdep_set_class(&genpd->mlock, &tegra_core_domain_lock_class);
-
 	err = of_genpd_add_provider_simple(np, genpd);
 	if (err) {
 		dev_err(pmc->dev, "failed to add core genpd: %d\n", err);
-- 
2.30.2

