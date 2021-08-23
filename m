Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC03F486D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhHWKQo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 06:16:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60018 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233481AbhHWKQn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 06:16:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629713761; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fNL5/uRZT3gAsMbmBThWEibZUiAf9+mkPhDIiyK7x8E=; b=HQuGXRT23EDhs0qpE+NKqlBikx9wPkL4hyqZTKM/HwM0GnELNcye9lpKVsDnC28wLOODL5rV
 hdkcznl0h3VYTEMjf8UZArr9vEjmk3XFqiokxP6DPSWot7gNPTj8ZBnMB0TRA6ydnXPUoUQE
 5b72iLuRGr85hwvHpBjBh2sPxOY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6123755f2b9e91b688e12a0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Aug 2021 10:15:59
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA368C43617; Mon, 23 Aug 2021 10:15:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF3E3C43460;
        Mon, 23 Aug 2021 10:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CF3E3C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag
Date:   Mon, 23 Aug 2021 15:45:46 +0530
Message-Id: <1629713746-18360-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As remote cpufreq updates are supported on QCOM platforms, set
dvfs_possible_from_any_cpu cpufreq driver flag.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
[v3]
  * update the dvfs_possible_from_any_cpu always from qcom_cpufreq_hw_cpu_init
[v2]
  * update the dvfs_possible_from_any_cpu always.

 drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859b..4dd77ac 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -348,6 +348,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	}

 	policy->driver_data = data;
+	policy->dvfs_possible_from_any_cpu = true;

 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

