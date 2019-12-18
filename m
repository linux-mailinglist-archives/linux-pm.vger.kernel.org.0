Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE7125446
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRVGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43858 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfLRVGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so3716574ljm.10;
        Wed, 18 Dec 2019 13:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntVu9I3XrhWfhrQTxhKWXPXWtQH1te/zTY/xV+5R5ck=;
        b=Kc+epk9iVsrcYKd1AhP2pJbSIakkbj7sE7TsSLmqLD7g4n9JKPPf3Ri+IMrYOlQzz2
         VoX48J+qWP2tYmVE5SVfpILRofHBWYk+lrji78eIIYE3354t5U8Kz7ZbbwmRCGyZCb8t
         tRX8qRpEU01B8sHXn8YA/5ETc6N1OWN4ILfqlILkGAASCuuR5GKsb85dIS00/h/KU9Ss
         c9uBFQ+N/0R4342enAx1v8a3DDoPiTJRN6CTsWTxv+H2oGIz0WL1W7QIBqWgFuFLiVwW
         8TrFym3VN0W3DsioImqWDuIiO5omLlNklHaUQ8SoCQhYZb0MwKp5iuqNUkTaCH9nfUFz
         w8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntVu9I3XrhWfhrQTxhKWXPXWtQH1te/zTY/xV+5R5ck=;
        b=X2SnmHKLMehmlcZgpb0/EqWdkIzEu8Hrpo0gbYVnpFPeSMq240FOLn51VCoy2fbDwn
         tYlocL9mRLoLlrTGh5zCcC2ujtAUJsOde11MX68ao5an9ENE6KpzrTdWy6K1+YjVQZ8g
         gTTLUXXdzNnkJfV4TCanX9KdWNsLNMSAAtmC8LkQbg4BjF9YL5901J/zH7SKpA9SPdmf
         U90RkbCTzVd8oo0O2osx0ukO24UvTNl9kxwaO75WsIxzpF+hlRjHkqljbzJp98Bji6uy
         OoCVzAN59NPlNpdd/3OVj/D6B8lJV8oPMBaBhJhhccKm9MvzRIWsHpwG+wZ3dPbteN+4
         2wnQ==
X-Gm-Message-State: APjAAAWMadrPXBhdkv3NqN3quge5e3gayyfRdBEm2sx7PDJQbm6E25W4
        ySOAsmaPEnai18mhdlzDpPvDRKzW
X-Google-Smtp-Source: APXvYqxu0TylR3ICWuTMlcE6n7+VPYU8W/rDeiaJMwGSQ+h88FLauLohsJ7hy3mKVFwOpVeXqBeM4A==
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr1335570ljl.9.1576703199037;
        Wed, 18 Dec 2019 13:06:39 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/17] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Thu, 19 Dec 2019 00:04:48 +0300
Message-Id: <20191218210503.6689-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
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

