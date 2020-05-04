Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9501C4808
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEDUYl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:24:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16376 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728036AbgEDUYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:24:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623880; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8MFAQptwlMzZ213cs5BM39F034pibT5h/5vqQT13lbY=; b=r1xw0osqBlH9i0XrQaex1ok/9i3Sc4rWDBQjg5p7tS4v8DcW3zN/HOf42Om0V4OeGj1N3XM1
 lpcCQsX63tD2wtHVh638fWDiKGI1pESaw4Yn58OmPRwPUIbKJ9aFjDwjLO0T5I2iN3pyx2y4
 DkGPHNWALR2Q3wYFNy0gvuAdciU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb079f9.7fef583320d8-smtp-out-n04;
 Mon, 04 May 2020 20:24:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8597CC433F2; Mon,  4 May 2020 20:24:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19BA8C43637;
        Mon,  4 May 2020 20:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19BA8C43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 05/12] OPP: Add and export helper to set bandwidth
Date:   Tue,  5 May 2020 01:52:36 +0530
Message-Id: <20200504202243.5476-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add and export 'dev_pm_opp_set_bw' to set the bandwidth
levels associated with an OPP for a given frequency.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v4:
 https://patchwork.kernel.org/patch/11019737/
 * Pass device opp to set bw levels [Bjorn]

 drivers/opp/core.c     | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7f7060079bb28..f157e2d768d76 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -791,6 +791,49 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
+/**
+ * dev_pm_opp_set_bw() - sets bandwidth levels corresponding to an available opp
+ * @dev:	device for which we do this operation
+ * @opp:	opp based on which the bandwidth levels are to be configured
+ *
+ * This configures the bandwidth to the levels specified
+ * by the OPP.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	struct opp_table *opp_table;
+	int ret = -EINVAL;
+	int i;
+
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		dev_err(dev, "%s: Invalid parameters\n", __func__);
+		return -EINVAL;
+	}
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp table doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	if (opp_table->paths) {
+		for (i = 0; i < opp_table->path_count; i++) {
+			ret = icc_set_bw(opp_table->paths[i],
+					 opp->bandwidth[i].avg,
+					 opp->bandwidth[i].peak);
+			if (ret)
+				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
+					i, ret);
+		}
+	}
+
+	dev_pm_opp_put_opp_table(opp_table);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 639bc0382ee02..87ba295080a2b 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -154,6 +154,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
@@ -352,6 +353,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	return -ENOTSUPP;
+}
+
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
