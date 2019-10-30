Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6FEA595
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJ3Vf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 17:35:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45945 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfJ3Vf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 17:35:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so2745746lfa.12;
        Wed, 30 Oct 2019 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0gNszD0ptBgrgfqARNo4dCfpARXgUJI1xW2pH1mNqQ=;
        b=K+JGjMrpWis7LiqdTjrEDc0Vb4vkrIiJgpGzq8V5anTW1SLs0nOIZjQ3YiS4tFagQK
         ZCim6N7Ja6vb12irMLpYvntQgob7oxH5jqyn5ApvTfymoP/pBmpCBWk+tGUlq+ibe3UE
         Li17jzu4JYWaHyNoKxKB7BKnzLrO6405nNSySFiFdKrgtt460RiytltlawXyEMp1zImP
         oFHjT/MgRAlHTLAeFNN3utd2ZFoIzO2N1FMnwg4M65zM3Qq9EA5+jq3wb3eRYxsC5fbn
         IGeVyo2IEWBXFl9N/gCIDBJvx79LqQEigQxEftaMRtLFJDOEiPIf88LuPS2NTOXLwD+t
         3G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0gNszD0ptBgrgfqARNo4dCfpARXgUJI1xW2pH1mNqQ=;
        b=Tf49f7CfnhachPDmRXyz+VqEQWXSqwOdsUINWp2avUWIYJeBF8RZX6S9DIyuANunHX
         Wnw5WHfQ2tK1Q9LcMvqVRfs2oGYRdfCwq87IR3lvARgInaOp+/G558lBiWxttE+OL/Za
         RTTCCLWPZKLLqmPBDR7Sc+Igg6oGsMwg96KtBAC/LmPpTti1BPg4ae1ZkesRVo3O1KS9
         TEI5ln+Cc/Z+ksRv4Atp3SPFykh4+BeYV4/vPGtmH4xaX4XGccMu0yj2zURTE1OMshln
         17qTbtjVWPIPp7bjwi0uGTVubwpnu7Ncgo08lBZAjzi3HHUyORkr/bxfkiV6GwcAaNMn
         /H/g==
X-Gm-Message-State: APjAAAVfv/4V6UesHMSsS0a1rpvGw5xODRqTl5p35SpvN820mdK+HdTH
        x28FSNeoJ1ywg3JeiRtmJ7M=
X-Google-Smtp-Source: APXvYqwVLX27k1uSJPoQEJ8Tj9MGUe4CF2sJMA6bvZGQkGnOTDBhEMEHYJmOmqcP5bpWKXn+APqsfg==
X-Received: by 2002:ac2:5deb:: with SMTP id z11mr252892lfq.35.1572471325864;
        Wed, 30 Oct 2019 14:35:25 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id c24sm553812lfm.20.2019.10.30.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:35:25 -0700 (PDT)
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
Subject: [PATCH v3 02/10] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Thu, 31 Oct 2019 00:33:52 +0300
Message-Id: <20191030213400.29434-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030213400.29434-1-digetx@gmail.com>
References: <20191030213400.29434-1-digetx@gmail.com>
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
2.23.0

