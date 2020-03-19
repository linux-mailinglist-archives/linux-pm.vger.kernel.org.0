Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D1118BFE3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCSTER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35725 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgCSTEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so3807535ljo.2;
        Thu, 19 Mar 2020 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODK6Kk27PrnQOcFwDD//72uI90JfjAQ39Nvujl8BUsc=;
        b=pfRDJg2z9wrKPiHrbHUuqoEe7njI8jZ5ZMZwH6oC1qfo7Xxy68z07cM7Cy0IPhyw5d
         spTeJzZ0YBLtM3Jz1rrFYZAPyJQl03lu+YZaX1M2uqVmdwAD+xeLy/4+iuQvCCdQjaBU
         +kpqzGItC0P3717T1WpXEr2A8eEhkclIBC00gGR42EzcqmSbIAB6ZSTQogVhV57y9TbT
         a7TDuCyUiFr1DjvhChaFijxBFOUU4uMgj0CGNmMR2AuHtPfMHZ+n4QGW6bcXFRLuXmer
         dPFUQyBaRd145d8jjd6bI1DRoSJ5kq5MJMtpfceyJKruf/vmb5eiYNaWlQyiDUtmTlHR
         Kk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODK6Kk27PrnQOcFwDD//72uI90JfjAQ39Nvujl8BUsc=;
        b=qxO13vGJkbZk311IGua/XTlPlZj5f9BddGm1A35qycVc95ONoi1MPGVVKPIlevG1DG
         +O9OyXXQkczqL8qFPXT6xsVHCMyLeNSuPHyI4746MtY98vM/zsZ0gviQpQE8gvCPt5uI
         ozzDTtxqa+ZJarjfTzAc01P/aslnr64YmYv5Es3SO3wy+3I/kqBTlv3ALOVDVN8VWcrs
         u9U3TVsJHF+qimPfWlbhlKx4D2gxR877g2cWQ++PE+8rip3JEMSfIUgrMo0xpTlSZQwb
         DAnwuoVqvwnYRpQqwnXGjDoG2geUAjTvLpa/TYVVGVpjAE6gb8zHHM0W6P4Aa+CKHGVS
         inVQ==
X-Gm-Message-State: ANhLgQ3CQYj6v0KsjatAK2YePam91Xhk0bKS0kBNqz6wdFioikDGbcgP
        MwXLyKjq5c7ZE0KHcBvbdNY=
X-Google-Smtp-Source: ADFU+vu/OkZ/e8wr4dxL0lZawKNIvBrUkaPvsqSLQ1B07/+runsfIKJWJW7mKOYeXA2qecrb+BuvLg==
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr2952495ljl.48.1584644653682;
        Thu, 19 Mar 2020 12:04:13 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:13 -0700 (PDT)
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
Subject: [PATCH v8 05/12] clk: tegra30: Use custom CCLK implementation
Date:   Thu, 19 Mar 2020 22:02:22 +0300
Message-Id: <20200319190229.32200-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
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
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 3255f82e61b5..37244a7e68c2 100644
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
@@ -926,11 +928,11 @@ static void __init tegra30_super_clk_init(void)
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
2.25.1

