Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3512535A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLRUWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40097 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRUWD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so3589240ljk.7;
        Wed, 18 Dec 2019 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imexZFgDzWkCRbfUn+5A59UpWIAqIcg+AW4OI+O1fRc=;
        b=TIMpJQye0ghIU07cqIGBCHU9joO+b4fNoaBaOScbkcPvKoP2nynCfJeM14cZr5usf7
         FtgnfOziX8i8ndnKhQC2s18IGAKHF1OhywYSh/+DAgXDBoeFTPGDpMR6HqWLrETaWLmR
         Xvd9Am1YDafhT49OqEz6XrLf5y1XsMM+VlGDmSaZeQHI65r//55i4qk+EkODQ/2yzSYk
         1nhn9sAozV/twreFEdzjbFAyt0iKOMs4R7+DzhCFci5DRXiUfqPKNmxHNVniS0VMkR3w
         v14SDEH0HBLk+QmdyjiYKHEBvrNkFHw2hIMpGYy7P7mGv07RzVBaFNOx+BRuQn5FGphH
         SERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imexZFgDzWkCRbfUn+5A59UpWIAqIcg+AW4OI+O1fRc=;
        b=Gn9jTVgjiq6kZF1oQ8TZIJFqLcY0fn1+xI/qnKQeTn1AwuwkSqqQ4F6IArWg750tzR
         v7FvgXN4yNYnpeCnB4Z/3fyXM5cnGAnkpipF+j3quy+JWgpWeGsupwAmymcY53iXUP5v
         AW9dPl1yY6qMyUVTWr8zerdZ7Yb9TArRbd+VmnkDHz3xAj24NHY7JTtbfS8mv2MkcoEN
         gENSVEbFm70lerTnBgLv7w8CuZeuVB2McDC/J5B+f6W1Bg+hA44wJHN2Isbr7ZIRxs2O
         0JKNrFNVHsw93aZ/0F5AHI5FPUCSfgMYrel/wSqyTT1hhrvTJPxSdTU03wOj4jTcaadO
         ZE6w==
X-Gm-Message-State: APjAAAVfztfEejpSbgNW8MURTaDU9+1fxhbrbAcXgRvlK03+SUKx/mXw
        LOwnRnhw6rs92r3AhQMUk7E=
X-Google-Smtp-Source: APXvYqwSKSW1uHgvLkGSyLaIihjHFbQY/XiYwGvAbXPZ9q8lzZffRW7lrZtSTiaIpKHK9WTyyk1tBg==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr3286732ljo.54.1576700520622;
        Wed, 18 Dec 2019 12:22:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:00 -0800 (PST)
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
Subject: [PATCH v6 03/12] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Wed, 18 Dec 2019 23:21:33 +0300
Message-Id: <20191218202142.11717-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
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
2.24.0

