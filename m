Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D35125437
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfLRVHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:07:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfLRVGx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so3726964lja.4;
        Wed, 18 Dec 2019 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ox3xjJZhAlXLoh8odxfq7BNhkqrIMThtE7VeUHdCC/o=;
        b=ZZ/1erMZSG3LqTV+84+dNZ+PeJLS/TJVEq/ZGZ2xKnTtPz3/J4jzf/mf2uZ5tLoviL
         ZwdRixKHsbfuhVVX60hEUhfFOd4so17k6sImZ8sCV507F8SgR4fnQuRLmfBsjxNCOe02
         XWauyssTD2fujG+5DapTGla1KnoGxvWo0sbT2dhqCGoiD4FLYOxl7vN172LCMSYXkKzn
         Z3w4T6Umlcw0yKvHaqhKsWyClgpD6TUONovfQq2Ey2mkHGkkRk+EnzzeL15yQbxzHlYa
         Zf2MHHVkyf7rZKwdVp4O/l6mtAA0EM+47Mjt355WbveSVAOcPg1TpUoZIuJxr6Y2aD8k
         xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ox3xjJZhAlXLoh8odxfq7BNhkqrIMThtE7VeUHdCC/o=;
        b=ehj61b0pDJwiWv7o4F+Q9DgNUwO4atVa9zsMieZmOsvd3ZVsjLPjN0M7JUA5YarxBi
         lwXB+K8282Ju0Mw8rZ1Wqv/ev5h3wcTHpOhlCUj9c/7sXFSmBCYZRLZItHeozBfnq2gC
         8h+xL5Ow9aFDsvdZHhsOZVlnVojdy6jP6g8JYXELQJlgdwxQzo6uDRgJO80+JEbBJ6Ve
         UMKgtpu7cku9tZJqdFurdhzdThTKGbCsUxOYBthUaJ1kq1jiSMd0jj2p9pbJin26HHXn
         yvpkLwKwT/be4StTzHAp4PJf5ET6d6nVHafoJqq5YZBn7tBgqU2Ipii8b4JrRILUUzsJ
         qidA==
X-Gm-Message-State: APjAAAXReic+z9XBM0GHYe5yIkdjaTALEhs8oK7b58fKhhyfVyeaDw4v
        qyhab2Ceb7o67mI2eJ4zhuE=
X-Google-Smtp-Source: APXvYqxBUk8VaEJtN37Hc5GIgP+xYncwHQ+X6s0x9iWLjHbSWGpIYzAFPzDlF7BGp3H85/IGrVAe+A==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr3268848ljl.83.1576703211300;
        Wed, 18 Dec 2019 13:06:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/17] arm: tegra20/30: cpuidle: Remove unnecessary memory barrier
Date:   Thu, 19 Dec 2019 00:04:57 +0300
Message-Id: <20191218210503.6689-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no good justification for smp_rmb() after returning from LP2
because there are no memory operations that require SMP synchronization.
Thus remove the confusing barrier.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 2 --
 arch/arm/mach-tegra/cpuidle-tegra30.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index ccb8b0aa6c46..f8f14c0b79ff 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -194,8 +194,6 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 
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

