Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977E415B532
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgBLXrN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:47:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36295 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgBLXqf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so4436205ljg.3;
        Wed, 12 Feb 2020 15:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jy56CF/Sf3+uwtcC22JB0l4dVspO7RMlTf9CHzOik90=;
        b=eTkALLQ3hUb7OazlEVmx7iXWbaEUtHgwSE9rOlYHjXOsItzOn+EdnYGCU0YpALRZ/8
         407RdA32aWzUcSjqIBiTLj4LuaP2/jNXpZNcLnKgp1yQcAs6djW0b/9wkJNoRT/89QhG
         CzfOOPOY8ApGDh3y8dkuAyApvNuL8eay5B3CsayjjkP0F2dsgY5c31pRFwompKpnlUPp
         2Qy5GVmgL/Gm7/NdASyDWeQXKWUk11EvmwRVWPkMKBrZyqIP1pQGhEoadDvZmlHXbPyd
         05gA44dS95/2ux0Xpitso5DvpoEOFDVhkxfWSmnnM58SaFHKHPTJVSfyOQ5WW64Ci2R8
         eqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jy56CF/Sf3+uwtcC22JB0l4dVspO7RMlTf9CHzOik90=;
        b=BseYG39QoQSN2lsMEKyjv0amZkHZn2JJGUktSINMSICes65RdS7QPSWMTGNk87A2jb
         KujZK20x9kNcXik+/QDI9iR7Ujh5NbOKBb0TPWLBbZ0smpwcCngdYluudxCYFgwxGqgW
         t3tLfsX1EBtucfwGF40UyPifIKI8N7E+/+K1SIjfBZISUigdUIGdPqirNt5OIAy5KUuV
         kkSkx6PpwjoUMK8VvZM6LXkt1p3PKLibRjuWi+5Zdu2V+auMq7iS2+uK/ArK8QOHWAn8
         Igz19w5uyg7kx5Z5GvBsmNmOSmaoXKcwr5bQ1sMy8TnKij6kKHLIRALswmPAaR1gPN3K
         Ns2w==
X-Gm-Message-State: APjAAAWatgAry6WTchtSOpoIZeaMWFX8aPN7BTXIHq7SEAAOfndUwQAq
        b3TGxz+XlX1JyXiYKbXU4Vw=
X-Google-Smtp-Source: APXvYqz4JyU+3wNqJIDiJjOpdF5KcYIIaNgf8sK9D5jbCPw0IUrx7/8sJGeO8DR6YJsMfBDPOAWRGw==
X-Received: by 2002:a2e:3e13:: with SMTP id l19mr9013337lja.11.1581551192796;
        Wed, 12 Feb 2020 15:46:32 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:32 -0800 (PST)
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
Subject: [PATCH v7 03/12] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Thu, 13 Feb 2020 02:45:58 +0300
Message-Id: <20200212234607.11521-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
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

