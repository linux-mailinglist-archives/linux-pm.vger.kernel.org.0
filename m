Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361C518BFE6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 20:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCSTER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 15:04:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42292 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgCSTEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 15:04:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id t21so2554245lfe.9;
        Thu, 19 Mar 2020 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYtwxh3M0WCDakQMYK6DovCpFCADDGOR6efWhY9EA5A=;
        b=lr3jIRYyhBT4KmYsOY3VhhCZZB2LkOgGOGd5DeAjpZ9V+xz6sClDAXin4nBvsXqCmu
         wHBBexrwWsfCchcXviHX0il3ngcfyRyVSV8MhcH5b/0rMTj49tFssKtcfvIwTGlulB0c
         xx7B6akVM4AvVJ04tz0OH8cPB0RnDdwpRU7hHLWbwEMLcuKspBmGfRLhOb590E7kt5PW
         jg3sC7qg9F7OKhFIEAoqZNl7dfwm+7nVyQ6bC+gg5TF9xLKNx5/o1oVrosfGJWQsZf1O
         4vgastk/Z/Tms/TcYdUcEbh6A0vywfsj9YCzHbkI34tXYgdYmp4T81F0HqH4PPqqtAzI
         wEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYtwxh3M0WCDakQMYK6DovCpFCADDGOR6efWhY9EA5A=;
        b=g73DsK8PqBRlEXti8OAg3cL1DDjLVqTEGuaG0MuLQQWi5oe+mXLdLk/lZbxaGnsmti
         XlEpkVrO+mFVtRO2/G0d6WYy347xBx0s0r+BoHm4eqoECezf5vwOOiyUoeSFDx1Dky+W
         WEk48Yf6SKF7GczHqlY3sf2Uq9H3A7QqPZeegYmoXFw3Adh0AhmQpDYtv0cWIYSkr/zW
         0bsIcI0uyZ6XLTAUsHeXKGfiurI8PC0Zkm5ydGzd+PpYRgpcapM0+ciEHQfucoJba1Nn
         6UHiBQuii3tJ2xCiJ5RvoIc4jQ/fxv/CkJAWg64WTBXKrI2sc3dyrhFBndvsU5OYV+Fg
         I7Sg==
X-Gm-Message-State: ANhLgQ3NfpoD9vKAmjv/pj3j1EVlDAy+VmSxrQd587Iyb3c0AFQpOBnQ
        +fVppYALLTkoYV8KISEbvxaKwxj4
X-Google-Smtp-Source: ADFU+vtBwRJ6EJ+7CZAsKbNUCuVjCzTZlGUgAHK4g8oqA0XRRkDZZTh7ycJg+SYDnFURJnBa4V+XfQ==
X-Received: by 2002:a19:4a12:: with SMTP id x18mr2953940lfa.161.1584644651906;
        Thu, 19 Mar 2020 12:04:11 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id k14sm2025380lfg.96.2020.03.19.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:04:11 -0700 (PDT)
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
Subject: [PATCH v8 04/12] clk: tegra20: Use custom CCLK implementation
Date:   Thu, 19 Mar 2020 22:02:21 +0300
Message-Id: <20200319190229.32200-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319190229.32200-1-digetx@gmail.com>
References: <20200319190229.32200-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to use the generic cpufreq-dt driver on Tegra20 and thus CCLK
intermediate re-parenting will be performed by the clock driver. There is
now special CCLK implementation that supports all CCLK quirks, this patch
makes Tegra20 SoCs to use that implementation.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 085feb04e913..3efc651b42e3 100644
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
@@ -702,9 +704,10 @@ static void tegra20_super_clk_init(void)
 	struct clk *clk;
 
 	/* CCLK */
-	clk = tegra_clk_register_super_mux("cclk", cclk_parents,
+	clk = tegra_clk_register_super_cclk("cclk", cclk_parents,
 			      ARRAY_SIZE(cclk_parents), CLK_SET_RATE_PARENT,
-			      clk_base + CCLK_BURST_POLICY, 0, 4, 0, 0, NULL);
+			      clk_base + CCLK_BURST_POLICY, TEGRA20_SUPER_CLK,
+			      NULL);
 	clks[TEGRA20_CLK_CCLK] = clk;
 
 	/* SCLK */
-- 
2.25.1

