Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23BB7AF2D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfG3RKW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32769 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfG3RKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so45749315wme.0;
        Tue, 30 Jul 2019 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8nZZlhkjH8gmOBLsrwLlw6x1w6bpTtxl5DUoKSzyGY=;
        b=RdQSw1juEsmNYUQ1d0WQk7AOJYHlWOgVUmS234Op8YJXCCWsiauFHUEIOZVyHo/0eo
         MJgFvkIadkVQI89foGSQJn0woeBf4wvyyVM+ct4U9QQwF8r1SR92UKFWKmPmYGskpvWo
         975AjHl5mM+zKzJ6HJ/W4xn+b03UXXAgt/AB+rT2AV1OMMnMJkhN5Hsc4l8iT8gdXDfU
         LuQC8kdpyMEcEXefuzv6MPkj8d+5smo92vNXpPB9huhhw3VsTy6sqjgx765f2SrkTsEC
         T0vPlcRka1RDYIh2gvWwLhy9B5x2tYAfYcCu+rkKybzBhgcWs6DMRYcfXiMDrgDugyCU
         3uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8nZZlhkjH8gmOBLsrwLlw6x1w6bpTtxl5DUoKSzyGY=;
        b=QaasonKXLKyKqQ91ZBnAbWBbsU85i1udo479xSKJeJqSsCy+nFf4xz0a6G9Zl86aaA
         WCljqlRjJ3zH3on8fvr+x4xkqoFEsec20use4kOA6ReUkSguOBoPZuTOLYVaVtwoAu6o
         R9tWCyn2Hf1tHV8YqTRf4ql0RnwnY0becrPdXGPOBnIWinOpoB2oj9DNr+gioZ6n0Z0X
         1vv/UywzqDI/ew+3A3mFSgjo9WNtxeDSzZWznIRYo8TbXKXfrSBgtd+cTrf72ebfK00u
         yqp3q09FowuDdxn5q+5OMO+kf6rZ5UcNYBWBHuv29wHBJZnIlPORFzwBO3zU1XbzDezC
         5fTw==
X-Gm-Message-State: APjAAAUWAGafLl9t/lEYo8MjlUZk2zz1hRJBowPjSLXWkR+YnFtiWE8k
        xF5Vggi9tgKaTEsb9Ef0nYnEPibT
X-Google-Smtp-Source: APXvYqwCVF92t4LAwe29F7M9D7NcwGu25M05HbpWbYMfDD0c2QSQVYsjUBd3P5BDXZHWyZChlcvSyw==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr106228570wme.102.1564506618949;
        Tue, 30 Jul 2019 10:10:18 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/13] cpuidle: tegra: Support CPU cluster power-down state on Tegra30
Date:   Tue, 30 Jul 2019 20:09:52 +0300
Message-Id: <20190730170955.11987-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPU Idle driver has all necessary features in order to allow
the deepest idling state on Tegra30 SoC where the whole CPU cluster is
power-gated using the coupled idle state.

Note that outer_disable() now need to be invoked directly since it
produces erroneous warning message about secondary CPUs being online
because it doesn't know that secondaries are turned off at that point
by the cpuidle driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c        | 7 ++++---
 drivers/cpuidle/cpuidle-tegra.c | 1 -
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 7d9ef26e52a7..16a02937d3da 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -146,9 +146,10 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	 * if any of secondary CPU's is online and this is the LP2-idle
 	 * code-path only for Tegra20/30.
 	 */
-	if (trusted_foundations_registered())
-		outer_disable();
-
+#ifdef CONFIG_OUTER_CACHE
+	if (trusted_foundations_registered() && outer_cache.disable)
+		outer_cache.disable();
+#endif
 	/*
 	 * Note that besides of setting up CPU reset vector this firmware
 	 * call may also do the following, depending on the FW version:
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 867c0403ea81..9e1659e93af6 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -324,7 +324,6 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_idle_driver.states[TEGRA_C7].disabled = true;
 		break;
 	case TEGRA30:
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 		break;
 	case TEGRA114:
 	case TEGRA124:
-- 
2.22.0

