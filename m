Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ED424E8CA
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHVQcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 12:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgHVQcl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 22 Aug 2020 12:32:41 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC35E214F1;
        Sat, 22 Aug 2020 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598113960;
        bh=+sgmNfBZHA+FLRc2AP/OeM5N/b+iPJ8pjZ5597XCKFE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2n4aE6VgokVE2IhC0qZB5SoV6wO8JfRK3/0piZCbRaotDWdAPFrYOXQalYuBw713A
         EGcjiLyQcbN62uD222jRY+u5+pYBO2osFh/Y53E2Vc8R5nS8N7zX70tmP9rYQWiGEo
         5zSmlfGS8zGhKL2dcOzKfKTfIJGqyZ/wmQLh2Wvw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] memory: samsung: exynos5422-dmc: add missing and fix kerneldoc
Date:   Sat, 22 Aug 2020 18:32:18 +0200
Message-Id: <20200822163218.21857-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822163218.21857-1-krzk@kernel.org>
References: <20200822163218.21857-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing kerneldoc to struct exynos5_dmc and correct the existing
kerneldoc in other places to fix W=1 warnings like:

    drivers/memory/samsung/exynos5422-dmc.c:107: warning: Function parameter or member 'freq_hz' not described in 'dmc_opp_table'
    drivers/memory/samsung/exynos5422-dmc.c:154: warning: Function parameter or member 'dev' not described in 'exynos5_dmc'
    drivers/memory/samsung/exynos5422-dmc.c:357: warning: Excess function parameter 'param' description in 'exynos5_set_bypass_dram_timings'
    drivers/memory/samsung/exynos5422-dmc.c:630: warning: Function parameter or member 'flags' not described in 'exynos5_dmc_get_volt_freq'
    drivers/memory/samsung/exynos5422-dmc.c:962: warning: cannot understand function prototype: 'struct devfreq_dev_profile exynos5_dmc_df_profile = '
    drivers/memory/samsung/exynos5422-dmc.c:1011: warning: Function parameter or member 'reg_timing_row' not described in 'create_timings_aligned'
    drivers/memory/samsung/exynos5422-dmc.c:1011: warning: Excess function parameter 'idx' description in 'create_timings_aligned'
    drivers/memory/samsung/exynos5422-dmc.c:1345: warning: Excess function parameter 'set' description in 'exynos5_dmc_set_pause_on_switching'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 44 ++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index df02afa8aa90..a9d04bd31603 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -108,6 +108,41 @@ struct dmc_opp_table {
 
 /**
  * struct exynos5_dmc - main structure describing DMC device
+ * @dev:		DMC device
+ * @df:			devfreq device structure returned by devfreq framework
+ * @gov_data:		configuration of devfreq governor
+ * @base_drexi0:	DREX0 registers mapping
+ * @base_drexi1:	DREX1 registers mapping
+ * @clk_regmap:		regmap for clock controller registers
+ * @lock:		protects curr_rate and frequency/voltage setting section
+ * @curr_rate:		current frequency
+ * @curr_volt:		current voltage
+ * @opp:		OPP table
+ * @opp_count:		number of 'opp' elements
+ * @timings_arr_size:	number of 'timings' elements
+ * @timing_row:		values for timing row register, for each OPP
+ * @timing_data:	values for timing data register, for each OPP
+ * @timing_power:	balues for timing power register, for each OPP
+ * @timings:		DDR memory timings, from device tree
+ * @min_tck:		DDR memory minimum timing values, from device tree
+ * @bypass_timing_row:	value for timing row register for bypass timings
+ * @bypass_timing_data:	value for timing data register for bypass timings
+ * @bypass_timing_power:	value for timing power register for bypass
+ *				timings
+ * @vdd_mif:		Memory interface regulator
+ * @fout_spll:		clock: SPLL
+ * @fout_bpll:		clock: BPLL
+ * @mout_spll:		clock: mux SPLL
+ * @mout_bpll:		clock: mux BPLL
+ * @mout_mclk_cdrex:	clock: mux mclk_cdrex
+ * @mout_mx_mspll_ccore:	clock: mux mx_mspll_ccore
+ * @counter:		devfreq events
+ * @num_counters:	number of 'counter' elements
+ * @last_overflow_ts:	time (in ns) of last overflow of each DREX
+ * @load:		utilization in percents
+ * @total:		total time between devfreq events
+ * @in_irq_mode:	whether running in interrupt mode (true)
+ *			or polling (false)
  *
  * The main structure for the Dynamic Memory Controller which covers clocks,
  * memory regions, HW information, parameters and current operating mode.
@@ -344,7 +379,6 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 /**
  * exynos5_set_bypass_dram_timings() - Low-level changes of the DRAM timings
  * @dmc:	device for which the new settings is going to be applied
- * @param:	DRAM parameters which passes timing data
  *
  * Low-level function for changing timings for DRAM memory clocking from
  * 'bypass' clock source (fixed frequency @400MHz).
@@ -612,6 +646,7 @@ exynos5_dmc_change_freq_and_volt(struct exynos5_dmc *dmc,
  *			requested
  * @target_volt:	returned voltage which corresponds to the returned
  *			frequency
+ * @flags:	devfreq flags provided for this frequency change request
  *
  * Function gets requested frequency and checks OPP framework for needed
  * frequency and voltage. It populates the values 'target_rate' and
@@ -948,7 +983,7 @@ static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
 	return 0;
 }
 
-/**
+/*
  * exynos5_dmc_df_profile - Devfreq governor's profile structure
  *
  * It provides to the devfreq framework needed functions and polling period.
@@ -991,7 +1026,9 @@ exynos5_dmc_align_init_freq(struct exynos5_dmc *dmc,
 /**
  * create_timings_aligned() - Create register values and align with standard
  * @dmc:	device for which the frequency is going to be set
- * @idx:	speed bin in the OPP table
+ * @reg_timing_row:	array to fill with values for timing row register
+ * @reg_timing_data:	array to fill with values for timing data register
+ * @reg_timing_power:	array to fill with values for timing power register
  * @clk_period_ps:	the period of the clock, known as tCK
  *
  * The function calculates timings and creates a register value ready for
@@ -1326,7 +1363,6 @@ static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 /**
  * exynos5_dmc_set_pause_on_switching() - Controls a pause feature in DMC
  * @dmc:	device which is used for changing this feature
- * @set:	a boolean state passing enable/disable request
  *
  * There is a need of pausing DREX DMC when divider or MUX in clock tree
  * changes its configuration. In such situation access to the memory is blocked
-- 
2.17.1

