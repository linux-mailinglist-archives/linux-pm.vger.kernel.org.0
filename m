Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AD3B94F9
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGAQ7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 12:59:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53342 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhGAQ7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 12:59:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625158596; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=a6Y+UJzX51hrFbNp2BhxTJQy4FwK+otdQWbFQJKCVAo=;
 b=MMHPqNBgN7cXJsjSGL+El74Md6se60ibJzug57eLkEhqQ83qyCedlISyFIPZHnHfXYTJuUZq
 tuy5ldsL1Sunieyv3xZ+eiHYdZDvUNl7Ybx9aNrLnh64G1FKOvrjCEUaTvmsQK+5usEznpgf
 50Q4bGbahCIGNBAgKwwkdS7eko0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ddf3c3f3042986149733b6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Jul 2021 16:56:35
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5525CC433D3; Thu,  1 Jul 2021 16:56:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7763C433F1;
        Thu,  1 Jul 2021 16:56:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Jul 2021 22:26:33 +0530
From:   okukatla@codeaurora.org
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        saravanak@google.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton=codeaurora.org@codeaurora.org
Subject: Re: [PATCH 1/4] interconnect: Zero initial BW after sync-state
In-Reply-To: <20210625212839.24155-2-mdtipton@codeaurora.org>
References: <20210625212839.24155-1-mdtipton@codeaurora.org>
 <20210625212839.24155-2-mdtipton@codeaurora.org>
Message-ID: <14c52b496918900c9cb3bef662a9e833@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-06-26 02:58, Mike Tipton wrote:
> The initial BW values may be used by providers to enforce floors. Zero
> these values after sync-state so that providers know when to stop
> enforcing them.
> 
> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  drivers/interconnect/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8a1e70e00876..945121e18b5c 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1106,6 +1106,8 @@ void icc_sync_state(struct device *dev)
>  		dev_dbg(p->dev, "interconnect provider is in synced state\n");
>  		list_for_each_entry(n, &p->nodes, node_list) {
>  			if (n->init_avg || n->init_peak) {
> +				n->init_avg = 0;
> +				n->init_peak = 0;
nit: It is good to reset init/floor levels back to zero, but we don't 
need to do this as we have sync_state flag to let providers know when to 
stop enforcing.
>  				aggregate_requests(n);
>  				p->set(n, n);
>  			}
