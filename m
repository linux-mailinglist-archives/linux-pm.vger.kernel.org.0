Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6A3A417A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 13:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFKLwD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 07:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhFKLwC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 07:52:02 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC21C0617AF
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 04:50:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id ew3so146328qvb.13
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RM8SbiamRAqEYBQWvt1zz0QiLBzqVfHdHpmDx37QuwU=;
        b=fePXtwI12Iq05ePtlIj8shlIJHX4DaDQ32hB9cG3cca21aINFphdPqRiPJhrRM+oUB
         wN3V+w55rL0QhXLQ0bbels3X5vyE4iS5q0dMAxOUjUOuUrqqk2aTeq6okhBrzluXvaxe
         Hz8bq3LYstAAwip+vGEMF4C/eRe/CJFsf6ZHpAzFNL+vkzw7r7z9THIp8k6R28exgeWM
         4HHMuSQi9fzSLxBgsC7HQizQPxXmPjqswVhAznvhC2pt5givvYX8XR1wfDukHEdBS+kP
         N0/b/dRySPVs/J+fAqEA56JSxrxzvXrx3rOL6d3p2f3DbuC6vHPXiZbrpB/dtvaL6JjH
         jSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RM8SbiamRAqEYBQWvt1zz0QiLBzqVfHdHpmDx37QuwU=;
        b=IW7okb/F4bHu+UMOdxiqKW6Gq3VYNIRnslAOv+8IqWsiplKR8zFqnlA5iiu0qID7Dd
         3bLrtNXpvAgRiIZOYcqyU+v046cXZIGyAxr1qzzsJb0/k28VglnMZNH61JrF0n2dqDUI
         b7X3eSl7aYO3ygQyl0AIKaGSaIeU/4TykKy4/j5/QWrPQhMrcFF5+lDjArxfQy5Jm5hr
         wxEkq+n6rVCA5Jv8uM4Ncbw9L5l20HrhcogsGZI3ZY3hhSe9WU0SY4tfg9N85ERCF8Fu
         HB1DmbCq/fBW6bE4gGjgRiAD+Ur63z0N6JwRl0WI2oDH/PuTd80bwVuYOd3yq3q/j6bQ
         KKtw==
X-Gm-Message-State: AOAM532FbCsw5ycKzpbIcVfy0D2F4MKbsU4eobHtLN0UW9uEHF/AsD+T
        EJJ7oNZ6/mWGwcyHzKLYRtzpXg==
X-Google-Smtp-Source: ABdhPJxzIcffT3qoG1eWyiesO8Mwm8yOIdHq4qcbltAq56GYtyGUnvyT4J2ipiPRhOVVLcc2VO3/DA==
X-Received: by 2002:ad4:40cf:: with SMTP id x15mr4329423qvp.50.1623412203934;
        Fri, 11 Jun 2021 04:50:03 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id f5sm4052391qkm.124.2021.06.11.04.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 04:50:03 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/tsens: fix usage of unititialized value
To:     Yang Li <yang.lee@linux.alibaba.com>, amitk@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1623145299-109090-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <3db50e86-911a-8b49-8c87-a33178754deb@linaro.org>
Date:   Fri, 11 Jun 2021 07:50:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1623145299-109090-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/8/21 5:41 AM, Yang Li wrote:
> When "tsens_version(priv) > VER_0_1" is false,
> "regmap_field_read(priv->rf[VER_MINOR], &ver_minor)" can't execute.
> So, ver_minor has no initialization and assignment before it is
> used, and we initialize it to 0.

Hi Yang,

Thanks for the patch. I have a few questions though.

1. Where do you see ver_minor being used uninitialized? AFAICT , 
ver_minor is used like below and will never be referenced if version <= 
VER_0_1
	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {

2. Do you know whether minor versions can be read or not on tsens ips 
with verions < 0_1?

-- 
Warm Regards
Thara (She/Her/Hers)

> 
> Clean up smatch warning:
> drivers/thermal/qcom/tsens.c:896 init_common() error: uninitialized
> symbol 'ver_minor'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/thermal/qcom/tsens.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 4c7ebd1..a36c43d 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -743,8 +743,8 @@ int __init init_common(struct tsens_priv *priv)
>   {
>   	void __iomem *tm_base, *srot_base;
>   	struct device *dev = priv->dev;
> -	u32 ver_minor;
>   	struct resource *res;
> +	u32 ver_minor = 0;
>   	u32 enabled;
>   	int ret, i, j;
>   	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
> 

