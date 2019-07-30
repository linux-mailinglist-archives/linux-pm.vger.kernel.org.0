Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E05F7AF27
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfG3RKS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfG3RKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so66593543wrl.7;
        Tue, 30 Jul 2019 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jx9uRBt6JB5ilMndbuQtI4fuwVo1oth3W6XlcI98xo=;
        b=H+L0aLW5CdeY4D/XejT1s8llSymAxTF1yyCNR3v7feiNOM83jgP4TZR6O3mV8kKFIa
         67C2l0UlaRSBBRAXtFJz6sp9jdzXIuUkuT5EnmR30fIkGNwZ7BBkQaWu3KN8L1J1OD/3
         jBqRD7sHA9ALOUxEizou112ro7cotPtzJaXVO+gA72McPD8/59VMG4kNMvyWLFu+vBob
         OiHc5wDspQX169M6Vxs4kcSxnqAxxYg4UizBgbAlNFrdfP+SM8Sx8x/IVqaIXod/DL+Z
         Cy51jN1Kp5yI965m9w9emiOfRfnDMViXboa9EPjjZPk4NGZDzXIpAMBddlIeYlP7FWgU
         JOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jx9uRBt6JB5ilMndbuQtI4fuwVo1oth3W6XlcI98xo=;
        b=CQ/n3xSlENfVRKB0SW8M4BMH+B+nmpVOyWqMtIDo7mjtHJaJpsyRfJfI4qXr5xhC1E
         jthfzJU6Bbxnyt3yQv4F5G72eW226lmoQEqjV2yuS18mzeTdcaGZ3qfJSnWtBzXrmd5v
         T8J32R2qX8HjkdESkOCWBgaFVKIsXGUUQj4Ts5Ou6CbWvTquvKth3ycCz97+FbhrETQe
         RGT57SRZl/IKxqYDYXw24lwtXFuRxavlyedl1Zy3S1bYknwZhs4kzg5va0ebQEA2vhiq
         MkFxdcD5A3JdelGtxZmxnaxCKLieruD058hTHRUuaHDt7cJqeDoC6E2wjUWwzNQqR/xx
         Mcsg==
X-Gm-Message-State: APjAAAXTdrbzEfWQC5gcDSl/HTkAzR93NmOuAqRihyinc4lHCfKrOlHH
        9r0k7Lp+azQrYys2U7ozAuY=
X-Google-Smtp-Source: APXvYqzycZSrm0esL/eLQiwlzq8G51YnZ68F3nWXoIV0MnnSl5kTIqDLuiFnNM+pV3FbAPx25q7eog==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr40131142wrt.295.1564506615247;
        Tue, 30 Jul 2019 10:10:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/13] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Tue, 30 Jul 2019 20:09:49 +0300
Message-Id: <20190730170955.11987-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
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
 include/soc/tegra/pm.h   |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 4cc64a135a3e..7d9ef26e52a7 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -427,4 +427,18 @@ void __init tegra_init_suspend(void)
 
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
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 2fbee9efda21..08477d7bfab9 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -27,6 +27,7 @@ int tegra30_pm_secondary_cpu_suspend(unsigned long arg);
 void tegra_pm_clear_cpu_in_lp2(void);
 void tegra_pm_set_cpu_in_lp2(void);
 int tegra_pm_enter_lp2(void);
+int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -55,6 +56,11 @@ static inline int tegra_pm_enter_lp2(void)
 {
 	return -ENOTSUPP;
 }
+
+static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.22.0

