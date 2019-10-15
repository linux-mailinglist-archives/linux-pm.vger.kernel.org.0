Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C08D8192
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbfJOVRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42891 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388655AbfJOVRJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so21723682lje.9;
        Tue, 15 Oct 2019 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaxOcHNCQgBOcrm4biyt/yiqExX0IF895chwfdoXUTo=;
        b=V2VM4SqY7RgcY6We78OfYm81HgBDfTjrRsWNAfdkuHXgCWmNC1pUDCWaYGvlFYV7es
         r/IsNHJnhtqIL3b6xMuDOxlaJf++g6ELXC4DxTJ5jE+PefeFTLYc6LfdpkDN7E9iwxUO
         JZdahwxTCgoRD91Goa/5+MKV+KYfSyVRl8lAc+8V9JRgyIgZ2BURLq/mUiiiu5hHv9qR
         xxsOyk7tsLMV0j27MgoRy4Hwq4nyz1P6LvfoPt0aR+FDhOmVSL6l853aDk3dq5jaGdBk
         stV9NaOBKxCKCsj6xaOEyLgvQV6M4Aosrsyohdf75gUdAHOPwQ98MKqUlBmAz7IBqcz5
         8rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaxOcHNCQgBOcrm4biyt/yiqExX0IF895chwfdoXUTo=;
        b=RYsAn4NKYhilRcT03PLJDZubMYyKcWN2BaTDDuZq/7kPQJuZJmBJCEp/3zckVG+/sR
         saLaYtGbOA9eJnvJYLnElq84HJWcA0EZh46gyozE2fsrdJPSRcWDSclnwBPFmYCilQ60
         4PRxMITpLPijPIDfCi9dz/OJ8kKYlWnPUAl8SjKW6d1nOo+DVDPcc5KRJdurkysRc94/
         UoiyHq2lK9iOt+8fY0c7mtVh0gJMpOfVSjW3wjNt98nn46w3Cz9FKaodXRy3oFuhD9w5
         I+G98lUzox3iBrE4d+77nj1bk11Twn/LpQmB7JjQR+YKXX54Gj01PPjxRS2n2Xp9s6hS
         jrCw==
X-Gm-Message-State: APjAAAVIf2SdhVUm4edNApOWgvL0RtcDrusBMNVsfTL7MItYgn4eEBJj
        pIKqLvDRLXxPyFy3I9VjO3g=
X-Google-Smtp-Source: APXvYqzV+EsRixS1BoknqxIzc/TDegZGH4tQ4ybkn7q80zhNSsYYo7kTqqdwCD7pHHj2v67UvRdY7A==
X-Received: by 2002:a2e:9848:: with SMTP id e8mr17279325ljj.148.1571174224563;
        Tue, 15 Oct 2019 14:17:04 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/17] clk: tegra30: Support custom CCLK implementation
Date:   Wed, 16 Oct 2019 00:16:06 +0300
Message-Id: <20191015211618.20758-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
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

