Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117BE5C0AF
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfGAPw6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 11:52:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfGAPw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 11:52:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EAE1602F8; Mon,  1 Jul 2019 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561996377;
        bh=NWDtiNweA0CkNIej7/fSB2y/+W0hjSrP7uxYhyOM4DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHFmui+6MeWLOQ/T85e9m2lYZ+cFlBBf0UpuVHACafbnz1WYHCLwEsHL5GXHV70En
         O+OSaBDFfdO3zUvtZSJp8fHko8+ciI6mZHptDH7vsDvR6TPaPCOSX/esJ8hvSbinpb
         9br2c7uQNyLqBWKWE8Z29hjgW4XmXxGGoh2o49jo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F404B6038E;
        Mon,  1 Jul 2019 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561996376;
        bh=NWDtiNweA0CkNIej7/fSB2y/+W0hjSrP7uxYhyOM4DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6C2RKKmCceTMf67CK1c2XVbkNn+TbqZyTQ1mpRc0KWqXeYKpXc6fsJqWj0fWv5ou
         LlytgxT517tzc/9hXFRiTdBtR6KNlonMbhi/98F4Ue8w49s+sr+um/++tkAwv2SMTC
         vEXM3IRbWqYLMaFLNY4bC+2Y65+ur2sEE9cbMLGo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F404B6038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 1 Jul 2019 09:52:55 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, swboyd@chromium.org,
        dianders@chromium.org, mkshah@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH 1/2] drivers: qcom: rpmh-rsc: simplify TCS locking
Message-ID: <20190701155255.GC24030@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190701152907.16407-1-ilina@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switching Andy's email address.

