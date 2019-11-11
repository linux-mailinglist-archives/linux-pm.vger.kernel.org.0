Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87EFF81A5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKKU5N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46358 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfKKU5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id o65so7271367lff.13;
        Mon, 11 Nov 2019 12:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0gNszD0ptBgrgfqARNo4dCfpARXgUJI1xW2pH1mNqQ=;
        b=ePuXH4N1diUNfpdEHjC9xzRvSYlc1Z2ire9MqkX4ns2BE2JVkJTu5JWE6LFVtNjQZ+
         Oe5balXFPDLkGxD62J0RPKxuqHFURPpCvSnoMI27YBKIOOMGKkTBR+CuD3kcK9vgp3Vd
         inUP8Y2tXOP7ejLmvaC4Vf+aSNX459QAvlWts7UEY2lS0eWFv++8+EQN9jjfQF1/yllF
         zZMFovb+jCS3nUcpXAotQ6BusRdzxDR/yCx4oqGxlOdL11Lru723/S2rWv3e63SxorkE
         7g+Bzy591ZIjYbHXpWLPDSaCWsjgQXaOm8s0/ubsUYD6JiU/PAOgSRn0xBPeXPI+lHmq
         MoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0gNszD0ptBgrgfqARNo4dCfpARXgUJI1xW2pH1mNqQ=;
        b=rv+/V3OC20T2OWohMEZ4ZhiIRe3z3AJEzrCmIHkHOBjuD80J6TiO9DUxi80A0xGLKu
         0RdpCGIBWP0IRlIwwPFG65GgbB6JPfyEjUBjwmQaXWYlv5hpKHrcI9STyCNgP1pdFbVE
         SpolOMTBFU7cD7OjPXWZtrevUSz/BDjA5GYNsBSp6xFfALhmQGANm/78WaTlCOvJ39uH
         T/rpsnc2YGbyIRHzRo1fEjvfkjT1RQCqA8Jp4Nh7mnHMwxv7XFtAgTs4Ae7rmlBrujQl
         TR9cKYU3vMuj2UotqVVlxDxvxTn2IwbF9bKW2SLeOib1jM/nWYnePMlBmfkuc+7MU9vN
         7fwg==
X-Gm-Message-State: APjAAAVd0fLl8ABo2uyo8ZcDzEpm5YpTG2QqxOL3x0R53yU4soa639vx
        2bX6Cz2230XJeXKH5EEfUTM=
X-Google-Smtp-Source: APXvYqzEsLhupYbrzzQr5Cy19ftT2seWidKiJlHrMOknEraImZcfvcmPrtB6SJXzm0t+AwCTUfkAdg==
X-Received: by 2002:ac2:5097:: with SMTP id f23mr16777817lfm.90.1573505828934;
        Mon, 11 Nov 2019 12:57:08 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:08 -0800 (PST)
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
Subject: [PATCH v4 02/10] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Mon, 11 Nov 2019 23:54:11 +0300
Message-Id: <20191111205419.16768-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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

