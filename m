Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68442121DD
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGBLL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgGBLL0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 07:11:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0CC08C5DC
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 04:11:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so27700213wrv.9
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2020 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EP4mIxEbTa2u7jpvr40EEMAGhOAwuykUNeTsn1WTCCk=;
        b=zFfBpLyxH6ZSt2sNv14lPq6aaA1kWUbVElWIUkMvuqR7bDo3IVlT2v2uaRUe8Gi29k
         CZLNUJOM0aUiuEGKBTY5yRMLIuAVo6GD8ha0zs5T0MR1RPn9Y6foojTjZJ+76XMnC5DL
         nKfx+bSQ0whmQP19yNleY9nDdJA6MC8bRwurC2uBVmirwPLtG2+4kFnD3Zt7OkpVDQap
         rUqr1IulYqGDTcMuUQ2lCd9DHbmwwLq8y6leC/gwCktBHhyYA4/LMjRZSAxEGyNDOrxs
         D18zfAJ5yWIlvZsRdQpv11JWQdTi9O2Q5pMooh1ZYb5VT1pB9FjbO7xCSivUpA5D6sLP
         sBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EP4mIxEbTa2u7jpvr40EEMAGhOAwuykUNeTsn1WTCCk=;
        b=NDDBNo0smaHFunI+s1EtM2dIsTCAt8VrpMpWiEZ4IF4dJ9Nt6o8iacACDqNymNg2OV
         L3gzs/ByCYFm8h1iAOG7/6IPwPSPsAThFxslqIHwuWsXyjfqgft3m5RGpKeHldErmzew
         fYfsDwMZPyhk3FBZZfkQJhiYyB8BbQZ+mwQGXn0rlm8ZRdg4rZp9W3FpgfMRhghGcQag
         H93jxdjt+hbdoxvozO/vZN+6AHO+LtCCqQJBGtd09KYKVhglpwj5NZlBljlMtvhCfgrq
         nJT3V6pKNQqRQ5XbQ9uBabpGyaKaT4MlnIv3r7q7WH2HiVW+gFSqmZYKAGRJEMz+3d0w
         lj7Q==
X-Gm-Message-State: AOAM532dLUA40+wvEh4D8jAqobYXQbqIya272kmMszOKjYVEUTTtkgia
        KP+QggXSu+qWPGSFm1alsH738A==
X-Google-Smtp-Source: ABdhPJyS5oKx0yim8v9iWhytgy1KkzBevo2CpUyPHtLaxLxwdvgkAS70IknqROe7wlPin77if/mQHg==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr30630239wrw.223.1593688284949;
        Thu, 02 Jul 2020 04:11:24 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id p8sm10418763wrq.29.2020.07.02.04.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 04:11:24 -0700 (PDT)
Subject: Re: [PATCH 4/4] interconnect: qcom: Fix small BW votes being
 truncated to zero
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200623040814.23791-1-mdtipton@codeaurora.org>
 <20200623040814.23791-5-mdtipton@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <09f21847-33bc-64fb-aeb7-df5bafa5593c@linaro.org>
Date:   Thu, 2 Jul 2020 14:11:23 +0300
MIME-Version: 1.0
In-Reply-To: <20200623040814.23791-5-mdtipton@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mike,

On 6/23/20 07:08, Mike Tipton wrote:
> Small BW votes that translate to less than a single BCM unit are
> currently truncated to zero. Ensure that non-zero BW requests always
> result in at least a vote of 1 to BCM.
> 
> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  drivers/interconnect/qcom/bcm-voter.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index a68c858ca6b7..9e2612fe7fad 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -54,8 +54,20 @@ static int cmp_vcd(void *priv, struct list_head *a, struct list_head *b)
>  		return 1;
>  }
>  
> +static u64 bcm_div(u64 num, u64 base)
> +{
> +	/* Ensure that small votes aren't lost. */
> +	if (num && num < base)
> +		return 1;
> +
> +	do_div(num, base);

do_div() does a 64-by-32 division, which will truncate these to 32-bit.

> +
> +	return num;
> +}
> +
>  static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>  {
> +	struct qcom_icc_node *node;
>  	size_t i, bucket;
>  	u64 agg_avg[QCOM_ICC_NUM_BUCKETS] = {0};
>  	u64 agg_peak[QCOM_ICC_NUM_BUCKETS] = {0};
> @@ -63,22 +75,21 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>  
>  	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
>  		for (i = 0; i < bcm->num_nodes; i++) {
> -			temp = bcm->nodes[i]->sum_avg[bucket] * bcm->aux_data.width;
> -			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
> +			node = bcm->nodes[i];
> +			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
> +				       node->buswidth * node->channels);
>  			agg_avg[bucket] = max(agg_avg[bucket], temp);
>  
> -			temp = bcm->nodes[i]->max_peak[bucket] * bcm->aux_data.width;
> -			do_div(temp, bcm->nodes[i]->buswidth);
> +			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
> +				       node->buswidth);
>  			agg_peak[bucket] = max(agg_peak[bucket], temp);
>  		}
>  
>  		temp = agg_avg[bucket] * bcm->vote_scale;
> -		do_div(temp, bcm->aux_data.unit);
> -		bcm->vote_x[bucket] = temp;
> +		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
>  
>  		temp = agg_peak[bucket] * bcm->vote_scale;
> -		do_div(temp, bcm->aux_data.unit);
> -		bcm->vote_y[bucket] = temp;
> +		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
>  	}
>  
>  	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
> 

The rest looks good.

Thanks,
Georgi
