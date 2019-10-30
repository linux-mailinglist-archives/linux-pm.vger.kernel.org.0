Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB24EA583
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfJ3Vfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44074 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfJ3Vfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so2753811lfd.11;
        Wed, 30 Oct 2019 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZXgBiZ7YOkoGyisWeubyUkOPcMd11xlE2xTsIL1hcs=;
        b=pWqTn8F1cf6KdDw1IogG3DYjamYVOwnJwIKPP5jYkfX6RipToLsLAQfIjn2qDVhsR4
         oj3Jt0OItTvvQxUUE9uRnvQ8p/ML3Zqnjb6GpAbukEl9Z7QgaZ5IIVAjXTnSq0Op4JE7
         R2X6QouHch+tAaG44+BXHWbBLmReDe7qQRnOVOikVBqVLtLaoD7uEhZTGL9oXZfq9qRO
         fm0Tk05pSDlwormMHanT/MAUfM6JSLfz+axiuf2zU9ypUrUG+Y1WR2lLB4mF/px4MATC
         QNnVsaurvI8dI2tbwbJmuyUeDvBdNKYvd/H7eFBIfefWc4CbpF3ypBPBDJnTKym6f8+s
         dCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZXgBiZ7YOkoGyisWeubyUkOPcMd11xlE2xTsIL1hcs=;
        b=R83bEEtWBzty/gFNXNcGZQRG1+dD1TRAGttqvbUMSpvHBS5/Wk1zH35vZ2DbS96fxw
         gbja2WOyS3AhBr2Z19NE9O1CzecYR0RN052gKXy+71egENR3wB4EYQALJ9/sKFDCVIpv
         RN69AoCruIHVbPWjb5+Z5N32aUrPbqAQmQJgsVdN82cdNhjFwu5pTVKej3IcMrkYB6f0
         mEWuPPnbtsGfmmZBRqMCl7TuC3sntamgAunXu9V5cISEzhyxX2nHIEB93yhxxscIk2ai
         zr20En4LaCqh7zbJBckI+FlDIlVZI5EAckbL3/ugmX90MgBIxe6TVBfVUN89dvRqDkQe
         DvWA==
X-Gm-Message-State: APjAAAV+NA6qs6vV98NhmCaEzuAqGUlzARxQVsCj5maVATJeR5fvTfX9
        hkXYJMnv6P21Bsz7LglMJ7E=
X-Google-Smtp-Source: APXvYqx977yb+MS+GJ5iH+ErzHq2FIs5tonlPqY3+qtmNyiAYwEvDewUgz/mLnhuGNWVwZatPaxWKw==
X-Received: by 2002:a19:e018:: with SMTP id x24mr213962lfg.191.1572471329315;
        Wed, 30 Oct 2019 14:35:29 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:28 -0700 (PDT)
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
Subject: [PATCH v3 05/10] clk: tegra30: Use custom CCLK implementation
Date:   Thu, 31 Oct 2019 00:33:55 +0300
Message-Id: <20191030213400.29434-6-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
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

