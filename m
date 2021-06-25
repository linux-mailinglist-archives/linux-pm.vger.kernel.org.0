Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FB03B4A32
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFYVbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 17:31:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:22597 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFYVb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 17:31:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624656544; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VKnhaTPJl4bd6GS1KO3Fw6pzG9/UGtuplYmEcz9Jwrw=; b=V1c7RteWpf4UfrXASzceuBCaocxvOSrZ/VgedWFC39o2JTbVu3ymrt+PRi8XopFAiZwXRmjf
 WAY7gJB4ULNhVEmzv0GMzqjgwpRyZd2EdKMhTHXA3ZGeYMkie7Hoz8sKfjffUBcfcB9G1mw3
 PtSvpZmlh4kA1TTOXmepE32ycxw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60d64a9c19389419555de0e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 21:29:00
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84626C433D3; Fri, 25 Jun 2021 21:28:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2EC1C433F1;
        Fri, 25 Jun 2021 21:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2EC1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 2/4] interconnect: Always call pre_aggregate before aggregate
Date:   Fri, 25 Jun 2021 14:28:37 -0700
Message-Id: <20210625212839.24155-3-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625212839.24155-1-mdtipton@codeaurora.org>
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The pre_aggregate callback isn't called in all cases before calling
aggregate. Add the missing calls so providers can rely on consistent
framework behavior.

Fixes: d3703b3e255f ("interconnect: Aggregate before setting initial bandwidth")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 945121e18b5c..cfd54c90a6bb 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -973,9 +973,12 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	}
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
-	if (provider->aggregate)
+	if (provider->aggregate) {
+		if (provider->pre_aggregate)
+			provider->pre_aggregate(node);
 		provider->aggregate(node, 0, node->init_avg, node->init_peak,
 				    &node->avg_bw, &node->peak_bw);
+	}
 	provider->set(node, node);
 	node->avg_bw = 0;
 	node->peak_bw = 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

