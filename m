Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A308515B506
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgBLXqi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46003 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgBLXqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so2841806lfa.12;
        Wed, 12 Feb 2020 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/51PDCaWOltwmr5vyW/UVNRobdC9/cI7Y/jAoA9zHs=;
        b=jawM+Rmo3xtHsycsN0jG9t83LBJfVgXgey4lQsjVqGr5aBUVFzj5PJy/Hy6H245LN4
         6X+OP9IjVTiiyPudTWWCy/Ls28zfDv3Li6f7QVj7Hh6ltA9YwdPAWZ+K+plv7gYq3uso
         mfVKe1RNQDZFmQxGJCgA473gN+HCu3U0aptuJRKFfQYmmAZluz3TEmcXUIDAMXGlnO9k
         79LVreL6PqqRZrGfcTeDcO6O19twlSWSJx2LtCq7+Ue4SsKOVrU+mvCuRxETKbr/qcWB
         4FxgBRiXd1i9GvXUIavkHgEy8eJLjLKhvPQR68bkNdgD8NsOoEBKfGUGhYAJlvnzWqTJ
         MRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/51PDCaWOltwmr5vyW/UVNRobdC9/cI7Y/jAoA9zHs=;
        b=hKCVMl1Ns+wjSudel9+agIn6xUFRDn/LGt+DfT2XwfyXNM0wFcfdtLveGEpwXJrniC
         Xg3sJTEvf80Jl3dMEdkjGmj8r9hmGYYecYgkCcoUVqLQBRUBWvMW7SgsAg5wB1XYKVzR
         pGJetyYAkd8kuixZlSn17EawIc8TLNFF1Ka8qobHpNkz//Y/I6a6dLvBt7MWUD7PwtvD
         OLuGnC/jYEiLN7Lq+FANMdaHn5fBH0UIHMxACempBkKDcKftYNk9tSaXucI//xjPrUcr
         anUYcbK1AWGqMAKr9qZ8mJVdLABG3m8m+gu1cJRsn1yfXqb8gcMXO3FTyDRvKMqP1vOe
         JIGw==
X-Gm-Message-State: APjAAAXJth+byE+OAjIacVDbOpBhK2S6qfvqaVL0gDH53I34Vl7kYR7f
        x3GqbDmm+e59In7HbkPTAFQ=
X-Google-Smtp-Source: APXvYqznlFtDiSzk3yrjYIYXsjLWL2Qw28OUTHgwSxbKXUIDaPhiSu0z3hTLEUgSrUYP1pCZjKtccw==
X-Received: by 2002:a19:5504:: with SMTP id n4mr7347333lfe.25.1581551195198;
        Wed, 12 Feb 2020 15:46:35 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:34 -0800 (PST)
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/12] clk: tegra30: Use custom CCLK implementation
Date:   Thu, 13 Feb 2020 02:46:00 +0300
Message-Id: <20200212234607.11521-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to use the generic cpufreq-dt driver on Tegra30 and thus CCLK
intermediate re-parenting will be performed by the clock driver. There is
now special CCLK implementation that supports all CCLK quirks, this patch
makes Tegra30 SoCs to use that implementation.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index b20891489e11..43b94175ff33 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -499,6 +499,8 @@ static struct tegra_clk_pll_params pll_x_params __ro_after_init = {
 	.freq_table = pll_x_freq_table,
 	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_SET_DCCON |
 		 TEGRA_PLL_USE_LOCK | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.pre_rate_change = tegra_cclk_pre_pllx_rate_change,
+	.post_rate_change = tegra_cclk_post_pllx_rate_change,
 };
 
 static struct tegra_clk_pll_params pll_e_params __ro_after_init = {
@@ -932,11 +934,11 @@ static void __init tegra30_super_clk_init(void)
 	clk_register_clkdev(clk, "pll_p_out4_cclkg", NULL);
 
 	/* CCLKG */
-	clk = tegra_clk_register_super_mux("cclk_g", cclk_g_parents,
+	clk = tegra_clk_register_super_cclk("cclk_g", cclk_g_parents,
 				  ARRAY_SIZE(cclk_g_parents),
 				  CLK_SET_RATE_PARENT,
 				  clk_base + CCLKG_BURST_POLICY,
-				  0, 4, 0, 0, NULL);
+				  0, NULL);
 	clks[TEGRA30_CLK_CCLK_G] = clk;
 
 	/*
-- 
2.24.0

