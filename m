Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15723EA3B8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhHLL2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 07:28:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58716 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhHLL2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 07:28:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628767678; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3tPMSIR0yeMvYncnvt56rtm6k7//fGvTLyHMUBzi+80=; b=dX5dngwZ1I0xg6eKz1a62FTwu8KU1pA1wAtzlMb7EUZ/zm/FKNrCTppFJ/Y6i0YnqNeMyTNT
 WTUhEGjKMYmH49HjNHmAomxSaZaAx0ig8FuUfErk/Nq4gBJhxEuk7/t3BYdkeZz2z7+OHKNf
 GJcbMVWDOuwqVy3kSPNILc079uU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 611505b691487ad5202f9279 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 11:27:50
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 623B9C4338A; Thu, 12 Aug 2021 11:27:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EFFDC43217;
        Thu, 12 Aug 2021 11:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EFFDC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net,
        digetx@gmail.com, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 2/3] PM / Domains: Add support for 'required-opps' to set default perf state
Date:   Thu, 12 Aug 2021 16:57:21 +0530
Message-Id: <1628767642-4008-3-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628767642-4008-1-git-send-email-rnayak@codeaurora.org>
References: <1628767642-4008-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices within power domains with performance states do not
support DVFS, but still need to vote on a default/static state
while they are active. They can express this using the 'required-opps'
property in device tree, which points to the phandle of the OPP
supported by the corresponding power-domains.

Add support to parse this information from DT and then set the
specified performance state during attach and drop it on detach.
runtime suspend/resume callbacks already have logic to drop/set
the vote as needed and should take care of dropping the default
perf state vote on runtime suspend and restore it back on runtime
resume.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/domain.c | 30 ++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a934c67..e1c8994 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2598,6 +2598,12 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
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
@@ -2637,6 +2643,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
+	int pstate;
 	int ret;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
@@ -2675,10 +2682,29 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		genpd_unlock(pd);
 	}
 
-	if (ret)
+	if (ret) {
 		genpd_remove_device(pd, dev);
+		return -EPROBE_DEFER;
+	}
 
-	return ret ? -EPROBE_DEFER : 1;
+	/* Set the default performance state */
+	pstate = of_get_required_opp_performance_state(dev->of_node, index);
+	if (pstate < 0 && pstate != -ENODEV) {
+		ret = pstate;
+		goto err;
+	} else if (pstate > 0) {
+		ret = dev_pm_genpd_set_performance_state(dev, pstate);
+		if (ret)
+			goto err;
+		dev_gpd_data(dev)->default_pstate = pstate;
+	}
+	return 1;
+
+err:
+	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
+		pd->name, ret);
+	genpd_remove_device(pd, dev);
+	return ret;
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

