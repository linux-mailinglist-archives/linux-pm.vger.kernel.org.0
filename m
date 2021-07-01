Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDFA3B9643
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhGAS5i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 14:57:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14643 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGAS5i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 14:57:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625165706; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KHgqtWCUqBAcSdEPitK4LKTrMWMcbdMy+WpPKXHyE30=;
 b=FxSVT1QDuOjShpdpJRWHilaUNx+/W4T25ZJApwdByEJ9YjhIW2IC4gVeZ1hnwsI+fhhbcdEv
 ApAPyjc5HuXYFZ1S+wulQsNqiJErooMdDYOPRw5DRXKrCtu+FFUnhcMUuH8jv9Lt99m1Z0vU
 BYeSkDr+MRzpYVcHlKDwn8enIbc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60de0f8aec0b18a745079612 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Jul 2021 18:55:06
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8498FC43460; Thu,  1 Jul 2021 18:55:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58071C433D3;
        Thu,  1 Jul 2021 18:55:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 02 Jul 2021 00:25:04 +0530
From:   okukatla@codeaurora.org
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton=codeaurora.org@codeaurora.org
Subject: Re: [PATCH 2/4] interconnect: Always call pre_aggregate before
 aggregate
In-Reply-To: <20210625212839.24155-3-mdtipton@codeaurora.org>
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
 <20210625212839.24155-3-mdtipton@codeaurora.org>
Message-ID: <000574efe90897c1738299cfba4fea7d@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-06-26 02:58, Mike Tipton wrote:
> The pre_aggregate callback isn't called in all cases before calling
> aggregate. Add the missing calls so providers can rely on consistent
> framework behavior.
> 
> Fixes: d3703b3e255f ("interconnect: Aggregate before setting initial 
> bandwidth")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  drivers/interconnect/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 945121e18b5c..cfd54c90a6bb 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -973,9 +973,12 @@ void icc_node_add(struct icc_node *node, struct
> icc_provider *provider)
>  	}
>  	node->avg_bw = node->init_avg;
>  	node->peak_bw = node->init_peak;
> -	if (provider->aggregate)
> +	if (provider->aggregate) {
> +		if (provider->pre_aggregate)
> +			provider->pre_aggregate(node);
nit: we can invoke pre_aggregate() out side of if (qcom_icc_aggregate).

>  		provider->aggregate(node, 0, node->init_avg, node->init_peak,
>  				    &node->avg_bw, &node->peak_bw);
> +	}
>  	provider->set(node, node);
>  	node->avg_bw = 0;
>  	node->peak_bw = 0;
