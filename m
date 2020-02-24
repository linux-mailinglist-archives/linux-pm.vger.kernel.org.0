Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118AA16B43A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBXWmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:42:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34022 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgBXWmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so8090345lfc.1;
        Mon, 24 Feb 2020 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b03TRFQ9QN9uhCU3mXS9EkQey+lE2Pt2IOy2EIPzQuM=;
        b=mxDlH6Lyrfi2/G/Bw2296CEMHOAkxAfb8ZGuFLGkbZYXCbSpDKazBfmqpBMSdJyg69
         NYwwkoUCJpwlnyIHiaVhnPCLwwhuHfUY+qujASryWO0n4kNstg3doN6HAMRp6Bz98Hzk
         Ay/ds3kl5Tzyi5Zo0j1Xk9C2DGSXJnoSmU9IxeLP36iwfK1jAsOzBVUswS3uTT/a+J1r
         JkYGgjRjfPfXdfqHhUXa1uF/pjlLr+OuIHTUh0N4rIZJ4OqzfLOXelsaEeiZ+mv/IDLL
         4Ycgde278nTpQOvG3574JNAdPTe70wWWkDRUqnSpbuVaKRIUBwemdIl/4kD3V4NT7I4e
         QD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b03TRFQ9QN9uhCU3mXS9EkQey+lE2Pt2IOy2EIPzQuM=;
        b=qMew/mxKs0G6uBqahCVSb0umbNpHr6KNRxlB2EuR1Nd9F60O4KXlit6nsd65Bz58OQ
         rHiWmr5VuxcD57wXkyewgvu6g1Q2rllRNcHcAnNzcXIf9o1Vw1N/I7NRLBAIpDN1/HZ6
         cyCO6FdY5+I9JjVw8Y3eozMZCecJSh4awEuVn6+nC+UXrUCyY1IaR6ax7JiT5OI5W8dC
         7ogwyxLksCPZ2f9rd6kNaAGffnZuSUEFrXOijRbwLj8DDqgNvlPPXRIITA/qsLQME3/Y
         WhqXPJAGFDKOSZcMEzsRF05bQh+qg3Mmyk3wl+jZPwX7dDXfP70JD58HF4o2z7fx8wFo
         Bfnw==
X-Gm-Message-State: APjAAAXYosQ1vAIGff8z5k3irc/ivIWeNLlNASJBvb9p2LW4MJN7H+We
        VH1Q9D+4qviJgmpqZEdP1I4=
X-Google-Smtp-Source: APXvYqwCQm9EZ60/Re6nbi2dVA0+hwHW7+b9xcpHVtXq6tF2ZqWD44cVlR7FD+FbegAhbbKIbXx2yg==
X-Received: by 2002:ac2:4857:: with SMTP id 23mr2748151lfy.200.1582584155714;
        Mon, 24 Feb 2020 14:42:35 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 02/17] ARM: tegra: Add tegra_pm_park_secondary_cpu()
Date:   Tue, 25 Feb 2020 01:40:42 +0300
Message-Id: <20200224224057.21877-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
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
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
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

