Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE418C006
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCSTE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40077 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSTEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so3760963ljj.7;
        Thu, 19 Mar 2020 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQCiOS4Pyn9ED/MgeohcKz78uGXYycVKqXoXcDIM5iY=;
        b=Jv1nnxbM/OsQc82UxjrfUi2g2dHNGyoVgg5OkVxcxKfYIZbC5n+m32dkr4geTnRB/g
         jbEpd6oauDLjEjdZ27p1373wdu8IJmdAjzbV+FV27TQ7AibA0FvX7fpM71X0rJ06+wzV
         GDQgpf/qy/7QNO04+jvB83vVBpr47VmIaQqCAkaV36kfJUjpRmKNfUh8J71rHEnBLPUr
         VgXcb/9386+NQlZKl+RbH33hlbPeprXV8spb4YTxYDKxQWaI2Ta9kpTlPsm+jPQPYiqz
         Gxs9ukwLavsQWNQCiZkiVa0FSQlrYLni3lVGybYhH80dfLBCXyNUG1HqPWX2tLoPIw+/
         Sr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQCiOS4Pyn9ED/MgeohcKz78uGXYycVKqXoXcDIM5iY=;
        b=LZd8pwLBmgCR2u3Fq7PlLdDCZQKsYrOVMdQgtNyU6MrFWNCYCzsDnJSvLgf+ZzKvec
         Ih1FYR/IDXklyP1eGaZ2EgXIQvMVN1hQv8vsb8IHATJJupQOhIZ05sKAIaKWi+9C5BE+
         2ADgL/etDrPXsyGavA9y2u8sZU3sHJo3bKQY+rWc6I+VVtVZRGu7/8T0NZyJxfFTyaek
         wn7vOGhjD9NEavKeMuGtVf3BZ3CUH9F2Y7QFazTdBaZekvwPnhjaqhBvlrIBqQWMulj8
         c80FoIYJP30c16j+v3ukTvd0vlTR7xFz5/BCBkm2VnmmcFU2lUCCxYjuQhZy8gX+nQK1
         FYZQ==
X-Gm-Message-State: ANhLgQ2GDZkdFZAAMhgDFIPlvDMSlUjESb3l1NOWuaDg9EVBfU+tiJWT
        ik5iEEHv5ZrMg6Q/3+UhOvU=
X-Google-Smtp-Source: ADFU+vtqJqyB9vPFtt9Xrh9pbzmrwmwrz/OOytKPu7fJKEQJa4/uVeXn4zJCxQGP+Vln8fAuCeKv5A==
X-Received: by 2002:a2e:99d6:: with SMTP id l22mr2962336ljj.231.1584644650609;
        Thu, 19 Mar 2020 12:04:10 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:10 -0700 (PDT)
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
Subject: [PATCH v8 03/12] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Thu, 19 Mar 2020 22:02:20 +0300
Message-Id: <20200319190229.32200-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CCLK should be re-parented away from PLLX if PLLX's rate is changing.
The PLLP parent is a common safe CPU parent for all Tegra SoCs, thus
CCLK will be re-parented to PLLP before PLLX rate-change begins and then
switched back to PLLX after the rate-change completion. This patch adds
helper functions which perform CCLK re-parenting, these helpers will be
utilized by further patches.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra-super-cclk.c | 34 ++++++++++++++++++++++++
 drivers/clk/tegra/clk.h                  |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra-super-cclk.c b/drivers/clk/tegra/clk-tegra-super-cclk.c
index 7bcb9e8d0860..a03119c30456 100644
--- a/drivers/clk/tegra/clk-tegra-super-cclk.c
+++ b/drivers/clk/tegra/clk-tegra-super-cclk.c
@@ -25,6 +25,9 @@
 
 #define SUPER_CDIV_ENB		BIT(31)
 
+static struct tegra_clk_super_mux *cclk_super;
+static bool cclk_on_pllx;
+
 static u8 cclk_super_get_parent(struct clk_hw *hw)
 {
 	return tegra_clk_super_ops.get_parent(hw);
@@ -115,6 +118,9 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
 	struct clk_init_data init;
 	u32 val;
 
+	if (WARN_ON(cclk_super))
+		return ERR_PTR(-EBUSY);
+
 	super = kzalloc(sizeof(*super), GFP_KERNEL);
 	if (!super)
 		return ERR_PTR(-ENOMEM);
@@ -173,6 +179,34 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
 	clk = clk_register(NULL, &super->hw);
 	if (IS_ERR(clk))
 		kfree(super);
+	else
+		cclk_super = super;
 
 	return clk;
 }
+
+int tegra_cclk_pre_pllx_rate_change(void)
+{
+	if (IS_ERR_OR_NULL(cclk_super))
+		return -EINVAL;
+
+	if (cclk_super_get_parent(&cclk_super->hw) == PLLX_INDEX)
+		cclk_on_pllx = true;
+	else
+		cclk_on_pllx = false;
+
+	/*
+	 * CPU needs to be temporarily re-parented away from PLLX if PLLX
+	 * changes its rate. PLLP is a safe parent for CPU on all Tegra SoCs.
+	 */
+	if (cclk_on_pllx)
+		cclk_super_set_parent(&cclk_super->hw, PLLP_INDEX);
+
+	return 0;
+}
+
+void tegra_cclk_post_pllx_rate_change(void)
+{
+	if (cclk_on_pllx)
+		cclk_super_set_parent(&cclk_super->hw, PLLX_INDEX);
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index e67c19eadb19..8ca215955bfa 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -771,6 +771,8 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		spinlock_t *lock);
+int tegra_cclk_pre_pllx_rate_change(void);
+void tegra_cclk_post_pllx_rate_change(void);
 
 /**
  * struct tegra_sdmmc_mux - switch divider with Low Jitter inputs for SDMMC
-- 
2.25.1

