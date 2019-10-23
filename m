Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA2E1888
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404658AbfJWLIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 07:08:46 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48420 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2391006AbfJWLIq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Oct 2019 07:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4462B494;
        Wed, 23 Oct 2019 04:08:21 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58CB83F718;
        Wed, 23 Oct 2019 04:08:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: vexpress-spc: use macros instead of hardcoded values for cluster ids
Date:   Wed, 23 Oct 2019 12:08:10 +0100
Message-Id: <20191023110811.15086-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A15 and A7 cluster identifiers are fixed to 0 and 1 respectively. There are
macros for the same and used in most of the places except this instance.

Lets use macros instead of hardcoded values for cluster ids even here.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 3259498d7eaa..093ef8d3a8d4 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -380,8 +380,9 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 		goto put_clusters;
 
 	/* Assuming 2 cluster, set clk_big_min and clk_little_max */
-	clk_big_min = get_table_min(freq_table[0]);
-	clk_little_max = VIRT_FREQ(1, get_table_max(freq_table[1]));
+	clk_big_min = get_table_min(freq_table[A15_CLUSTER]);
+	clk_little_max = VIRT_FREQ(A7_CLUSTER,
+				   get_table_max(freq_table[A7_CLUSTER]));
 
 	return 0;
 
-- 
2.17.1

