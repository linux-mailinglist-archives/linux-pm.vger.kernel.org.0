Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11AB3DAAB8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhG2SFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 14:05:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12056 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhG2SFk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Jul 2021 14:05:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627581936; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ftwcXvxs2q2J5gUs8pkqXIhBDrujiscNrQ/zdQQCG7s=; b=WWIztYxPTiz8+tMIR7LTrajC/OtVHhU0QLhYpbSSReUy03sX6DAmQ51KtcY2HHZYy5KbXL2e
 rqsm/LzTdPqG6Vd31GLiBYrrUtrsJ5VUpX4zs6PNQ0hUkY/Kx0ti6ywMcdKa/Fk8ln9gtC2E
 VlEne6i5OpNpaopROavj+zC+xUU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6102edd6b653fbdadd3ccdd1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 18:05:10
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD695C4338A; Thu, 29 Jul 2021 18:05:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34D05C4338A;
        Thu, 29 Jul 2021 18:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34D05C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     sboyd@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mka@chromium.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/4] cpufreq: qcom: Re-arrange register offsets to support per core L3 DCVS
Date:   Thu, 29 Jul 2021 23:34:43 +0530
Message-Id: <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm SoCs (starting with SM8350) support per core voting for L3 cache
frequency. So, re-arrange the cpufreq register offsets to allow access for
the L3 interconnect to implement per core control. Also prevent binding
breakage caused by register offset shuffling by using the SM8250/SM8350
EPSS compatible.

Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..74ef3b38343b 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -28,6 +28,7 @@ struct qcom_cpufreq_soc_data {
 	u32 reg_volt_lut;
 	u32 reg_perf_state;
 	u8 lut_row_size;
+	bool skip_enable;
 };
 
 struct qcom_cpufreq_data {
@@ -257,19 +258,31 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.reg_volt_lut = 0x114,
 	.reg_perf_state = 0x920,
 	.lut_row_size = 32,
+	.skip_enable = false,
 };
 
 static const struct qcom_cpufreq_soc_data epss_soc_data = {
+	.reg_freq_lut = 0x0,
+	.reg_volt_lut = 0x100,
+	.reg_perf_state = 0x220,
+	.lut_row_size = 4,
+	.skip_enable = true,
+};
+
+static const struct qcom_cpufreq_soc_data epss_sm8250_soc_data = {
 	.reg_enable = 0x0,
 	.reg_freq_lut = 0x100,
 	.reg_volt_lut = 0x200,
 	.reg_perf_state = 0x320,
 	.lut_row_size = 4,
+	.skip_enable = false,
 };
 
 static const struct of_device_id qcom_cpufreq_hw_match[] = {
 	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
 	{ .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
+	{ .compatible = "qcom,sm8250-cpufreq-epss", .data = &epss_sm8250_soc_data },
+	{ .compatible = "qcom,sm8350-cpufreq-epss", .data = &epss_sm8250_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
@@ -334,10 +347,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	data->res = res;
 
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
-		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
-		ret = -ENODEV;
-		goto error;
+	if (!data->soc_data->skip_enable) {
+		if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
+			dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
+			ret = -ENODEV;
+			goto error;
+		}
 	}
 
 	qcom_get_related_cpus(index, policy->cpus);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

