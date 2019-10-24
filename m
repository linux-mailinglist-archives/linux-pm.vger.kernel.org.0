Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F41E3F2C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfJXWRp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38985 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfJXWRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so366911ljj.6;
        Thu, 24 Oct 2019 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaxOcHNCQgBOcrm4biyt/yiqExX0IF895chwfdoXUTo=;
        b=nvGLbHSpSSEXDCX1oCkTnFop/u2122sVdMVfFV0N3w8Sf47nmsKlj+huD0BkkaJ96w
         C7yKJQiKlnxA9miTyAxYqMfFVisHxDqgaEKYuTw2YLNhI/aXTw0vAFrcYLU3SnsbsAeP
         UP1SBdscLc551DeT3v7EPL8pPFgSbqSmV932Ihq9oLB/rG0J9Mofwd6X2DYtknkzOSC3
         sf6AsA1v1HQRuNIXygK4HEvkQDQzBN3e5KkOuZDwozst1+4Gm42rrud8Fm8I3Gd6lR8E
         gX+Jfn9MO/OxBkcKDKqrc99NggLAgXSBY/OXyR/DcCKfE95XAoOnzBjX5MEMsVKo+xUV
         osaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaxOcHNCQgBOcrm4biyt/yiqExX0IF895chwfdoXUTo=;
        b=Ba32OTG1Tge3Nlj5UNcZyxBVhTxdOZvz8+VUMQcaJWh8BeMCM0xm7bBULVRMnS0Eu6
         6zvRB4ec/AzmKZKkwz1YaksWBzb312jhKx4xlqqxoDdJwwCtwZiCOS9D4XHeLanRbz+6
         L7+2XCIPvk46VmvP1gGvhlB+A2TWlDZTCVyXzEU3luwsW7M38cyGGFhQ4EvsakemqGqA
         H4yo4ys+CV5BFxcOi6ICUjVsUgreb4+ypHPnO/7fVd8mfiKhmOdehZS5H22+ps8HZiaM
         qFujlNQAm/3MmrvlONaYOL82BekuJSJYOYdmvC2KHnYi8McAzjHYz/z5aKaiakj0Bmqw
         26GQ==
X-Gm-Message-State: APjAAAWG2XHGGOuPWy/UQR6NmzDPE03AzXzPIBQN0ovCm7UdD+yGg0T3
        3iRAypgSUInaM570b3+hVcs=
X-Google-Smtp-Source: APXvYqw7OtcR8bSIYh+BvpL2wschswWU5ZzTFbLgdH2zeYmRG2J0qWqsEiqbnuobt9+RuwRVWOOhiA==
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr43185lji.236.1571955460681;
        Thu, 24 Oct 2019 15:17:40 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] clk: tegra30: Support custom CCLK implementation
Date:   Fri, 25 Oct 2019 01:14:04 +0300
Message-Id: <20191024221416.14197-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to switch to the generic cpufreq-dt driver on Tegra30 and
thus CCLK intermediate re-parenting will be performed by the clock driver.
There is now special CCLK implementation that supports all CCLK quirks,
this patch makes Tegra30 SoCs to use that implementation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 95b0e4a16dd5..ad545803af42 100644
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
2.23.0

