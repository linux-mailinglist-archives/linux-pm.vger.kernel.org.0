Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCBD100986
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKRQqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42561 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRQqw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so19727525ljc.9;
        Mon, 18 Nov 2019 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbLJtKoWfGlhZ2yYzvSNqEKgjc0Cow8QnHrPe+s4dKk=;
        b=Spe6Tzh60D3ZTg9s/zkyl7wl4CuoTu0oyslPSiyEOtyirEZQeaFbOey3pfBLyFETcC
         vSAzesQHoplqbIKVa4mA42Q13P9AOO+q3QCvMuxuAQOaHgBsVnD/rWZei158k2qX9dj2
         FqjIy4eZSdcz43V6s/qW3wCERH/leZFhX5elCsc/kDREY8asUobqdAS12PAxDFUypcLc
         7V3t5ABm336ZEc2TUIHxmH9ofZJT3fZDUicPe2ldnoWpef7eKz55pl+vKBSf+Z7cQyLA
         XFGZUPVYZ9muXzf85x0GR3Coc9b/dCdloxVUZxxFWXJS+yAEPhZK/x5ponNB3QEalP/B
         Lu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbLJtKoWfGlhZ2yYzvSNqEKgjc0Cow8QnHrPe+s4dKk=;
        b=iX//Qg5HA0FPkGpzvDjZbupVHuXtyP3wVvmJOX+ChzWfUSZrcOXUb0YMq2ROTqPw8P
         owMpA4Q+Oiz+Npx1bB4H7ZxEChMqh4z2na/hiFBvOQPL8XlVCWhmbOwE8+tyea9PTXs6
         dhPHWW/A4Zxg+xH/slpiDxmjuEoWf4HJYTgFwq6aVuSu2kuVZB9cNIx+ho7VcSj5e0Cc
         HzM4GMbU3HVJhJyaKd3FTfn33Tc++dWZ2bf8gz6rQUrWPRUsGTDVdeBqL6RKV7TQSccz
         cGddGRb22VtkvSU6kjDPI9LXH70LoS+XuotWJ/dra0KQSZWg9JAVirHBAW1pascg9dHo
         PKSg==
X-Gm-Message-State: APjAAAWSdhhNiDsBK5/0Ozhe+OjQrifWKfRX7oO3CeX1Y3WI7kD5DLbb
        O3r7W9udkA7UBsE+7l4vayw=
X-Google-Smtp-Source: APXvYqzlStWq8xLfPnzIePvkf3wmed1fYUfNORwB5pIca2VkphXS5T1s/r1C+tDD8TaUy5o/TSi1/w==
X-Received: by 2002:a2e:990b:: with SMTP id v11mr238497lji.151.1574095609837;
        Mon, 18 Nov 2019 08:46:49 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:49 -0800 (PST)
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
Subject: [PATCH v5 04/11] clk: tegra20: Use custom CCLK implementation
Date:   Mon, 18 Nov 2019 19:45:05 +0300
Message-Id: <20191118164512.8676-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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
2.23.0

