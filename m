Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8510F42D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLCAmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36376 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfLCAmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id f16so1418753lfm.3;
        Mon, 02 Dec 2019 16:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ulGCTMcCDBRRk2yLFdFo9M4Wmqj5q8vYCHGVC30ky4=;
        b=PM1DpEIefdGw++srLH30Y63fT0TR+zXMyX81gz4dGtjWpyXgP2NpvUbnWHFLVwSj/y
         WijM3WvSt3MZ3cVC5OyybdBIKxVQpczex7yBt0KY6HJnvgEilN6OVNrgEKWk/8654Qak
         xXBpYAZjBBOiVCAIHrTioORhhAo1m8u0JFLH4RuY9F697osQdl6SYZnUF5W/taxM4IOJ
         bV+VbKHMtfV9PsvHdtII2V+5IHNBww8f60/QzgznxHpttTdQCmZbaSSKEdOW6to6QDas
         q1boaekthAdyc8ro86mqN8RcYNx5oi7GUgq9OXO03fDNROAcAaha9y5HNo0x7O8SbsyN
         kCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ulGCTMcCDBRRk2yLFdFo9M4Wmqj5q8vYCHGVC30ky4=;
        b=Lu4QPb/TPAF+mZDJDxaKVSv7aLmzJhihwkAGH78tUv66uvaKTT1RF7ZFRo6dl0mkUy
         P7Be48eGkm2pHYdZ+HXcvmi3d/IlVKfuCrjxVClPve+Hrern0W13L8AM2L42nSL5BihK
         BYPTxW+fp4eaXoaIJhUBl8YLlAcxfbItYTbvJtinX8dYLU0rUyoB4BpB7rQDka+2VoL2
         5pHiL+HZ/CQ7rW1hanp8/N1Ry4VC208uibY7M2dBhstaeKFq8jdkspURsL3K1Gt+OjHR
         Lsn0JRLfzz+VlP6e8umd0iIDBl3BxQoRKmAwfurfQavmYSuSuidxtPi5q1AJPYo4AVfX
         6HJg==
X-Gm-Message-State: APjAAAWy5tuBWZt5WxHu6SUOGt5mbR8jtEbbIVlVwjkZWoaeMvj/iybA
        3Sys+4SEpWXjnppUDvVZ3WQ=
X-Google-Smtp-Source: APXvYqw1uehVpy5cg+XgrJGqqkYH7IwgvT7Cm7YzIaBNPiFp4O7eFINcnpnLo0WhGEBh5uG4t3IInA==
X-Received: by 2002:a19:ae10:: with SMTP id f16mr1006600lfc.147.1575333721957;
        Mon, 02 Dec 2019 16:42:01 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/19] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Tue,  3 Dec 2019 03:40:59 +0300
Message-Id: <20191203004116.11771-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
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

