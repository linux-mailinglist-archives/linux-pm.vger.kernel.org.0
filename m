Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC473D8190
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbfJOVRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34318 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbfJOVRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:17:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so15643833lfm.1;
        Tue, 15 Oct 2019 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnvZcm6xKDLd2C8gFoE+9zB1+dwZoNg7mIGeQbYm6u0=;
        b=D85K7PhdLPqxNEUhLax7YsT7qjzoM7IXAXBY9gYaree5AWKMWPJDDJetx0pMZ4vLJF
         gVE7M7w+W7d2Yub0zgLTOlDOPWQ+qMH+GSYErdrxQeuUz7ztK4POTowKj2dpxw8qjND8
         vG3MQB3qBLwI1EszmxK4cfKbJaZq1oSybhupjhWMeWrXvWzkoAjf6F/SVQWqffQ/DLQk
         wDSBer2dMfaukYTPMP7QzI+07F7XZP8gGujyQqIsE6/RmG6rBcoplEvIi/5GZFYwzXHv
         w7jB6JYEv2CkVR9crfA7o2J80YRJko8VS+hCmzK/AFxbFxchR5fjdQgIOccctGxI0zdt
         /qRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnvZcm6xKDLd2C8gFoE+9zB1+dwZoNg7mIGeQbYm6u0=;
        b=kqnJ0fbRZX4yQDcGRgKYKDIs9ceuSRBtuDSTRXz2oyviaoMqYfL4RK4W0yt+mMo0Z5
         d0hbE0NHOj9VyqJRvi0XBRuASI8sFPoFLIL6TIJ4eNicFZROq7wmKIJNeAZJCMhduit2
         RcHUYm1n/CnAewSUNQhpgkJYno8TXdJs8FMLsQBkZlHIDV6qiFJblULqH5PxBvTy/H7e
         5V271d9qrIBpz6gTfqp9Uf+uAFBut34amMJ+AlOobfalMc72b5RVVrmpQR2dvXdPp/N7
         fvfjJPkSfo1YpmbLDyrAx+t1/gfQ0084Gw4FyeRop0pkvs5V1dWMKEwJ0leG5lqu5YxN
         e5mg==
X-Gm-Message-State: APjAAAXdqDh/efRs8Fji2ClPVPsjiMdnSGCBFCzOFPjmTvhvaR3njJaD
        MdvBSAzO0vUUwud0LKx0MoI=
X-Google-Smtp-Source: APXvYqy0Ace10Ic5tNpo6f6zuJKqS9wls7GZUYcZIfGNOWpp4uqzIH7zy+5OC5bfwOLye4iiqg6RWA==
X-Received: by 2002:ac2:5219:: with SMTP id a25mr22871387lfl.62.1571174223499;
        Tue, 15 Oct 2019 14:17:03 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t16sm5269186ljj.29.2019.10.15.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:17:02 -0700 (PDT)
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
Subject: [PATCH v1 04/17] clk: tegra20: Support custom CCLK implementation
Date:   Wed, 16 Oct 2019 00:16:05 +0300
Message-Id: <20191015211618.20758-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015211618.20758-1-digetx@gmail.com>
References: <20191015211618.20758-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to switch to the generic cpufreq-dt driver on Tegra20 and
thus CCLK intermediate re-parenting will be performed by the clock driver.
There is now special CCLK implementation that supports all CCLK quirks,
this patch makes Tegra20 SoCs to use that implementation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index cceefbd67a3b..bb3d84182b78 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -391,6 +391,8 @@ static struct tegra_clk_pll_params pll_x_params = {
 	.lock_delay = 300,
 	.freq_table = pll_x_freq_table,
 	.flags = TEGRA_PLL_HAS_CPCON | TEGRA_PLL_HAS_LOCK_ENABLE,
+	.pre_rate_change = tegra_cclk_pre_pllx_rate_change,
+	.post_rate_change = tegra_cclk_post_pllx_rate_change,
 };
 
 static struct tegra_clk_pll_params pll_e_params = {
@@ -704,9 +706,9 @@ static void tegra20_super_clk_init(void)
 	struct clk *clk;
 
 	/* CCLK */
-	clk = tegra_clk_register_super_mux("cclk", cclk_parents,
+	clk = tegra_clk_register_super_cclk("cclk", cclk_parents,
 			      ARRAY_SIZE(cclk_parents), CLK_SET_RATE_PARENT,
-			      clk_base + CCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
+			      clk_base + CCLK_BURST_POLICY, 0, NULL);
 	clks[TEGRA20_CLK_CCLK] = clk;
 
 	/* SCLK */
-- 
2.23.0

