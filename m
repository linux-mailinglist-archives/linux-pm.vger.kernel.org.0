Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5865410097B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfKRQqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:46:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40905 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfKRQqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:46:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so19767485ljg.7;
        Mon, 18 Nov 2019 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0gNszD0ptBgrgfqARNo4dCfpARXgUJI1xW2pH1mNqQ=;
        b=AMnRbLdQfenpLVnLwnoKmthFoia/qBJo4V8FZhRcpT1kRligp9K2XHi2QKxXKLRKsh
         dP6Zy1SGzXjQS+CrKneQNd6HheDriZha3AoH605RNMsdHwaNTmYP28x9ocb2DOcJdJcK
         qTU/5ykYzr6p0ww8E4Sdjoi2ffgH7apLuTRViE7YDnVmY91r89NTSPepv/K6I082VUiC
         uhF7KvP1P844SzHRR0VjqHY9nKXL0hUvN8ZZ58yp/jVFdIVebKNWjmnV0sm/FlILwUx7
         Q4VLcGB76ab3WJBk9LZ/hMoRGXnGwjUw4kSvMZ9QeR58qjepubuQkjnMnGktfYgZuaLk
         XQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0gNszD0ptBgrgfqARNo4dCfpARXgUJI1xW2pH1mNqQ=;
        b=R/hztodzXVCSUF41/IIyIgV3iSWn6xFvG5jh7Wl7NTWcYS8dFej5CNRDNPzCnVQdAD
         hhl9uvh6uR3yXZe7oWKHjn28VtpDQprypKpPTg2RGAH0h7HywHWBYkYXlnte8Q3Ny/kp
         cWEb9t+UpMIpmmsuRcVYVyerid3IwfhjbkpLfK3MNcLhITtzIoocQ4JGOAGYMzC8Gg+B
         VhPg8feAGqQdVGztS3F7/5TJJgghm5xuW4VkmNjN6xQoO7nNcyGDa63HAiEaIOTwYafK
         SNPClcOMaGqBCXd3kNSQjcbiTgY0HdUCLPpVphiU3dquKrQiXva1J5a+m8CJcOfFyc6c
         Cdsw==
X-Gm-Message-State: APjAAAVoZ2dXxd18BCbtTs7k+wL6IBOajYAXVhCVgCiollY6y1o2Zz+T
        Jnm71NsXaAL+tLO3Y/EU/Xk=
X-Google-Smtp-Source: APXvYqz/ScRecKieVBX1sp9czjfXmCAdVkefP5wvCaTAy2Vo6vr9IFK29pNFdWsZc+VSNIF6TFRQvQ==
X-Received: by 2002:a2e:2c1a:: with SMTP id s26mr243441ljs.239.1574095607750;
        Mon, 18 Nov 2019 08:46:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d4sm8880307lfi.32.2019.11.18.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:46:47 -0800 (PST)
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
Subject: [PATCH v5 02/11] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Mon, 18 Nov 2019 19:45:03 +0300
Message-Id: <20191118164512.8676-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118164512.8676-1-digetx@gmail.com>
References: <20191118164512.8676-1-digetx@gmail.com>
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

