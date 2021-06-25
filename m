Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61173B4A2C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhFYVbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 17:31:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:22597 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFYVbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 17:31:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624656541; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ySesvNlauEEm7yyBbVlezGiznvSWahvS4OLJh1EwFhQ=; b=b40h3X/YxLEEajPqjgag1Lp2c4c2DFcXWGeNGdVYfcoOS5t8t/itjJ1ARL986XaIWoeoxa5M
 S3nvogdz6t+9AZ/6q1NWrdC1uVBeQOIl4Ey9Poh2y6e8qDkGz9DlO7kz4t8P4gDWUhawPMpa
 3Ex2bVLiTVoiG2dnCS0IH76smIk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60d64a9c7e5ba0fdc0745f36 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 21:29:00
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81239C433D3; Fri, 25 Jun 2021 21:29:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F94AC4338A;
        Fri, 25 Jun 2021 21:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F94AC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, okukatla@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 3/4] interconnect: qcom: icc-rpmh: Ensure floor BW is enforced for all nodes
Date:   Fri, 25 Jun 2021 14:28:38 -0700
Message-Id: <20210625212839.24155-4-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625212839.24155-1-mdtipton@codeaurora.org>
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We currently only enforce BW floors for a subset of nodes in a path.
All BCMs that need updating are queued in the pre_aggregate/aggregate
phase. The first set() commits all queued BCMs and subsequent set()
calls short-circuit without committing anything. Since the floor BW
isn't set in sum_avg/max_peak until set(), then some BCMs are committed
before their associated nodes reflect the floor.

Set the floor as each node is being aggregated. This ensures that all
all relevant floors are set before the BCMs are committed.

Fixes: 266cd33b5913 ("interconnect: qcom: Ensure that the floor bandwidth value is enforced")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index bf01d09dba6c..f118f57eae37 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -57,6 +57,11 @@ int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 			qn->sum_avg[i] += avg_bw;
 			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
 		}
+
+		if (node->init_avg || node->init_peak) {
+			qn->sum_avg[i] = max_t(u64, qn->sum_avg[i], node->init_avg);
+			qn->max_peak[i] = max_t(u64, qn->max_peak[i], node->init_peak);
+		}
 	}
 
 	*agg_avg += avg_bw;
@@ -90,11 +95,6 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	qp = to_qcom_provider(node->provider);
 	qn = node->data;
 
-	qn->sum_avg[QCOM_ICC_BUCKET_AMC] = max_t(u64, qn->sum_avg[QCOM_ICC_BUCKET_AMC],
-						 node->avg_bw);
-	qn->max_peak[QCOM_ICC_BUCKET_AMC] = max_t(u64, qn->max_peak[QCOM_ICC_BUCKET_AMC],
-						  node->peak_bw);
-
 	qcom_icc_bcm_voter_commit(qp->voter);
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

