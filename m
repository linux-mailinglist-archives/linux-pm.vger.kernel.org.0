Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682E524E240
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHUUto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 16:49:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29144 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgHUUtn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 16:49:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598042983; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WRPAZeilvd47qwxaLmDsAccJ+EomVymQZ4wOUU2EfTs=; b=AIcQN2XgFpkVj+5w0Nx6Gpw2nW+KorXKTuNU3wvsf2Rfjt/VBBlGrhvvt8NWrplIIaT3g4AP
 M3bA3yHLGtOA+I+phsR25mZnmN10ITID8WvXPRyd2WWZz/frQvmVVjZbwlfWSthIJU5ZRvOa
 gvkhMfXGv7HM7wx/Gxy6HxQOsD0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f40336691f122588b1f5ee0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 20:49:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20795C433A1; Fri, 21 Aug 2020 20:49:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6C4DC43395;
        Fri, 21 Aug 2020 20:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6C4DC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        khilman@kernel.org, swboyd@chromium.org
Cc:     rjw@rjwysocki.net, agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 2/2] soc: qcom: aoss: Use both GENPD_FLAG_NO_SUSPEND/RESUME flags
Date:   Sat, 22 Aug 2020 02:19:21 +0530
Message-Id: <20200821204921.32536-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200821204921.32536-1-sibis@codeaurora.org>
References: <20200821204921.32536-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the power domains exposed as part of the AOSS QMP driver require to
stay unaltered during suspend/resume. They are powered on when the remote
processors boots up and powered off on remote processor crash/shutdown.
Mark the power domains with GENPD_FLAG_NO_SUSPEND and GENPD_FLAG_NO_RESUME
to model this behavior.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

V2:
 * Use the renamed flags
 * Drop R-b/T-b

 drivers/soc/qcom/qcom_aoss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index ed2c687c16b31..da763ac6bca2f 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -366,6 +366,7 @@ static int qmp_pd_add(struct qmp *qmp)
 		res[i].pd.name = sdm845_resources[i];
 		res[i].pd.power_on = qmp_pd_power_on;
 		res[i].pd.power_off = qmp_pd_power_off;
+		res[i].pd.flags = GENPD_FLAG_NO_SUSPEND | GENPD_FLAG_NO_RESUME;
 
 		ret = pm_genpd_init(&res[i].pd, NULL, true);
 		if (ret < 0) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

