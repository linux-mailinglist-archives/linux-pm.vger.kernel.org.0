Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130FE234FA0
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 05:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHADck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 23:32:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18075 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728471AbgHADck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 23:32:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596252759; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FwOsBUwW6ySFHOCeZdm5uzF0UBLnzcbxYV4r9s7dT0E=; b=LpoJO1L5uxmlHyRxDnG6s1EvnUR5dsESJ2wY8KgTRSJa01JM+3mXwToqQyVbrTG0aBHQXOA8
 ZLCJ8IEGFYe/Nfeb67c5bUfi6P39EDrqTlPriMFU9PeE67C+CQhUTXZftqHd3XonnowfSCdw
 Atgodn/fajP+zWusn6r3KHolyOk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f24e24b21feae908bf871fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 03:32:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF47BC43391; Sat,  1 Aug 2020 03:32:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1832C433C9;
        Sat,  1 Aug 2020 03:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1832C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v3 5/6] interconnect: qcom: Add support for per-BCM scaling factors
Date:   Fri, 31 Jul 2020 20:32:14 -0700
Message-Id: <20200801033215.1440-6-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200801033215.1440-1-mdtipton@codeaurora.org>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, bcm-voter always assumes requests are made in KBps and that
BCM HW always wants them in Bps, so it always scales the requests by
1000. However, certain use cases and BCMs may use different units.
Thus, add support for BCM-specific scaling factors.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 4 ++--
 drivers/interconnect/qcom/icc-rpmh.c  | 3 +++
 drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d95725b9208c..be7660b95ccc 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -72,11 +72,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 			agg_peak[bucket] = max(agg_peak[bucket], temp);
 		}
 
-		temp = agg_avg[bucket] * 1000ULL;
+		temp = agg_avg[bucket] * bcm->vote_scale;
 		do_div(temp, bcm->aux_data.unit);
 		bcm->vote_x[bucket] = temp;
 
-		temp = agg_peak[bucket] * 1000ULL;
+		temp = agg_peak[bucket] * bcm->vote_scale;
 		do_div(temp, bcm->aux_data.unit);
 		bcm->vote_y[bucket] = temp;
 	}
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3ac5182c9ab2..008846c17bec 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -136,6 +136,9 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 	INIT_LIST_HEAD(&bcm->list);
 	INIT_LIST_HEAD(&bcm->ws_list);
 
+	if (!bcm->vote_scale)
+		bcm->vote_scale = 1000;
+
 	/* Link Qnodes to their respective BCMs */
 	for (i = 0; i < bcm->num_nodes; i++) {
 		qn = bcm->nodes[i];
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index cb736b745e1a..10b1890345b1 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -80,6 +80,7 @@ struct qcom_icc_node {
  * @addr: address offsets used when voting to RPMH
  * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
  * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
+ * @vote_scale: scaling factor for vote_x and vote_y
  * @dirty: flag used to indicate whether the bcm needs to be committed
  * @keepalive: flag used to indicate whether a keepalive is required
  * @aux_data: auxiliary data used when calculating threshold values and
@@ -95,6 +96,7 @@ struct qcom_icc_bcm {
 	u32 addr;
 	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
 	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
+	u64 vote_scale;
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