On Mon, Jul 01 2019 at 09:32 -0600, Lina Iyer wrote:
>From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>
>tcs->lock was introduced to serialize access with in TCS group. But
>even without tcs->lock, drv->lock is serving the same purpose. So
>use a single drv->lock.
>
>Other optimizations include -
> - Remove locking around clear_bit() in IRQ handler. clear_bit() is
>   atomic.
> - Remove redundant read of TCS registers.
> - Use spin_lock instead of _irq variants as the locks are not held
>   in interrupt context.
>
>Fixes: 658628 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM
>SoCs")
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/soc/qcom/rpmh-internal.h |  2 --
> drivers/soc/qcom/rpmh-rsc.c      | 37 +++++++++++---------------------
> drivers/soc/qcom/rpmh.c          | 20 +++++++----------
> 3 files changed, 21 insertions(+), 38 deletions(-)
>
>diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>index a7bbbb67991c..969d5030860e 100644
>--- a/drivers/soc/qcom/rpmh-internal.h
>+++ b/drivers/soc/qcom/rpmh-internal.h
>@@ -28,7 +28,6 @@ struct rsc_drv;
>  * @offset:    start of the TCS group relative to the TCSes in the RSC
>  * @num_tcs:   number of TCSes in this type
>  * @ncpt:      number of commands in each TCS
>- * @lock:      lock for synchronizing this TCS writes
>  * @req:       requests that are sent from the TCS
>  * @cmd_cache: flattened cache of cmds in sleep/wake TCS
>  * @slots:     indicates which of @cmd_addr are occupied
>@@ -40,7 +39,6 @@ struct tcs_group {
> 	u32 offset;
> 	int num_tcs;
> 	int ncpt;
>-	spinlock_t lock;
> 	const struct tcs_request *req[MAX_TCS_PER_TYPE];
> 	u32 *cmd_cache;
> 	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
>diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>index e278fc11fe5c..92461311aef3 100644
>--- a/drivers/soc/qcom/rpmh-rsc.c
>+++ b/drivers/soc/qcom/rpmh-rsc.c
>@@ -93,8 +93,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
>
> static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
> {
>-	return !test_bit(tcs_id, drv->tcs_in_use) &&
>-	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
>+	return !test_bit(tcs_id, drv->tcs_in_use);
> }
>
> static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>@@ -104,29 +103,28 @@ static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>
> static int tcs_invalidate(struct rsc_drv *drv, int type)
> {
>-	int m;
>+	int m, ret = 0;
> 	struct tcs_group *tcs;
>
> 	tcs = get_tcs_of_type(drv, type);
>
>-	spin_lock(&tcs->lock);
>-	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
>-		spin_unlock(&tcs->lock);
>-		return 0;
>-	}
>+	spin_lock(&drv->lock);
>+	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
>+		goto done;
>
> 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> 		if (!tcs_is_free(drv, m)) {
>-			spin_unlock(&tcs->lock);
>-			return -EAGAIN;
>+			ret = -EAGAIN;
>+			goto done;
> 		}
> 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
> 		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
> 	}
> 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
>-	spin_unlock(&tcs->lock);
>
>-	return 0;
>+done:
>+	spin_unlock(&drv->lock);
>+	return ret;
> }
>
> /**
>@@ -242,9 +240,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
> 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
> 		write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
> 		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
>-		spin_lock(&drv->lock);
> 		clear_bit(i, drv->tcs_in_use);
>-		spin_unlock(&drv->lock);
> 		if (req)
> 			rpmh_tx_done(req, err);
> 	}
>@@ -349,14 +345,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
> {
> 	struct tcs_group *tcs;
> 	int tcs_id;
>-	unsigned long flags;
> 	int ret;
>
> 	tcs = get_tcs_for_msg(drv, msg);
> 	if (IS_ERR(tcs))
> 		return PTR_ERR(tcs);
>
>-	spin_lock_irqsave(&tcs->lock, flags);
> 	spin_lock(&drv->lock);
> 	/*
> 	 * The h/w does not like if we send a request to the same address,
>@@ -364,26 +358,23 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
> 	 */
> 	ret = check_for_req_inflight(drv, tcs, msg);
> 	if (ret) {
>-		spin_unlock(&drv->lock);
> 		goto done_write;
> 	}
>
> 	tcs_id = find_free_tcs(tcs);
> 	if (tcs_id < 0) {
> 		ret = tcs_id;
>-		spin_unlock(&drv->lock);
> 		goto done_write;
> 	}
>
> 	tcs->req[tcs_id - tcs->offset] = msg;
> 	set_bit(tcs_id, drv->tcs_in_use);
>-	spin_unlock(&drv->lock);
>
> 	__tcs_buffer_write(drv, tcs_id, 0, msg);
> 	__tcs_trigger(drv, tcs_id);
>
> done_write:
>-	spin_unlock_irqrestore(&tcs->lock, flags);
>+	spin_unlock(&drv->lock);
> 	return ret;
> }
>
>@@ -481,19 +472,18 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
> {
> 	struct tcs_group *tcs;
> 	int tcs_id = 0, cmd_id = 0;
>-	unsigned long flags;
> 	int ret;
>
> 	tcs = get_tcs_for_msg(drv, msg);
> 	if (IS_ERR(tcs))
> 		return PTR_ERR(tcs);
>
>-	spin_lock_irqsave(&tcs->lock, flags);
>+	spin_lock(&drv->lock);
> 	/* find the TCS id and the command in the TCS to write to */
> 	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
> 	if (!ret)
> 		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
>-	spin_unlock_irqrestore(&tcs->lock, flags);
>+	spin_unlock(&drv->lock);
>
> 	return ret;
> }
>@@ -584,7 +574,6 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
> 		tcs->type = tcs_cfg[i].type;
> 		tcs->num_tcs = tcs_cfg[i].n;
> 		tcs->ncpt = ncpt;
>-		spin_lock_init(&tcs->lock);
>
> 		if (!tcs->num_tcs || tcs->type == CONTROL_TCS)
> 			continue;
>diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>index 035091fd44b8..12f830610b94 100644
>--- a/drivers/soc/qcom/rpmh.c
>+++ b/drivers/soc/qcom/rpmh.c
>@@ -118,9 +118,8 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
> 					   struct tcs_cmd *cmd)
> {
> 	struct cache_req *req;
>-	unsigned long flags;
>
>-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
>+	spin_lock(&ctrlr->cache_lock);
> 	req = __find_req(ctrlr, cmd->addr);
> 	if (req)
> 		goto existing;
>@@ -154,7 +153,7 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>
> 	ctrlr->dirty = true;
> unlock:
>-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>+	spin_unlock(&ctrlr->cache_lock);
>
> 	return req;
> }
>@@ -283,23 +282,21 @@ EXPORT_SYMBOL(rpmh_write);
>
> static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
> {
>-	unsigned long flags;
>
>-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
>+	spin_lock(&ctrlr->cache_lock);
> 	list_add_tail(&req->list, &ctrlr->batch_cache);
>-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>+	spin_unlock(&ctrlr->cache_lock);
> }
>
> static int flush_batch(struct rpmh_ctrlr *ctrlr)
> {
> 	struct batch_cache_req *req;
> 	const struct rpmh_request *rpm_msg;
>-	unsigned long flags;
> 	int ret = 0;
> 	int i;
>
> 	/* Send Sleep/Wake requests to the controller, expect no response */
>-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
>+	spin_lock(&ctrlr->cache_lock);
> 	list_for_each_entry(req, &ctrlr->batch_cache, list) {
> 		for (i = 0; i < req->count; i++) {
> 			rpm_msg = req->rpm_msgs + i;
>@@ -309,7 +306,7 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
> 				break;
> 		}
> 	}
>-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>+	spin_unlock(&ctrlr->cache_lock);
>
> 	return ret;
> }
>@@ -317,13 +314,12 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
> static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
> {
> 	struct batch_cache_req *req, *tmp;
>-	unsigned long flags;
>
>-	spin_lock_irqsave(&ctrlr->cache_lock, flags);
>+	spin_lock(&ctrlr->cache_lock);
> 	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
> 		kfree(req);
> 	INIT_LIST_HEAD(&ctrlr->batch_cache);
>-	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>+	spin_unlock(&ctrlr->cache_lock);
> }
>
> /**
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
