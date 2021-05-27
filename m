Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED939272E
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhE0GOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 02:14:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59879 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhE0GOo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 02:14:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622095991; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3hOmE0VPR1A3EJosKoBXOYdxI8H1foQzRse78k1n4cQ=; b=jT4LNRlCRL54+bJQWVAOG70iUmR1YuT8V4//grGrXPX19q859K2Vckdnoe1aQg4KbRmEftm0
 47GKB09a5xAndwHTKO/sCKW3cLadcKpumI5GFowi0l3v5qJqDQpM7vADCQ+JFEHigQ/bNVzD
 EQGCms3TSCWYndskCN4tj9Ek4nU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60af3871063320cd13807ec3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 May 2021 06:13:05
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3113C433D3; Thu, 27 May 2021 06:13:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B434C4338A;
        Thu, 27 May 2021 06:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B434C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 2/3] PM / Domains: Add support for 'assigned-performance-states'
Date:   Thu, 27 May 2021 11:42:28 +0530
Message-Id: <1622095949-2014-3-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For devices which have 'assigned-performance-states' specified in DT,
set the specified performance state during attach and drop it on detach.
Also drop/set as part of runtime suspend/resume callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/domain.c | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b6a782c..145ce12 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -888,6 +888,10 @@ static int genpd_runtime_suspend(struct device *dev)
 	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
 		return 0;
 
+	/* Drop the assigned performance state */
+	if (dev_gpd_data(dev)->assigned_pstate)
+		dev_pm_genpd_set_performance_state(dev, 0);
+
 	genpd_lock(genpd);
 	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
@@ -907,6 +911,7 @@ static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	unsigned int assigned_pstate = dev_gpd_data(dev)->assigned_pstate;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -935,6 +940,9 @@ static int genpd_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Set the assigned performance state */
+	if (assigned_pstate)
+		dev_pm_genpd_set_performance_state(dev, assigned_pstate);
  out:
 	/* Measure resume latency. */
 	time_start = 0;
@@ -967,6 +975,8 @@ static int genpd_runtime_resume(struct device *dev)
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
+		if (assigned_pstate)
+			dev_pm_genpd_set_performance_state(dev, 0);
 		genpd_lock(genpd);
 		genpd_power_off(genpd, true, 0);
 		genpd_unlock(genpd);
@@ -2568,6 +2578,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Drop the assigned performance state */
+	if (dev_gpd_data(dev)->assigned_pstate) {
+		dev_pm_genpd_set_performance_state(dev, 0);
+		dev_gpd_data(dev)->assigned_pstate = 0;
+	}
+
 	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
 		ret = genpd_remove_device(pd, dev);
 		if (ret != -EAGAIN)
@@ -2605,6 +2621,7 @@ static void genpd_dev_pm_sync(struct device *dev)
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
+	unsigned int assigned_pstate;
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
 	int ret;
@@ -2648,6 +2665,16 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	if (ret)
 		genpd_remove_device(pd, dev);
 
+	/* Set the assigned performance state */
+	if (!of_property_read_u32_index(base_dev->of_node,
+					"assigned-performance-states",
+					index, &assigned_pstate)) {
+		if (assigned_pstate) {
+			dev_pm_genpd_set_performance_state(dev, assigned_pstate);
+			dev_gpd_data(dev)->assigned_pstate = assigned_pstate;
+		}
+	}
+
 	return ret ? -EPROBE_DEFER : 1;
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index dfcfbce..71c1b11 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -198,6 +198,7 @@ struct generic_pm_domain_data {
 	struct notifier_block *power_nb;
 	int cpu;
 	unsigned int performance_state;
+	unsigned int assigned_pstate;
 	ktime_t	next_wakeup;
 	void *data;
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

