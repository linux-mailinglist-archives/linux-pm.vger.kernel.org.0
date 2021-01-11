Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C642E2F19EC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 16:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbhAKPns (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 10:43:48 -0500
Received: from foss.arm.com ([217.140.110.172]:60230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbhAKPns (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 10:43:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADE9511B3;
        Mon, 11 Jan 2021 07:43:02 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.39.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 570F23F70D;
        Mon, 11 Jan 2021 07:43:00 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v6 1/4] scmi-cpufreq: Remove deferred probe
Date:   Mon, 11 Jan 2021 15:45:21 +0000
Message-Id: <20210111154524.20196-2-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210111154524.20196-1-nicola.mazzucato@arm.com>
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current implementation still carries a case for a deferred probe, but
in practise this should not happen anymore.

Since the energy model expects to pass the number of OPPs, let us just
move the call dev_pm_opp_get_opp_count closer to EM registration instead.

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 491a0a24fb1e..15b213ed78fa 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -153,13 +153,6 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
-	if (nr_opp <= 0) {
-		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
-		ret = -EPROBE_DEFER;
-		goto out_free_opp;
-	}
-
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
@@ -190,6 +183,15 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
 
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
+		dev_err(cpu_dev, "%s: No OPPs for this device: %d\n",
+			__func__, ret);
+
+		ret = -ENODEV;
+		goto out_free_priv;
+	}
+
 	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
 	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
 				    power_scale_mw);
-- 
2.27.0

