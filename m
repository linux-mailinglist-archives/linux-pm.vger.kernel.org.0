Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F48AEA58F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfJ3VgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:36:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38638 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so3940740ljc.5;
        Wed, 30 Oct 2019 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVzm8mtRZe9pGxMBECnqp/gOMywxQtkTfIw9ywF34Yw=;
        b=UNRbGTr5WuGohvs1YxWTAZri7+eq9htoRCvk2CrGjDnXG7VNuNuea+xI8IUIVi//zB
         b81E8BErKCZ4zJJMT0/maJTaJ1Q3CJmetf4XSTAj0SVS8t3qOaZ7+p4N4Rj9Ollkq2ch
         HfPgkvdHjuZW2gLAgGQ5xEcIV8gk7mrFEGKyglS6L1VJ9Wex2VC+8n/tDPMFlqfO2vxy
         +gpMp7CuT1+Y8S3Lu/L5NE2ibM4JnumIvc5Ji9b6fk1LTS39oVXnPB5m0nnPT4RK5Qgm
         0/66ODqLQOtpyekhn0uVZlZMBmQox+SDuqYbGxlMJeRHAjl7jGvL9VU5wT8NEnLj5qT5
         2QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVzm8mtRZe9pGxMBECnqp/gOMywxQtkTfIw9ywF34Yw=;
        b=sQyx8QsIqa89KQa3Uof5BtZeg/vTjalxTGJHGTGH8hNNA3K7h4z8KcjF0rT4T9lzsn
         TlAZPIA5C6KIxxbcOJ/bTdShG/bc0urQMNHz74JExYpfh+b++0sS5VyWodNFLnh3vPNz
         SUDhLECtzBLykaKNAlStpi/COqLQGsCgpx/o+C7QBX95vwqu20atb178d8eCNns2fnDa
         kT0CnvF/DMo8+oaDu/Hk7iwgHpmwiEk8ASrPcR2cWMeIJvgclfJpHyLv8IeHmvpLAafO
         PsWueH2Z92iCfUBBDwVN6ymdK8FsxGGz2+NmZYCMuUnDYRYiCogVNXagelVnUUfRVKMY
         vu8g==
X-Gm-Message-State: APjAAAUIp58ob8CMJGHjCqIEdmCBd8Idhhv3/i1vhY7Yb8MSIG0d6ki0
        JKVd8yFRkztKSWOYKxhC54Y=
X-Google-Smtp-Source: APXvYqxNqQZFcLENWauGXTZYF4ycn2H0Ke6gJe3XnMbceLKhPamFT+iRFbeh7Uv2StfqcxVp6gOXYQ==
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr1298579ljm.60.1572471327121;
        Wed, 30 Oct 2019 14:35:27 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:26 -0700 (PDT)
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
Subject: [PATCH v3 03/10] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Thu, 31 Oct 2019 00:33:53 +0300
Message-Id: <20191030213400.29434-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra-super-cclk.c | 34 ++++++++++++++++++++++++
 drivers/clk/tegra/clk.h                  |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra-super-cclk.c b/drivers/clk/tegra/clk-tegra-super-cclk.c
index 5cff8363c978..c7e4be0efc59 100644
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
@@ -171,6 +177,34 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
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
index fa18bef914af..0afe28f4372b 100644
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
2.23.0

