Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32F71E4F26
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgE0UW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 16:22:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54632 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgE0UW6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 16:22:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590610978; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pUCIYbPRVZUgve3cbw/4j/9bYTh8pYcYVgQsdofQzas=; b=degv2GfXNAJYPiQzoT4t04EBL5cYadtFz5PK2ueYvGJ63ed7Iqrvq7eWYV+Y5a7JtUK0uXgn
 fYSkmpK6ypeasbWNvXeRFmLDpp/jG/DP1oxJ7exkgSWlfxXybIyxEG4E19teuwCe2zNgeuEZ
 REd1SLSJRAjYglHjxWsUt6FxJRs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ececc19c6d4683243f59d24 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 20:22:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1692AC433C9; Wed, 27 May 2020 20:22:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15589C433CA;
        Wed, 27 May 2020 20:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15589C433CA
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
Subject: [PATCH v5 5/5] cpufreq: qcom: Disable fast switch when scaling DDR/L3
Date:   Thu, 28 May 2020 01:51:53 +0530
Message-Id: <20200527202153.11659-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200527202153.11659-1-sibis@codeaurora.org>
References: <20200527202153.11659-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Disable fast switch when the opp-tables required for scaling DDR/L3
are populated.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

V5:
 * Drop dev_pm_opp_get_path_count [Saravana]

 drivers/cpufreq/qcom-cpufreq-hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index fbd73d106a3ae..ff6ad7ac38411 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -159,6 +159,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	} else if (ret != -ENODEV) {
 		dev_err(cpu_dev, "Invalid OPP table in Device tree\n");
 		return ret;
+	} else {
+		policy->fast_switch_possible = true;
 	}
 
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
@@ -308,8 +310,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	dev_pm_opp_of_register_em(policy->cpus);
 
-	policy->fast_switch_possible = true;
-
 	return 0;
 error:
 	devm_iounmap(dev, base);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

