Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85AB10F400
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLCAmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37755 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfLCAmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so1413423lfc.4;
        Mon, 02 Dec 2019 16:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPWz6Eps+PhevUacVbz0yxoPDkrfT6VaPLM5BXqdcsI=;
        b=aLOtU4r//tQHJ0s0P85Xa2GTz9bMIPnWQbIWq0RIjUxJPAc5Gfy7ojVkUz8wlTY+2d
         0L2B8iHVVr3F6ZMyhdIMq4tm6RbTAQ5fWPVytZWQUVifQ3CWm2g6FTroG1rAEXzpov/Z
         PNCkJ/FMlkgA0EJEnG2rCTEG2+oRpcYP6r36LKEnMA77d8IJ89q27mgeHJfSkLegZdkG
         Zho5xsE+6Xpqf6UM1Ltr8VDoaWXZcGnZ+qhKZ1jJSjsgr/EkfajrP0/H10jIm1jdqWxV
         PY54SwiB21bzhKz/w1xJY2DO5LBcKBDhKX2bt9eAWJjlcCSQTxfGEtShaI7GtxPVg8aw
         dYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPWz6Eps+PhevUacVbz0yxoPDkrfT6VaPLM5BXqdcsI=;
        b=tz+ibvIP6yt3eq5tk0nkCyYpa2B0qI0eBvucbduYij/USz8CF9oawgcC2TGrjBoAgK
         /1V/vQbLZj5w1hJl9G7fyDanhPzldR3/sPrtlGVVe7uRV/75Ib3c2mGcioifN8vkpE9F
         Qsdj3koLZrNwKdIQTXE3OMV6MxRY6B4WYjzKJOd5Hx3QLmzb48nmKNKnjHX9Krw5Hu4d
         CJEbWc0QZxqhhJKjWcCaiN8skTdz0jrntuRPFldXsWfKxQaqPRbePE/iztI89EFFFWhs
         cF3bgU7wU5JxqFK1XWvwHYXuNg+YEMg6fH5/2VdLtXkO2hSK0V4SyMBnHM6KmjrEpcqQ
         5iAw==
X-Gm-Message-State: APjAAAX/U1MuTKQU9lak1hYT27AS7/5YpTA6qnnjBEQDlAZw0izQp92j
        zLueoO5oDayuRiqNCSpXqkA=
X-Google-Smtp-Source: APXvYqzCGutgD2DB6pOTAMV4est1pbVbMLLuTEe/8IXprp0YJhjGPp9cyqhBlQN0h55qaukg9EJC/Q==
X-Received: by 2002:a19:7611:: with SMTP id c17mr983236lff.86.1575333732664;
        Mon, 02 Dec 2019 16:42:12 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:12 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/19] arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
Date:   Tue,  3 Dec 2019 03:41:08 +0300
Message-Id: <20191203004116.11771-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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
index 3f4c75dbb4aa..78cc424fac35 100644
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
2.24.0

