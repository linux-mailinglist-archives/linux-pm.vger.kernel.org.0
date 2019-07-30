Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B17AF36
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfG3RKj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39166 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfG3RKW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so46982017wmc.4;
        Tue, 30 Jul 2019 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ez/DtEbZm91hvKH3/uYPobJLTWojYBqiK7N01oWP7xA=;
        b=JUaIZUxSEsHYmEI0ls5DWjv2KtKHaJgHFG3N27a0nlkFxaWBeI/a41JkQPG77U3hA+
         YNfod7UD+3ituq/uQz3v6CY1gQOv3M7d6qm0TRK6M9cardOBH/FiPY1mc4OzkRD2j6I6
         BSedX9kbsx/9cD5RQdGeJUOmuvPvboOw5kN8yeefcxa9ySR9G8FfgqmXLH1/lpaj1gJD
         0IveRqBqUHVN7opIfPG6bQ0fkPiJ5jF4glGe/oAWpelaiQGT1zQANa2+hRTe3/udsOr6
         7aEkuN/NQbigsX+jdv3SKe2+kvZCmrNhfPuwaN2dz9LhsSxK8O0iCz5oX8TYjL79Fm4q
         hFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez/DtEbZm91hvKH3/uYPobJLTWojYBqiK7N01oWP7xA=;
        b=TNUvVC4G+8HA9Www5VE9Ie9PPi+TWyhMWX4cYoaOoEz2tbMd47stg/DtJ/5WPT5473
         dnZX3Mgmra0FAh5wjKZqo1wpclSZ1gYGsodK6tfxueMgCHDdA/oCLYxpPHE//i8T2v+Q
         XpcD7EBXp+v+COry65qpE1VYrpi/eaoSOf+QJ9VEfwZIKerh9sKXZ6lDZjoExj1gDAfh
         n7d0xupjNt8ZVvrw+GmZIM6nMt4dfXAm4z1pyBOmryAUEsZ7sUzPPos0TS4fG2280VWf
         1O/8LxM3NwgxEWD1uv+z+EGjzMkf3raKijXa5Qr4L02rTWXmvl++nV+Kh8RwA6mgCfYm
         sH8Q==
X-Gm-Message-State: APjAAAXTZW3rvF3dA4Pcm3Q4qUdbwXMuVqq66072roUXePFixwrLkSsZ
        UtKU3T1U+uZCoHsgiT005aY=
X-Google-Smtp-Source: APXvYqw6zcbOYrRen1/+NlRr06lBi6pn7loELvbKEaRD5+06q7HkgvTKT8/fRNYwNoe5DkkXTAAIZg==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr32874121wmi.79.1564506620301;
        Tue, 30 Jul 2019 10:10:20 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/13] ARM: tegra: Create simple platform device for cpuidle driver
Date:   Tue, 30 Jul 2019 20:09:53 +0300
Message-Id: <20190730170955.11987-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPUIDLE driver now is a proper platform driver, hence it needs
a platform device in order to be functional. Register the platform device,
like we do that for the CPUFreq driver. Note that on some Tegra114(124)
devices PSCI may be used for the CPU hotplugging and CPUIDLE driver
doesn't support that case, thus CPUIDLE device won't be registered if
PCSI presents.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index d9237769a37c..f1ce2857a251 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -36,6 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach-types.h>
+#include <asm/psci.h>
 #include <asm/setup.h>
 
 #include "board.h"
@@ -92,6 +93,9 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
+		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.22.0

