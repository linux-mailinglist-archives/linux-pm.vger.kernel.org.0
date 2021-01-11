Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66F82F19F3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 16:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbhAKPn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 10:43:57 -0500
Received: from foss.arm.com ([217.140.110.172]:60250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbhAKPn4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 10:43:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89AB112FC;
        Mon, 11 Jan 2021 07:43:10 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.39.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB1793F70D;
        Mon, 11 Jan 2021 07:43:08 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v6 3/4] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM
Date:   Mon, 11 Jan 2021 15:45:23 +0000
Message-Id: <20210111154524.20196-4-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210111154524.20196-1-nicola.mazzucato@arm.com>
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
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

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4aa97cdc5997..ff6ba6fab58b 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -226,9 +226,12 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
 	bool power_scale_mw;
 	cpumask_var_t scmi_cpus;
+	cpumask_var_t opp_shared_cpus;
 
 	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
 		return -ENOMEM;
+	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
+		return -ENOMEM;
 
 	cpumask_set_cpu(cpu, scmi_cpus);
 
@@ -240,6 +243,20 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
 		goto free_cpumask;
 	}
 
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
+		cpumask_copy(opp_shared_cpus, scmi_cpus);
+	}
+
 	/*
 	 * We get here for each CPU. Add OPPs only on those CPUs for which we
 	 * haven't already done so, or set their OPPs as shared.
@@ -252,7 +269,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
 			goto free_cpumask;
 		}
 
-		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
 		if (ret) {
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
@@ -269,7 +286,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
 		}
 
 		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
-		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, scmi_cpus,
+		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus,
 					    power_scale_mw);
 	}
 
@@ -284,6 +301,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
 
 free_cpumask:
 	free_cpumask_var(scmi_cpus);
+	free_cpumask_var(opp_shared_cpus);
 	return ret;
 }
 
-- 
2.27.0

