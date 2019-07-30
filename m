Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969C57AF42
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfG3RLC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:11:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35729 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbfG3RKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so57315912wmg.0;
        Tue, 30 Jul 2019 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RatHWh+WSZJO51BDaAO/tJPgTyTi6HlHiiIlwIODHqM=;
        b=AUGPMfrpqrLf6isEeDUZRDdvbrSFitLmYvA1aUHmA2+cEgeNdiyBKXZCozthcYdBQA
         ZSSiHINPOdowc1qIMNAACfppNURt8zRnMpcAbypCWz5VN1tRgoLJNpsSDsNGoIFuHr+1
         O/jauIkMgJWseP/JNrREARwj6+mT1Y3Y1+1Is5VcU3gNHZIdJKjsBLd0ESnrLMGk9aYB
         Zrf4SgsFaYcYtOBzz6oFhaAdo9HVc0lXY2BTbSEmOwYGX4rWm/li5rYLCVCho0urjI7I
         nCPu8s2E8friZy5xk0SQ2Q+Q0XyNl9tJh57x+ui2gvv7dglddj8xknyykp0D41O5W15F
         venA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RatHWh+WSZJO51BDaAO/tJPgTyTi6HlHiiIlwIODHqM=;
        b=Vq9w6DRpoWJE3+IWV0uuqeBmlKjx4bxRAWBhQZpqmks9AxTwWinAweeAn04Asw0U0F
         tHA16EQXD0LAQg/ULf8gXn7iRL1hHY97p25QqmA6Rzi4JpaCHRsSevUjLxavh4fwdUQr
         qs5pWfDDZTqHqE9SNKcy+o12NDviBFKlTeNeEnmGzvL7P0F220mw+bExIJu1f2G5XjQG
         XWJCiT3iW+H5iPohuj32k+b7y9up2eCKhkO7Yn4WAhZkc8GSJO7WkPIdEy7lqWlsXbY/
         4NNhYFX3bl5ixs4gHfvAeg+1ubAuMj5gQpygcUU/dbC6mYUPjBqJwsa/2m7waO65BQWa
         tiiA==
X-Gm-Message-State: APjAAAW1W/cAJHTkqz/8ajnh9GryeBSORyfCDZOTxcz93enoaxNCb2FA
        hS82WZpueFV68h1oQcTrCVo=
X-Google-Smtp-Source: APXvYqyf3AuU7dHOUhFwQ6/nJUqRu6dqjccLVp6uRnAKN5itoppColHM+3D79FhzEVVE/ssL0RBr/g==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr110401178wmj.116.1564506610113;
        Tue, 30 Jul 2019 10:10:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/13] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Tue, 30 Jul 2019 20:09:45 +0300
Message-Id: <20190730170955.11987-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpu_suspend() may fail, it's never good to lose information about
failure because it may become very useful for the caller. The new CPUIDLE
driver will handle all of possible error cases, including the case of
tegra_idle_lp2_last() failure.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 8 ++++++--
 arch/arm/mach-tegra/pm.h | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 2f6fb54be9f8..f9c9bce9e15d 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -189,14 +189,16 @@ static void tegra_pm_set(enum tegra_suspend_mode mode)
 	tegra_pmc_enter_suspend_mode(mode);
 }
 
-void tegra_idle_lp2_last(void)
+int tegra_idle_lp2_last(void)
 {
+	int err;
+
 	tegra_pm_set(TEGRA_SUSPEND_LP2);
 
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
-	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
+	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
 	/*
 	 * Resume L2 cache if it wasn't re-enabled early during resume,
@@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
 
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
+
+	return err;
 }
 
 enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 3f3164ad04b7..ae68fc7db576 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -25,7 +25,7 @@ void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
 void tegra_set_cpu_in_lp2(void);
-void tegra_idle_lp2_last(void);
+int tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.22.0

