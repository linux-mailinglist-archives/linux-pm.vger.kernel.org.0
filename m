Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8C12541E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLRVGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34243 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLRVGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id k1so3074505ljg.1;
        Wed, 18 Dec 2019 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7zoQEFmsGogAWkaE40lhlm76GWfdMIaBL9Y9j0dDa0=;
        b=YS0GF1CtA72Gao7lovkHwuYxF56pWlrfs9x+GEcgCdgHxNTyPdLdjVjptok0oLczW0
         T4ZMC/tnMRK4cztUBCG1lvE7KLEua5Zunv9J6jJAiCZ6Iz9EoZJp5a6CBXkXuOrSworD
         uAinlbJpJT8Uztw+gR0c3l9HaDme0kk6shwx1W/VQcIPCJ/3IqFH7ZAnIl749NfFU1Ly
         U6A2Q1QYZsnR4Dohe961F++Q4CizqT7o5bqJhfZ+IvSMW01ATvGLslRFUU5oTeiBOanR
         7G/qITDH5gxxsCpWb73kUlPf+OJiuAkZ/D0Z6jkYwdsvgPUA9rEuKIg4kiRvNTlerSJH
         p63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7zoQEFmsGogAWkaE40lhlm76GWfdMIaBL9Y9j0dDa0=;
        b=lgbkAju0WdSwKrBq7vwqtNv6YvVN93AVrT4B+xd//IUoouXnvLLQCeWMB9hO6KLpiL
         SEj/isaK+o2aQHDmsIjy9gE8GAatrnNAxdtbugP/qSD8uWGwysihPTccWUxDPZYJPmzd
         TVkluEo+/Zod27m77CdUxt2I79/o4yDRpc4lUtfwEGsGL6rfF+gMpdJe3NCcgVZza40z
         14xIAtdoCRWEPOU0fpiuC4aciZUay/JTqy9W7ap3lhi7/uQmWnpJoOKS3FAfr4dAFPu5
         cDkVKna8jhBjmh5/tF9lLS98iDKZMNC3zmg1SuH2dwlzS54G+zBXiZYSK5liMeokYg0O
         9BtA==
X-Gm-Message-State: APjAAAVMAa5Ur+rzpW77H0ZkzhX4N0d/uWctwqriEiYUOZgGqpcVcs77
        +vjenbVEmQAzODiO5wu7KLc=
X-Google-Smtp-Source: APXvYqyBZi6N40MLE2qthPqi0FTpqbgkqfrbGreDo4DBfCoAxGlI5qKFaJyS32WPSBFhqp7Y7Pragw==
X-Received: by 2002:a2e:8015:: with SMTP id j21mr3392113ljg.172.1576703208128;
        Wed, 18 Dec 2019 13:06:48 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:47 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/17] ARM: tegra: Make outer_disable() open-coded
Date:   Thu, 19 Dec 2019 00:04:54 +0300
Message-Id: <20191218210503.6689-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
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

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
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
2.24.0

