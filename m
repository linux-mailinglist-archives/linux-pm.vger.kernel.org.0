Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F015B52A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgBLXqi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:46:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40437 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:46:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so4416279ljo.7;
        Wed, 12 Feb 2020 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vsbqTcsPyW7zXr+f9YIopAxvpsx05GcKaLZaiIxhNY=;
        b=SlyAu0hYm0T01pumhDVu9+DQtPnOXBztlyGQqZCqi7EDWDKpJf3iUBK0TOgpebMWrc
         euQsx6gyLszzo/AlujdMxysnEkOoB7+TVtLzhmkSfQlB1UBZ9+3YUz0uQOzW/ESWk5J6
         T7FP5jwwokxPxVsjui+cpmH1YB8dVq5wB17jnOQdi2i3pIwo+twX6lVaDSx2xSHGCoC4
         FW7srSfDvCCWbYdg8yRY/q/r8GUPay9iaYrE0s4Yn5ZCWkmrRLKQ94VsIukewKbTUj3w
         lZ2mZ9c4Uv/O4Jl9PXmsfSJdpS7+6huysl5rQdOUtnY9iLJ3jADFMwigWERYChYtLe2C
         a44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vsbqTcsPyW7zXr+f9YIopAxvpsx05GcKaLZaiIxhNY=;
        b=YwjpDQ03amxW4oK4P6zLHKLbW8F1C+tADANjnCZav3Ra0NcCrvr2l2cLV13ttFhBqv
         ERGJEBSjKHEMZG4Ghdl4WVhqc5fAlElLb1RpbYkR54qPFe4piSQpdBczD1+6AlNr8gej
         kR+IBPcFMPedo67TjJIMHjTkqUwHtYkrzUBncoTj14hDihHWvq3KeKSPMsmAWp2a8yTs
         0yrWkf5jCdTtp3CdxIPGEozhxcJS8lFkTxs90GmbP0BIoVMWir15GQyvAih7JLU+hIZN
         SbEpxlrtoq3UqDptgWLdbv9uqRB/Ybk9yqRT06e8p8dBRJUP3I6WT+R9n0cBfzppt5p4
         7tSg==
X-Gm-Message-State: APjAAAWyMUeFN7oHA8ZW/GiPZ6vxYoc+H7Z6mRkzZvrpJiR0Y3L5XpCm
        V4bjXWQvhh0pdNQQT3zo3+M=
X-Google-Smtp-Source: APXvYqxeHGA6dJTm+f2ddhlIBD4sce3z/PMqWS0gUaJFELwLmQu3UUdPHbhphRVko1TJpRmjwc7rDQ==
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr8992845lju.117.1581551194026;
        Wed, 12 Feb 2020 15:46:34 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id u15sm234453lfl.87.2020.02.12.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:46:33 -0800 (PST)
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
Subject: [PATCH v7 04/12] clk: tegra20: Use custom CCLK implementation
Date:   Thu, 13 Feb 2020 02:45:59 +0300
Message-Id: <20200212234607.11521-5-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212234607.11521-1-digetx@gmail.com>
References: <20200212234607.11521-1-digetx@gmail.com>
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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index fff5cba87637..abc6a2bc828a 100644
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
@@ -704,9 +706,10 @@ static void tegra20_super_clk_init(void)
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
2.24.0

