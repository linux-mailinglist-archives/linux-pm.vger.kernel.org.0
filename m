Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B531FF447
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgFROKe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jun 2020 10:10:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42563 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729110AbgFROKc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2020 10:10:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592489431; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=jjmPl8ffifdefNdsGpjiapdQuNH9tn0Yaao34JTd4R8=; b=SdwMOn5hPHW7Xmm3iZhCgkFKvKEQCULnbPaf4A/3nQRjCe42k1EbTsVjap5reDQn7IvtZk7g
 QocllmixizEt5FqHCOmwICOSm9pljtd+Z5FuZkM81i6v0LYk5yFF76xenZM/+v02TPE3WAx6
 dnnJwY2TA8iRiFVZamw4OMbezug=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5eeb75d0567385e8e7ff6a58 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Jun 2020 14:10:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0BAEAC43391; Thu, 18 Jun 2020 14:10:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF7EC433C8;
        Thu, 18 Jun 2020 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EF7EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 18 Jun 2020 08:10:21 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        lsrao@codeaurora.org
Subject: Re: [PATCH] soc: qcom: rpmh: Update rpmh_invalidate function to
 return void
Message-ID: <20200618141021.GG12942@codeaurora.org>
References: <1592485553-29163-1-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1592485553-29163-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 18 2020 at 07:06 -0600, Maulik Shah wrote:
>Currently rpmh_invalidate() always returns success. Update its
>return type to void.
>
>Suggested-by: Stephen Boyd <swboyd@chromium.org>
>Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/interconnect/qcom/bcm-voter.c | 6 +-----
> drivers/soc/qcom/rpmh.c               | 4 +---
> include/soc/qcom/rpmh.h               | 7 ++++---
> 3 files changed, 6 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
>index 2a11a63..a3d2ef1 100644
>--- a/drivers/interconnect/qcom/bcm-voter.c
>+++ b/drivers/interconnect/qcom/bcm-voter.c
>@@ -266,11 +266,7 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
> 	if (!commit_idx[0])
> 		goto out;
>
>-	ret = rpmh_invalidate(voter->dev);
>-	if (ret) {
>-		pr_err("Error invalidating RPMH client (%d)\n", ret);
>-		goto out;
>-	}
>+	rpmh_invalidate(voter->dev);
>
> 	ret = rpmh_write_batch(voter->dev, RPMH_ACTIVE_ONLY_STATE,
> 			       cmds, commit_idx);
>diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>index f2b5b46c..b61e183 100644
>--- a/drivers/soc/qcom/rpmh.c
>+++ b/drivers/soc/qcom/rpmh.c
>@@ -497,7 +497,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>  *
>  * Invalidate the sleep and wake values in batch_cache.
>  */
>-int rpmh_invalidate(const struct device *dev)
>+void rpmh_invalidate(const struct device *dev)
> {
> 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
> 	struct batch_cache_req *req, *tmp;
>@@ -509,7 +509,5 @@ int rpmh_invalidate(const struct device *dev)
> 	INIT_LIST_HEAD(&ctrlr->batch_cache);
> 	ctrlr->dirty = true;
> 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>-
>-	return 0;
> }
> EXPORT_SYMBOL(rpmh_invalidate);
>diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
>index f9ec353..bdbee1a 100644
>--- a/include/soc/qcom/rpmh.h
>+++ b/include/soc/qcom/rpmh.h
>@@ -20,7 +20,7 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
> int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> 		     const struct tcs_cmd *cmd, u32 *n);
>
>-int rpmh_invalidate(const struct device *dev);
>+void rpmh_invalidate(const struct device *dev);
>
> #else
>
>@@ -38,8 +38,9 @@ static inline int rpmh_write_batch(const struct device *dev,
> 				   const struct tcs_cmd *cmd, u32 *n)
> { return -ENODEV; }
>
>-static inline int rpmh_invalidate(const struct device *dev)
>-{ return -ENODEV; }
>+static inline void rpmh_invalidate(const struct device *dev)
>+{
>+}
>
> #endif /* CONFIG_QCOM_RPMH */
>
>-- 
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>of Code Aurora Forum, hosted by The Linux Foundation
>
