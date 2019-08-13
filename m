Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF68B259
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfHMI0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 04:26:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfHMI0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 04:26:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FB3860A24; Tue, 13 Aug 2019 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684769;
        bh=ywXBBWxMTJ6nEUmFDL5tcAalqszcOwF+FOJjszNDL4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iycE6UXAzhgJ2NQW63Hb1jrDnnsZzkdlnskCzo6sDkbr4f8teSJjCti0CZHXYBR0D
         ZNTrycF6/TpfdtBPZYccqAYKuHI2lqiaKdIktPm36jGHgTLX1KFJvx5Ciz5VZtmVe8
         o/Y9H152BUN+ktxAa0wEivqx0TpSsj5lUD5aNRxo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D287B60909;
        Tue, 13 Aug 2019 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684766;
        bh=ywXBBWxMTJ6nEUmFDL5tcAalqszcOwF+FOJjszNDL4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAIuNpwHyb8CsQCLnMAe+wPf8F0DDODNAew3cep8H4njKQZwRyZve+5CPkb5Kw/Fo
         OjBG4u3IBQqA4oKM6nm4UOCrwbxj4CtdTE5koG+ULPpK+QKpxmc65UC4kX8XANATHZ
         XHOwa5Y3VPUZiz9ajdHUvGWSVFlOfzpd4hSXj740=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D287B60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 2/4] drivers: qcom: rpmh: remove rpmh_flush export
Date:   Tue, 13 Aug 2019 13:54:40 +0530
Message-Id: <20190813082442.25796-3-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813082442.25796-1-mkshah@codeaurora.org>
References: <20190813082442.25796-1-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 drivers/soc/qcom/rpmh-internal.h |  1 +
 drivers/soc/qcom/rpmh.c          | 18 ++++++++----------
 include/soc/qcom/rpmh.h          |  5 -----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index a7bbbb67991c..6eec32b97f83 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -110,5 +110,6 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 int rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
+int rpmh_flush(struct rpmh_ctrlr *ctrlr);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 3a4579d056a4..eb0ded059d2e 100644
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
index 619e07c75da9..f9ec353d24a5 100644
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

