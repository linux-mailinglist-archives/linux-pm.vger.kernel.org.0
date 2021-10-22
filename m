Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F094437316
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJVHxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 03:53:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhJVHxf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Oct 2021 03:53:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 651C21FB;
        Fri, 22 Oct 2021 00:51:18 -0700 (PDT)
Received: from e120189.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 554903F70D;
        Fri, 22 Oct 2021 00:51:15 -0700 (PDT)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dietmar.Eggemann@arm.com
Subject: [PATCH v1] cpufreq: CPPC: Fix performance/frequency conversion
Date:   Fri, 22 Oct 2021 08:50:57 +0100
Message-Id: <20211022075057.10759-1-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUfreq governors request CPU frequencies using information
on current CPU usage. The CPPC driver converts them to
performance requests. Frequency targets are computed as:
  target_freq = (util / cpu_capacity) * max_freq
target_freq is then clamped between [policy->min, policy->max].

The CPPC driver converts performance values to frequencies
(and vice-versa) using cppc_cpufreq_perf_to_khz() and
cppc_cpufreq_khz_to_perf(). These functions both use two different
factors depending on the range of the input value. For
cppc_cpufreq_khz_to_perf():
- (NOMINAL_PERF / NOMINAL_FREQ) or
- (LOWEST_PERF / LOWEST_FREQ)
and for cppc_cpufreq_perf_to_khz():
- (NOMINAL_FREQ / NOMINAL_PERF) or
- ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))

This means the functions are not inverse for some values:
(perf_to_khz(khz_to_perf(x)) != x)

This patch makes use of one single conversion factor, being
(MAX_PERF / MAX_FREQ).

As LOWEST_FREQ is not used during conversion, the LOWEST_FREQ
advertised through policy->cpuinfo.min_freq might be different
from the LOWEST_FREQ value available in the CPPC object,
but the conversion will be correct.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d4c27022b9c9..d2ac74e7701e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -302,13 +302,10 @@ static u64 cppc_get_dmi_max_khz(void)
 }
 
 /*
- * If CPPC lowest_freq and nominal_freq registers are exposed then we can
- * use them to convert perf to freq and vice versa
- *
- * If the perf/freq point lies between Nominal and Lowest, we can treat
- * (Low perf, Low freq) and (Nom Perf, Nom freq) as 2D co-ordinates of a line
- * and extrapolate the rest
- * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
+ * The CPPC driver receives frequency requests and translates them to performance
+ * requests. Thus, frequency values are actually performance values on a frequency
+ * scale. The conversion is done as:
+ * target_freq = target_perf * (nominal_freq / nominal_perf)
  */
 static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
 					     unsigned int perf)
@@ -317,14 +314,9 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
 	static u64 max_khz;
 	u64 mul, div;
 
-	if (caps->lowest_freq && caps->nominal_freq) {
-		if (perf >= caps->nominal_perf) {
-			mul = caps->nominal_freq;
-			div = caps->nominal_perf;
-		} else {
-			mul = caps->nominal_freq - caps->lowest_freq;
-			div = caps->nominal_perf - caps->lowest_perf;
-		}
+	if (caps->nominal_freq) {
+		mul = caps->nominal_freq;
+		div = caps->nominal_perf;
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
@@ -341,14 +333,9 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 	static u64 max_khz;
 	u64  mul, div;
 
-	if (caps->lowest_freq && caps->nominal_freq) {
-		if (freq >= caps->nominal_freq) {
-			mul = caps->nominal_perf;
-			div = caps->nominal_freq;
-		} else {
-			mul = caps->lowest_perf;
-			div = caps->lowest_freq;
-		}
+	if (caps->nominal_freq) {
+		mul = caps->nominal_perf;
+		div = caps->nominal_freq;
 	} else {
 		if (!max_khz)
 			max_khz = cppc_get_dmi_max_khz();
-- 
2.17.1

