Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8E1F3C2D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgFINS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgFINOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA8C08C5C2;
        Tue,  9 Jun 2020 06:14:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so23348190ljm.9;
        Tue, 09 Jun 2020 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6f9+MOvkwq1aAaynwsAkKO2umWR0wN+jrBMe13wif8=;
        b=kkSv/99gOI/t6u4mXuEC1Si/b5wfS61hLdZiZuJcLBD4SD5XNUB4OGCPwTKPQHewDh
         WJlMxACKl0Uh4wgpLAM94ve+C1wuCJQFMENy3TvxdYc4gDQWBjNkL0eU6cvfIF1P0HU/
         /UYMSBxVNj81W7nOjsn9GtqCvrjB6SRiPZxpKs7ZLwniJQH76f5OsqSATpUQ0dkdc3NV
         kKGOqvNV6xYcSCAyhJHDCv+SWUDXLEE5fc3I6BYZwgjsJlEYqQMN7J1eoJzl7cSx6Yul
         02YH8JIckFCOtgMJDcyqDadEyk/aMC8ObvjsuVTypsmrwyNRU5ZG3Hj8XqHT8lF4gM0c
         PDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6f9+MOvkwq1aAaynwsAkKO2umWR0wN+jrBMe13wif8=;
        b=TBcX5s7XmeHuUm6kLyTgJTc49SCm8puL4LO1FkN1qcvVT8FNMk5SSEyFtkTPYSGqLm
         +w68MthAiaqcb/rvp7EFuvVZTEaPm7q0Tp98oADzEai/cdIyPZWPA8z1rVrWKSAMj1Jb
         j2b7Z9iHZG5CfYF4Jn6nW5L5qzQYHl5w3TkFLzjztMTjqSHgq6Wc2+uonUDSQKfpQRDG
         d60u/IJlMKFx4NXoK0kYcUyLVF6REmlIA+YAk5IEtqbeHb+BKC3tlc2bMB2k63JJJcQ1
         1f44bqzgM6VzO0ZBCgri1LutOqEPBdRCGMmY89AzlQyHC0fvrdApbaHxNt/5EUCYfCwg
         Q9Dw==
X-Gm-Message-State: AOAM5317qGK2vkXKwL14eGmGkWLWtKkALugBZpbdUJQTWitk0wPaBTj7
        HCQ9qr/V6Eof22d3xeBvesM=
X-Google-Smtp-Source: ABdhPJyb3PjfqSp+L3AKcWzLA0R8DGC3n8YGAq8iTxF1RrXpc11/Hufi5Iffw7zOD7eTzxa4tPog4w==
X-Received: by 2002:a05:651c:1044:: with SMTP id x4mr9577629ljm.409.1591708467431;
        Tue, 09 Jun 2020 06:14:27 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 02/37] clk: tegra: Remove Memory Controller lock
Date:   Tue,  9 Jun 2020 16:13:29 +0300
Message-Id: <20200609131404.17523-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The shared Memory Controller lock isn't needed since the time when
Memory Clock was made read-only. The lock could be removed safely now.
Hence let's remove it, this will help a tad to make further patches
cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c  | 4 ++--
 drivers/clk/tegra/clk-tegra114.c | 6 ++----
 drivers/clk/tegra/clk-tegra124.c | 7 ++-----
 drivers/clk/tegra/clk-tegra20.c  | 3 +--
 drivers/clk/tegra/clk-tegra30.c  | 3 +--
 drivers/clk/tegra/clk.h          | 2 +-
 6 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 38daf483ddf1..56adb01638cc 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -177,10 +177,10 @@ static const struct clk_div_table mc_div_table[] = {
 };
 
 struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
-				  void __iomem *reg, spinlock_t *lock)
+				  void __iomem *reg)
 {
 	return clk_register_divider_table(NULL, name, parent_name,
 					  CLK_IS_CRITICAL,
 					  reg, 16, 1, CLK_DIVIDER_READ_ONLY,
-					  mc_div_table, lock);
+					  mc_div_table, NULL);
 }
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index bc9e47a4cb60..ca8d9737d301 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -134,7 +134,6 @@ static DEFINE_SPINLOCK(pll_d_lock);
 static DEFINE_SPINLOCK(pll_d2_lock);
 static DEFINE_SPINLOCK(pll_u_lock);
 static DEFINE_SPINLOCK(pll_re_lock);
-static DEFINE_SPINLOCK(emc_lock);
 
 static struct div_nmp pllxc_nmp = {
 	.divm_shift = 0,
@@ -1050,10 +1049,9 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
 			       CLK_SET_RATE_NO_REPARENT,
 			       clk_base + CLK_SOURCE_EMC,
-			       29, 3, 0, &emc_lock);
+			       29, 3, 0, NULL);
 
-	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
-				    &emc_lock);
+	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC);
 	clks[TEGRA114_CLK_MC] = clk;
 
 	clk = tegra_clk_register_periph_gate("mipi-cal", "clk_m", 0, clk_base,
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index e931319dcc9d..0c956e14b9ca 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -126,7 +126,6 @@ static DEFINE_SPINLOCK(pll_d_lock);
 static DEFINE_SPINLOCK(pll_e_lock);
 static DEFINE_SPINLOCK(pll_re_lock);
 static DEFINE_SPINLOCK(pll_u_lock);
-static DEFINE_SPINLOCK(emc_lock);
 static DEFINE_SPINLOCK(sor0_lock);
 
 /* possible OSC frequencies in Hz */
@@ -1050,8 +1049,7 @@ static __init void tegra124_periph_clk_init(void __iomem *clk_base,
 					     periph_clk_enb_refcnt);
 	clks[TEGRA124_CLK_DSIB] = clk;
 
-	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
-				    &emc_lock);
+	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC);
 	clks[TEGRA124_CLK_MC] = clk;
 
 	/* cml0 */
@@ -1518,8 +1516,7 @@ static void __init tegra124_132_clock_init_post(struct device_node *np)
 				  tegra124_reset_deassert);
 	tegra_add_of_provider(np, of_clk_src_onecell_get);
 
-	clks[TEGRA124_CLK_EMC] = tegra_clk_register_emc(clk_base, np,
-							&emc_lock);
+	clks[TEGRA124_CLK_EMC] = tegra_clk_register_emc(clk_base, np, NULL);
 
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 3efc651b42e3..2f8b6de4198f 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -802,8 +802,7 @@ static void __init tegra20_periph_clk_init(void)
 
 	clks[TEGRA20_CLK_EMC] = clk;
 
-	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
-				    NULL);
+	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC);
 	clks[TEGRA20_CLK_MC] = clk;
 
 	/* dsi */
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 37244a7e68c2..88e8c485f8ae 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1042,8 +1042,7 @@ static void __init tegra30_periph_clk_init(void)
 
 	clks[TEGRA30_CLK_EMC] = clk;
 
-	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
-				    NULL);
+	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC);
 	clks[TEGRA30_CLK_MC] = clk;
 
 	/* cml0 */
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 6b565f6b5f66..5ed8b95d331c 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -136,7 +136,7 @@ struct clk *tegra_clk_register_divider(const char *name,
 		unsigned long flags, u8 clk_divider_flags, u8 shift, u8 width,
 		u8 frac_width, spinlock_t *lock);
 struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
-				  void __iomem *reg, spinlock_t *lock);
+				  void __iomem *reg);
 
 /*
  * Tegra PLL:
-- 
2.26.0

