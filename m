Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C60153094
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBEM0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:26:46 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:57745 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgBEM0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 07:26:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580905604; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=x+iZQ9XzDcSMxhDrHJl3nh+DtwFljq054K315F2nuJg=; b=meLvdP9yfIBgBWdtWgVSmImNxG6JtL8BK0OGm55W1epR35g5Bx0ZyafUKsxmRQgAdXw2IDeX
 +8B7oX+rbmz6Y5KGctct3fIbNiv+nBTGzcTwTMYio3uBVRD1k1QpdXW/+sk8xpL3WwTVfP76
 T7CrXNEHqblNzVFP+OBFotigT8c=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ab482.7ff3e452b3e8-smtp-out-n03;
 Wed, 05 Feb 2020 12:26:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73A2CC447AD; Wed,  5 Feb 2020 12:26:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83D9EC447A2;
        Wed,  5 Feb 2020 12:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83D9EC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v4 2/6] drivers: qcom: rpmh: remove rpmh_flush export
Date:   Wed,  5 Feb 2020 17:56:08 +0530
Message-Id: <1580905572-22712-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
References: <1580905572-22712-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

rpmh_flush() was exported with the idea that an external entity
operation during CPU idle would know when to flush the sleep and wake
TCS. Since, this is not the case when defining a power domain for the
RSC. Remove the function export and instead allow the function to be
called internally.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh.c          | 18 ++++++++----------
 include/soc/qcom/rpmh.h          |  5 -----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index a7bbbb6..6eec32b 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -110,5 +110,6 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
+int rpmh_flush(struct rpmh_ctrlr *ctrlr);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 3a4579d..eb0ded0 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -427,11 +427,10 @@ static int is_req_valid(struct cache_req *req)
 		req->sleep_val != req->wake_val);
 }
 
-static int send_single(const struct device *dev, enum rpmh_state state,
+static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
 		       u32 addr, u32 data)
 {
-	DEFINE_RPMH_MSG_ONSTACK(dev, state, NULL, rpm_msg);
-	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	DEFINE_RPMH_MSG_ONSTACK(NULL, state, NULL, rpm_msg);
 
 	/* Wake sets are always complete and sleep sets are not */
 	rpm_msg.msg.wait_for_compl = (state == RPMH_WAKE_ONLY_STATE);
@@ -445,7 +444,7 @@ static int send_single(const struct device *dev, enum rpmh_state state,
 /**
  * rpmh_flush: Flushes the buffered active and sleep sets to TCS
  *
- * @dev: The device making the request
+ * @ctrlr: controller making request to flush cached data
  *
  * Return: -EBUSY if the controller is busy, probably waiting on a response
  * to a RPMH request sent earlier.
@@ -454,10 +453,9 @@ static int send_single(const struct device *dev, enum rpmh_state state,
  * that is powering down the entire system. Since no other RPMH API would be
  * executing at this time, it is safe to run lockless.
  */
-int rpmh_flush(const struct device *dev)
+int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 {
 	struct cache_req *p;
-	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	int ret;
 
 	if (!ctrlr->dirty) {
@@ -480,11 +478,12 @@ int rpmh_flush(const struct device *dev)
 				 __func__, p->addr, p->sleep_val, p->wake_val);
 			continue;
 		}
-		ret = send_single(dev, RPMH_SLEEP_STATE, p->addr, p->sleep_val);
+		ret = send_single(ctrlr, RPMH_SLEEP_STATE, p->addr,
+				  p->sleep_val);
 		if (ret)
 			return ret;
-		ret = send_single(dev, RPMH_WAKE_ONLY_STATE,
-				  p->addr, p->wake_val);
+		ret = send_single(ctrlr, RPMH_WAKE_ONLY_STATE, p->addr,
+				  p->wake_val);
 		if (ret)
 			return ret;
 	}
@@ -493,7 +492,6 @@ int rpmh_flush(const struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL(rpmh_flush);
 
 /**
  * rpmh_invalidate: Invalidate all sleep and active sets
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 619e07c..f9ec353 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -20,8 +20,6 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 *n);
 
-int rpmh_flush(const struct device *dev);
-
 int rpmh_invalidate(const struct device *dev);
 
 #else
@@ -40,9 +38,6 @@ static inline int rpmh_write_batch(const struct device *dev,
 				   const struct tcs_cmd *cmd, u32 *n)
 { return -ENODEV; }
 
-static inline int rpmh_flush(const struct device *dev)
-{ return -ENODEV; }
-
 static inline int rpmh_invalidate(const struct device *dev)
 { return -ENODEV; }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
