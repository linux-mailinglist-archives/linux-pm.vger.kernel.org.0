Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8952031E1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgFVIR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 04:17:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45406 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgFVIR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 04:17:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592813846; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VWc645tQv56zUmLmd/9l85xrA/yzGryLvtCI3SsQW8E=; b=fREaaZ++8y+odrE1e8r3+lq1CqHTESmcLjle5VXdU6Nb2dSgQc5OLQjtV7FZEcKA2zDNEmt0
 1SUYu8yM4v2Hs94A60gi9jY1nW8b49qTSVkPH8MqfogKZNMlv1hmLsaCXASRMtiyHkw5Dl/G
 ijbiL29zTXqvbexKi66MhsqfUDA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ef0691686de6ccd4409f72d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 08:17:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3350BC43449; Mon, 22 Jun 2020 08:17:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82C28C43395;
        Mon, 22 Jun 2020 08:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82C28C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, smasetty@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v6 3/5] OPP: Add and export helper to set bandwidth
Date:   Mon, 22 Jun 2020 13:46:47 +0530
Message-Id: <20200622081649.27280-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622081649.27280-1-sibis@codeaurora.org>
References: <20200622081649.27280-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add and export 'dev_pm_opp_set_bw' to set the bandwidth
levels associated with an OPP.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v7:
 * Picked up R-b from Matthias

v6:
 * Pass NULL to _set_opp_bw 

v5:
https://lkml.org/lkml/2020/5/27/7
 * Rework the patch based on ^^

v4:
https://patchwork.kernel.org/patch/11019737/
 * Pass device opp to set bw levels [Bjorn]

 drivers/opp/core.c     | 31 +++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 864cf4c65fff3..c9336aac74e91 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -831,6 +831,37 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
+/**
+ * dev_pm_opp_set_bw() - sets bandwidth levels corresponding to an opp
+ * @dev:	device for which we do this operation
+ * @opp:	opp based on which the bandwidth levels are to be configured
+ *
+ * This configures the bandwidth to the levels specified by the OPP. However
+ * if the OPP specified is NULL the bandwidth levels are cleared out.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp table doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	if (opp)
+		ret = _set_opp_bw(opp_table, opp, dev, false);
+	else
+		ret = _set_opp_bw(opp_table, NULL, dev, true);
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
index d5c4a329321dd..ae68417c0ae00 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -151,6 +151,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
@@ -342,6 +343,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

