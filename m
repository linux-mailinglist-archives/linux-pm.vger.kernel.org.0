Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956E63FDDD7
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhIAOc0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhIAOc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 10:32:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F2C061760
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 07:31:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f18so2517236lfk.12
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MyzTGgHBdb4UXbVsskL7/lTl0nOigmvBb/mL1uEUdQ8=;
        b=NGX5lM7/edC/Mh61QE7Tgdd3R6sEK9TJbozyAAqaY2gn8zbhcE+FS/LHoTFj6gZWEe
         pujif+8SdYUF6XrNvhc9hKIpC7wpRIw5k95GQonbDsii7WAwhHyTGGrdeQuAq7djx9Dt
         +xR8NmF4/pR/9ye1U98Nidg8oB0KaMBCwOkr7Y3/CS5Y2nT4mAExI0jlswROY/QffCe/
         ywCxWlWMVHO6OExgU3hxfg2D7Cfd26+DefC9qd66MUjg8vwCUNSRORiCgarfbgx/SU6L
         7BdS9swL5awlXII1UeP2Qo9mvaNuo1Ksh1yGzOdy0+XW7hgWTN33TdJOugGAQx9OeEdx
         6Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MyzTGgHBdb4UXbVsskL7/lTl0nOigmvBb/mL1uEUdQ8=;
        b=c2CD1xKGT9h+F//BnbmCTFJL1WBOpquU68a6rCXpQuNdUGYBgYZ+uOLUHI9gU9584E
         rzQx09yBQuwRsLQsGG8lmHz1IT+RHpf3OZ7J4oFO2AGUlTImyWZ5FTpR8WyIiWbmLnTD
         DFVLCa+c4ftnB4rlrLReohKB8Possre/kvGjFjpmUEhIlrXr8ywjk63HCfuOP+g+Gawa
         +FLzCdveidKO1g4c7lyI1JwW9QhHQWrmL8kM3Xg0Pf5UL1ZaoieIDEj8tQas8PgrZfUd
         XugoUT1JFve0xA1YefIyE9eYfxsidMvWUTC4g4Fs+LUH8pvdNEWhqiP77ciklOwQwvUe
         k33g==
X-Gm-Message-State: AOAM530IY+dQ8Rll4O863VPy5o1J5+WY6Pi7NBFv2HJj7a2TtOrGO8ia
        SdbrDZlCJ6sW8rThjdE0liAQSLtyE3E0Og==
X-Google-Smtp-Source: ABdhPJyeI12ATjCWraagvCx3dR1wv6RJ23LEPdkRkdUEYHeG1MSn8VJusN+OtImL97jjZ9kLLy9RUQ==
X-Received: by 2002:a05:6512:ac4:: with SMTP id n4mr18982410lfu.237.1630506687231;
        Wed, 01 Sep 2021 07:31:27 -0700 (PDT)
Received: from [192.168.43.7] ([94.25.229.122])
        by smtp.gmail.com with ESMTPSA id k8sm4194lja.57.2021.09.01.07.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 07:31:26 -0700 (PDT)
Subject: Re: [PATCH] interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY
 shift and mask
To:     Shawn Guo <shawn.guo@linaro.org>, Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210823075405.382-1-shawn.guo@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <813898c9-5ad6-a98b-35a6-58f24a7cada2@linaro.org>
Date:   Wed, 1 Sep 2021 17:31:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823075405.382-1-shawn.guo@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/08/2021 10:54, Shawn Guo wrote:
> The NOC_QOS_PRIORITY shift and mask do not match what vendor kernel
> defines [1].  Correct them per vendor kernel.
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/soc/qcom/msm_bus/msm_bus_noc_adhoc.c?h=LA.UM.8.2.r1-04800-sdm660.0#n37
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/interconnect/qcom/sdm660.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
> index ac13046537e8..c89c991a80a0 100644
> --- a/drivers/interconnect/qcom/sdm660.c
> +++ b/drivers/interconnect/qcom/sdm660.c
> @@ -44,9 +44,10 @@
>   #define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
>   
>   #define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
> -#define NOC_QOS_PRIORITY_MASK		0xf
> +#define NOC_QOS_PRIORITY_P1_MASK	0xc
> +#define NOC_QOS_PRIORITY_P0_MASK	0x3
>   #define NOC_QOS_PRIORITY_P1_SHIFT	0x2
> -#define NOC_QOS_PRIORITY_P0_SHIFT	0x3
> +#define NOC_QOS_PRIORITY_P0_SHIFT	0x0
>   
>   #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
>   #define NOC_QOS_MODEn_MASK		0x3
> @@ -624,13 +625,13 @@ static int qcom_icc_noc_set_qos_priority(struct regmap *rmap,
>   	/* Must be updated one at a time, P1 first, P0 last */
>   	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
>   	rc = regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> -				NOC_QOS_PRIORITY_MASK, val);
> +				NOC_QOS_PRIORITY_P1_MASK, val);
>   	if (rc)
>   		return rc;
>   
>   	val = qos->prio_level << NOC_QOS_PRIORITY_P0_SHIFT;
>   	return regmap_update_bits(rmap, NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
> -				  NOC_QOS_PRIORITY_MASK, val);
> +				  NOC_QOS_PRIORITY_P0_MASK, val);
>   }
>   
>   static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
> 


-- 
With best wishes
Dmitry
