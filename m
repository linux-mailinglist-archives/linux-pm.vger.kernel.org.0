Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5632B31B5B8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 08:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhBOHuK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 02:50:10 -0500
Received: from foss.arm.com ([217.140.110.172]:60442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhBOHt6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 02:49:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C03C711D4;
        Sun, 14 Feb 2021 23:49:12 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.16.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F0ACA3F40C;
        Sun, 14 Feb 2021 23:49:10 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v7 2/3] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM
Date:   Mon, 15 Feb 2021 07:51:38 +0000
Message-Id: <20210215075139.30772-3-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210215075139.30772-1-nicola.mazzucato@arm.com>
References: <20210215075139.30772-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

By design, SCMI performance domains define the granularity of
performance controls, they do not describe any underlying hardware
dependencies (although they may match in many cases).

It is therefore possible to have some platforms where hardware may have
the ability to control CPU performance at different granularity and choose
to describe fine-grained performance control through SCMI.

In such situations, the energy model would be provided with inaccurate
information based on controls, while it still needs to know the
performance boundaries.

To restore correct functionality, retrieve information of CPUs under the
same performance domain from operating-points-v2 in DT, and pass it on to
EM.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 72 ++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 34bf2eb8d465..fc9866511f01 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -126,6 +126,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
+	cpumask_var_t opp_shared_cpus;
 	bool power_scale_mw;
 
 	cpu_dev = get_cpu_device(policy->cpu);
@@ -134,32 +135,62 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
-	if (ret) {
-		dev_warn(cpu_dev, "failed to add opps to the device\n");
-		return ret;
-	}
+	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
+		ret = -ENOMEM;
 
+	/* Obtain CPUs that share SCMI performance controls */
 	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
-		return ret;
+		goto out_free_cpumask;
 	}
 
-	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
-	if (ret) {
-		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
-			__func__, ret);
-		return ret;
+	/*
+	 * Obtain CPUs that share performance levels.
+	 * The OPP 'sharing cpus' info may come from DT through an empty opp
+	 * table and opp-shared.
+	 */
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);
+	if (ret || !cpumask_weight(opp_shared_cpus)) {
+		/*
+		 * Either opp-table is not set or no opp-shared was found.
+		 * Use the CPU mask from SCMI to designate CPUs sharing an OPP
+		 * table.
+		 */
+		cpumask_copy(opp_shared_cpus, policy->cpus);
 	}
 
+	/*
+	 * Add OPPs only on those CPUs for which we haven't already done so.
+	 */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
-			__func__, ret);
-
-		ret = -ENODEV;
-		goto out_free_priv;
+		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to add opps to the device\n");
+			goto out_free_cpumask;
+		}
+
+		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+		if (nr_opp <= 0) {
+			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
+				__func__, ret);
+
+			ret = -ENODEV;
+			goto out_free_opp;
+		}
+
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
+		if (ret) {
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
+
+			goto out_free_opp;
+		}
+
+		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
+		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
+					    opp_shared_cpus, power_scale_mw);
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -192,17 +223,18 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
 
-	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
-	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
-				    power_scale_mw);
-
+	free_cpumask_var(opp_shared_cpus);
 	return 0;
 
 out_free_priv:
 	kfree(priv);
+
 out_free_opp:
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
+out_free_cpumask:
+	free_cpumask_var(opp_shared_cpus);
+
 	return ret;
 }
 
-- 
2.27.0

