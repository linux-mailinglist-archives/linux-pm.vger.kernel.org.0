Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A505070C20
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfGVVyG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 17:54:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfGVVx4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 17:53:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B57696178B; Mon, 22 Jul 2019 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832435;
        bh=68C2u8fpsqFhT6IQyKhGhREqY4z0D2JwTGvXninivrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBMZhOKFMKlHm8XM2/zAkcHXBeuOu4OLdVAF6gZ/o6JZQONZUeoOGqRMOxfQv7F7j
         OkJWx6/JyDORDJqHq+MhOzk5/KZ7BwlIDsECVdU/5yjyLUpZaPyBeRNdbVxwf9ICuy
         OMipWyLgsP/A+eRsIOdbN3fAtZ1NznE7pNJ37MXM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EB4F615E6;
        Mon, 22 Jul 2019 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832435;
        bh=68C2u8fpsqFhT6IQyKhGhREqY4z0D2JwTGvXninivrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBMZhOKFMKlHm8XM2/zAkcHXBeuOu4OLdVAF6gZ/o6JZQONZUeoOGqRMOxfQv7F7j
         OkJWx6/JyDORDJqHq+MhOzk5/KZ7BwlIDsECVdU/5yjyLUpZaPyBeRNdbVxwf9ICuy
         OMipWyLgsP/A+eRsIOdbN3fAtZ1NznE7pNJ37MXM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EB4F615E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, swboyd@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH V2 3/4] drivers: qcom: rpmh: switch over from spinlock irq variants
Date:   Mon, 22 Jul 2019 15:53:39 -0600
Message-Id: <20190722215340.3071-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722215340.3071-1-ilina@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

Switch over from using _irqsave/_irqrestore variants since we no longer
race with a lock from the interrupt handler. While we are at it, rename
the cache_lock to just lock to allow use of the lock to synchronize
controller access.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  4 ++--
 drivers/soc/qcom/rpmh-rsc.c      |  2 +-
 drivers/soc/qcom/rpmh.c          | 21 ++++++++-------------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 969d5030860e..93d59db435bb 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -67,13 +67,13 @@ struct rpmh_request {
  * struct rpmh_ctrlr: our representation of the controller
  *
  * @cache: the list of cached requests
- * @cache_lock: synchronize access to the cache data
+ * @lock: synchronize access to the controller data
  * @dirty: was the cache updated since flush
  * @batch_cache: Cache sleep and wake requests sent as batch
  */
 struct rpmh_ctrlr {
 	struct list_head cache;
-	spinlock_t cache_lock;
+	spinlock_t lock;
 	bool dirty;
 	struct list_head batch_cache;
 };
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 694ba881624e..add5e84751c9 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -656,7 +656,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	/* Enable the active TCS to send requests immediately */
 	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
 
-	spin_lock_init(&drv->client.cache_lock);
+	spin_lock_init(&drv->client.lock);
 	INIT_LIST_HEAD(&drv->client.cache);
 	INIT_LIST_HEAD(&drv->client.batch_cache);
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 035091fd44b8..d6fb254a4b57 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -118,9 +118,8 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 					   struct tcs_cmd *cmd)
 {
 	struct cache_req *req;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->lock);
 	req = __find_req(ctrlr, cmd->addr);
 	if (req)
 		goto existing;
@@ -154,7 +153,7 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 
 	ctrlr->dirty = true;
 unlock:
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->lock);
 
 	return req;
 }
@@ -283,23 +282,20 @@ EXPORT_SYMBOL(rpmh_write);
 
 static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->lock);
 	list_add_tail(&req->list, &ctrlr->batch_cache);
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->lock);
 }
 
 static int flush_batch(struct rpmh_ctrlr *ctrlr)
 {
 	struct batch_cache_req *req;
 	const struct rpmh_request *rpm_msg;
-	unsigned long flags;
 	int ret = 0;
 	int i;
 
 	/* Send Sleep/Wake requests to the controller, expect no response */
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->lock);
 	list_for_each_entry(req, &ctrlr->batch_cache, list) {
 		for (i = 0; i < req->count; i++) {
 			rpm_msg = req->rpm_msgs + i;
@@ -309,7 +305,7 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 				break;
 		}
 	}
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->lock);
 
 	return ret;
 }
@@ -317,13 +313,12 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
 static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
 {
 	struct batch_cache_req *req, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	spin_lock(&ctrlr->lock);
 	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
 		kfree(req);
 	INIT_LIST_HEAD(&ctrlr->batch_cache);
-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+	spin_unlock(&ctrlr->lock);
 }
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

