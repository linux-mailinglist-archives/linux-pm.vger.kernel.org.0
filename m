Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB13CB5A2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhGPKFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 06:05:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16517 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237960AbhGPKFN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Jul 2021 06:05:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626429739; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ayL7fcdsDc7ta3Lq0zYDFlhNjQhIj2jjhQaQNS87qXM=; b=XDNOlxHLDrg+KXKvswb66/RoXoJCYAVUe/i/V6P7DEdLw4QSTXLjE1VgsEHHaYOZrNcheE8R
 O3m8SofH/4RWICPejvaUOIC1QBtDDZ9U35/b/quu2B2aQoJM7Hg39SuYErQXD4Qb7AOk0JCx
 Xnc8GBsAjCk4bD8fHOUHiv01jYc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f158f117c2b4047d74589d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Jul 2021 10:01:21
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48996C433F1; Fri, 16 Jul 2021 10:01:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C601C433F1;
        Fri, 16 Jul 2021 10:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C601C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 1/2] PM / Domains: Add support for 'required-opps' to set default perf state
Date:   Fri, 16 Jul 2021 15:30:57 +0530
Message-Id: <1626429658-18961-2-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devics within power domains with performance states do not
support DVFS, but still need to vote on a default/static state
while they are active. They can express this using the 'required-opps'
property in device tree, which points to the phandle of the OPP
supported by the corresponding power-domains.

Add support to parse this information from DT and then set the
specified performance state during attach and drop it on detach.
Also drop/set as part of runtime suspend/resume callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/domain.c | 37 ++++++++++++++++++++++++++++++++++---
 include/linux/pm_domain.h   |  1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a934c67..dcc0b71 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -917,6 +917,10 @@ static int genpd_runtime_suspend(struct device *dev)
 	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
 		return 0;
 
+	/* Drop the default performance state */
+	if (dev_gpd_data(dev)->default_pstate)
+		dev_pm_genpd_set_performance_state(dev, 0);
+
 	genpd_lock(genpd);
 	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
@@ -937,6 +941,7 @@ static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	unsigned int default_pstate = gpd_data->default_pstate;
 	struct gpd_timing_data *td = &gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
@@ -968,6 +973,9 @@ static int genpd_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Set the default performance state */
+	if (default_pstate)
+		dev_pm_genpd_set_performance_state(dev, default_pstate);
  out:
 	/* Measure resume latency. */
 	time_start = 0;
@@ -1000,6 +1008,8 @@ static int genpd_runtime_resume(struct device *dev)
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
+		if (default_pstate)
+			dev_pm_genpd_set_performance_state(dev, 0);
 		genpd_lock(genpd);
 		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_power_off(genpd, true, 0);
@@ -2598,6 +2608,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Drop the default performance state */
+	if (dev_gpd_data(dev)->default_pstate) {
+		dev_pm_genpd_set_performance_state(dev, 0);
+		dev_gpd_data(dev)->default_pstate = 0;
+	}
+
 	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
 		ret = genpd_remove_device(pd, dev);
 		if (ret != -EAGAIN)
@@ -2635,9 +2651,10 @@ static void genpd_dev_pm_sync(struct device *dev)
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
+	struct device_node *np;
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
-	int ret;
+	int ret, pstate;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 				"#power-domain-cells", index, &pd_args);
@@ -2675,10 +2692,24 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		genpd_unlock(pd);
 	}
 
-	if (ret)
+	if (ret) {
 		genpd_remove_device(pd, dev);
+		return -EPROBE_DEFER;
+	}
+
+	/* Set the default performance state */
+	np = base_dev->of_node;
+	if (of_parse_phandle(np, "required-opps", index)) {
+		pstate = of_get_required_opp_performance_state(np, index);
+		if (pstate < 0) {
+			dev_err(dev, "failed to set pstate:%d", pstate);
+			ret = pstate;
+		}
+		dev_pm_genpd_set_performance_state(dev, pstate);
+		dev_gpd_data(dev)->default_pstate = pstate;
+	}
 
-	return ret ? -EPROBE_DEFER : 1;
+	return ret ? ret : 1;
 }
 
 /**
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 21a0577..67017c9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -198,6 +198,7 @@ struct generic_pm_domain_data {
 	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
+	unsigned int default_pstate;
 	unsigned int rpm_pstate;
 	ktime_t	next_wakeup;
 	void *data;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

