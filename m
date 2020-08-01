Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C244234FAC
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 05:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHADcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 23:32:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25011 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgHADcl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 23:32:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596252761; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gcqQzQVXCs7enCe/CsT0vSZrIaJ9bCn32XECqcM0XFI=; b=au+5W0aoy4wrR2DrndLIVTK9xKT4Xj6OI6nXKjURfNXR2PkSmXJakdbTTsiZl2lh6UQccibu
 m0OXsMdr3vbfm47/E0b9UV8rbw60nUVTZtsp7IV3loYhyPKXyoFUE3zigy+KgboZLKlRXK5O
 tGjWVMJFO2WUzPkz8er5LOPp12Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-west-2.postgun.com with SMTP id
 5f24e24beb556d49a60e44ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 03:32:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07BC5C433CB; Sat,  1 Aug 2020 03:32:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 433BFC433C6;
        Sat,  1 Aug 2020 03:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 433BFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3 4/6] interconnect: qcom: Only wait for completion in AMC/WAKE by default
Date:   Fri, 31 Jul 2020 20:32:13 -0700
Message-Id: <20200801033215.1440-5-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200801033215.1440-1-mdtipton@codeaurora.org>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
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
index 4bba3b42b648..d95725b9208c 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -341,7 +341,7 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 	voter->np = np;
 
 	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
-		voter->tcs_wait = QCOM_ICC_TAG_ALWAYS;
+		voter->tcs_wait = QCOM_ICC_TAG_ACTIVE_ONLY;
 
 	mutex_init(&voter->lock);
 	INIT_LIST_HEAD(&voter->commit_list);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

