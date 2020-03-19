Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8012518BFDE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCSTEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38170 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgCSTEM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id n13so2575483lfh.5;
        Thu, 19 Mar 2020 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AlGN/9KxfqGP1gha8cnpAV1qjiffCVac50q6n9Lx2fc=;
        b=hdZiJC4z0SdQqSyWftZwUgVtGcjthk7l45qSR1wQTB9u37zfMyrwHIx5GlsSx57aLs
         0/RU9gjAKCJipg32LTOoe7jX1MYQ3m0KR7IHp5sz8cwbI7TMsSeHDHDkGVVnAqiJD6nO
         mfEJILqQ4G2BpCOnwLEIXbzYjl2FeVGpkwmPSnkQNRxUybXap2Si5WpBgIxXwoBIeAUA
         iJaa8SzoCu4wY4Ak2F5kL/8yaRo1G+v7BcW0rdcRKEmkNGcfRjqxLo0Zr+zkeGU3LvlP
         wx3Rw9lbhv+fTstB2uF8xRam24n5N9AaQNCDAz9oK91qo4QvyFgU5msjGp+BwBtV1PSV
         YhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AlGN/9KxfqGP1gha8cnpAV1qjiffCVac50q6n9Lx2fc=;
        b=P6t3ooIo2HN3hIP+l5RTr65n3M/cEdMOOdlHNBe5XKPh/XlbHEHUkLYFFPZ5VdgGNY
         iEAtGOsHSlzzkD/uwMOdfwhqPGTjCAtSwZvE4JezV2t/ODAYNN6XRMGgrUSszkVeXfEd
         OCAjPpQAyBIRyldTcgZp53tz2f8/3Zr1bOQdTCU6JUx/UtsSJqbcTPedTxo3o4Stcwi6
         f5oVG8eiRaWQTTpnZgKwm0PxCIO8ycfxbVUVq4UtNZCNMLOdjhiRPtQ188e4pOALEIxR
         uu2nuEI8e9PiFuv7R+0OwBO9eV8QjtiIvisFVUtNywg2f20BykuGyoXJz8gbLMWdqS9E
         37rw==
X-Gm-Message-State: ANhLgQ0wuS+iJYT5KzCLtbuXtU+BuCq2AYHey4b8114YFMzrz8TkG3XM
        w2grvQX2RGdui9EkpdS3ZYg=
X-Google-Smtp-Source: ADFU+vt1ZXbG+Xg7AuEkHJu+k3N6+eh1nkUz9bxUj9O/sc9v+WC6JGwJKZXoUTupdzN3gYl+JvVjtQ==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr3009914lfi.19.1584644649164;
        Thu, 19 Mar 2020 12:04:09 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:08 -0700 (PDT)
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
Subject: [PATCH v8 02/12] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Thu, 19 Mar 2020 22:02:19 +0300
Message-Id: <20200319190229.32200-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
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
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
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
index 412d4b47ecfd..e67c19eadb19 100644
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
2.25.1

