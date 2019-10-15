Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B537D7CA4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJORBu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41128 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388448AbfJORBt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so15044925lfn.8;
        Tue, 15 Oct 2019 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKVJFFh8Cx/4gPPO/PGTSjqb7RA5OGONGJRuyQho6vA=;
        b=R5BzyqQOYuLNoBodaGGxY6Hx09q1YWK4gcJfNCU3Glsqac2WO8Gk6of1xPUz2OJ6qm
         lg7QDeqyOQZhH902/Oa12EOS9kJK/QVRuQDAwY1IGSnXhq2p5UB5OKf1Gm4JypFwiokT
         GAGYYGlI4zGMFSA+Y5MO1aomvu3hIM2w8LCjz00IGvJNKwDWvXU4EgltE2BGJ+ja5X8h
         xW8MYIRw7wRHySldiEWSo0Xd1z52YOSvrDCspTZ2Y66v76oaBUoBcKhIVjzk0foAXPc4
         /wPsHKglIfnSzbRhIJyKEAs24iyaBLT6Z8GbqwIXX4KWgBOywLsQX1qmxnadttMFu7N/
         Nwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKVJFFh8Cx/4gPPO/PGTSjqb7RA5OGONGJRuyQho6vA=;
        b=jTZFRoYVdoyp8gA6Zq5lYaVqdQtjnGnNxJgp+25jjj0rmE7g5tlE6ZHcrH/Y4fMUrl
         p7ROQWbWGBqbAtplIRGbjuzCtnNeFnuPXfHgspSz6mBrh6kBZSTyweHwmityCRmIOT1Z
         AVMLVTz/eaVxFhiwjwuZwGJqoctaTC1J4cb5w4tLEjCsa0RjyIGzeLbqgJ3nQeB4ZIwP
         TuuUuN5YkA0CDEH3HYP2/zmOK8kCf5q3ahJT0aL7tyOVW/5sTtR8YLv/s0TnKROAvs7l
         +zkpNvojHS+j5ZkCeFBamoodYWcRCVTyRng81V50cgUilxUbpPfOkMXgX/8eIK0JSgff
         DaPw==
X-Gm-Message-State: APjAAAW5i0z3yzb4CPoQXRywdzealn0D92Be562CVn5+0AcqZUfNl5nv
        1LRl3kbJeuaXFOgp0fy5OcQ=
X-Google-Smtp-Source: APXvYqwJ82d/wKxxUowJytKFAk2mnLq612OOTqGPmIMhDOvZ+2GnNyH+tfiGHs/nR3D4/pzCQ1Kg7A==
X-Received: by 2002:a19:c518:: with SMTP id w24mr3155277lfe.14.1571158907142;
        Tue, 15 Oct 2019 10:01:47 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/18] ARM: tegra: Make outer_disable() open-coded
Date:   Tue, 15 Oct 2019 20:00:05 +0300
Message-Id: <20191015170015.1135-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The outer_disable() of Tegra's suspend code is open-coded now since
that helper produces spurious warning message about secondary CPUs being
online when CPU enters into LP2 from cpuidle. The secondaries are actually
halted by the cpuidle driver on entering into LP2 idle-state, but the
online status is not touched by the cpuidle. This fixes a storm of
warnings once LP2 idling state is enabled on Tegra30. The outer_disable()
helper has sanity checks for interrupts and secondary CPUs being disabled
and we are pretty confident about the interrupts state during of CPU
idling / system suspend. The rail-off status check is added in this patch
as equivalent for the "num_online_cpus() > 1".

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 7d9ef26e52a7..d1e1a61b12cf 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -138,6 +138,10 @@ void tegra_pm_set_cpu_in_lp2(void)
 
 static int tegra_sleep_cpu(unsigned long v2p)
 {
+	if (tegra_cpu_car_ops->rail_off_ready &&
+	    WARN_ON(!tegra_cpu_rail_off_ready()))
+		return -EBUSY;
+
 	/*
 	 * L2 cache disabling using kernel API only allowed when all
 	 * secondary CPU's are offline. Cache have to be disabled with
@@ -146,9 +150,10 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	 * if any of secondary CPU's is online and this is the LP2-idle
 	 * code-path only for Tegra20/30.
 	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
+#ifdef CONFIG_OUTER_CACHE
+	if (trusted_foundations_registered() && outer_cache.disable)
+		outer_cache.disable();
+#endif
 	/*
 	 * Note that besides of setting up CPU reset vector this firmware
 	 * call may also do the following, depending on the FW version:
-- 
2.23.0

