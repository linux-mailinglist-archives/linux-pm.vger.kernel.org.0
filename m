Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C64234F99
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHADc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 23:32:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38478 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgHADc3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 23:32:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596252748; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4F33MECp3PLMA5dVQe508bFwLJi13Gd+zPp0VmPVuUU=; b=jh0Waq5Qok2ckWrPDPmfaFomad5prMTft0qODwEEqbifq+f8q7WfBT+EAxGYHBJ3XuX5Cbsi
 VWv2TzA2xuFPZUkqw3PuJG39L4bRMWO7QyhJRnEcskA5HMvGoL3OFBtlvaT+ohvsObL+csIx
 PMNQu6EIGAi+NZxsWg4Wctx6fAw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f24e24cba6d142d1cdfc71e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 03:32:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0F653C43391; Sat,  1 Aug 2020 03:32:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BAF0C433CB;
        Sat,  1 Aug 2020 03:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BAF0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3 6/6] interconnect: qcom: Fix small BW votes being truncated to zero
Date:   Fri, 31 Jul 2020 20:32:15 -0700
Message-Id: <20200801033215.1440-7-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200801033215.1440-1-mdtipton@codeaurora.org>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
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
index be7660b95ccc..887d13721e52 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -54,8 +54,20 @@ static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
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
@@ -63,22 +75,21 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 
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
 
 		temp = agg_avg[bucket] * bcm->vote_scale;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_x[bucket] = temp;
+		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
-		do_div(temp, bcm->aux_data.unit);
-		bcm->vote_y[bucket] = temp;
+		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

