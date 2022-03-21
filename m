Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A045B4E23C6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Mar 2022 10:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbiCUJ71 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Mar 2022 05:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbiCUJ71 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2022 05:59:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 291BF2DD9;
        Mon, 21 Mar 2022 02:57:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0BF3106F;
        Mon, 21 Mar 2022 02:57:59 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D248B3F766;
        Mon, 21 Mar 2022 02:57:56 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: [RESEND][PATCH 4/8] PM: EM: Change the order of arguments in the .active_power() callback
Date:   Mon, 21 Mar 2022 09:57:25 +0000
Message-Id: <20220321095729.20655-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220321095729.20655-1-lukasz.luba@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The .active_power() callback passes the device pointer when it's called.
Aligned with a convetion present in other subsystems and pass the 'dev'
as a first argument. It looks more cleaner.

Adjust all affected drivers which implement that API callback.

Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst  | 4 ++--
 drivers/cpufreq/mediatek-cpufreq-hw.c | 4 ++--
 drivers/cpufreq/scmi-cpufreq.c        | 4 ++--
 drivers/opp/of.c                      | 6 +++---
 include/linux/energy_model.h          | 6 +++---
 kernel/power/energy_model.c           | 2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 49549aab41b4..fd29ed2506c0 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -181,8 +181,8 @@ EM framework::
 
   -> drivers/cpufreq/foo_cpufreq.c
 
-  01	static int est_power(unsigned long *mW, unsigned long *KHz,
-  02			struct device *dev)
+  01	static int est_power(struct device *dev, unsigned long *mW,
+  02			unsigned long *KHz)
   03	{
   04		long freq, power;
   05
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 0a94c56ddad2..813cccbfe934 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -51,8 +51,8 @@ static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
 };
 
 static int __maybe_unused
-mtk_cpufreq_get_cpu_power(unsigned long *mW,
-			  unsigned long *KHz, struct device *cpu_dev)
+mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *mW,
+			  unsigned long *KHz)
 {
 	struct mtk_cpufreq_data *data;
 	struct cpufreq_policy *policy;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 919fa6e3f462..6d2a4cf46db7 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -96,8 +96,8 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 }
 
 static int __maybe_unused
-scmi_get_cpu_power(unsigned long *power, unsigned long *KHz,
-		   struct device *cpu_dev)
+scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
+		   unsigned long *KHz)
 {
 	unsigned long Hz;
 	int ret, domain;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 440ab5a03df9..485ea980bde7 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1448,7 +1448,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
  * Returns 0 on success or a proper -EINVAL value in case of error.
  */
 static int __maybe_unused
-_get_dt_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
+_get_dt_power(struct device *dev, unsigned long *mW, unsigned long *kHz)
 {
 	struct dev_pm_opp *opp;
 	unsigned long opp_freq, opp_power;
@@ -1482,8 +1482,8 @@ _get_dt_power(unsigned long *mW, unsigned long *kHz, struct device *dev)
  * Returns -EINVAL if the power calculation failed because of missing
  * parameters, 0 otherwise.
  */
-static int __maybe_unused _get_power(unsigned long *mW, unsigned long *kHz,
-				     struct device *dev)
+static int __maybe_unused _get_power(struct device *dev, unsigned long *mW,
+				     unsigned long *kHz)
 {
 	struct dev_pm_opp *opp;
 	struct device_node *np;
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 92e82a322859..8419bffb4398 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -101,11 +101,11 @@ struct em_data_callback {
 	/**
 	 * active_power() - Provide power at the next performance state of
 	 *		a device
+	 * @dev		: Device for which we do this operation (can be a CPU)
 	 * @power	: Active power at the performance state
 	 *		(modified)
 	 * @freq	: Frequency at the performance state in kHz
 	 *		(modified)
-	 * @dev		: Device for which we do this operation (can be a CPU)
 	 *
 	 * active_power() must find the lowest performance state of 'dev' above
 	 * 'freq' and update 'power' and 'freq' to the matching active power
@@ -117,8 +117,8 @@ struct em_data_callback {
 	 *
 	 * Return 0 on success.
 	 */
-	int (*active_power)(unsigned long *power, unsigned long *freq,
-			    struct device *dev);
+	int (*active_power)(struct device *dev, unsigned long *power,
+			    unsigned long *freq);
 
 	/**
 	 * get_cost() - Provide the cost at the given performance state of
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 95a3b33001f6..babefc72085d 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -140,7 +140,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		 * lowest performance state of 'dev' above 'freq' and updates
 		 * 'power' and 'freq' accordingly.
 		 */
-		ret = cb->active_power(&power, &freq, dev);
+		ret = cb->active_power(dev, &power, &freq);
 		if (ret) {
 			dev_err(dev, "EM: invalid perf. state: %d\n",
 				ret);
-- 
2.17.1

