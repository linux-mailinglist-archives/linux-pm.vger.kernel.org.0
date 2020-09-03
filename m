Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0526E25C96B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 21:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgICTWp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 15:22:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10859 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgICTWk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 15:22:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599160960; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TwIJpxRouKmM2OseNIA08YDmu9GtOwzMuftNT1neRqo=; b=ZY3As8p4RA7CqgxcVasLWJ9Ra2NshH77tegPpV2URw5nDXrRPzCXAXtoQSrF9Ampp699D4Zl
 orV701cXZIJl0QdF9utfdW2gDD4ogg/+RjsfvFE9y6AvDBHu3lCKvKm9kLNrrKr8iCLVOZju
 Oni263I3watuZH1nkteo0iqd5ok=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f514263ba408b30ceb3b41d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 19:22:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 27E6DC433A1; Thu,  3 Sep 2020 19:22:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CE9CC433CB;
        Thu,  3 Sep 2020 19:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CE9CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v4 1/6] interconnect: qcom: Fix small BW votes being truncated to zero
Date:   Thu,  3 Sep 2020 12:21:44 -0700
Message-Id: <20200903192149.30385-2-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200903192149.30385-1-mdtipton@codeaurora.org>
References: <20200903192149.30385-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Small BW votes that translate to less than a single BCM unit are
currently truncated to zero. Ensure that non-zero BW requests always
result in at least a vote of 1 to BCM.

Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a3d2ef1d9903..609db9c95fd7 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -52,8 +52,20 @@ static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
 		return 1;
 }
 
+static u64 bcm_div(u64 num, u32 base)
+{
+	/* Ensure that small votes aren't lost. */
+	if (num && num < base)
+		return 1;
+
+	do_div(num, base);
+
+	return num;
+}
+
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
+	struct qcom_icc_node *node;
 	size_t i, bucket;
 	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
 	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
@@ -61,22 +73,21 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
 	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
 		for (i = 0; i < bcm->num_nodes; i++) {
-			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			node = bcm->nodes[i];
+			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
+				       node->buswidth * node->channels);
 			agg_avg[bucket] = max(agg_avg[bucket], temp);
 
-			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
-			do_div(temp, bcm->nodes[i]->buswidth);
+			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
+				       node->buswidth);
 			agg_peak[bucket] = max(agg_peak[bucket], temp);
 		}
 
 		temp = agg_avg[bucket] * 1000ULL;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_x[bucket] = temp;
+		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
 
 		temp = agg_peak[bucket] * 1000ULL;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_y[bucket] = temp;
+		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

