Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAEA25C968
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgICTWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 15:22:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18310 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbgICTWO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 15:22:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599160934; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=buByExxU324rJaH/QAV4fD/s5fMCpT+XE8+kHh2nz8o=; b=C5U2m5w/8f+6/kpnCEqjrHTzxSlHddQGSvuj13uyZRccjSrZghmMDnaaFhC9E6/pPM2FWJoe
 p14+/XKw2JkYbHg/fywu4Tp5T/SJAb1+wg9ALMZF4q1cygE1VJ7Vjtl+2xpj7CxTlJHL4gZY
 Ma5gC7dWMryQMehfaayPoRvniK8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f514265238e1efa37885d70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 19:22:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B9ECC433A1; Thu,  3 Sep 2020 19:22:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CE2BC433CB;
        Thu,  3 Sep 2020 19:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CE2BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v4 5/6] interconnect: qcom: Only wait for completion in AMC/WAKE by default
Date:   Thu,  3 Sep 2020 12:21:48 -0700
Message-Id: <20200903192149.30385-6-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200903192149.30385-1-mdtipton@codeaurora.org>
References: <20200903192149.30385-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the default TCS wait behavior to only wait for completion in AMC
and WAKE. Waiting isn't necessary in the SLEEP TCS, since votes are only
being removed in this case. Resources can be safely disabled
asynchronously in parallel with the rest of the power collapse sequence.
This reduces the sleep entry latency.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index f7db2b900599..d58b08f1f495 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -352,7 +352,7 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 	voter->np = np;
 
 	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
-		voter->tcs_wait = QCOM_ICC_TAG_ALWAYS;
+		voter->tcs_wait = QCOM_ICC_TAG_ACTIVE_ONLY;
 
 	mutex_init(&voter->lock);
 	INIT_LIST_HEAD(&voter->commit_list);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

