Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC021ACC3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 03:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGJB6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 21:58:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:53862 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727914AbgGJB6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 21:58:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594346283; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=F4eXeq25Q9ZWoEpyuwr/eiFhZ8aoX1bXVjTCKxaL/gc=; b=b6mZDEKI+9iavevDIb0w6nRL/okGv5PxO5cFdNKLuDUJfuKmQm30uzGPt0h0nmCLpPPMw6rN
 fDxRPe8ZjI0wTxg9CQolHD8rAu80IPWmXJ1J60JBWjIbv9YxiJwDpS1J5yQlUrQfz2zUV5bI
 e1nK/VE+vzUl54L4f6kz2TAwfJ4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f07caf4d07c1358558afff1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 01:57:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2B8A8C433A1; Fri, 10 Jul 2020 01:57:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4098BC433A0;
        Fri, 10 Jul 2020 01:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4098BC433A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH v2 3/6] interconnect: qcom: Support bcm-voter-specific TCS wait behavior
Date:   Thu,  9 Jul 2020 18:56:49 -0700
Message-Id: <20200710015652.19206-4-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200710015652.19206-1-mdtipton@codeaurora.org>
References: <20200710015652.19206-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, all bcm-voters set tcs_cmd::wait=true for the last VCD
command in each TCS (AMC, WAKE, and SLEEP). However, some bcm-voters
don't need the completion and instead need to optimize for latency. For
instance, disabling wait-for-completion in the WAKE set can decrease
resume latency and allow for certain operations to occur in parallel
with the WAKE TCS triggering. This is only safe in very specific
situations. Keep the default behavior of always waiting, but allow it to
be overridden in devicetree.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 32 ++++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a3d2ef1d9903..4bba3b42b648 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -27,6 +27,7 @@ static DEFINE_MUTEX(bcm_voter_lock);
  * @commit_list: list containing bcms to be committed to hardware
  * @ws_list: list containing bcms that have different wake/sleep votes
  * @voter_node: list of bcm voters
+ * @tcs_wait: mask for which buckets require TCS completion
  */
 struct bcm_voter {
 	struct device *dev;
@@ -35,6 +36,7 @@ struct bcm_voter {
 	struct list_head commit_list;
 	struct list_head ws_list;
 	struct list_head voter_node;
+	u32 tcs_wait;
 };
 
 static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
@@ -89,7 +91,7 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 }
 
 static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
-			       u32 addr, bool commit)
+			       u32 addr, bool commit, bool wait)
 {
 	bool valid = true;
 
@@ -114,15 +116,16 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 	 * Set the wait for completion flag on command that need to be completed
 	 * before the next command.
 	 */
-	cmd->wait = commit;
+	cmd->wait = wait;
 }
 
-static void tcs_list_gen(struct list_head *bcm_list, int bucket,
-			 struct tcs_cmd tcs_list[MAX_BCMS],
+static void tcs_list_gen(struct bcm_voter *voter, int bucket,
+			 struct tcs_cmd tcs_list[MAX_VCD],
 			 int n[MAX_VCD + 1])
 {
+	struct list_head *bcm_list = &voter->commit_list;
 	struct qcom_icc_bcm *bcm;
-	bool commit;
+	bool commit, wait;
 	size_t idx = 0, batch = 0, cur_vcd_size = 0;
 
 	memset(n, 0, sizeof(int) * (MAX_VCD + 1));
@@ -135,8 +138,11 @@ static void tcs_list_gen(struct list_head *bcm_list, int bucket,
 			commit = true;
 			cur_vcd_size = 0;
 		}
+
+		wait = commit && (voter->tcs_wait & BIT(bucket));
+
 		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
-			    bcm->vote_y[bucket], bcm->addr, commit);
+			    bcm->vote_y[bucket], bcm->addr, commit, wait);
 		idx++;
 		n[batch]++;
 		/*
@@ -261,8 +267,7 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 	 * Construct the command list based on a pre ordered list of BCMs
 	 * based on VCD.
 	 */
-	tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
-
+	tcs_list_gen(voter, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
 	if (!commit_idx[0])
 		goto out;
 
@@ -298,7 +303,7 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 
 	list_sort(NULL, &voter->commit_list, cmp_vcd);
 
-	tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
+	tcs_list_gen(voter, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
 
 	ret = rpmh_write_batch(voter->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
 	if (ret) {
@@ -306,7 +311,7 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 		goto out;
 	}
 
-	tcs_list_gen(&voter->commit_list, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
+	tcs_list_gen(voter, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
 
 	ret = rpmh_write_batch(voter->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
 	if (ret) {
@@ -325,6 +330,7 @@ EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_commit);
 
 static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct bcm_voter *voter;
 
 	voter = devm_kzalloc(&pdev->dev, sizeof(*voter), GFP_KERNEL);
@@ -332,7 +338,11 @@ static int qcom_icc_bcm_voter_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	voter->dev = &pdev->dev;
-	voter->np = pdev->dev.of_node;
+	voter->np = np;
+
+	if (of_property_read_u32(np, "qcom,tcs-wait", &voter->tcs_wait))
+		voter->tcs_wait = QCOM_ICC_TAG_ALWAYS;
+
 	mutex_init(&voter->lock);
 	INIT_LIST_HEAD(&voter->commit_list);
 	INIT_LIST_HEAD(&voter->ws_list);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

