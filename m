Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBEF81B3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 21:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKKU5Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 15:57:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37999 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKKU5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 15:57:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so10976142lfa.5;
        Mon, 11 Nov 2019 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbLJtKoWfGlhZ2yYzvSNqEKgjc0Cow8QnHrPe+s4dKk=;
        b=QU7GT4Gn4qhqAjo+x7iJ2aVKPQoxU2QNQTAbTOzCbEaWc8mvrRV5YLJ537xB7tCBjI
         5OgNdEUqKVEZYOuXglKODAY4Nn/smNHy7u2yoiO37Ua9pKo3dXXgDoMTRYL9RM4ETCqt
         CI1ehLDJjGpUy4tAiKq9WlC/YdePFA02h4n9j3bTvGJGyJR0HWXlWMylIrklLwfBN8Ef
         1Le3Qz50U1i64dor4sGIAcdpNbUbM7LZzAlJwaRhI3n/luzmBqc391ovuLSMqOMtmWEI
         HGi+UmBz/rdyJEKJXmLw0E4UJjW8KLMpC+gKayxvIn41SUYrTMEoA2Uhy7aeHtvEaO2U
         ylyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbLJtKoWfGlhZ2yYzvSNqEKgjc0Cow8QnHrPe+s4dKk=;
        b=ZI2VUyj7niqFksiaiwsPP/BcW6a5YLAyDwL8StUif10Yy/Rz44lghfjtGMzKJLBHf7
         M19RCGiDOsbV39OI4v5YigTK5nn3C6bGoP7M/syyLHsu+FeVHwMV32ta6dh25cDiAALI
         zezYTAdbyIjDE3/SxcUnJpcP+WOuH9nUan4GmVJsM9KHa9JeK/0HR07RE3U9O0oOT0DH
         BYbG3Iyzgd/cvRkmTZmOHPsa8Quy3cW2qhSCyyOjO7lunlG+7X4zuYyzH/kyJAC9TWW7
         j1Dr0x/PiZGQtaIgKCXFXcoz1T/GraTfhiLzREvdco+WeFrUPORTF5Bdrh3883VTqggs
         o38Q==
X-Gm-Message-State: APjAAAXjIyrT5sfQt4xz8sqwwYiyWnGqOxU3MjDuyBuQ4EV9TUHZb/XW
        1iDuDcGmVvr40IF15SmshyQ=
X-Google-Smtp-Source: APXvYqzZeL6DOiXbgybhMH87aKuaIctavA3yanUheLeZSqDTvQPBpkJpcdJM8kBBvfGaJyzqDjLalg==
X-Received: by 2002:a19:911c:: with SMTP id t28mr16229971lfd.84.1573505831297;
        Mon, 11 Nov 2019 12:57:11 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id q124sm7423784ljq.93.2019.11.11.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 12:57:10 -0800 (PST)
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
Subject: [PATCH v4 04/10] clk: tegra20: Use custom CCLK implementation
Date:   Mon, 11 Nov 2019 23:54:13 +0300
Message-Id: <20191111205419.16768-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111205419.16768-1-digetx@gmail.com>
References: <20191111205419.16768-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 4d8222f5c638..eb821666ca61 100644
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
2.23.0

