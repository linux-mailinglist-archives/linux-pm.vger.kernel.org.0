Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D56125352
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 21:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLRUWD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 15:22:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35714 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLRUWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 15:22:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so2659358lfr.2;
        Wed, 18 Dec 2019 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iX2kRwtJGZa5DimaLjPu5czm6QHLMvmyQt7c8wHvrWE=;
        b=GfrU/U9dPVZzvNwO2xBD+gfegB//ASxzS91iPz5GgqDLhCPhBCmyCzIcnCjW8B67PQ
         RkoeozJYPE+zZhD++4eWi4T53MLLzjkZ+ZUVWsdbygoeD1hrk2udzIW+l7RFQKFnsQIn
         5uzqrD+vunswAkVkuAmf1oa9o/k1/O2LQIngoRITw4o2STizloawhh2aB5MoHVZhGu5i
         8xg60tdhBN2e2cHIZ6fcQTNiyDyYKW1B/DTwhOiVpLPyAQlUOmsBpBDLBKAymrRyGuZ5
         O4Y2ArPplqyhGqpd1zIQbyOokU1wooG2u9ihnn05khMT1hkSdyYwTOZjH/5ln6fACUzx
         v7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iX2kRwtJGZa5DimaLjPu5czm6QHLMvmyQt7c8wHvrWE=;
        b=X/X5IGr/13f63S4I8QVa5nab9Ald4BIjOgp7GWuKlJcVFbxqTUfKQ6t2aMPb76515+
         5D3s4ODMtVBIYkFwf9l5OrDqlHICtrqN8xMj1rAfP0jrU7EfeLQ2+7WN61aBU7/8Shb1
         m6NEjzPovX99wewTsclS7qoPC/1rsH91jSsPVVpISlUVsUOpxJGKbGg9eaUb1qnu5tpy
         sqQba0hBkR+Dl4tZPVAJLfkL/SiDD4YiT5vSr1PZppafdkg35FmUH6rBUojxrqRLYCnD
         Wm/ChNAxUR9dwi7gyCyba9KFQ/Z6LZ+AQNJ7v5PUDX7qn1MrpGCrPONaxkZAj4+vSbjB
         lrSw==
X-Gm-Message-State: APjAAAUGAScaILghMuKvwdkmpjAuGcdm54QC+cIROkMLoMEUUhfzN7PL
        9pqPmwDpqD5XwORwfox9kZ0=
X-Google-Smtp-Source: APXvYqz05YVya38CeJOEAWsYmfAyaPnBWbuOwbOAWLyvHuIWZYjLrkprTsJcPZ5sSuDfSVremoFfPQ==
X-Received: by 2002:a19:784:: with SMTP id 126mr2905428lfh.191.1576700519561;
        Wed, 18 Dec 2019 12:21:59 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:21:59 -0800 (PST)
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
Subject: [PATCH v6 02/12] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Wed, 18 Dec 2019 23:21:32 +0300
Message-Id: <20191218202142.11717-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
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
index 531c2b3d814e..0b212cf2e794 100644
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
index ee35a847df08..fa18bef914af 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -266,6 +266,10 @@ struct tegra_clk_pll;
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
@@ -342,6 +346,8 @@ struct tegra_clk_pll_params {
 	void	(*set_defaults)(struct tegra_clk_pll *pll);
 	int	(*dyn_ramp)(struct tegra_clk_pll *pll,
 			struct tegra_clk_pll_freq_table *cfg);
+	int	(*pre_rate_change)(void);
+	void	(*post_rate_change)(void);
 };
 
 #define TEGRA_PLL_USE_LOCK BIT(0)
-- 
2.24.0

