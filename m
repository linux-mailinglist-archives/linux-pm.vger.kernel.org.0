Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC224E8C9
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHVQcl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 12:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgHVQcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 22 Aug 2020 12:32:39 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24B320825;
        Sat, 22 Aug 2020 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598113958;
        bh=Kk7CchBwLo3PT20ELNk1JwWtLQAZK0S0jQjYYyeYDYw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IQuez17ANPldlgQInfKi1WDt9Up7obsqXy5A5967wALzh9d+Ojc6IM9gZmaUfjdx6
         0mjwNBskyaiqStwkC2l5nu0pJeJdT4W9M4tUfBWfao6yLGA9M5aSbGbCB2izekq7Ok
         ShbpIIwUtUVcxrE0zdmCMN0lK5JyZ1CUF89K75XI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] memory: samsung: exynos5422-dmc: remove unused exynos5_dmc members
Date:   Sat, 22 Aug 2020 18:32:17 +0200
Message-Id: <20200822163218.21857-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822163218.21857-1-krzk@kernel.org>
References: <20200822163218.21857-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The struct exynos5_dmc members bypass_rate, mx_mspll_ccore_phy,
mout_mx_mspll_ccore_phy and opp_bypass are not actually used.

Apparently there was a plan to store the OPP for the bypass mode in
opp_bypass member, but drivers fails to do it and instead always sets
target voltage during bypass mode.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 31864ce59b25..df02afa8aa90 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -123,9 +123,7 @@ struct exynos5_dmc {
 	struct mutex lock;
 	unsigned long curr_rate;
 	unsigned long curr_volt;
-	unsigned long bypass_rate;
 	struct dmc_opp_table *opp;
-	struct dmc_opp_table opp_bypass;
 	int opp_count;
 	u32 timings_arr_size;
 	u32 *timing_row;
@@ -143,8 +141,6 @@ struct exynos5_dmc {
 	struct clk *mout_bpll;
 	struct clk *mout_mclk_cdrex;
 	struct clk *mout_mx_mspll_ccore;
-	struct clk *mx_mspll_ccore_phy;
-	struct clk *mout_mx_mspll_ccore_phy;
 	struct devfreq_event_dev **counter;
 	int num_counters;
 	u64 last_overflow_ts[2];
@@ -455,9 +451,6 @@ static int exynos5_dmc_align_bypass_voltage(struct exynos5_dmc *dmc,
 					    unsigned long target_volt)
 {
 	int ret = 0;
-	unsigned long bypass_volt = dmc->opp_bypass.volt_uv;
-
-	target_volt = max(bypass_volt, target_volt);
 
 	if (dmc->curr_volt >= target_volt)
 		return 0;
@@ -1268,8 +1261,6 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
 
 	clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
 
-	dmc->bypass_rate = clk_get_rate(dmc->mout_mx_mspll_ccore);
-
 	clk_prepare_enable(dmc->fout_bpll);
 	clk_prepare_enable(dmc->mout_bpll);
 
-- 
2.17.1

