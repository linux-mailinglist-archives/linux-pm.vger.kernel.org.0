Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356E824E8C7
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHVQch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Aug 2020 12:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgHVQch (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 22 Aug 2020 12:32:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8ECE206C0;
        Sat, 22 Aug 2020 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598113956;
        bh=TRlm30t86MjSYo1EEsLjO22W4UsIuUhrEDplYYJjKVQ=;
        h=From:To:Subject:Date:From;
        b=Pyl7fNyoa7bCkM8lGz65UBoK6qPb+eC+kAtHMyi96vn08cN9TnRSImWhaCwbsDDKI
         UqBSUnpm7J1Pz93W+koiYAmOFA/1VDWOufr21OyyFDbJ5d7fn1JQ5xdZhpqpFD51GG
         BTCC43jF+SIEbsQKa4v5HUFtGQYOziuV82s3qiic=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] memory: samsung: exynos5422-dmc: rename timing register fields variables
Date:   Sat, 22 Aug 2020 18:32:16 +0200
Message-Id: <20200822163218.21857-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver has file-scope arrays defining fields of timing registers
(e.g. struct timing_reg timing_row) and actual values for these
registers per each OPP in state container (struct
exynos5_dmc.timing_row).  The meanings of these are different so use
different names to avoid confusion.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 49 +++++++++++++------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 0045fa536b2b..31864ce59b25 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -170,7 +170,7 @@ struct timing_reg {
 	unsigned int val;
 };
 
-static const struct timing_reg timing_row[] = {
+static const struct timing_reg timing_row_reg_fields[] = {
 	TIMING_FIELD("tRFC", 24, 31),
 	TIMING_FIELD("tRRD", 20, 23),
 	TIMING_FIELD("tRP", 16, 19),
@@ -179,7 +179,7 @@ static const struct timing_reg timing_row[] = {
 	TIMING_FIELD("tRAS", 0, 5),
 };
 
-static const struct timing_reg timing_data[] = {
+static const struct timing_reg timing_data_reg_fields[] = {
 	TIMING_FIELD("tWTR", 28, 31),
 	TIMING_FIELD("tWR", 24, 27),
 	TIMING_FIELD("tRTP", 20, 23),
@@ -190,7 +190,7 @@ static const struct timing_reg timing_data[] = {
 	TIMING_FIELD("RL", 0, 3),
 };
 
-static const struct timing_reg timing_power[] = {
+static const struct timing_reg timing_power_reg_fields[] = {
 	TIMING_FIELD("tFAW", 26, 31),
 	TIMING_FIELD("tXSR", 16, 25),
 	TIMING_FIELD("tXP", 8, 15),
@@ -198,8 +198,9 @@ static const struct timing_reg timing_power[] = {
 	TIMING_FIELD("tMRD", 0, 3),
 };
 
-#define TIMING_COUNT (ARRAY_SIZE(timing_row) + ARRAY_SIZE(timing_data) + \
-		      ARRAY_SIZE(timing_power))
+#define TIMING_COUNT (ARRAY_SIZE(timing_row_reg_fields) + \
+		      ARRAY_SIZE(timing_data_reg_fields) + \
+		      ARRAY_SIZE(timing_power_reg_fields))
 
 static int exynos5_counters_set_event(struct exynos5_dmc *dmc)
 {
@@ -1022,117 +1023,117 @@ static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
 	val = dmc->timings->tRFC / clk_period_ps;
 	val += dmc->timings->tRFC % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRFC);
-	reg = &timing_row[0];
+	reg = &timing_row_reg_fields[0];
 	*reg_timing_row |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRRD / clk_period_ps;
 	val += dmc->timings->tRRD % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRRD);
-	reg = &timing_row[1];
+	reg = &timing_row_reg_fields[1];
 	*reg_timing_row |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRPab / clk_period_ps;
 	val += dmc->timings->tRPab % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRPab);
-	reg = &timing_row[2];
+	reg = &timing_row_reg_fields[2];
 	*reg_timing_row |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRCD / clk_period_ps;
 	val += dmc->timings->tRCD % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRCD);
-	reg = &timing_row[3];
+	reg = &timing_row_reg_fields[3];
 	*reg_timing_row |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRC / clk_period_ps;
 	val += dmc->timings->tRC % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRC);
-	reg = &timing_row[4];
+	reg = &timing_row_reg_fields[4];
 	*reg_timing_row |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRAS / clk_period_ps;
 	val += dmc->timings->tRAS % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRAS);
-	reg = &timing_row[5];
+	reg = &timing_row_reg_fields[5];
 	*reg_timing_row |= TIMING_VAL2REG(reg, val);
 
 	/* data related timings */
 	val = dmc->timings->tWTR / clk_period_ps;
 	val += dmc->timings->tWTR % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tWTR);
-	reg = &timing_data[0];
+	reg = &timing_data_reg_fields[0];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tWR / clk_period_ps;
 	val += dmc->timings->tWR % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tWR);
-	reg = &timing_data[1];
+	reg = &timing_data_reg_fields[1];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRTP / clk_period_ps;
 	val += dmc->timings->tRTP % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRTP);
-	reg = &timing_data[2];
+	reg = &timing_data_reg_fields[2];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tW2W_C2C / clk_period_ps;
 	val += dmc->timings->tW2W_C2C % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tW2W_C2C);
-	reg = &timing_data[3];
+	reg = &timing_data_reg_fields[3];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tR2R_C2C / clk_period_ps;
 	val += dmc->timings->tR2R_C2C % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tR2R_C2C);
-	reg = &timing_data[4];
+	reg = &timing_data_reg_fields[4];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tWL / clk_period_ps;
 	val += dmc->timings->tWL % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tWL);
-	reg = &timing_data[5];
+	reg = &timing_data_reg_fields[5];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tDQSCK / clk_period_ps;
 	val += dmc->timings->tDQSCK % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tDQSCK);
-	reg = &timing_data[6];
+	reg = &timing_data_reg_fields[6];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tRL / clk_period_ps;
 	val += dmc->timings->tRL % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tRL);
-	reg = &timing_data[7];
+	reg = &timing_data_reg_fields[7];
 	*reg_timing_data |= TIMING_VAL2REG(reg, val);
 
 	/* power related timings */
 	val = dmc->timings->tFAW / clk_period_ps;
 	val += dmc->timings->tFAW % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tFAW);
-	reg = &timing_power[0];
+	reg = &timing_power_reg_fields[0];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tXSR / clk_period_ps;
 	val += dmc->timings->tXSR % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tXSR);
-	reg = &timing_power[1];
+	reg = &timing_power_reg_fields[1];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tXP / clk_period_ps;
 	val += dmc->timings->tXP % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tXP);
-	reg = &timing_power[2];
+	reg = &timing_power_reg_fields[2];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tCKE / clk_period_ps;
 	val += dmc->timings->tCKE % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tCKE);
-	reg = &timing_power[3];
+	reg = &timing_power_reg_fields[3];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
 	val = dmc->timings->tMRD / clk_period_ps;
 	val += dmc->timings->tMRD % clk_period_ps ? 1 : 0;
 	val = max(val, dmc->min_tck->tMRD);
-	reg = &timing_power[4];
+	reg = &timing_power_reg_fields[4];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
 	return 0;
-- 
2.17.1

