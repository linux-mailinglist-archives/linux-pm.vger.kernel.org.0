Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A575C15B544
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgBLXwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41688 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgBLXwN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so4429903ljc.8;
        Wed, 12 Feb 2020 15:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTPdM12fyBCCVlKFI3ULFHoFZOJF/ALHZLwLAFaee+A=;
        b=oRIIW20gG3imlnTsCAcHYDgHbDKBSW9M6CiCnJbeOFak1W6Gp8HAsSGFquhiiAohA8
         MJyZox9B+LFbEJq7lOMiKJl+9zzvz0w1AkBJghtyV4dSDtLCd54OsG5j2VYC6342VK/s
         VPBnEw2xGo8MJnzEwExTpDn+LVEe7QUinEtlzXkzJMT+lCH3PgyfCFwqvEOiWWoDBqE9
         TNOeiDKIK2cCPfD/VBtHpqbXnkoci8gWMLtwuPDAJEdxxNluNCq8cuhLC9VGNWh8sRGW
         06ZHD/fOY5wRSet+1Q85Da8sLUHALv+I5utRzZZeta+kBM3sNCgL1vK1a+nWJV2JrO6a
         gszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTPdM12fyBCCVlKFI3ULFHoFZOJF/ALHZLwLAFaee+A=;
        b=hBddlwjnntqjOr4JWjVdXO5ojB9V1DHkEIJbHIfAI1K9VJVMBe4dlU6qTJqfxJelBk
         TnbcGX/6Ja898aMo8mU+4XiUnsOQjWzTqjkvZeqvwX0uMt/EznXTrLTK+dIc2JRPY48m
         rugG3dFUYAQEghB6K7xuXUuI3DAQvsPAnWwMk+QZTqBylN+N+nblPbydJR4u1tqd8/6s
         tDrbbXe8qRMCqYRnpk3bWPuk1FGEUZCTFZzy+b39ZJvzA4M0NV4O9KHOArqDPz1xB1Ro
         Z6qRSpJLyc82hycYQPE2sDmKAUiWWHlyFZacdA+lk+zAfU5rUxsRVZ7Ea36w6JDZBNFe
         r6kg==
X-Gm-Message-State: APjAAAWHkWWsjn2jNyN5u1AtSDKu5WxjlFn+JAr14fgQDo09R0CGQYwm
        MISkV1rpD7cc5brfJV7jApE=
X-Google-Smtp-Source: APXvYqw+BRcwzoxFYm00DSpaVKnNpINQ3xuDsVT2izfRuLQEK5ztJoqNV/2a7HXsnLb0T0xtyCtk3g==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr8937131ljm.202.1581551530835;
        Wed, 12 Feb 2020 15:52:10 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/17] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Thu, 13 Feb 2020 02:51:19 +0300
Message-Id: <20200212235134.12638-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This function resembles tegra_cpu_die() of the hotplug code, but
this variant is more suitable to be used for CPU PM because it's made
specifically to be used by cpu_suspend(). In short this function puts
secondary CPU offline, it will be used by the new CPUIDLE driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 14 ++++++++++++++
 arch/arm/mach-tegra/pm.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 3cab81b82866..f5ff3dd1dd81 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -436,4 +436,18 @@ void __init tegra_init_suspend(void)
 
 	suspend_set_ops(&tegra_suspend_ops);
 }
+
+int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	if (cpu > 0) {
+		tegra_disable_clean_inv_dcache(TEGRA_FLUSH_CACHE_LOUIS);
+
+		if (tegra_get_chip_id() == TEGRA20)
+			tegra20_hotplug_shutdown();
+		else
+			tegra30_hotplug_shutdown();
+	}
+
+	return -EINVAL;
+}
 #endif
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 569151b3edc0..9a790f00237f 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -31,8 +31,13 @@ extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
 void tegra_init_suspend(void);
+int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline void tegra_init_suspend(void) {}
+static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif /* _MACH_TEGRA_PM_H_ */
-- 
2.24.0

