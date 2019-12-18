Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35F2125343
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLRUWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40102 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfLRUWG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so3589406ljk.7;
        Wed, 18 Dec 2019 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5HlnYJPIwYxVleWdO7CO0bzUDmsMGuP+g11IVxSh3M=;
        b=pRKki1GKBPSMKIMwHJNJbUOoTSffcGV4/u8nAIW+KUeM33SlEpfxBX6VajkI5oDkIR
         r0SFc9gntwgx7UMhHyTODk2tWI+on/Zrp2j2SNFUlmYAfeWwec2DsA4j0DzY7A0tW9+f
         qI27MUM5oiSHkpKHQ83cMy2xAZdgBWxKKCk7WParmOy9z/INZEUsEVcun9A/tIFEvb6k
         Nz5H8QSlMmzubj4RmCIJiQBvCsnkwqq65DLEdDTrLM3KrSCfU2QoxCVZu00z4c2cwK4j
         eXR5UOB9drDVFHkEAXCe6i0zQjbIqMLE4lT1rYMavyPLKJcCsWWZBjMrKg54ztbN6dY1
         q8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5HlnYJPIwYxVleWdO7CO0bzUDmsMGuP+g11IVxSh3M=;
        b=O+xAWCwHNVThr0HtWPvaZUplT02rFYEwfvZOf3YfoVVM/sxfVCGsHvRL+fiSSCXuSr
         KBQllEkKsbbZli/h34LhllHBi71bb70JP878nuXdL9QjOBj62k5SZpDjFAqCRX9kTqN2
         IGVp12moDB+uxW1ZWqRJEsuhzQ01nUrGdayFfnf6FTd2SqL+s9QuhmiHEzL8NV8t7rd4
         t/DneaZJHwND+WWSQcNTaLsXs/JECfJkWPiIl/uUWl0Y5rmBfAFX6a+z9wMKDbfr675i
         4eb+Ptir1CA8rNVVxLTdmFZ9sHIpB7yf2HJatUJ8EKph4FCV8OprSsMU2PZyTbn2txf8
         N7BA==
X-Gm-Message-State: APjAAAV7bAbiwZdxb6Z8STzZkm+N4e2z/0n/3eYjXZCogVw9X5BOX9kW
        DBASaztC1mABmUInfqKAwhY=
X-Google-Smtp-Source: APXvYqwQRyeToKP+ODMia48YTGwgR/XlDVi8uJnRU1eq9o72QRChD98WM/TUp0eK6iJbQd3HU/0OZg==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr3258522ljk.186.1576700524025;
        Wed, 18 Dec 2019 12:22:04 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/12] ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
Date:   Wed, 18 Dec 2019 23:21:36 +0300
Message-Id: <20191218202142.11717-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The early-resume code shall not switch CPU to PLLX because PLLX
configuration could be unstable or PLLX should be simply disabled if
CPU enters into suspend running off some other PLL (the case if CPUFREQ
driver is active). The actual burst policy is restored by the clock
drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 3341a12bbb9c..9a20c93abe48 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -383,11 +383,8 @@ _pll_m_c_x_done:
 	ldr	r4, [r5, #0x1C]		@ restore SCLK_BURST
 	str	r4, [r0, #CLK_RESET_SCLK_BURST]
 
-	cmp	r10, #TEGRA30
-	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
-	movteq	r4, #:upper16:((1 << 28) | (0x8))
-	movwne	r4, #:lower16:((1 << 28) | (0xe))
-	movtne	r4, #:upper16:((1 << 28) | (0xe))
+	movw	r4, #:lower16:((1 << 28) | (0x4))	@ burst policy is PLLP
+	movt	r4, #:upper16:((1 << 28) | (0x4))
 	str	r4, [r0, #CLK_RESET_CCLK_BURST]
 
 	/* Restore pad power state to normal */
-- 
2.24.0

