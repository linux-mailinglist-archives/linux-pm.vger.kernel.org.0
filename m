Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A52425837
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhJGQo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 12:44:57 -0400
Received: from foss.arm.com ([217.140.110.172]:37086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242714AbhJGQo4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Oct 2021 12:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74A201FB;
        Thu,  7 Oct 2021 09:43:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.72.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A64A43F766;
        Thu,  7 Oct 2021 09:43:01 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, hector.yuan@mediatek.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] cpufreq: mediatek-hw: Fix cpufreq_table_find_index_dl call
Date:   Thu,  7 Oct 2021 17:42:18 +0100
Message-Id: <20211007164218.169942-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new cpufreq table flag RELATION_E introduced a new "efficient"
parameter for the cpufreq_table_find*() functions.

Fixes: 1f39fa0dccff (cpufreq: Introducing CPUFREQ_RELATION_E)
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 0cf18dd46b92..8ddbd0c5ce37 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -109,7 +109,7 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	struct mtk_cpufreq_data *data = policy->driver_data;
 	unsigned int index;
 
-	index = cpufreq_table_find_index_dl(policy, target_freq);
+	index = cpufreq_table_find_index_dl(policy, target_freq, false);
 
 	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
 
-- 
2.25.1

