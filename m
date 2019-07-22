Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8929570C13
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 23:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfGVVxy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 17:53:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfGVVxy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 17:53:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8AA8C616B9; Mon, 22 Jul 2019 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832433;
        bh=be9/QsL0swCk3x3llqIibWSVJSbE8k9VDv03K/wu/Fc=;
        h=From:To:Cc:Subject:Date:From;
        b=NTlEin5mIThygbNaJX/yGWRbwSku1nLraSYm8sQmFu3Kb7rWrO+Q3FuSPI59T18QY
         UQTl/WTjhZAeFFwtH5am8sHqJ49BuYeZy65ZbPZU1nMunwVNymTu+Sg7aPzVrVVw42
         ut8Of7huOXAwof3USLZy59CQ2zarSmFf1tJrGIc0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3112B604BE;
        Mon, 22 Jul 2019 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563832433;
        bh=be9/QsL0swCk3x3llqIibWSVJSbE8k9VDv03K/wu/Fc=;
        h=From:To:Cc:Subject:Date:From;
        b=NTlEin5mIThygbNaJX/yGWRbwSku1nLraSYm8sQmFu3Kb7rWrO+Q3FuSPI59T18QY
         UQTl/WTjhZAeFFwtH5am8sHqJ49BuYeZy65ZbPZU1nMunwVNymTu+Sg7aPzVrVVw42
         ut8Of7huOXAwof3USLZy59CQ2zarSmFf1tJrGIc0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3112B604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, swboyd@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH V2 1/4] drivers: qcom: rpmh-rsc: simplify TCS locking
Date:   Mon, 22 Jul 2019 15:53:37 -0600
Message-Id: <20190722215340.3071-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

The tcs->lock was introduced to serialize access with in TCS group. But,
drv->lock is still needed to synchronize core aspects of the
communication. This puts the drv->lock in the critical and high latency
path of sending a request. drv->lock provides the all necessary
synchronization. So remove locking around TCS group and simply use the
drv->lock instead.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
[ilina: split patch into multiple files, update commit text]
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v2:
    - Split the patches into multiple
	- Optimzation to remove reundant TCS access
	- Split the rpmh library changes into its own patch
	- Remove locks in IRQ handler
    - Update commit text
    - Remove fixes in commit text
---
 drivers/soc/qcom/rpmh-internal.h |  2 --
 drivers/soc/qcom/rpmh-rsc.c      | 32 ++++++++++++--------------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index a7bbbb67991c..969d5030860e 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -28,7 +28,6 @@ struct rsc_drv;
  * @offset:    start of the TCS group relative to the TCSes in the RSC
  * @num_tcs:   number of TCSes in this type
  * @ncpt:      number of commands in each TCS
- * @lock:      lock for synchronizing this TCS writes
  * @req:       requests that are sent from the TCS
  * @cmd_cache: flattened cache of cmds in sleep/wake TCS
  * @slots:     indicates which of @cmd_addr are occupied
@@ -40,7 +39,6 @@ struct tcs_group {
 	u32 offset;
 	int num_tcs;
 	int ncpt;
-	spinlock_t lock;
 	const struct tcs_request *req[MAX_TCS_PER_TYPE];
 	u32 *cmd_cache;
 	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e278fc11fe5c..5ede8d6de3ad 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -106,26 +106,26 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
 {
 	int m;
 	struct tcs_group *tcs;
+	int ret = 0;
 
 	tcs = get_tcs_of_type(drv, type);
 
-	spin_lock(&tcs->lock);
-	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
-		spin_unlock(&tcs->lock);
-		return 0;
-	}
+	spin_lock(&drv->lock);
+	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
+		goto done_invalidate;
 
 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
 		if (!tcs_is_free(drv, m)) {
-			spin_unlock(&tcs->lock);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto done_invalidate;
 		}
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
 	}
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
-	spin_unlock(&tcs->lock);
 
+done_invalidate:
+	spin_unlock(&drv->lock);
 	return 0;
 }
 
@@ -349,41 +349,35 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id;
-	unsigned long flags;
 	int ret;
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irqsave(&tcs->lock, flags);
 	spin_lock(&drv->lock);
 	/*
 	 * The h/w does not like if we send a request to the same address,
 	 * when one is already in-flight or being processed.
 	 */
 	ret = check_for_req_inflight(drv, tcs, msg);
-	if (ret) {
-		spin_unlock(&drv->lock);
+	if (ret)
 		goto done_write;
-	}
 
 	tcs_id = find_free_tcs(tcs);
 	if (tcs_id < 0) {
 		ret = tcs_id;
-		spin_unlock(&drv->lock);
 		goto done_write;
 	}
 
 	tcs->req[tcs_id - tcs->offset] = msg;
 	set_bit(tcs_id, drv->tcs_in_use);
-	spin_unlock(&drv->lock);
 
 	__tcs_buffer_write(drv, tcs_id, 0, msg);
 	__tcs_trigger(drv, tcs_id);
 
 done_write:
-	spin_unlock_irqrestore(&tcs->lock, flags);
+	spin_unlock(&drv->lock);
 	return ret;
 }
 
@@ -481,19 +475,18 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id = 0, cmd_id = 0;
-	unsigned long flags;
 	int ret;
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irqsave(&tcs->lock, flags);
+	spin_lock(&drv->lock);
 	/* find the TCS id and the command in the TCS to write to */
 	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
 	if (!ret)
 		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
-	spin_unlock_irqrestore(&tcs->lock, flags);
+	spin_unlock(&drv->lock);
 
 	return ret;
 }
@@ -584,7 +577,6 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 		tcs->type = tcs_cfg[i].type;
 		tcs->num_tcs = tcs_cfg[i].n;
 		tcs->ncpt = ncpt;
-		spin_lock_init(&tcs->lock);
 
 		if (!tcs->num_tcs || tcs->type == CONTROL_TCS)
 			continue;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

