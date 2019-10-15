Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A34D7CD4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbfJORBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 13:01:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbfJORBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 13:01:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so21001583lje.9;
        Tue, 15 Oct 2019 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAYNs/o0oQ+5oMrw2AY1UO1+THnKmjTd9tnbcB8Y4M0=;
        b=hhHXoeGkeFH0aG2jGZZZ5SdqCD7w4e45J1BVWduxeXXVD4TeDF5TpJraTJ8N72qawA
         49pAISszbYizOd2peiIVDpJoiFjO0qOJvev0OcvMPM+VE++6BxSlvPPc5JGpQn+ucBKM
         b28olFBRKPBb4cRw1u4OeEFkkH5fWybbbEPQFmWnD8XoQgdW4iA6ocWapMhxZta0buAk
         viiRVkSBtnZuGfo4vALCOhmjpiPxpKqz/WAoJEsClyf4Er/WuZY4MA9zCvXAuvGJkYyf
         jfqkYcLZVppSJNmgk0uM+4zkHPLRRK0hkLanIjftmD/0/1FeT6xLfHQqnNwzTX9yv4AQ
         h7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAYNs/o0oQ+5oMrw2AY1UO1+THnKmjTd9tnbcB8Y4M0=;
        b=pyXyjV1PzEZcJWVTP/E3yq8dYj7PosS3UHK0pXVjdaiD7be2lPcJa7m0a5gji+wU7E
         id2r1NgtrqpX8UZaHnIkOCiK4IkkSrUZlSa4eYLAVcCBcxSyVQIrPz0ytldgmcbU1LSc
         pGyhS2o7y9NtcgPMCoIYTUJLwEX9ZOLen+b3QIQeyG0jt9TT9KiQuv6Ze1EUULbqcSNn
         UYv6Vxsk6qxMlf5jN/sT/H39hq1HREK24oODPqRNdb+oJl8gxezljOLapObbq6GeHM0m
         uS7n/FxpJZ6jU1kvvBdfvADfEYxeDElRrJr3aEp58X5wX9c2iyqmF22ia64YWdeDregW
         Yaqg==
X-Gm-Message-State: APjAAAWO6Xq2F4ME17QMXQH6DRepFKcqbB6Cm/hpjTBm4Tl7x1TGmrJb
        WSdFjgjWkU5DtiDdQFof0So=
X-Google-Smtp-Source: APXvYqxl7Tz9wEfgAkrvBVOg4eZ9ADEiRSRldWhV7QHOFUUVf8eYWuB4B5BDfnRtXrgCghrxi8WyRQ==
X-Received: by 2002:a2e:858f:: with SMTP id b15mr23110599lji.68.1571158900984;
        Tue, 15 Oct 2019 10:01:40 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/18] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Tue, 15 Oct 2019 19:59:59 +0300
Message-Id: <20191015170015.1135-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
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
2.23.0

