Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4E14AAD3
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA0UEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:04:22 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:59383 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbgA0UEW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:04:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155461; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RJAMdUDP8dF7r2pNL8GlWJRlgLG0/Bk8X3egAxim7JQ=; b=iAPsqGJFTmrEkiILfHwalRoh1BFS+sg9tFjaY7zjpQek6VPHHAmvbN4ZXkwOulw/tzH0hzTi
 HOYaNHkyVxqncWhNJkmRpYm7Q02XAfpF9AlI3MrA53+TH0Gh+2NjNM0sKE1kTWZ8mzKjLHJ1
 Cro8eb+radky5X0reSdGayDz934=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f4242.7fb047415148-smtp-out-n02;
 Mon, 27 Jan 2020 20:04:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C584CC447A6; Mon, 27 Jan 2020 20:04:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE142C447A4;
        Mon, 27 Jan 2020 20:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE142C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC v3 02/10] cpufreq: blacklist SDM845 in cpufreq-dt-platdev
Date:   Tue, 28 Jan 2020 01:33:42 +0530
Message-Id: <20200127200350.24465-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add SDM845 to cpufreq-dt-platdev blacklist.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f2ae9cd455c17..5492cf3c9dc18 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -130,6 +130,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
+	{ .compatible = "qcom,sdm845", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
