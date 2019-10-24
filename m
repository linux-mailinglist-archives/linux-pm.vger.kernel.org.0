Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99A7E3F38
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfJXWTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:19:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34786 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJXWRl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id 139so175939ljf.1;
        Thu, 24 Oct 2019 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wB82R3MFt67D59fjq1rNSmAnF6D5wU77YsrpbjBZwI=;
        b=iGokp3ukRR7ewHcVMoCNHaHnK/gTGCdknRlM2lNAlBCvMpZQaJi9NdHGzedfS/bxA4
         ahIbx6PihpwDlH8tzYNCZ4NGp+3dsJh6CzS8icdF9XxJ1h+UfuZVmVboDguTKiLYs11p
         GpI9KxHKEKszoFQVToDGNjK26eD2sX0I8fTuRDSNVZUdVoiSH7cwa8VOPJFUhgTOqq68
         H+p4bctm1tx4vUrQexT2zzkkqgVD7k0Nfnn5smbcmAYY/5/9T2IU5F7gQz3e6XpgTEE1
         1Xltwr2fyS3PJNGNan1YDHhqky6qPrfywgCyQ7OSuCuJ5pSLmlYwjXC/M49nDP4rb7Qa
         RgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wB82R3MFt67D59fjq1rNSmAnF6D5wU77YsrpbjBZwI=;
        b=CFyB4uyk2VmJSb1LOMCv1grz6zR9ftPF59oVckPRf5yxTwz1GISAAX9YDrVHfl5oZg
         VnsSFgAZ5+YfuCVb4pyrE7RyEjskNE50TStb/VJT42qdcAOnrJpI+Co+yDVQlxME6RNY
         GqnwpBQT1Wb7FEA+u02K8xcn88pdTieqajC3MgbwsfaKaoTME4RFc9uvt2uL7MN5xD6P
         Gvt/+4fytiDytFHstO8cZhOT0RB8yAAGDIDib8C6uBQeMvPeYAnbFMgQO1aV9HyxEKxa
         mYL5AQ9BZBVBENel2R0nIXmqSpjR/kdZzwl5oa/uTpzKcab6MNB9+YtPNXPfpWx5zfu8
         eJNw==
X-Gm-Message-State: APjAAAWo2PWAZE3nxEEeZ8Lqh0fsvGZfk5ETQNxjrWzsslWucto/CRJc
        qxgBToeg44L0cG7KchnCp5c=
X-Google-Smtp-Source: APXvYqxPQaepcEj5dkqg9xQNacRaP9CR0JTafW0HoCSEsdqzoqAcdGvKnmgYYnYbWFn2rVThzWRsIg==
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr24620lja.239.1571955458243;
        Thu, 24 Oct 2019 15:17:38 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/17] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Fri, 25 Oct 2019 01:14:02 +0300
Message-Id: <20191024221416.14197-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
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
index a032d2701fc9..56e7626ef288 100644
--- a/drivers/clk/tegra/clk-tegra-super-cclk.c
+++ b/drivers/clk/tegra/clk-tegra-super-cclk.c
@@ -21,6 +21,9 @@
 #define PLLP_INDEX	4
 #define PLLX_INDEX	8
 
+static struct tegra_clk_super_mux *cclk_super;
+static bool cclk_on_pllx;
+
 static u8 cclk_super_get_parent(struct clk_hw *hw)
 {
 	return tegra_clk_super_ops.get_parent(hw);
@@ -98,6 +101,9 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
 	struct clk *clk;
 	struct clk_init_data init;
 
+	if (WARN_ON(cclk_super))
+		return ERR_PTR(-EBUSY);
+
 	super = kzalloc(sizeof(*super), GFP_KERNEL);
 	if (!super)
 		return ERR_PTR(-ENOMEM);
@@ -125,6 +131,34 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
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
index 2be38aa2c204..3285b0332ae8 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -709,6 +709,8 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		spinlock_t *lock);
+int tegra_cclk_pre_pllx_rate_change(void);
+void tegra_cclk_post_pllx_rate_change(void);
 
 /**
  * struct tegra_sdmmc_mux - switch divider with Low Jitter inputs for SDMMC
-- 
2.23.0

