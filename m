Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C614915B528
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgBLXqf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43400 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXqe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so4415647ljm.10;
        Wed, 12 Feb 2020 15:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3LGfCdeQzU8y6RcjHLOzc6mRQN8kt3++oI0IAl5DEA=;
        b=gdgui55y/mzCpuABmTSECaxVGZCS/Ry59fPpo5gc3iXc4MItPuzmJ6e7l3PSS0zN63
         Rv70sxOVUVbFtNPi+yO/jhOXZ3TGDIUqvgKt9KUKDguujDXPycvNpT/XTvxOiZjaP2y5
         J3AqDPyu6r3LJjT409xgK/B/Ffl197IFUUjeMxod1sgi2O+qv/xCwycHFs9+dUi1YGmb
         lyGvk2iACbJQULwqNqaGbo3eNAXlAgRIJwaH4SEHDZgYrw2Pryx3nLv7zN+xwxYGQy93
         xoksDbGsZSW3oVlHqU8pm+nrrtIviYnAhpAg2k0/2kV4wSgnQiw9nhEgfiBNS+PPBImV
         K+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3LGfCdeQzU8y6RcjHLOzc6mRQN8kt3++oI0IAl5DEA=;
        b=itGQvqqYlwyPNWSIyEoHV3CMDMWcszqufvgUdR9Zz6p9oWlrMupHyThEIZBthMxZz6
         0Bbs5WMZsUPxmlNjajVIxUGr7CxnJE825ipFGeIh6rrnpY5QCICqxu9Vz6aHj88sWtOi
         T4dKYehNo8AwyMWIe5Psn2TrhqFhF3+w+YFFaf76k+LbITR7QJsvJ0uTQFRm5ksPnDTP
         XfQbgrDwIvdzGNo244zXmJdj3e40LyLwSN940WH01z1w2VS3BTJEpw4hVaBR8F9+4MA9
         +aXp4tfNv+WwgRLTRVbHg/dltPs/i6GHnw577tad/zRJNPc9z4GjtGz39H8DglGjFrXs
         +ymg==
X-Gm-Message-State: APjAAAV52J3Kyv1idpZaDVARRWvr9G4D7pH5zrcESj7BeYnBUbml6yuO
        pLY6t+NCXCWQS8hMfGup3SM=
X-Google-Smtp-Source: APXvYqymM4rtJj9oCW+XjmAVdHkZXe/KOV/sVe3NJqg6FidgyPAaJW3+93NUUdVz5Z3+gSl0xN+fxw==
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr9272533ljc.84.1581551191583;
        Wed, 12 Feb 2020 15:46:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:31 -0800 (PST)
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
Subject: [PATCH v7 02/12] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Thu, 13 Feb 2020 02:45:57 +0300
Message-Id: <20200212234607.11521-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a need to temporarily re-parent CCLK away from PLLX if PLLX's
rate is about to change. The newly introduced PLL pre/post rate-change
hooks allow to handle such case.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
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

