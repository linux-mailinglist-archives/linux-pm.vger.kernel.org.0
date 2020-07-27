Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAD22F2F5
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgG0Orm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 10:47:42 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11505 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728815AbgG0Orm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 10:47:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595861261; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TPb15OCnOsAowfP2BhokEuD7cKnbaHb+UsLNuqo/luU=; b=ZcJcgrZ9nvJzTpphNmUlmxQV6XblCwURm67FEBIlHRqXIXJHZgYQ00H3tsKv19XAT/ikepxj
 IIj4BFtNX45qvE/RYE8A8W49PZVIhcJGrVuhRsaQfTcwWrRKGlkca5D8t9mpQcZrdQPX8sxN
 xSbDQR50xoz/HG2tubt0f88L2f4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f1ee90d634c4259e3b01e2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 14:47:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20EDDC43391; Mon, 27 Jul 2020 14:47:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14B37C433C6;
        Mon, 27 Jul 2020 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14B37C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 2/6] interconnect: qcom: Implement xlate_extended() to
 parse tags
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org
References: <20200723130942.28491-1-georgi.djakov@linaro.org>
 <20200723130942.28491-3-georgi.djakov@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <9bb9aa9c-b9da-ffb3-01e8-0e1ebece18a9@codeaurora.org>
Date:   Mon, 27 Jul 2020 20:17:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200723130942.28491-3-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

Thanks for the patch!

On 7/23/20 6:39 PM, Georgi Djakov wrote:
> Implement a function to parse the arguments of the "interconnects" DT
> property and populate the interconnect path tags if this information
> is available.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpmh.c | 27 +++++++++++++++++++++++++++
>   drivers/interconnect/qcom/icc-rpmh.h |  1 +
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 3ac5182c9ab2..44144fabec32 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -6,6 +6,8 @@
>   #include <linux/interconnect.h>
>   #include <linux/interconnect-provider.h>
>   #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
>   
>   #include "bcm-voter.h"
>   #include "icc-rpmh.h"
> @@ -92,6 +94,31 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   }
>   EXPORT_SYMBOL_GPL(qcom_icc_set);
>   
> +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
> +{
> +	struct icc_node_data *ndata;
> +	struct icc_node *node;
> +
> +	if (!spec)
> +		return ERR_PTR(-EINVAL);
> +

you could probably skip ^^ check

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> +	node = of_icc_xlate_onecell(spec, data);
> +	if (IS_ERR(node))
> +		return ERR_CAST(node);
> +
> +	ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
> +	if (!ndata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ndata->node = node;
> +
> +	if (spec->args_count == 2)
> +		ndata->tag = spec->args[1];
> +
> +	return ndata;
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
> +
>   /**
>    * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
>    * @bcm: bcm to be initialized
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 903d25e61984..1dac39bc255d 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -143,6 +143,7 @@ struct qcom_icc_desc {
>   int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   		       u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
>   int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
> +struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
>   int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
>   void qcom_icc_pre_aggregate(struct icc_node *node);
>   
> 
> 
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
