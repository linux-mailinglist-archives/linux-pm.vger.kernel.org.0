Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE410098E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKRQq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42563 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKRQqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so19727599ljc.9;
        Mon, 18 Nov 2019 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZXgBiZ7YOkoGyisWeubyUkOPcMd11xlE2xTsIL1hcs=;
        b=FEB2yciicFM5rkAopit+Cycgfy+rgDcDNO1D1l2REgdESUrLizS2okO3oluoQa4u7A
         /P8Guj/HHQzLw67PKlgUREY1n4UHuPCC//wcBApH8T9AwTzLIf3qQrUY6ANbIfHOj2fb
         EFWVlr5tkdXzEZCVIj+EEAQwtiZ7eNrzjS4I0NMWhYrFpAe+wznS8A1ksAANt2t8+GRc
         zfBbtEgTHzr8Rorau+QJAxKR3em5Ry0u4Y0UtcxzsOb9NPj7hoFM808wlSU+ZnsgxLJ+
         8tZZy6G6lZ41edkaj27AE6DOcgP5ewZsXR0pjvqZ8+US2HKfRuBSE7aNN6wc+mB/kXAy
         g9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZXgBiZ7YOkoGyisWeubyUkOPcMd11xlE2xTsIL1hcs=;
        b=K+cQ0njA5ZeW6OtifGJLW/i1ce1yHRKJ28+ts1RxwMToC9nr641tEuWG2kh6Zo7pzO
         QV68LH9lCyHiqTe8viikIDmHipzM5HBLxYxKjGqqPAMRl5BTTK1XznnxYvVX+jhH66cg
         E+47ZUi+8DzJLkdjQMRfqZTXeNmDgYwklqGhQB4KqbNePCHcWyiq5UKvM5kwgSjXQRu5
         Ntu5jU2jKOXFKjt54BVm5oSRB+43WpfZvSESN1o0WFMsNUDRpVPa8Soc982thksNswN2
         3iT1jzJWw6y7C9qCEMwD20UnC/AQGVaPOOcGLd2sJX9Hux1BTfC+AdCzC55j1god1ALP
         DLsw==
X-Gm-Message-State: APjAAAUExsbxmWFfAG5l1s/GtM7UDWCNyxrq2Py2h0h8lLxZkWUvZA8C
        Pd39gdMvXkjySgAwdeXyWF4=
X-Google-Smtp-Source: APXvYqye2GKLQ1yaQqROyuS0/T2RW2xNdSuYo7BQZHAfJ7hhyt2zZOjPfv9V4XEn5pgdD9+yu/Dd8g==
X-Received: by 2002:a2e:4703:: with SMTP id u3mr271809lja.126.1574095611004;
        Mon, 18 Nov 2019 08:46:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:50 -0800 (PST)
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
Subject: [PATCH v5 05/11] clk: tegra30: Use custom CCLK implementation
Date:   Mon, 18 Nov 2019 19:45:06 +0300
Message-Id: <20191118164512.8676-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c8bc18e4d7e5..0fe03d69fe1a 100644
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

