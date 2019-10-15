Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3BD81DF
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbfJOVRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45205 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388542AbfJOVRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id a19so2725348lfg.12;
        Tue, 15 Oct 2019 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxE09PUcKKlExbr/5uoOUH1nEVCHzR8KIH2/PrRNMfI=;
        b=TVHE7h4Yq2BENyPFXKaq+AkyBAAOXTp7hMJt63QwDtuy0X8srXp6CV8ZkGzhUQ3RZ7
         eZ5unQf0L0Vt6Vqm0J1+upkYbvt6eU+7LJYcQ4VyIegv82QuDW+WA4DsHLhYCyPS+Jyt
         ogKsqZpkLDbItQvcisrMYSNfIBzXTDW/+38j3W3V99UDFp4oE2UeGkidx2SqHxCzHdMX
         1H2ASLfA7psXuVfLnPiwdzv/kgmxD06Ec7A6+YqZ0bUQYfIjpO08tW+SgmytU7peAbdI
         amvGmU/OUsnI/mOGmw7S/L7RgdhRwU32mhHmVu9vBpPLEz4Z3xfQQ0S3T7czydP11ClI
         T5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxE09PUcKKlExbr/5uoOUH1nEVCHzR8KIH2/PrRNMfI=;
        b=Ik6YhjIIsVuCnnTYVEMhjWRUoTbub9EGEaxOUlMcDRrWDOLyktksYuLyLj9kZCrX8F
         Vj2FIGEAaCSIRQYjyozZh3Kb5n6lNWOjbfB+ZT0AGTtgmmfCiBq9Y2gHlG5dSaWouFwJ
         ty1oUoO7e3CZBFyer9hbDMscWKEmCJPrmgEzdIx8ete5PsjsZWKZ/YpAim1hL5K1CqWP
         BOpPoUgqfOcDcxKz6TrHWeSgUx2C70srbKHgrmq/yzM1YafoA0AuaRG7gBegZ4N1YJD9
         Nd0JYCZ0mgFS62kD88ryP8poPqSiU6yDgP1MZBcpsIxIds+pR5OGtZxySTXK8bPm4bG4
         ul4Q==
X-Gm-Message-State: APjAAAUGLHEjY0NfpUg1zx2kYEYM9cnTrw7ZT7Xw9CZmKfIXh65kLBX3
        sq3b9wIyJ4AOmiv+ybRSGJ8=
X-Google-Smtp-Source: APXvYqwIuLux3wrHGvsAD+Isi95lNtBmZbRI5cerr+59VLJX5ktxw2119ZCyzvmywujgxT14AESH5Q==
X-Received: by 2002:ac2:42c7:: with SMTP id n7mr19789898lfl.138.1571174222322;
        Tue, 15 Oct 2019 14:17:02 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/17] clk: tegra: cclk: Add helpers for handling PLLX rate changes
Date:   Wed, 16 Oct 2019 00:16:04 +0300
Message-Id: <20191015211618.20758-4-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
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
index 9b41365c4331..cacb00796c99 100644
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
@@ -126,6 +132,34 @@ struct clk *tegra_clk_register_super_cclk(const char *name,
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

