Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D443EA694
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhHLO3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 10:29:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27769 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235850AbhHLO3b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Aug 2021 10:29:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628778546; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=CT17Ngp9j6iBC60DyOnMKn7APbpKq6W9lI7bXc6aE+4=; b=HJMO5bCAThI7bVdBJZ5gjqkqF155EhDNhhpePCACG+JvK3De2ZVusKx0GlBgcgGEo+XY3bdr
 csDpDu1ff6bW9hiH/bdJUUkBD3qpHd0bLADWV/0MtMy00DDUKblVCTvWxGYYgWuGYShGs+5G
 IeSLl+wwBb6/bt0X3lTD5Zo8gIE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61152df57ee60409774313d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Aug 2021 14:19:33
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 37DC3C43217; Thu, 12 Aug 2021 14:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FB64C433F1;
        Thu, 12 Aug 2021 14:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FB64C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2] cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag
Date:   Thu, 12 Aug 2021 19:49:15 +0530
Message-Id: <1628777955-7198-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As remote cpufreq updates are supported on QCOM platforms, set
dvfs_possible_from_any_cpu cpufreq driver flag.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---

[v2]
  * update the dvfs_possible_from_any_cpu always.

 drivers/cpufreq/qcom-cpufreq-hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859b..53d3898 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -223,6 +223,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,

 	table[i].frequency = CPUFREQ_TABLE_END;
 	policy->freq_table = table;
+	policy->dvfs_possible_from_any_cpu = true;
+
 	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);

 	return 0;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

