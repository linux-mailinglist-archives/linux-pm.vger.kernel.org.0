Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E191C489C
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDUym (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:54:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53904 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgEDUym (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:54:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588625681; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9ahIoLZuf4i2vmDOgmcd4PuOw+1RXCAR/V4fKZiimv8=;
 b=CTZEzCwqPWduRyqgIDZvlis2oaR6se3Q5OrjKL02OdaZv5xobK+x484GgxQ2YviByvkjbxTx
 oDQer1J0kN0XUuZ8gCZUZg3HeIZT8hLe2SsGpYIQMiYJf03oLs+7WfPJfKR5Rv7ekAjKPUs9
 iP3/vu3ZSI7kw0OBqBBI4Z/IGXE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb08106.7ff0eebd0110-smtp-out-n03;
 Mon, 04 May 2020 20:54:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13064C4478F; Mon,  4 May 2020 20:54:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 59778C433D2;
        Mon,  4 May 2020 20:54:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:24:27 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
In-Reply-To: <20200424155404.10746-7-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org>
Message-ID: <edfbab40a72724470ec9f4a16bfb3c67@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-24 21:24, Georgi Djakov wrote:
> If the OPP bandwidth values are populated, we want to switch also the
> interconnect bandwidth in addition to frequency and voltage.
> 

https://patchwork.kernel.org/patch/11527571/

Scaling from set_rate or using ^^
to set bw levels, I'm fine with
both.

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed review comments from Viresh.
> 
> v2: 
> https://lore.kernel.org/r/20190423132823.7915-5-georgi.djakov@linaro.org
> 
>  drivers/opp/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 8e86811eb7b2..66a8ea10f3de 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -808,7 +808,7 @@ int dev_pm_opp_set_rate(struct device *dev,
...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
