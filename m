Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE4699BC
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 19:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfGOR3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 13:29:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39008 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbfGOR3t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 13:29:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so17086498ljh.6;
        Mon, 15 Jul 2019 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAZS/gHavS5YSEczNZRmVNHcV03HXfR9BNASQHjKGJI=;
        b=Jst9Ui9qHEGJyoR820DT+dbzNqmoyU0griYCNuZ+AAWmlsLDSbF4r4hKBnx9FiGw6s
         oqMpVKkdKs3dwznQ9d0PKfyxuuI8cPmU59grmhvotih4QLX3FJkKCL6yLghvu05Fbc5H
         la0RYf84/EMum0P2XfBh13fdfWn7OYABemb0hJawquoRbUB4dDRnZNWIXR0utvX2dnLW
         mcHgtrH7GNnAaKQCkPAWF3yBW9MY8O3Z2gsBNpnl18rO0+OTXeLd9U9HV23+M8rzjW/+
         OZ3ecwiWSduDbZYK5iZwDoDqUtmlmNPJLBI7C1Q42+W1nE1kZ7GgGDjZTx1XPxJjNRVF
         dzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAZS/gHavS5YSEczNZRmVNHcV03HXfR9BNASQHjKGJI=;
        b=DUu796qmThvHHQOI/otRylGNr0XFqzKaByzFE6TdSMhsmt1N1a0CCG5Xv2kQ1rkSrg
         p5bMMuoc7FCj6iJTt1ksnjCjTtNHRN62vehBw7zmCdmG5nw+YYWI6b8bGhyABo/tknko
         iId2unYrpR6G0j/nMk1UNgTsH/mc4jP9HDSmsWsqK6i+sS0F3/aeaR+dXPRMSnXl38FW
         s85RtMwRMKX6HSA5KktxXC5nrB8LASxdeoaZO0+Sh3Vs79pughN8odwpvRtGrci9YeyU
         NT33dQ90SM1efpwZMeDH1HYcsu86fpOo3Js3gA39OCwxh7wjhIfQpKF7BAqNGrSWkxsb
         MyMw==
X-Gm-Message-State: APjAAAWrcRrVxZZ4PpS34vltHO59wDLidYfkHVfAbbWP0MpREwijEjxw
        58D8FtcgrlAf/eJv5uHaDKI=
X-Google-Smtp-Source: APXvYqz/YOgCfk53IIHGcYQxyANpzzg7RT4bR0PVoEUmFsvNwc8I9plE9nCfBGaGoEESIt9W98AkeA==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr14310263ljc.210.1563211786801;
        Mon, 15 Jul 2019 10:29:46 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] ARM: tegra: Change tegra_set_cpu_in_lp2() type to void
Date:   Mon, 15 Jul 2019 20:26:18 +0300
Message-Id: <20190715172629.4437-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
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

