Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD18E3F3C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfJXWRl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 18:17:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41310 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfJXWRj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 18:17:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id x4so14117799lfn.8;
        Thu, 24 Oct 2019 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQVJNNL4da8n9Sk1LwVlO9zFiqg3NWuXdGvnGpoii4k=;
        b=VWOzSqhDCNBNpiV8E6naLYSmkUYhTUXqPf5M6+X0u/pmVhf+oFx0s5cJwcVnB99axy
         EDR/omZwgTfrsGWUHiEDvt5KrpHRJCwzu/cKryQWQm89xNhHzHjtEolsZyOvHE3szRRp
         DBSpufnIff6u33qh5Rw4GcX8dNWNsOIByJPPT+TsfvnXmxoKljCGJxgEF9183HbZPVL+
         d2XHhytMyAiU2ff1aRbS7uXmGh5ozrDI3APnwyOldZ0eGcpuqjKbI0oCi9wb52M4Fx0Z
         AnRJmfY/PcNaUJUPCTl3jtz/UtGduEntKuwhsMOSHIEAPW3U442PmNI5PBJVvyfGtf2w
         VZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQVJNNL4da8n9Sk1LwVlO9zFiqg3NWuXdGvnGpoii4k=;
        b=ZOmVt3sZ5YfKs73eQCL+bI9DgQCQY450cEd5KchAay0IOXxGTd5sHiK+N7nV3GFCWm
         z24W4975s0kd8fQT8L/PgmNdAnlQ03/k5CkO+ojRZY1QOt67ux6BgbcJ6FTiKLg6hE3Y
         m0amOkCTSdxykcXbn2Yy1S8uF+AqLC/YOxk4WXxm5DxVdTcQLaWvD26tAISM5+VcB3al
         ewu+XuI5xlkVAMyo5ATIUD3nnj1QGE6RHib7aiGyYUiT5mS/wMvhYc3ebfQmlKRRgUei
         mE4luwFBoYl00TYpBpga7CxlvIaIPnDOhsTYJ0cNqpDx1UsJQNpTHkrJyUCD/hYqebg3
         hHOQ==
X-Gm-Message-State: APjAAAUUJqT9It7Y3B3e1XwVhi3Weg4vR71R59whKAswYPtQYzKQrWXJ
        zrFxOi9lzHYwo2ecPPa1cNI=
X-Google-Smtp-Source: APXvYqxrY702Ciuq4uM8C1Q7gjzvZXcB0zz9gCPlVN4hNBkVeFIIGwd0FbWi6VvocKPpLOn/alAPYA==
X-Received: by 2002:a19:1ce:: with SMTP id 197mr322126lfb.16.1571955456954;
        Thu, 24 Oct 2019 15:17:36 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id i6sm11338765lfo.83.2019.10.24.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:17:35 -0700 (PDT)
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
Subject: [PATCH v2 02/17] clk: tegra: pll: Add pre/post rate-change hooks
Date:   Fri, 25 Oct 2019 01:14:01 +0300
Message-Id: <20191024221416.14197-3-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024221416.14197-1-digetx@gmail.com>
References: <20191024221416.14197-1-digetx@gmail.com>
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

