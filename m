Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391D47AF4A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfG3RLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:11:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54405 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfG3RKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so57851545wme.4;
        Tue, 30 Jul 2019 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAZS/gHavS5YSEczNZRmVNHcV03HXfR9BNASQHjKGJI=;
        b=mPkGQygw4DLGPaWr3Xz6lNid26MhTAQMHZSDAUjMdOiRdQRy8tzlX9LXZ7GVTRy/xp
         uvkQCTAHNzKHQ693JiJECQwTjVZwF7iFp2vJnConQOY22HRswmkJzzO/DOsJ9ZqZ/A7u
         mOgKrAdV8nEjSAaERryHV1p0s5gPMdrY7dB6UaDlSjfA+VXKJcesKj8F7uH0ZUWnt5AB
         Kmqw/WnrK3bUsvebYuKZvRtvOs/dIwU0fnn9NABXblAFXHwgLRMLpml+NUxqhg3eqWsn
         0YeIgYWaD7zqeI57244itDOuh9ssy2pcJNe8naIGpA0A8TcVbP4FBMpRJyZMxKCGfMpj
         LhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAZS/gHavS5YSEczNZRmVNHcV03HXfR9BNASQHjKGJI=;
        b=fdFTDzUfn5OR/k0Fkw8W1uNBmhgGO///PBedy7JwBir5XUoe/wSBegHvoR9t+wFvOf
         riqFYLZs+jI786kq08hAY/lwL4Y+Lryq6xC/YZ2Azx9DOwASAqAlAJMk20lCZkwbIRxX
         lAZ16yqL1t0lwujyDdarQl25Xft1K82zXmPGeMc5iwUbFvwXm4w3uZ+k6XV0wZ56S/P7
         D3Ewby2BdPmKF08gUdL4/eXCvA4TV33Ky632P1THv38fHiI1eEwoZZwUIvIIuXP6lBJR
         +gz6Y9xOiyevo/KH+UclBFmFQiph0oDL32svAS7W69ai5GcFVVxKps/lOfII6BS3gOk/
         1D6A==
X-Gm-Message-State: APjAAAWfbTyrs25NjJAuRfTmHbW/tKKd3oHuQeFpMFcreOg2xSSQnIdd
        zpKOpbjJfcmZln2JU5OMxao=
X-Google-Smtp-Source: APXvYqxqywZ/f3YPM1E07qXbT0nfalXAksZ5rQLa+eyisBEzK65LQzg/zGpVdV9V4834zuJHCBk7ug==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr56445150wmh.76.1564506608653;
        Tue, 30 Jul 2019 10:10:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/13] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Tue, 30 Jul 2019 20:09:44 +0300
Message-Id: <20190730170955.11987-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The old Tegra30 CPUIDLE driver had intention to check whether primary
CPU was the last CPU that entered LP2 (CC6) idle-state, but that
functionality never got utilized by the old-removed driver because it
never supported the CC6 while secondary CPUs were online. The new driver
will properly support CC6 on Tegra30, including the case where secondary
CPUs are online, and that knowledge about what CPUs entered CC6 won't be
needed at all because new driver will use different approach by making use
of the coupled idle-state and explicitly parking secondary CPUs before
entering into CC6.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c | 8 +-------
 arch/arm/mach-tegra/pm.h | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 6aaacb5757e1..2f6fb54be9f8 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -123,11 +123,9 @@ void tegra_clear_cpu_in_lp2(void)
 	spin_unlock(&tegra_lp2_lock);
 }
 
-bool tegra_set_cpu_in_lp2(void)
+void tegra_set_cpu_in_lp2(void)
 {
 	int phy_cpu_id = cpu_logical_map(smp_processor_id());
-	bool last_cpu = false;
-	cpumask_t *cpu_lp2_mask = tegra_cpu_lp2_mask;
 	u32 *cpu_in_lp2 = tegra_cpu_lp2_mask;
 
 	spin_lock(&tegra_lp2_lock);
@@ -135,11 +133,7 @@ bool tegra_set_cpu_in_lp2(void)
 	BUG_ON((*cpu_in_lp2 & BIT(phy_cpu_id)));
 	*cpu_in_lp2 |= BIT(phy_cpu_id);
 
-	if ((phy_cpu_id == 0) && cpumask_equal(cpu_lp2_mask, cpu_online_mask))
-		last_cpu = true;
-
 	spin_unlock(&tegra_lp2_lock);
-	return last_cpu;
 }
 
 static int tegra_sleep_cpu(unsigned long v2p)
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 1e51a9b636eb..3f3164ad04b7 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -24,7 +24,7 @@ void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
 void tegra_clear_cpu_in_lp2(void);
-bool tegra_set_cpu_in_lp2(void);
+void tegra_set_cpu_in_lp2(void);
 void tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
-- 
2.22.0

