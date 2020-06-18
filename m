Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F331FF29B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgFRNG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 09:06:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:60752 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729709AbgFRNGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 09:06:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592485583; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hMRM2QVP/ewY7wLU63zjCcKd42Mc9s6EEHHa9yVORQk=; b=KJRsqVNk85Zs/lWU7GpQjFJM+3ZickYTfYNlsC0LH+ls9PyYv/Sr4bgLvsOj3pzzoRM/LSrn
 auKGeg8JwINFpIWIRnimklO6tPXdcFBfrgKkTaNuwC8CBi65Yz5HPhxJX/TfiWPuBuvfEMC3
 WYC9twzSgpZnTT7Qlzme3ScxRmQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5eeb66c8ad153efa3425df8e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 13:06:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC7B2C43391; Thu, 18 Jun 2020 13:06:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D58D8C433C8;
        Thu, 18 Jun 2020 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D58D8C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] soc: qcom: rpmh: Update rpmh_invalidate function to return void
Date:   Thu, 18 Jun 2020 18:35:53 +0530
Message-Id: <1592485553-29163-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently rpmh_invalidate() always returns success. Update its
return type to void.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 6 +-----
 drivers/soc/qcom/rpmh.c               | 4 +---
 include/soc/qcom/rpmh.h               | 7 ++++---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 2a11a63..a3d2ef1 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -266,11 +266,7 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 	if (!commit_idx[0])
 		goto out;
 
-	ret = rpmh_invalidate(voter->dev);
-	if (ret) {
-		pr_err("Error invalidating RPMH client (%d)\n", ret);
-		goto out;
-	}
+	rpmh_invalidate(voter->dev);
 
 	ret = rpmh_write_batch(voter->dev, RPMH_ACTIVE_ONLY_STATE,
 			       cmds, commit_idx);
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index f2b5b46c..b61e183 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -497,7 +497,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
  *
  * Invalidate the sleep and wake values in batch_cache.
  */
-int rpmh_invalidate(const struct device *dev)
+void rpmh_invalidate(const struct device *dev)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	struct batch_cache_req *req, *tmp;
@@ -509,7 +509,5 @@ int rpmh_invalidate(const struct device *dev)
 	INIT_LIST_HEAD(&ctrlr->batch_cache);
 	ctrlr->dirty = true;
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
-
-	return 0;
 }
 EXPORT_SYMBOL(rpmh_invalidate);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index f9ec353..bdbee1a 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -20,7 +20,7 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 *n);
 
-int rpmh_invalidate(const struct device *dev);
+void rpmh_invalidate(const struct device *dev);
 
 #else
 
@@ -38,8 +38,9 @@ static inline int rpmh_write_batch(const struct device *dev,
 				   const struct tcs_cmd *cmd, u32 *n)
 { return -ENODEV; }
 
-static inline int rpmh_invalidate(const struct device *dev)
-{ return -ENODEV; }
+static inline void rpmh_invalidate(const struct device *dev)
+{
+}
 
 #endif /* CONFIG_QCOM_RPMH */
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

