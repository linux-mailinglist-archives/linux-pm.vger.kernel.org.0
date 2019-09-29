Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9826C18D8
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfI2SAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33794 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfI2SAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so7125096lja.1;
        Sun, 29 Sep 2019 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hb10u+5FTmJk4Ov2bvkx+DvcjkejWf8nRCYDqHfhxFs=;
        b=jEkRti53uzQ/wwAgHw3isn/r1DUVfAcnhnVf+caN1qoNtV8C2z0dc07uMUxWpc3qXQ
         LV87UD9YX/htWOt6ZnjjuNYxKsvlybnvbkcZcteDQ2iBbe8oi9ySqn24IxT+MiUxOAyj
         d9s7o9O+Mt/Pz/2gTgihD16xYGMFFvJyno8MJ6+srEiY7OyxVrF2SIy5QA9HPzOTMUgZ
         7JFJ/8EclvgokkLb2wmDkNKVI+RfSsnYBXoCDwv/q6k7I9cqPMbHne5XVKpjs1AD8uz2
         myZ+I+rCV8Sxnev1sQErd3MGEjDnvlUjpLgsTDV967JVmeTuobCkUugo/TS+Eo6cjwgo
         zDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hb10u+5FTmJk4Ov2bvkx+DvcjkejWf8nRCYDqHfhxFs=;
        b=J+SolWxgZzJN3e7JQTsduWXWWLO/FPJPhectAT1mCRiYAGphACrQH0RT20XeLGYw4v
         rfZzfENXh7mfAK/gLwyX+19f9uMfPk4ZUcHbZ+ZsSMJIHON0aL/1z5sjXrbBadpnUlVH
         QqGug6IJS+wfBybX2k3ZlLhYeIJyNRTVpeP/6RmGylf5eSNv40tiDRS4p1c6P0YLXWkx
         oVOR0M5tHcLt2UP8AEbePitlPs4oDEzlyyh2/T3jyjmWCjtbcbyxsIsbufopWoNbqgJQ
         L6uBc1bsD/MIOzYkJdXaRS80kPcuzkKUuYVKGkwL0TDsLhPhC+z7Yci9axdHzAKZDb2b
         APqg==
X-Gm-Message-State: APjAAAUSFxQFopyhZRf3VCEaMfyay6ShEzGKVWIJPIN7DXAKcsl87dOW
        TwRFyac+m73CtxIq81Fd4UPfPTYn
X-Google-Smtp-Source: APXvYqymnfaHb1KTiEwwOGyKrX3EBgNSg9249nqO2pYjwowQ5RKJ4/YQ1pghOnwwn9JKfAheibJdpA==
X-Received: by 2002:a2e:9a83:: with SMTP id p3mr9684509lji.136.1569780011032;
        Sun, 29 Sep 2019 11:00:11 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/14] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Sun, 29 Sep 2019 20:59:41 +0300
Message-Id: <20190929175952.22690-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
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
2.23.0

