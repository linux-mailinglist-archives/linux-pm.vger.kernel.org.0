Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8309232151
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgG2PMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:12:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgG2PMe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 11:12:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9EDD6E;
        Wed, 29 Jul 2020 08:12:28 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 252B03F66E;
        Wed, 29 Jul 2020 08:12:25 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com, rjw@rjwysocki.net
Subject: [PATCH 3/4] cpufreq: scmi: Move scmi_cpufreq_driver structure to the top
Date:   Wed, 29 Jul 2020 16:12:07 +0100
Message-Id: <20200729151208.27737-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729151208.27737-1-lukasz.luba@arm.com>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the scmi_cpufreq_driver to top of the file in order to prepare for
upcoming changes, which will extend it based on discoverable
functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 36 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index fb42e3390377..fe95350eb844 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -24,6 +24,28 @@ struct scmi_data {
 	struct device *cpu_dev;
 };
 
+static unsigned int scmi_cpufreq_get_rate(unsigned int cpu);
+static int scmi_cpufreq_set_target(struct cpufreq_policy *policy,
+				   unsigned int index);
+static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq);
+static int scmi_cpufreq_init(struct cpufreq_policy *policy);
+static int scmi_cpufreq_exit(struct cpufreq_policy *policy);
+
+static struct cpufreq_driver scmi_cpufreq_driver = {
+	.name	= "scmi",
+	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_IS_COOLING_DEV,
+	.verify	= cpufreq_generic_frequency_table_verify,
+	.attr	= cpufreq_generic_attr,
+	.target_index	= scmi_cpufreq_set_target,
+	.fast_switch	= scmi_cpufreq_fast_switch,
+	.get	= scmi_cpufreq_get_rate,
+	.init	= scmi_cpufreq_init,
+	.exit	= scmi_cpufreq_exit,
+};
+
 static const struct scmi_handle *handle;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
@@ -219,20 +241,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct cpufreq_driver scmi_cpufreq_driver = {
-	.name	= "scmi",
-	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		  CPUFREQ_IS_COOLING_DEV,
-	.verify	= cpufreq_generic_frequency_table_verify,
-	.attr	= cpufreq_generic_attr,
-	.target_index	= scmi_cpufreq_set_target,
-	.fast_switch	= scmi_cpufreq_fast_switch,
-	.get	= scmi_cpufreq_get_rate,
-	.init	= scmi_cpufreq_init,
-	.exit	= scmi_cpufreq_exit,
-};
-
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
-- 
2.17.1

