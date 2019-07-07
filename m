Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB986187E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 01:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfGGXjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 19:39:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38886 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfGGXjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 19:39:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so14020540ljg.5;
        Sun, 07 Jul 2019 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJMZ24jD47u62P2hBjS2/2gUe0e2nBhC9K5zAxtymIs=;
        b=JRTbAtZDHylzPi5f0reg//dRjfrBruSREGQEtXL1VtuLfOINdky+kTpnPDG+BvafLx
         e9lZXjbSE+fWvAlIj3h4/AhAfAIePNisBnuydAy/CEwu9oXggqY20LnQVExxZHfREyGn
         rfbfZfGyl5Kmubww2sslVRObxlHd9bVf8/snhgl35iCSl9tlyr058W8DRtjMmzOCIcAA
         FlVZ6F6UvVYYZz8Bjq/MUp/yR5ERVXrCs04Vc3snLA8lzVyck3mCE4vZAfLMDBIi2gCT
         cSxY601zjcTY3UkIZjyZ3HsRGseKZw5Syijhb5XHHjkyOQOR9eh2NPXX2JlupN5ZtE+w
         8PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJMZ24jD47u62P2hBjS2/2gUe0e2nBhC9K5zAxtymIs=;
        b=h5NQrhKEG2DnxeENwjU+8UhS+oZOrCBss9+UDfLuipBDZfWJORDdSEBl3YNDdZ6pAC
         MTz69VGqEAcdNTYdm4Da/tSKcmUnJCmyutQZJXoW60pQ9ctpQhYsGQEM2vmobh1CSJ88
         CUMwqo2Np2cIQMfgNrNTowh0kZsAq9V1h1goAVf30eaAh5/A3ae/YdvkZUnul2NSygPD
         6DrjTcmPI5tUENsRbzeg/ipj8mU4MdG2XNwlQ7BT9LzeKjcrt3OUZ4G7v9f4tQWj2OCK
         CP2/TkN4ISV+DEejUrELxXcGoFXdf1GMAYnFbONVBjn4ewMBWQ5N2lxjs2mI/dNjwfgO
         1OVw==
X-Gm-Message-State: APjAAAWWD+j8wX4ddlrnTB6TIu08bMx2nDvtUXU3sUQ6ZdRVaaWkOMTD
        Z8bJg+UMw4QkhYlnj0ECQIcZYKOb
X-Google-Smtp-Source: APXvYqwae+3QpxuB+bxwHDdp3Pqy4N5PHhX/lqEfpwASCoi7fiYGLAtZ6knBEgTT9XniabdPe4Twfw==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr8533842ljg.134.1562542741192;
        Sun, 07 Jul 2019 16:39:01 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id y5sm3246520ljj.5.2019.07.07.16.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 16:39:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] cpuidle: tegra: Support CPU cluster power-down on Tegra30
Date:   Mon,  8 Jul 2019 02:38:07 +0300
Message-Id: <20190707233809.14400-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707233809.14400-1-digetx@gmail.com>
References: <20190707233809.14400-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new CPU Idle driver has all necessary features in order to allow
the deepest idling state on Tegra30 SoC where the whole CPU cluster is
power-gated using the coupled idle state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Please note that outer_disable() has a WARN_ON(num_online_cpus > 1)
and it doesn't know that we turned off those secondary CPUs, hence the
outer_cache.disable() is now invoked directly.

 arch/arm/mach-tegra/pm.c        | 4 ++--
 drivers/cpuidle/cpuidle-tegra.c | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index f9c9bce9e15d..cc941b0c97e8 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -146,8 +146,8 @@ static int tegra_sleep_cpu(unsigned long v2p)
 	 * if any of secondary CPU's is online and this is the LP2-idle
 	 * code-path only for Tegra20/30.
 	 */
-	if (trusted_foundations_registered())
-		outer_disable();
+	if (trusted_foundations_registered() && outer_cache.disable)
+		outer_cache.disable();
 
 	/*
 	 * Note that besides of setting up CPU reset vector this firmware
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 3fad4a0cbc78..31eeef22c0ff 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -202,10 +202,8 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		tegra_idle_driver.states[1].disabled = true;
-		tegra_idle_driver.states[3].disabled = true;
-		break;
+		/* fall through */
 	case TEGRA30:
-		tegra_idle_driver.states[2].disabled = true;
 		tegra_idle_driver.states[3].disabled = true;
 		break;
 	case TEGRA114:
-- 
2.22.0

