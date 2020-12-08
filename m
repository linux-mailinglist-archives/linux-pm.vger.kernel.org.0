Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECE2D3158
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgLHRmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:42:22 -0500
Received: from foss.arm.com ([217.140.110.172]:52420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgLHRmW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 12:42:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 532A61424;
        Tue,  8 Dec 2020 09:41:36 -0800 (PST)
Received: from ubuntu.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B75BE3F68F;
        Tue,  8 Dec 2020 09:41:33 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com
Cc:     daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v5 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for EM
Date:   Tue,  8 Dec 2020 17:42:28 +0000
Message-Id: <20201208174229.24323-4-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208174229.24323-1-nicola.mazzucato@arm.com>
References: <20201208174229.24323-1-nicola.mazzucato@arm.com>
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

As part of the rework, the deferred probe is also removed as this
condition should never occur.

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 69 ++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 491a0a24fb1e..88ebfd47c5de 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -127,6 +127,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
 	bool power_scale_mw;
+	cpumask_var_t opp_shared_cpus;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -134,30 +135,62 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
-	if (ret) {
-		dev_warn(cpu_dev, "failed to add opps to the device\n");
-		return ret;
-	}
+	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
+		return -ENOMEM;
 
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
+	 * The OPP 'sharing cpus' info may come from dt through an empty opp
+	 * table and opp-shared. If found, it takes precedence over the SCMI
+	 * domain IDs info.
+	 */
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);
+	if (ret || !cpumask_weight(opp_shared_cpus)) {
+		/*
+		 * Either opp-table is not set or no opp-shared was found,
+		 * use the information from SCMI domain IDs.
+		 */
+		cpumask_copy(opp_shared_cpus, policy->cpus);
 	}
 
+	/*
+	 * For a given opp_shared_cpus, add OPPs only for the 'first' CPU and
+	 * mark the other ones as shared.
+	 */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
-		ret = -EPROBE_DEFER;
-		goto out_free_opp;
+		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
+		if (ret) {
+			dev_warn(cpu_dev, "failed to add OPPs to the device\n");
+			goto out_free_cpumask;
+		}
+
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
+		if (ret) {
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
+			goto out_free_cpumask;
+		}
+
+		/*
+		 * To correctly register EM, get the number of OPPs just added
+		 * for this CPU.
+		 */
+		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+		if (nr_opp <= 0) {
+			dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
+				__func__, ret);
+			goto out_free_cpumask;
+		}
+
+		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
+		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
+					    opp_shared_cpus, power_scale_mw);
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -190,16 +223,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
 
-	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
-	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
-				    power_scale_mw);
-
-	return 0;
+	goto out_free_cpumask;
 
 out_free_priv:
 	kfree(priv);
 out_free_opp:
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
+out_free_cpumask:
+	free_cpumask_var(opp_shared_cpus);
 
 	return ret;
 }
-- 
2.27.0

