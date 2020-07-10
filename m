Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D815621AE4E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 07:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgGJFFc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 01:05:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52083 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgGJFFb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 01:05:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594357530; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2wFkL9OS2RcOtL39cOkIS2ykYHuyTYSSD7UIeIv226A=; b=fgO/b9RhBWglFCukmLDT1MIJx82BN65973EuUoRw+I937gPLxHBdHHQYBRQLYcI9my0q8s3b
 C3sb8QaJuKLRQFTnJgfDq36/alJwpFqE3uorjLrE+sl/JecaTwa2x4X/cmvoFdNR5s0mp8ra
 qsMPPnY1MKlHWmFQa62FcuRjPY0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f07f6fac431f7323bff1ebb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 05:04:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8813EC433A1; Fri, 10 Jul 2020 05:04:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.117] (ip70-179-20-127.sd.sd.cox.net [70.179.20.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7607FC433C8;
        Fri, 10 Jul 2020 05:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7607FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
Subject: Re: [PATCH 2/4] interconnect: Add get_bw() callback
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org
Cc:     saravanak@google.com, okukatla@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200709110705.30359-1-georgi.djakov@linaro.org>
 <20200709110705.30359-3-georgi.djakov@linaro.org>
From:   Mike Tipton <mdtipton@codeaurora.org>
Message-ID: <cb0d8879-9ded-1118-65c3-cb1d2ea519e1@codeaurora.org>
Date:   Thu, 9 Jul 2020 22:04:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709110705.30359-3-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/9/2020 4:07 AM, Georgi Djakov wrote:
> The interconnect controller hardware may support querying the current
> bandwidth settings, so add a callback for providers to implement this
> functionality if supported.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/core.c           | 3 ++-
>   include/linux/interconnect-provider.h | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index e53adfee1ee3..edbfe8380e83 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -926,7 +926,8 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>   	list_add_tail(&node->node_list, &provider->nodes);
>   
>   	/* get the bandwidth value and sync it with the hardware */
> -	if (node->init_bw && provider->set) {
> +	if (provider->get_bw && provider->set) {
> +		provider->get_bw(node, &node->init_bw);

I'm not sure what benefit this callback provides over the provider 
directly setting init_bw in the structure. Additionally, "get_bw" is a 
more generic callback than just for getting the *initial* BW 
requirement. Currently it's only used that way, but staying true to the 
spirit of the callback would require us to return the current BW at any 
point in time.

We can only detect the current HW vote at BCM-level granularity and a 
single BCM can have many nodes. So since this callback is being used to 
determine init_bw, we'd end up voting way more nodes than necessary. In 
practice we'll only need to enforce minimum initial BW on a small subset 
of them, but I wouldn't want to hardcode that init-specific logic in a 
generic "get_bw" callback.

>   		node->peak_bw = node->init_bw;
>   		provider->set(node, node);
>   	}
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 153fb7616f96..329eccb19f58 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -38,6 +38,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
>    * @aggregate: pointer to device specific aggregate operation function
>    * @pre_aggregate: pointer to device specific function that is called
>    *		   before the aggregation begins (optional)
> + * @get_bw: pointer to device specific function to get current bandwidth
>    * @xlate: provider-specific callback for mapping nodes from phandle arguments
>    * @dev: the device this interconnect provider belongs to
>    * @users: count of active users
> @@ -50,6 +51,7 @@ struct icc_provider {
>   	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
>   			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>   	void (*pre_aggregate)(struct icc_node *node);
> +	int (*get_bw)(struct icc_node *node, u32 *bw);
>   	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
>   	struct device		*dev;
>   	int			users;
> 
