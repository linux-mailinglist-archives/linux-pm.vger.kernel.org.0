Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C92378E97
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhEJNXC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 09:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348746AbhEJMq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 08:46:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC5C061344
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 05:41:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id p6so11732870qtk.13
        for <linux-pm@vger.kernel.org>; Mon, 10 May 2021 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWBxeMl4QMRBC5+HydxigOqadY8c03VHN4Jo2XyXuPo=;
        b=lUJjWERR/ZcJbmtBbd5iJHakU3oreeyOxyCL4YrM6P7zuPQw2GJkQffGGmfGnvJRir
         +oF0c/rzhyz/lBDJsejg9ioEipSSUl6YM7KVlF22Niw9EMV4pl0+rknlKMWtfLG1QBaC
         3uu6kPe2j1gowaAl8KngEZD+1x2gctxma/sH/MWCp1ACPZPVtp0PV84ISPrCwiy5yhfi
         Cd44Bhz7s1CZe0YfwOyq0ROOHSxmgsl6ybs1U2eo3pwKzSsGRlUK2mgNDmXQ6HldbWFN
         G0i50m6QYIKB9/dbw2CsgNdOtt+rh3MzCrpJ/u8WOJs6uwD0OEx6ftDWNImjebFY24Pr
         8Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWBxeMl4QMRBC5+HydxigOqadY8c03VHN4Jo2XyXuPo=;
        b=RTmMI5ZsAoSgfK+roRCxoOMWLuMnOQ6KkJbf07Z5Fd4CIKbKBq1JzyM/g5eS7/4zQB
         FBjE9pENGlni+CnsoVe+g6/iNWQ0lD7vxgwRCfaYgW9nUfkDV74RPu/kUdvx10b7NbSX
         TABct7oeERkx4gXSjSvDVDuW9n9AuRnkmFZXnkUvLyDgJ16r2FhayVbpkQ8NbM8tFDT5
         NhAWp3Wn21LvVlqZNUyzOKVLwr1uItZpsvbmjQotVOO/ZZJTR6fAmNL0UzxdbOX/RhWz
         HPllbrvlnDwfvePz1OwdWzn4SEF+igvqEdfV8jBd1e0WA2mM1vLx08X5rnkioOafi7I7
         NrlQ==
X-Gm-Message-State: AOAM5323WK0PcD9lN09AU9WO+M9A8d7sTleuPFXrUbsvUW6wTNnUQ3ai
        U6PCNYJ0eeiTEcMXRiSx9CgVwA==
X-Google-Smtp-Source: ABdhPJxbq2hX5CW1bhvlOJNY25r+kplAkc2Kf7zakAydxBuGzUc7Mh8fQJ2R+nUpsqxXyWrj9bYZ9Q==
X-Received: by 2002:ac8:4710:: with SMTP id f16mr18777928qtp.250.1620650463263;
        Mon, 10 May 2021 05:41:03 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id o5sm11333822qkl.64.2021.05.10.05.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 05:41:02 -0700 (PDT)
Subject: Re: [thermal-next PATCH v2 1/2] thermal: qcom: tsens: init debugfs
 only with successful probe
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210429010518.13319-1-ansuelsmth@gmail.com>
 <20210429010518.13319-2-ansuelsmth@gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <d9549fb6-462e-5e22-4f76-c6b37a04a02a@linaro.org>
Date:   Mon, 10 May 2021 08:41:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429010518.13319-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/28/21 9:05 PM, Ansuel Smith wrote:
> calibrate and tsens_register can fail or PROBE_DEFER. This will cause a
> double or a wrong init of the debugfs information. Init debugfs only
> with successful probe fixing warning about directory already present.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>

-- 
Warm Regards
Thara
> ---
>   drivers/thermal/qcom/tsens.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..b37d5fd71f3a 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -845,8 +845,6 @@ int __init init_common(struct tsens_priv *priv)
>   	if (tsens_version(priv) >= VER_0_1)
>   		tsens_enable_irq(priv);
>   
> -	tsens_debug_init(op);
> -
>   err_put_device:
>   	put_device(&op->dev);
>   	return ret;
> @@ -1057,7 +1055,12 @@ static int tsens_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	return tsens_register(priv);
> +	ret = tsens_register(priv);
> +
> +	if (!ret)
> +		tsens_debug_init(pdev);
> +
> +	return ret;
>   }
>   
>   static int tsens_remove(struct platform_device *pdev)
> 

