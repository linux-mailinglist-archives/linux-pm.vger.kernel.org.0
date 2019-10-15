Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4766D81E6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbfJOVRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46851 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfJOVRD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so15573295lfc.13;
        Tue, 15 Oct 2019 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQVJNNL4da8n9Sk1LwVlO9zFiqg3NWuXdGvnGpoii4k=;
        b=SXK5ANJLVW5cpayGedfPSqHzoyqVOtsdkU3olawUMjKC2/C7E6/v64kosYtwwTIA6V
         m5lm/Se1DICYyOU4y1dWPCUKutLE5UIG1DKxs1JgJhpb2v2x8N0lIzh9SrlO2gFSB70x
         Qq3nwieQjagtTYGaDJ+B44e0Rmp+10dzaGQL2ouV/dYnYLwr0Nln1zNI976noF0QoESL
         rnmSXOGoZLf3YM+JGYWobfWDTODjdhLDeu66N3dpdzxRadRHAjXWnUlveOQSy7bViTti
         YnPtq5HdFpBA/YOedf8sPBCzrbUwSdqQ1agfHdhSHlrBm7hT0Sz9KHRV2xM+FDNaqCHr
         v8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQVJNNL4da8n9Sk1LwVlO9zFiqg3NWuXdGvnGpoii4k=;
        b=boKxwV9QIz0etLx9zNhQD9AJfbrYAhgy/DGWS008NtQD/QeElcqsAcrEX+GPtDLFi1
         doav+OvVbiY07MFIfqZb4fl3DvN52dYOEr7u7q+JW6xiuDSq81UqtpD7V7swO3YNR3zN
         VyHvuks4N53t5qBIXiY5jGnMtYUTjMVwi8uBjQ4nhXnOpZcTnRE0ULvOCmrgC32kDbKs
         h7HxuMsQo879XuWv4KdjlDv20BbA68vioYPXlDE7RbFFGCcp0rtxVrBx3zbPNVx+F4Xf
         C/dpxLF1jiMzSRmnr9vNMfdIjWpaTaIlJusKYvJwoYjGJtPOYBYpbVdXMMTf0jaFVwBi
         lpIw==
X-Gm-Message-State: APjAAAXMQGybkf/6LtOji5BYxmHz6ZdYb6EKyTj8PfYp5YJahRX701Fb
        /wp0F112e+lQhV6XaR7JqpI=
X-Google-Smtp-Source: APXvYqwchGHbj0b+BFm75H+RmluBV+S+AIwAee/jeZut/R/NIu0eBKF6uaAnkENiXQ6Y8JqcAhXGZA==
X-Received: by 2002:a19:ae18:: with SMTP id f24mr214962lfc.186.1571174221245;
        Tue, 15 Oct 2019 14:17:01 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:00 -0700 (PDT)
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
Subject: [PATCH v1 02/17] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Wed, 16 Oct 2019 00:16:03 +0300
Message-Id: <20191015211618.20758-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a need to temporarily re-parent CCLK away from PLLX if PLLX's
rate is about to change. The newly introduced PLL pre/post rate-change
hooks allow to handle such case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-pll.c | 12 +++++++++++-
 drivers/clk/tegra/clk.h     |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 1583f5fc992f..859340ad3515 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -744,13 +744,19 @@ static int _program_pll(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
 
 	state = clk_pll_is_enabled(hw);
 
+	if (state && pll->params->pre_rate_change) {
+		ret = pll->params->pre_rate_change();
+		if (WARN_ON(ret))
+			return ret;
+	}
+
 	_get_pll_mnp(pll, &old_cfg);
 
 	if (state && pll->params->defaults_set && pll->params->dyn_ramp &&
 			(cfg->m == old_cfg.m) && (cfg->p == old_cfg.p)) {
 		ret = pll->params->dyn_ramp(pll, cfg);
 		if (!ret)
-			return 0;
+			goto done;
 	}
 
 	if (state) {
@@ -772,6 +778,10 @@ static int _program_pll(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
 		pll_clk_start_ss(pll);
 	}
 
+done:
+	if (state && pll->params->post_rate_change)
+		pll->params->post_rate_change();
+
 	return ret;
 }
 
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 095595a5b8a8..2be38aa2c204 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -211,6 +211,10 @@ struct tegra_clk_pll;
  *				disabled.
  * @dyn_ramp:			Callback which can be used to define a custom
  *				dynamic ramp function for a given PLL.
+ * @pre_rate_change:		Callback which is invoked just before changing
+ *				PLL's rate.
+ * @post_rate_change:		Callback which is invoked right after changing
+ *				PLL's rate.
  *
  * Flags:
  * TEGRA_PLL_USE_LOCK - This flag indicated to use lock bits for
@@ -287,6 +291,8 @@ struct tegra_clk_pll_params {
 	void	(*set_defaults)(struct tegra_clk_pll *pll);
 	int	(*dyn_ramp)(struct tegra_clk_pll *pll,
 			struct tegra_clk_pll_freq_table *cfg);
+	int	(*pre_rate_change)(void);
+	void	(*post_rate_change)(void);
 };
 
 #define TEGRA_PLL_USE_LOCK BIT(0)
-- 
2.23.0

