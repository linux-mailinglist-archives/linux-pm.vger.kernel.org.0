Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA75F81C7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKU5r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39254 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKKU5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so2365790lfk.6;
        Mon, 11 Nov 2019 12:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pG9lXccv0oOEUJTH/gOp3aikTwBYEJL3+x/Tztb4ZXo=;
        b=ZkINMQoiT/jCLcB/Il6D7tp13igrBaOrQmFWZ/9dIP4MutQdUT2AKJpNyQTyZ5Q5EW
         rMnGETQBf/e5bo95mmdlVyUooaNbYYWwuERpY36dfI6JdPcuoLUozMspHwxJIiShTcpC
         0FIALRAq/js8RsbEDZItkDJLSnPRqsqkgyvx2Xl9YB0KSoKe0s6xdWLPdXOrietuKXBQ
         M5jlXvHTu0YB+6FqnBI40Si87W/93go0tnzNasghoUzmZtUoGx7j0K/4HQNdSwOKJYBh
         XhCvstrYDjEwVUQ2p7OXxMPsKvDDh+qshYgEqwG+lIVq59uNL+tR8JHM6aZV0eN7msjA
         nyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pG9lXccv0oOEUJTH/gOp3aikTwBYEJL3+x/Tztb4ZXo=;
        b=ElwESIv2iYkLveEkmHxrXvozyR05LYhDT8159G6BHnEOJKP7V854kZMhvDij3k0td+
         /gEU1Mb89mfPC+tkFUd8c5FrDBtfComsSUPO+uC9d1BacnsW3FLhbTLPQxfozx9CRdUI
         YnDydh6t1XdrG3XDt6cqDOBVVlIBAZYbuU6Q1P6TNMjYMNiwW0EiXTdHlnwQrKpcM22j
         AL+7KvmQasE9zMUn4GawI31wo0G+zvP7RHSz/CTK100sTpHhqm7cOZ19a9neubdiEVyb
         Nz3FYZvJLr1xq2HSCvwtyrA5TYlwG2tGoaY6vEMEcopT8flC4Bs8D1VUOi2BFiSydZWR
         wFnA==
X-Gm-Message-State: APjAAAW5F5fz4hBMX4iTPY1fDzXt7qh32Mx7S2jaIwJwimj+/0X07qUk
        Rk707WpRWuliIJuH42G1L/YikiD7
X-Google-Smtp-Source: APXvYqyTLvaW2jX9fnIpBh+CACwUJYXd1X6vSzrQ2vWpCHoS0b+gPFRz9R5AOCf5ttzmw8HybM0GZA==
X-Received: by 2002:a19:ae02:: with SMTP id f2mr7206530lfc.54.1573505830112;
        Mon, 11 Nov 2019 12:57:10 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:09 -0800 (PST)
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
Subject: [PATCH v4 03/10] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Mon, 11 Nov 2019 23:54:12 +0300
Message-Id: <20191111205419.16768-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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
2.23.0

