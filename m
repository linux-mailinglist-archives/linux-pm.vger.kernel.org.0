Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73FA2111A4
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgGARKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgGARKN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 13:10:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55028C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 10:10:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so23200414wmi.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iAmyBjucUvreoEWUkZI20ibgdJNiBgFXx30xaPRx/xA=;
        b=XQeaH6yImlrDYYtsz2DYYzhZxlJeHDLUCXIQgmDtV4cDt+Vg9j1u7dzc3i0Ztyu2eK
         pENtT9q/u4vBspnrp0m79+afEEjVjqFE77KyHErg4GkdaDme6bkBkSogsJLMqqhZZ6I8
         kZ/iymGAY/Mpas6XlQpSdNn40Q+x13ItoIe8EV/ZURuiBFBSiPucrjg3empJwZlUAS3m
         nH5QPfqfZqrXJvMriu7434qy9r3qdezjm+c4LqNHZJqXyeMmXmtSctd5NyMznTOAtHCP
         X1/8AYdfLP4YSw3kPCaqutzuIDdWEIRuMcodEFPJBssvk8PBCHpp0iZJZj1GDXZaOjFF
         jzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAmyBjucUvreoEWUkZI20ibgdJNiBgFXx30xaPRx/xA=;
        b=RksA6KQH2F6RFLP3RV6Qwa6nemw9ECg2K/1KSqKuv0WFnPpiz5Y1PTTFz86P0qmmzh
         d4hmibJPP6CQ/I5zq4VPbKWGFo2rQqsmhqQTPotQCrg3dyVkYYQ1IXX/8kU3646TpQJe
         pu2wIVATU+0NgMgciewgtnBNDmbIHf0S3hOmeOiex7Gpkifl876ogNXlF0v+ARzUYsP6
         QFjlQzpjAupgdq4TO+jNoDTiWlWjdFoFKtkIMIrI4ueU8ZXz9Kkn9GjzxUEQSi++N9Ge
         bu/SXyJUQyDA69O26GbyqD5H+h5HPwkXCmqFqttrtjEVys790oKcwIP4q6IgBaTij6aT
         QuBQ==
X-Gm-Message-State: AOAM531PA+Lv2a8VzZRsMl/mSq4wHd8KqqVhQNsawajHplE1/xCirL0L
        /h7+l11T99KN4Fd5taVWd19vog==
X-Google-Smtp-Source: ABdhPJxRoAZIiKa74FbFTUsZV5KAVRLjCbHIpX1rcXcl+CjO9DLVFf0U2JKCm6Ho81pYAcVBNxxOpg==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr15892330wmb.112.1593623412008;
        Wed, 01 Jul 2020 10:10:12 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a15sm9444906wrh.54.2020.07.01.10.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 10:10:11 -0700 (PDT)
Subject: Re: [PATCH v4 27/37] interconnect: Relax requirement in
 of_icc_get_from_provider()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-28-digetx@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <3b410ea3-26d3-6f7a-213c-40dbabbde8d1@linaro.org>
Date:   Wed, 1 Jul 2020 20:10:09 +0300
MIME-Version: 1.0
In-Reply-To: <20200609131404.17523-28-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 6/9/20 16:13, Dmitry Osipenko wrote:
> From: Artur Świgoń <a.swigon@samsung.com>
> 
> This patch relaxes the condition in of_icc_get_from_provider() so that it
> is no longer required to set #interconnect-cells = <1> in the DT. In case
> of the devfreq driver for exynos-bus, #interconnect-cells is always zero.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> [digetx@gmail.com: added cells_num checking for of_icc_xlate_onecell()]
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

I have already applied the original patch by Artur, so please make the cells_num
check a separate patch.

Thanks,
Georgi

> ---
>  drivers/interconnect/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index e5f998744501..cb143421ca67 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -339,7 +339,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
>  	struct icc_provider *provider;
>  
> -	if (!spec || spec->args_count != 1)
> +	if (!spec)
>  		return ERR_PTR(-EINVAL);
>  
>  	mutex_lock(&icc_lock);
> @@ -967,6 +967,15 @@ EXPORT_SYMBOL_GPL(icc_nodes_remove);
>   */
>  int icc_provider_add(struct icc_provider *provider)
>  {
> +	struct device_node *np = provider->dev->of_node;
> +	u32 cells_num;
> +	int err;
> +
> +	err = of_property_read_u32(np, "#interconnect-cells", &cells_num);
> +	if (WARN_ON(err))
> +		return err;
> +	if (WARN_ON(provider->xlate == of_icc_xlate_onecell && cells_num != 1))
> +		return -EINVAL;
>  	if (WARN_ON(!provider->set))
>  		return -EINVAL;
>  	if (WARN_ON(!provider->xlate))
> 
