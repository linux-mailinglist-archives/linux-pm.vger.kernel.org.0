Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0215AF820B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfKKVRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:17:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46707 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfKKVQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id o65so7309316lff.13;
        Mon, 11 Nov 2019 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0El1r5sR/3XS90TExiIvdI2lmehipmygt0wHnvPAxUQ=;
        b=cWSmRnOm5ugBk6/Snx7xQzymzMdIhnOaqFgdTWKHqyrSdHbP6p/FEYRQedUk9abRRE
         zXCAN2gtRDA3VrLB8MzkdmSOMuBqQ7sBArUn35dxWK136eYwppfOr8P9sq2Tz3Ih0iRy
         IGRlHLKco/8jAb4YSk7LMWiXtyLL999HJros8/b77/nfm6RA3kA4I4SAw4RPmiIULiNf
         9gf+1u6nm23d4hH4bEnj4dgWvSR3k5t5+0nMPuYmsXK4mBAC9sBHdm5sdywzyj+cxHnK
         nIZbOEqCz0ndqMOzb1hyBuYvP9zQLqD5E2q8l1MwTybtVed+eQ3CdhTKd+nNfmaDq4Ub
         ytrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0El1r5sR/3XS90TExiIvdI2lmehipmygt0wHnvPAxUQ=;
        b=n4fzK0VgcCOIh3JlT+ZWvyJHBWLtavmnK55yHpBWM0MACmt6TVRLVuhkuzOr5q9QG0
         8o6bP+PcfpMcUH4bRqiY90DK6QidygwR0nyY/Qs1evzh8kPVONHRdyddgJ4P18DF006g
         OLz36OXVzfcjvauvcg8gbS6kQVAN/tloPRQNBYFNoeCQ6+Hf+tx5bTtVyMbEFB1boqr6
         +ITC50M7FlELga/cONdg35kjI/RfgdU84bKT2lLDtSnI8VvAD/J054KQAHKru+3oq5v/
         bj+9/bAlHI7LMkBoQqyDNYOuj8umKQixLOBF5SLwBwoTb669vZbTfHWrKYlPkt3H7rmf
         6y5Q==
X-Gm-Message-State: APjAAAWdvUM2xtil1cVbFjH0Vwr834mMxumkF0JbrnUfaiJDMP8WNtkn
        AMyRc9SU4npokWeu+Tt8Ce0=
X-Google-Smtp-Source: APXvYqwI2DYik2l74mXPwId3GVHdWw0UbWtR9+K8IEReNeyySyIhaLnkA9FVn/+0OqPoTHg+GeRLhA==
X-Received: by 2002:ac2:4474:: with SMTP id y20mr2907375lfl.95.1573506995316;
        Mon, 11 Nov 2019 13:16:35 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:34 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/17] arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
Date:   Tue, 12 Nov 2019 00:15:50 +0300
Message-Id: <20191111211556.20723-12-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no good justification for smp_rmb() after returning from LP2
because there are no memory operations that require SMP synchronization.
Thus remove the confusing barrier.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 2 --
 arch/arm/mach-tegra/cpuidle-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index fe80f1988120..af2cd339db43 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -193,8 +193,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
 	local_fiq_enable();
 
-	smp_rmb();
-
 	return entered_lp2 ? index : 0;
 }
 #endif
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index a4f0add46a27..80ae64bcdf50 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -113,8 +113,6 @@ static int tegra30_idle_lp2(struct cpuidle_device *dev,
 
 	local_fiq_enable();
 
-	smp_rmb();
-
 	return (entered_lp2) ? index : 0;
 }
 #endif
-- 
2.23.0

