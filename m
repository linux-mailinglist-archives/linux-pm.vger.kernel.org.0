Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE01E4F1A
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgE0UWg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 16:22:36 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:39007 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbgE0UWg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 16:22:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590610955; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Y8r0vejj7AAxjfIGnYZNa+fR6ffFzxlWascR8sqXLkM=; b=cu2qlTDBzQ+Q7TOrVr4l2VZVz6HHk3Ilhj02F1lNLcKVYQ7D974x+p/fl8sjU3nuuZQDf1B0
 wlmF1VZgeY+Cb3ClhNheeKCGI64dcJJKm6dsuYdFeng+/LUqkSMC8HqNOikb4zC01vELF+Ln
 HeFQ9MFseLnec37dxSdS1s/b0zU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ececc0137a454afcbe3f531 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 20:22:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CB29C433AF; Wed, 27 May 2020 20:22:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52CBEC43395;
        Wed, 27 May 2020 20:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52CBEC43395
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
Subject: [PATCH v5 1/5] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
Date:   Thu, 28 May 2020 01:51:49 +0530
Message-Id: <20200527202153.11659-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200527202153.11659-1-sibis@codeaurora.org>
References: <20200527202153.11659-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add SDM845 to cpufreq-dt-platdev blacklist since the actual scaling is
handled by the 'qcom-cpufreq-hw' driver.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v5:
 * Picked up R-b from Amit

v4:
 * Updated commit message [Matthias]
 * Picked up R-b from Matthias

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index e8e20fef400b0..be85eb494a6b3 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -132,6 +132,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
+	{ .compatible = "qcom,sdm845", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

