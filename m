Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC0125356
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfLRUWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42430 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLRUWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so2622253lfl.9;
        Wed, 18 Dec 2019 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KjPx1Wv5d8ZDM6UbOjJE0HvBiQeI+lxOPx3jO6nNXM=;
        b=CwgrWCCrkPxE4vnzsp5eWX0DlCVDkLzDuqtnbH2asE+7qHf4W8TzdZsfKohMWs89ec
         wPbK4Vd6qU9O0Szlvwe+v6452qD092tx6g8wI5EfmtRG1iDYebX7pbwb0RKXu2jWExmH
         sco++uaWLi3rSth627xF0mjNXsjjtnqEfVF4mc1IRpoKZB2nRtf1qLmp1XBF792rjnxA
         Y4u2D5AJZRWqFKwftNMy/bClxJQIaB3IEWSV5CyfruA0UAcgbwg97Cq9m9aZuuCLWFdM
         R72VKMVkiwoUntiDsuKC/UoPuxCRUMfnGmHtEo25U3zsmGs9St+GW/cvMTLcwxjmJ5eB
         vgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KjPx1Wv5d8ZDM6UbOjJE0HvBiQeI+lxOPx3jO6nNXM=;
        b=lUJKGP99mrxCkO57cy4Nf4zTwLNuYEPXnQJyZ+LWYI4a6ywOhizeSym4gg/HLOIWHQ
         b7aGIhXtmo3CcYpx9uRAvng8RyHxBOUMrz/OjFSwlE82ACMmXxD0H+tIFUsYKuyoD49M
         n3Glv19cbNb/48qrY5lVJ34O/ZPJS2W8b+pwqRn9ty8EsSEvRBvZJ6zsX7c/k5iHknJ0
         Fsxuh/liVPXbbzw0Mk05/YAy4xVRVKpkdCuSoxnklFNI23Sg2aewWpzj0/7/7/yKPjiq
         JL35KBA8I4S+8IXBaRstCT1PP/ZesjrAdSMPR9E0WQWSR+p2yv/SRddBcofwlk1EZZJF
         rCHA==
X-Gm-Message-State: APjAAAU717hH8N6pgM52wbN783EfyQKvKxOqKVOjyFznsZRQwFtG1G/L
        o4mnlr9740xI9Muhyj2uzGE=
X-Google-Smtp-Source: APXvYqx4EaLXUxYnR5mzvQOrJkLC3E8upu+/JNFLZqza1KliT7qDQlT3QRhiE73+iiCu7XfTBKyNdQ==
X-Received: by 2002:ac2:4946:: with SMTP id o6mr2987807lfi.170.1576700521780;
        Wed, 18 Dec 2019 12:22:01 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:01 -0800 (PST)
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
Subject: [PATCH v6 04/12] clk: tegra20: Use custom CCLK implementation
Date:   Wed, 18 Dec 2019 23:21:34 +0300
Message-Id: <20191218202142.11717-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to use the generic cpufreq-dt driver on Tegra20 and thus CCLK
intermediate re-parenting will be performed by the clock driver. There is
now special CCLK implementation that supports all CCLK quirks, this patch
makes Tegra20 SoCs to use that implementation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 4d8222f5c638..eb821666ca61 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -391,6 +391,8 @@ static struct tegra_clk_pll_params pll_x_params = {
 	.lock_delay = 300,
 	.freq_table = pll_x_freq_table,
 	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.pre_rate_change = tegra_cclk_pre_pllx_rate_change,
+	.post_rate_change = tegra_cclk_post_pllx_rate_change,
 };
 
 static struct tegra_clk_pll_params pll_e_params = {
@@ -704,9 +706,10 @@ static void tegra20_super_clk_init(void)
 	struct clk *clk;
 
 	/* CCLK */
-	clk = tegra_clk_register_super_mux("cclk", cclk_parents,
+	clk = tegra_clk_register_super_cclk("cclk", cclk_parents,
 			      ARRAY_SIZE(cclk_parents), CLK_SET_RATE_PARENT,
-			      clk_base + CCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
+			      clk_base + CCLK_BURST_POLICY, TEGRA20_SUPER_CLK,
+			      NULL);
 	clks[TEGRA20_CLK_CCLK] = clk;
 
 	/* SCLK */
-- 
2.24.0

