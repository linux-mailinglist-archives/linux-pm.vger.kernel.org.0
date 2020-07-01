Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A369A21079D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgGAJJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:27 -0400
Received: from foss.arm.com ([217.140.110.172]:47742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgGAJJ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A83E1045;
        Wed,  1 Jul 2020 02:09:25 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85CE13F68F;
        Wed,  1 Jul 2020 02:09:23 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] cpufreq: allow drivers to flag custom support for freq invariance
Date:   Wed,  1 Jul 2020 10:07:44 +0100
Message-Id: <20200701090751.7543-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The scheduler's Frequency Invariance Engine (FIE) is providing a
frequency scale correction factor that helps achieve more accurate
load-tracking by conveying information about the currently selected
frequency relative to the maximum supported frequency of a CPU.

In some cases this is achieved by passing information from cpufreq
drivers about the frequency selection done by cpufreq.

Given that most drivers follow a similar process of selecting and
setting of frequency, there is a strong case for moving the setting
of the frequency scale factor from the cpufreq drivers frequency
switch callbacks (target_index() and fast_switch()), to the cpufreq
core functions that call them.

In preparation for this, acknowledge that there are still drivers
who's frequency setting process is custom and therefore these drivers
will want to provide and flag custom support for the setting of the
scheduler's frequency invariance (FI) scale factor as well. Prepare
for this by introducing a new flag: CPUFREQ_CUSTOM_SET_FREQ_SCALE.

Examples of users of this flag are:
 - drivers that do not implement the callbacks that lend themselves
   to triggering the setting of the FI scale factor,
 - drivers that implement the appropriate callbacks but which have
   an atypical implementation.

Currently, given that all drivers call arch_set_freq_scale() directly,
flag all users with CPUFREQ_CUSTOM_SET_FREQ_SCALE. These driver changes
are also useful to maintain bisection between the FI switch from the
drivers to the core.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c           |  3 ++-
 drivers/cpufreq/qcom-cpufreq-hw.c      |  3 ++-
 drivers/cpufreq/scmi-cpufreq.c         |  3 ++-
 drivers/cpufreq/scpi-cpufreq.c         |  3 ++-
 drivers/cpufreq/vexpress-spc-cpufreq.c |  3 ++-
 include/linux/cpufreq.h                | 10 +++++++++-
 6 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 944d7b45afe9..8e0571a49d1e 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -331,7 +331,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_IS_COOLING_DEV,
+		 CPUFREQ_IS_COOLING_DEV |
+		 CPUFREQ_CUSTOM_SET_FREQ_SCALE,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 573630c23aca..e13780beb373 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -337,7 +337,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-			  CPUFREQ_IS_COOLING_DEV,
+			  CPUFREQ_IS_COOLING_DEV |
+			  CPUFREQ_CUSTOM_SET_FREQ_SCALE,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qcom_cpufreq_hw_target_index,
 	.get		= qcom_cpufreq_hw_get,
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index fb42e3390377..16ab4ecc75e4 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -223,7 +223,8 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		  CPUFREQ_IS_COOLING_DEV,
+		  CPUFREQ_IS_COOLING_DEV |
+		  CPUFREQ_CUSTOM_SET_FREQ_SCALE,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index b0f5388b8854..6b5f56dc3ca3 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -197,7 +197,8 @@ static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		  CPUFREQ_IS_COOLING_DEV,
+		  CPUFREQ_IS_COOLING_DEV |
+		  CPUFREQ_CUSTOM_SET_FREQ_SCALE,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 4e8b1dee7c9a..e0a1a3367ec5 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -496,7 +496,8 @@ static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.name			= "vexpress-spc",
 	.flags			= CPUFREQ_STICKY |
 					CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+					CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+					CPUFREQ_CUSTOM_SET_FREQ_SCALE,
 	.verify			= cpufreq_generic_frequency_table_verify,
 	.target_index		= ve_spc_cpufreq_set_target,
 	.get			= ve_spc_cpufreq_get_rate,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 3494f6763597..42668588f9f8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -293,7 +293,7 @@ __ATTR(_name, 0644, show_##_name, store_##_name)
 
 struct cpufreq_driver {
 	char		name[CPUFREQ_NAME_LEN];
-	u8		flags;
+	u16		flags;
 	void		*driver_data;
 
 	/* needed by all drivers */
@@ -417,6 +417,14 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_IS_COOLING_DEV			BIT(7)
 
+/*
+ * Set by drivers which implement the necessary calls to the scheduler's
+ * frequency invariance engine. The use of this flag will result in the
+ * default arch_set_freq_scale calls being skipped in favour of custom
+ * driver calls.
+ */
+#define CPUFREQ_CUSTOM_SET_FREQ_SCALE		BIT(8)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.17.1

