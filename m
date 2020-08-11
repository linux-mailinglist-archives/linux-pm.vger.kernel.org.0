Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4DB242016
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgHKTDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 15:03:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60604 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgHKTDj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 15:03:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597172618; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+3oLMOjRVphuPQ+PhEKkKC/mDHCGYkvA89mtuFU3+3Y=; b=hvhuJbOuGaphz0WsoSwyVu8F/m8qGmPfPj5IuOZdnQYf2GeqBm87IvPKH7dw05G5nknSla8N
 UhRXXwGyQMVEBgu0XoKCfD/9yEmkaJ4a7jlBsGpUI0/smEFYMHMoo1bWQ3uLt3DJ/2sC9lqK
 97SAhe1tjtEgQDt8KSn3koOOjhc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f32eb79ba4c2cd3676fcc0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 19:03:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 15EF5C433C6; Tue, 11 Aug 2020 19:03:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FCB0C433CB;
        Tue, 11 Aug 2020 19:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FCB0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, khilman@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/2] soc: qcom: aoss: Use GENPD_FLAG_SUSPEND_ON flag
Date:   Wed, 12 Aug 2020 00:32:52 +0530
Message-Id: <20200811190252.10559-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200811190252.10559-1-sibis@codeaurora.org>
References: <20200811190252.10559-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All the power domains exposed as part of AOSS QMP driver require to stay
powered on for suspend. They are powered on when the remote processors
boots up and powered off on remote processor crash/shutdown. Mark the
power domains with GENPD_FLAG_SUSPEND_ON to model this behavior.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/qcom_aoss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index ed2c687c16b31..5a5b4bf928147 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -366,6 +366,7 @@ static int qmp_pd_add(struct qmp *qmp)
 		res[i].pd.name = sdm845_resources[i];
 		res[i].pd.power_on = qmp_pd_power_on;
 		res[i].pd.power_off = qmp_pd_power_off;
+		res[i].pd.flags = GENPD_FLAG_SUSPEND_ON;
 
 		ret = pm_genpd_init(&res[i].pd, NULL, true);
 		if (ret < 0) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

