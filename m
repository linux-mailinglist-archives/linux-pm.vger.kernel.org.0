Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCBC41EDC7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353148AbhJAMuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhJAMuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 08:50:01 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936DCC061775
        for <linux-pm@vger.kernel.org>; Fri,  1 Oct 2021 05:48:17 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l13so8777922qtv.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Oct 2021 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8V2pc5LCezKMlPjmG0dHcIOoWZt1S3YATNfepJ+v0g=;
        b=TNd1ZtBD2OKA52FPYnN6UzEoLOTtNah9xEAzbT55QnUM76mFj7+vlBA11AWoEgz2m6
         q4yFAZZAqEprNNDlACxn1r9mDeoj79Q/eJbflp6cSi5rn5onsJiyHfKBnAxzclCHC6Ho
         O6t4vqGUMLOks2sHnZ3lR1ktiiWnjo1+soIg/xzuo0YivpLt599Aof3B5N7ktU0eZAjD
         IiufPDJutwKph7s8rppx6JRquWfMYnUkalDt8ruNWZITNn97OrNX+Na4Jv0/EUFDG6+s
         6u3U5/2bjWaqL0kD5IrIMsLnWVUGIW89qGyWkulogOVtfAndy0ICqNiPreykXeMxvSZl
         G8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8V2pc5LCezKMlPjmG0dHcIOoWZt1S3YATNfepJ+v0g=;
        b=2vwxDQgrvial1iWweWajY3JZLAfa0DbndDGvZ/Ann6n9ZExx0eZYxbejxYKscdUqSC
         ZDbDopNVAAb4T13SJan2P+qJt3If7ervxosDUONl4GZGZPcFYYFfmA4rr5ATfCEkt7eG
         U/42x+aHU5D0LZrraM1FMNlqJk1WoSbjcsM3JroyCRhnDzjBODN5XR6p0mS5Js6jpxQT
         A20zluPJ5hzdwjvYQk2XN/ERUSuJqecDMJDdObMRVxbKYmDVGmr9+1UsSGUvHNT+EDux
         r+xe1Yx46mv+WsWJNmpA8fHwbHZU1YTyYKlMgj8GZhYVIBuZzr69a/vjzux6H7eMCrNJ
         UuCA==
X-Gm-Message-State: AOAM530oNw1NWCDiV/Nfs16wcghpb4DfzAm1zWhNS1MYZ0XRACFhOzip
        H/glbVjqJlm6Q8FoVNOVu4bIzQ==
X-Google-Smtp-Source: ABdhPJxuvb/SYZ+d67IrjFIEIIK/r05HU07/8Qb6sLEYoThGPL8o6tAg4exSSAaJ/N9DXrYvV4cx5Q==
X-Received: by 2002:ac8:5905:: with SMTP id 5mr12587198qty.391.1633092496743;
        Fri, 01 Oct 2021 05:48:16 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id a2sm2894435qkk.53.2021.10.01.05.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 05:48:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: qcom: tsens: fix VER_0 support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20210926134237.23863-1-dmitry.baryshkov@linaro.org>
 <20210926134237.23863-2-dmitry.baryshkov@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5b878548-caa8-b8ea-055f-f13524d4ce73@linaro.org>
Date:   Fri, 1 Oct 2021 08:48:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210926134237.23863-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/26/21 9:42 AM, Dmitry Baryshkov wrote:
> For VER_0 tsens shares the device with the clock controller, but
> nevertheless it does not use syscon for these registers. Drop
> syscon_node_to_regmap() and acquire the regmap on our own.
> 
> apq8064 has tsens as a part of gcc device tree node, ipq8064 puts tsens
> node as a child node of gcc. Thus check whether tsens resource can be
> fetched either from the device itself or from it's parent.
> 
> Fixes: 53e2a20e4c41 ("thermal/drivers/tsens: Add VER_0 tsens version")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Thara Gopinath <thara.gopinath@linaro.org>

-- 
Warm Regards
Thara (She/Her/Hers)

> ---
>   drivers/thermal/qcom/tsens.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 6aeea74c1bb0..bc0c86a54fe7 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -12,7 +12,6 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_platform.h>
> -#include <linux/mfd/syscon.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm.h>
>   #include <linux/regmap.h>
> @@ -773,19 +772,19 @@ int __init init_common(struct tsens_priv *priv)
>   	if (tsens_version(priv) >= VER_0_1) {
>   		res = platform_get_resource(op, IORESOURCE_MEM, 0);
>   		tm_base = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(tm_base)) {
> -			ret = PTR_ERR(tm_base);
> -			goto err_put_device;
> -		}
> -
> -		priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
> -	} else { /* VER_0 share the same gcc regs using a syscon */
> -		struct device *parent = priv->dev->parent;
> +	} else { /* VER_0 share the same gcc regs. It can be either the same device, or parent */
> +		res = platform_get_resource(op, IORESOURCE_MEM, 0);
> +		if (!res && dev_is_platform(priv->dev->parent))
> +			res = platform_get_resource(to_platform_device(priv->dev->parent), IORESOURCE_MEM, 0);
> +		tm_base = devm_ioremap(dev, res->start, resource_size(res));
> +	}
>   
> -		if (parent)
> -			priv->tm_map = syscon_node_to_regmap(parent->of_node);
> +	if (IS_ERR(tm_base)) {
> +		ret = PTR_ERR(tm_base);
> +		goto err_put_device;
>   	}
>   
> +	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
>   	if (IS_ERR_OR_NULL(priv->tm_map)) {
>   		if (!priv->tm_map)
>   			ret = -ENODEV;
> 


