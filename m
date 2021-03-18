Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD28F340FA5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 22:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhCRVPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhCRVPe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 17:15:34 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CBC06175F
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 14:15:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id 94so5269712qtc.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2h/fJfUVZc3lt7GnwBXU8ijaCWEWcTsFoNt4wS6wz1k=;
        b=rYLjhs1YdAhKTS6eb8HBmzfxZ4x/0tZbMjtiNYOtofICym5tn05oJbxhGMl6QdVpFL
         +XLl0QmUv1G7Rxc6KA6nswMEtbxk+AqDzoJxB+8GfHNH4UA6ksowzKD72R5JX5ZmfYiV
         xVtYKIR0toh2j1UceS23cg9M0hmseOGEHWZpC+kFxsDfUhDYpPvSHVV7RFpcXpoesVjf
         v2i+qiDCHWgCgCuGLgg9L/Z7nzyAywWCpUAmKt1FakZsoeJkIHOS9ukRTUFDLscpZ/r6
         KSypcnjxKrGaaQAfa5ziHBvS8u3wGY20k0n5WyzuCkEeojZ7DocNgkxaLPRVO7gGQshq
         buZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2h/fJfUVZc3lt7GnwBXU8ijaCWEWcTsFoNt4wS6wz1k=;
        b=S1wZncqcmEdgIOY8UijWBzXpFv8kGM9NNm9osRgBNh3Nq/usg5QD2lTniFGQ033+L3
         Wc3Ha6SHawofCdjSrrEABNYK+RvtpYVDtdq6+p/QRC3yp+IO462ckk9FRnrerpv5nRBC
         921Dxbsp+cFqi9UAGK+Q0Lq8FzOV6eaYTltZW3S9KQgFN+ZiPgqX7MJ5Hc6pE+JH075D
         qcNK/Qq4idqCnvU6tzqPy4rcFvoy9OA0tWIBKM5ZYYk5hY7EgAY9afWdwQsKedpHcSzc
         /dHgY9xV7d3P0o1lyLlcZXyAcUErKK4UaW3mOIOh6cistaqUlCCEftgQ2fP1nG0OcLXs
         I8fg==
X-Gm-Message-State: AOAM531dRrlkIi6hCtwc7MXw0G6G2QXoknSdve3iKsDNA4LgKqZ1f+E2
        LzgribbBr+UcG86hac0qBsxdnQ==
X-Google-Smtp-Source: ABdhPJzI1lPGhLk5ZiaM2WHWL90E3tj31UDGa5JlBt1mw/TmLvVFD48T3jrajRkre4pAVR+hgGYICA==
X-Received: by 2002:a05:622a:8a:: with SMTP id o10mr5451875qtw.50.1616102133172;
        Thu, 18 Mar 2021 14:15:33 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id c73sm2857463qkg.6.2021.03.18.14.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 14:15:32 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v10 4/8] drivers: thermal: tsens: Use init_common for
 msm8960
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
 <20210217194011.22649-5-ansuelsmth@gmail.com>
Message-ID: <d85c44e1-b436-4e7b-1bec-f33a36b4ec71@linaro.org>
Date:   Thu, 18 Mar 2021 17:15:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/17/21 2:40 PM, Ansuel Smith wrote:
> Use init_common and drop custom init for msm8960.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

Warm Regards
Thara

> --- >   drivers/thermal/qcom/tsens-8960.c | 52 +------------------------------
>   1 file changed, 1 insertion(+), 51 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 3f4fc1ffe679..86585f439985 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -173,56 +173,6 @@ static void disable_8960(struct tsens_priv *priv)
>   	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
>   }
>   
> -static int init_8960(struct tsens_priv *priv)
> -{
> -	int ret, i;
> -	u32 reg_cntl;
> -
> -	priv->tm_map = dev_get_regmap(priv->dev, NULL);
> -	if (!priv->tm_map)
> -		return -ENODEV;
> -
> -	/*
> -	 * The status registers for each sensor are discontiguous
> -	 * because some SoCs have 5 sensors while others have more
> -	 * but the control registers stay in the same place, i.e
> -	 * directly after the first 5 status registers.
> -	 */
> -	for (i = 0; i < priv->num_sensors; i++) {
> -		if (i >= 5)
> -			priv->sensor[i].status = S0_STATUS_ADDR + 40;
> -		priv->sensor[i].status += i * 4;
> -	}
> -
> -	reg_cntl = SW_RST;
> -	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
> -	if (ret)
> -		return ret;
> -
> -	if (priv->num_sensors > 1) {
> -		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
> -		reg_cntl &= ~SW_RST;
> -		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
> -					 CONFIG_MASK, CONFIG);
> -	} else {
> -		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
> -		reg_cntl &= ~CONFIG_MASK_8660;
> -		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
> -	}
> -
> -	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
> -	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> -	if (ret)
> -		return ret;
> -
> -	reg_cntl |= EN;
> -	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>   static int calibrate_8960(struct tsens_priv *priv)
>   {
>   	int i;
> @@ -346,7 +296,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
>   };
>   
>   static const struct tsens_ops ops_8960 = {
> -	.init		= init_8960,
> +	.init		= init_common,
>   	.calibrate	= calibrate_8960,
>   	.get_temp	= get_temp_8960,
>   	.enable		= enable_8960,
> 

