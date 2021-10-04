Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10371420AE5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJDMbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 08:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhJDMbY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Oct 2021 08:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4658C611F0;
        Mon,  4 Oct 2021 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633350575;
        bh=oCtFEAWJjcmkfj0mvzoc76dWPQAtKadeKfZmqR7yG7s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R6+m6Ki6TkjdwXplaCn73CUz0UuAzkoWgK1bd2l1kLbodSO2a4cuUiaWZXODRFMIQ
         CrfKYwrrMsnaTdcAr2UD4ONa4ycJE3SnNJl/dyKkcGA5DJcPmx7QP3Sml3A6P35dwR
         t5I1xqRdeXf4IFs7fdt6+GlcWuQ9e8rQIMQzfyxGGBF2MaxakTTBXh+pZgdVfgQpda
         8XeJohdTS/Azuu5MpMnyv+/ziKaax8ZmAjclhxXMbFCB3FdJ9j9faZ6cLcGNb36i+a
         MTlxi+CYIes9mTE3T/T0UOAMXG8hkdBJAFHf2pinkn15S1MVKOFdW2R6GsgKqp81Bo
         t/ePLz+jBLaUg==
Message-ID: <bc2e5c1a-be92-d9c2-08ca-52f4901c7c22@kernel.org>
Date:   Mon, 4 Oct 2021 15:29:31 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: qcom: Fix endianness in an intermediate
 storage
Content-Language: en-US
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210930122254.8899-1-vladimir.zapolskiy@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20210930122254.8899-1-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vladimir,

Thanks for working on this!

On 30.09.21 15:22, Vladimir Zapolskiy wrote:
> A minor issue is reported by sparse:
> 
> bcm-voter.c:72:77: warning: restricted __le16 degrades to integer
> bcm-voter.c:76:78: warning: restricted __le16 degrades to integer
> bcm-voter.c:82:66: warning: incorrect type in argument 2 (different base types)
> bcm-voter.c:82:66:    expected unsigned int [usertype] base
> bcm-voter.c:82:66:    got restricted __le32 [usertype] unit
> bcm-voter.c:85:66: warning: incorrect type in argument 2 (different base types)
> bcm-voter.c:85:66:    expected unsigned int [usertype] base
> bcm-voter.c:85:66:    got restricted __le32 [usertype] unit
> 
> icc-rpmh.c:165:28: warning: incorrect type in assignment (different base types)
> icc-rpmh.c:165:28:    expected restricted __le32 [usertype] unit
> icc-rpmh.c:165:28:    got unsigned int [usertype]
> icc-rpmh.c:166:29: warning: incorrect type in assignment (different base types)
> icc-rpmh.c:166:29:    expected restricted __le16 [usertype] width
> icc-rpmh.c:166:29:    got unsigned short [usertype]
> 
> The change is intended to be non-functional, only the stored data of
> 'struct bcm_db' is changed and build time warnings from above are gone.

Nice! But with your patch i see another sparse warning. Could you fix
it too, please?

bcm-voter.c:117:21: warning: restricted __le32 degrades to integer
bcm-voter.c:117:21: warning: restricted __le32 degrades to integer

Thanks,
Georgi

> 
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---
>   drivers/interconnect/qcom/bcm-voter.c | 8 ++++----
>   drivers/interconnect/qcom/icc-rpmh.c  | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index 8f385f9c2dd3..976938a84bd1 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -69,20 +69,20 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>   	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
>   		for (i = 0; i < bcm->num_nodes; i++) {
>   			node = bcm->nodes[i];
> -			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
> +			temp = bcm_div(node->sum_avg[bucket] * le16_to_cpu(bcm->aux_data.width),
>   				       node->buswidth * node->channels);
>   			agg_avg[bucket] = max(agg_avg[bucket], temp);
>   
> -			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
> +			temp = bcm_div(node->max_peak[bucket] * le16_to_cpu(bcm->aux_data.width),
>   				       node->buswidth);
>   			agg_peak[bucket] = max(agg_peak[bucket], temp);
>   		}
>   
>   		temp = agg_avg[bucket] * bcm->vote_scale;
> -		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
> +		bcm->vote_x[bucket] = bcm_div(temp, le32_to_cpu(bcm->aux_data.unit));
>   
>   		temp = agg_peak[bucket] * bcm->vote_scale;
> -		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
> +		bcm->vote_y[bucket] = bcm_div(temp, le32_to_cpu(bcm->aux_data.unit));
>   	}
>   
>   	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 3eb7936d2cf6..e8533027ce38 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -162,8 +162,8 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
>   		return -EINVAL;
>   	}
>   
> -	bcm->aux_data.unit = le32_to_cpu(data->unit);
> -	bcm->aux_data.width = le16_to_cpu(data->width);
> +	bcm->aux_data.unit = data->unit;
> +	bcm->aux_data.width = data->width;
>   	bcm->aux_data.vcd = data->vcd;
>   	bcm->aux_data.reserved = data->reserved;
>   	INIT_LIST_HEAD(&bcm->list);
> 

