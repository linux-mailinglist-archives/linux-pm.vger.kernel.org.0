Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209BE1C4818
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgEDUY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:24:57 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35290 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbgEDUYv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:24:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623890; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MrDi8noaTB1I3x+4qIYePHEVKUCye+KrBWK+o+3mFgY=; b=kc1l/4DuQWkNfmb7l+js7QSjZiINVTEWysDgzUk4r62o+desj2mK3PoZQr5yyaIpjBZOHFk4
 srKLCpILWKmiOjWiNWnlVPGKqPBrYi/tSfQhU1TJHfYSOudO8PPMj3pV0zylR+4LvGV3v49L
 0fl99VUvwpw+kE51jaXN8k99dqg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07a10.7fef5ee2e3e8-smtp-out-n04;
 Mon, 04 May 2020 20:24:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1905BC44788; Mon,  4 May 2020 20:24:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6AABC44788;
        Mon,  4 May 2020 20:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6AABC44788
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
Subject: [PATCH v4 08/12] cpufreq: qcom: Disable fast switch when scaling ddr/l3
Date:   Tue,  5 May 2020 01:52:39 +0530
Message-Id: <20200504202243.5476-9-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Disable fast switch when the icc paths required for scaling ddr/l3
are populated.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4fb489b69bc61..4b2c23dab3728 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -316,7 +316,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	dev_pm_opp_of_register_em(policy->cpus);
 
-	policy->fast_switch_possible = true;
+	ret = dev_pm_opp_get_path_count(cpu_dev);
+	if (ret <= 0)
+		policy->fast_switch_possible = true;
 
 	return 0;
 error:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
