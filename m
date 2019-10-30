Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5BEA58B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfJ3VgI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:36:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44074 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfJ3Vfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so2753776lfd.11;
        Wed, 30 Oct 2019 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbLJtKoWfGlhZ2yYzvSNqEKgjc0Cow8QnHrPe+s4dKk=;
        b=sYt0IY0MV3n0HOpInaOX7CJOfia7FY6pvQcNxNJZBlwIeoA3OGqmY6cXkRDb+Ex1PN
         CizAwzcccu+VDuJ9ZG/AdR8NqVvlWLuS/rRzTIu6qXJdlBrfx5B1Ub8b3pB4Qe4mfGre
         3b3WfPsjiy1kFCPnpEJnZFvlWH5NKbCOYaG34qT6/EMH2ZVOMufe+If7rjCVmvN9wuhy
         TxDGOUez5+lmm5ht2rFsnxnyovmsW67HAjpkesy3iQDn4MePGnbVEuziBnJQBzLE8E5b
         N5nnneUdaS8QXKVgoZIydrW6JYjJ84k7WwqI3nT3w0MQDVHsd/YoMDKQVo7KLVdawZd1
         6VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbLJtKoWfGlhZ2yYzvSNqEKgjc0Cow8QnHrPe+s4dKk=;
        b=f5EbhTfsJ1pqqyvFoJ+Sg/SKxigpC8TQbqFRyRJXkMj9IJpl3SWvUDNtVaM/UGc0yg
         ma7B/GwSGRbOWDmJxX58ShZrb9Cw0fvMm4LRuCQY0j70rhJgY01wDB9q49x37y79PyHR
         B5We7qy2Qq8XkJjcXLp/2uQgE8tlnFdzfWt7e/sNRR+uwTkaNOpZsWw9/oAFV+JdZXYF
         FfuQu9SQMuTxzkusR1DacA5dSxwrVrMW7SOM6xScGfn5F+NxdNb9+MCZMI0JOs9wzQOn
         eY/MImky+fuVzmELgljxvIoKGDrznNkkCe4PsvyDSBks+fxa2F5qQ5CFEWuz7AOG6Gib
         8v3Q==
X-Gm-Message-State: APjAAAUMZBL1VOLyDT4pDBgDIAoRZiAGBvvTN9mgYenziJmqLSYVywKg
        YEsEMHiqEgYKM70pLusshzQ=
X-Google-Smtp-Source: APXvYqw9xYh95wmQAYjU+L8AqmrUtyJ9hRvYmMAI6XDfnr5aDV3POt8UuV/i23aKJ79yWXu1A+xQdw==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr226847lfc.153.1572471328193;
        Wed, 30 Oct 2019 14:35:28 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:27 -0700 (PDT)
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
Subject: [PATCH v3 04/10] clk: tegra20: Use custom CCLK implementation
Date:   Thu, 31 Oct 2019 00:33:54 +0300
Message-Id: <20191030213400.29434-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
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

