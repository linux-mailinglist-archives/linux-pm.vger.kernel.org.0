Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA593F83CC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbhHZIhW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 04:37:22 -0400
Received: from foss.arm.com ([217.140.110.172]:41622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240327AbhHZIhT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 04:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6684D6E;
        Thu, 26 Aug 2021 01:36:32 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AF713F5A1;
        Thu, 26 Aug 2021 01:36:30 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v5 8/8] cpufreq: scmi: Read inefficiencies from EM
Date:   Thu, 26 Aug 2021 09:35:44 +0100
Message-Id: <1629966944-439570-9-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model has a 1:1 mapping between OPPs and performance states
(em_perf_state). If a CPUFreq driver registers an Energy Model,
inefficiencies found by the latter can be applied to CPUFreq.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 1e0cd4d165f0..f4fd634d2ecd 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -250,6 +250,7 @@ static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
 {
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
 	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct scmi_data *priv = policy->driver_data;
 
 	/*
@@ -262,9 +263,9 @@ static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
 	if (!priv->nr_opp)
 		return;
 
-	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
-				    &em_cb, priv->opp_shared_cpus,
-				    power_scale_mw);
+	em_dev_register_perf_domain(cpu_dev, priv->nr_opp, &em_cb,
+				    priv->opp_shared_cpus, power_scale_mw);
+	cpufreq_read_inefficiencies_from_em(policy, em_pd_get(cpu_dev));
 }
 
 static struct cpufreq_driver scmi_cpufreq_driver = {
-- 
2.7.4

