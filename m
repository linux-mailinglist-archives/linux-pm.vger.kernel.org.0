Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58486699D3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfGOR3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbfGOR3u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so17126918ljh.2;
        Mon, 15 Jul 2019 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RatHWh+WSZJO51BDaAO/tJPgTyTi6HlHiiIlwIODHqM=;
        b=YCxjBQ0dgT+LIdjwWrqKjoEqsb1bDymfKP3kPV6zR9IjEopiAu0/EqlOebUUfHDX5w
         zz+4Tvgg0oDcoZ2pVEGcgghbm0LXuJN142WjlGSdRDdgrpRvwAHQ+jNjbsKkhyhGAElY
         P5D6/38/7GcB1LVFXGCNkSLfs8eLXr/pIwRbh9lm2+HvDzYK7mbn2snTjQ3+5J8GR5aV
         ehv5RjiXuc74y3AEAXMa0yBTmOWtGeGLlqc6pUj+A2YfHTXnM/GHXjEadwLyUBrDK3le
         x1JgQS5hd85AZzGH0WxnyNnEuxnGNW8PEbDcWM1IxSjE9cnDlr4lViHNlTq8LPkQ+bWu
         oZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RatHWh+WSZJO51BDaAO/tJPgTyTi6HlHiiIlwIODHqM=;
        b=BPjXXAHQWmtj9Aryjy+qx6ijFkxaYkxVg1Y2Y+0KfMzJMpyP9JKH29/V4R7/FtFAD9
         w9gYp9yKornjpniRpZzrx6IcD617CMxeQ8q8z1tqiYlEBv0WuE5w9zPOME5bqzjzs8Lc
         aPPNARBfU9PqrcDypqVvJ8b7MwaU1vJdWEAR3Ys5WFZiv+NYGI9RQooEBbhZ7V5lM9S+
         gD9jY41UATjy/LEmtz6DzAq2UryAHqsxi9GShdkxcCePvG9ZnYjAF7nGCZ8iPtuWXuiJ
         oy4Esk3JkAiCjW4BSp5e3rsvnhjxxKlkRcTGN+b+au/PE+Cr33BSXhUAqfRjwkLCZzqU
         BUkw==
X-Gm-Message-State: APjAAAUrIOMcAHaPcniJWXYfojYrEZq+SppsMlwF/yMf20/j7x7hXfUB
        nc2R6K3d4aSEAk9UD9OresI=
X-Google-Smtp-Source: APXvYqybrC/BDz0zU8yBa2W+gs2MV9KsGr77hQlEYneiZ1tKRQSVHKyXIgKDtPbQLztrw5DYuoDAWA==
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr14795572ljg.83.1563211787757;
        Mon, 15 Jul 2019 10:29:47 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/13] ARM: tegra: Propagate error from tegra_idle_lp2_last()
Date:   Mon, 15 Jul 2019 20:26:19 +0300
Message-Id: <20190715172629.4437-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
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

