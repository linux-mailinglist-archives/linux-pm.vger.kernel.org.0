Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F35F81A7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKKU5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41282 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKKU5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so10951755lfb.8;
        Mon, 11 Nov 2019 12:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZXgBiZ7YOkoGyisWeubyUkOPcMd11xlE2xTsIL1hcs=;
        b=JN4lPrste717s/4AQdu1jc1YIYNtZXuqu5CWkhLocrAQX9wq1Z9uWmTwoPG3n0KTDd
         2RnHc82t6mkhZVFE2o2Jdy6YiFfJcqlBhyynKaDmjSRlBWJ2j+gDC59FWpCtMl6Ff5f7
         vwwnbetoVoQgl98Jwp/bT8OwArU3ewDOVum4hKLf/OmfETeFjH649L9ctPpk21FcfDTB
         HoagzqDt+LmEsLwBzxwd8Qif+T5zWId5zfj5vGQqbdZ6ZcB3XbVeNcByhQ1EOWFzPvfF
         vf4iDSD/AL1OMEzEfJbLyhmhKqgYD5SVgxWUHv3x7jvWfeodCf/5mlrmrTtY+zeXIhXZ
         Gogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZXgBiZ7YOkoGyisWeubyUkOPcMd11xlE2xTsIL1hcs=;
        b=FMZBuVcbk9vNfvlElknv7G2IS7j3nY2vn8POF3OzfD0eYrCjkiu7kKu0zPzOfffpOZ
         w+NhxJfuYzrnzLsj3tm8LA1JkhSJuCLL9IVgtcT/4di+IQpt4ZD6BPuVoWrYQxsNOOth
         7fwpZlfpxDCf2H9YQDBHEh4H5Fz7Ay8AdJhwpbX25b1ajRkXOSeqpDjn1wH9wlZ7wiXy
         ZC0TRi3e3fnlvBeaVN66Fw8pdjecKYbyrGwJ+YcImHKQbVq/SnPJnx00+E8koJY/Thga
         3wYj+GjarjCAHjfSujO0mVFEJXMsOYnEmV1qGHXqmHGc8PXyA9mvjMW68i3W1IRguNEZ
         pIrw==
X-Gm-Message-State: APjAAAUG7JBb5iFivfGHa6ure1yjfI3pcODrUr0I7G3rt9czWnsU8fuB
        8gC7AUy1C2i4MBUCyJUS9iA=
X-Google-Smtp-Source: APXvYqxRsfVaocdlSi5pMhGFrip887n9pCvGiTBOokLkS0zGZq+wSp+5cS7302YNUSziBslKQS3jMA==
X-Received: by 2002:a19:4314:: with SMTP id q20mr16210252lfa.146.1573505832319;
        Mon, 11 Nov 2019 12:57:12 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:11 -0800 (PST)
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
Subject: [PATCH v4 05/10] clk: tegra30: Use custom CCLK implementation
Date:   Mon, 11 Nov 2019 23:54:14 +0300
Message-Id: <20191111205419.16768-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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

