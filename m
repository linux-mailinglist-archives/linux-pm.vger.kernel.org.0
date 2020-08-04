Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8623BA3E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgHDLrZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 07:47:25 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31310 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730299AbgHDLrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 07:47:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596541639; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kv7I/3RRqNOT13X3DGDmONEGT2EBJqW5mZB4sv1aNGA=; b=O3qy96K/4hLjbsKkbgYVP2zywKISKQQAhQCCvsO6yq5d0fZb1+UVUbCvOfYhwRBMWD5n8bcA
 w9tYXyimjsoyE6+77Rv57OHj+JYb3M/cnOuAr2TrlMZSuGRTTsDJkpfLJnsMsL61HulqAgCJ
 vJb1nDUk+KURvB7YOKQxoRLUYhU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-west-2.postgun.com with SMTP id
 5f294ac3781ba1c5e2e7055b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 11:47:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D8C4C43391; Tue,  4 Aug 2020 11:47:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8E30C433CB;
        Tue,  4 Aug 2020 11:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8E30C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 2/3] PM / Domains: Add support for 'assigned-performance-states'
Date:   Tue,  4 Aug 2020 17:16:55 +0530
Message-Id: <1596541616-27688-3-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
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
index 0a01df60..8704823 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -810,6 +810,10 @@ static int genpd_runtime_suspend(struct device *dev)
 	if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
 		return 0;
 
+	/* Drop the assigned performance state */
+	if (dev_gpd_data(dev)->assigned_pstate)
+		dev_pm_genpd_set_performance_state(dev, 0);
+
 	genpd_lock(genpd);
 	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
@@ -829,6 +833,7 @@ static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	unsigned int assigned_pstate = dev_gpd_data(dev)->assigned_pstate;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -857,6 +862,9 @@ static int genpd_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Set the assigned performance state */
+	if (assigned_pstate)
+		dev_pm_genpd_set_performance_state(dev, assigned_pstate);
  out:
 	/* Measure resume latency. */
 	time_start = 0;
@@ -890,6 +898,8 @@ static int genpd_runtime_resume(struct device *dev)
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) ||
 		(pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
+		if (assigned_pstate)
+			dev_pm_genpd_set_performance_state(dev, 0);
 		genpd_lock(genpd);
 		genpd_power_off(genpd, true, 0);
 		genpd_unlock(genpd);
@@ -2405,6 +2415,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
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
@@ -2442,6 +2458,7 @@ static void genpd_dev_pm_sync(struct device *dev)
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
+	unsigned int assigned_pstate;
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
 	int ret;
@@ -2485,6 +2502,16 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
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
index 9ec78ee..4a415ee 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -180,6 +180,7 @@ struct generic_pm_domain_data {
 	struct notifier_block nb;
 	int cpu;
 	unsigned int performance_state;
+	unsigned int assigned_pstate;
 	void *data;
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

