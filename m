Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F75C0B1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 17:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfGAPxw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 11:53:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfGAPxw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 11:53:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3D83607B9; Mon,  1 Jul 2019 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561996430;
        bh=ZHFRcUfkmA8gyffOLFCQIwfLpo0nfmJ6jPhQbS4fLaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvGvhaCnraYanqxrjT2yQxDTXekQzXoGCmt4ugzgSHdiQFodZjHAsgiG/cqL5zenC
         rvNhfOdFep0zCV4tR/KuZ+r8R4m56FN8dZdPXgNj9yVMpz/4Ess2WOP+HY/mvb1f/D
         U3K78oJldlovACDp03FrHsCl6FrIPdb4bzuoSTcM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D3C9602F8;
        Mon,  1 Jul 2019 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561996430;
        bh=ZHFRcUfkmA8gyffOLFCQIwfLpo0nfmJ6jPhQbS4fLaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvGvhaCnraYanqxrjT2yQxDTXekQzXoGCmt4ugzgSHdiQFodZjHAsgiG/cqL5zenC
         rvNhfOdFep0zCV4tR/KuZ+r8R4m56FN8dZdPXgNj9yVMpz/4Ess2WOP+HY/mvb1f/D
         U3K78oJldlovACDp03FrHsCl6FrIPdb4bzuoSTcM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D3C9602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 1 Jul 2019 09:53:49 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, swboyd@chromium.org,
        dianders@chromium.org, mkshah@codeaurora.org
Subject: Re: [PATCH 2/2] drivers: qcom: rpmh-rsc: fix read back of trigger
 register
Message-ID: <20190701155349.GD24030@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
 <20190701152907.16407-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190701152907.16407-2-ilina@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switching Andy's email address.

On Mon, Jul 01 2019 at 09:32 -0600, Lina Iyer wrote:
>When triggering a TCS to send its contents, reading back the trigger
>value may return an incorrect value. That is because, writing the
>trigger may raise an interrupt which could be handled immediately and
>the trigger value could be reset in the interrupt handler. By doing a
>read back we may end up spinning waiting for the value we wrote.
>
>Fixes: 658628 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM
>SoCs")
>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/soc/qcom/rpmh-rsc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>index 92461311aef3..2fc2fa879480 100644
>--- a/drivers/soc/qcom/rpmh-rsc.c
>+++ b/drivers/soc/qcom/rpmh-rsc.c
>@@ -300,7 +300,7 @@ static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
> 	enable = TCS_AMC_MODE_ENABLE;
> 	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> 	enable |= TCS_AMC_MODE_TRIGGER;
>-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
>+	write_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, enable);
> }
>
> static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
