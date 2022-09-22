Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C45E5834
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 03:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIVBmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 21:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiIVBmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 21:42:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0CAB199
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 18:42:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e67so1583442pgc.12
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5TqaiC6+5PjODgdBwHtICicD+dd5+ergNAw4nNe6Mow=;
        b=LPkR45NRdlBatKPakcpv4dsSnn64O6AKZ3CP7Canb3ZMh3urZEDP/6aeCNoCvXpoyi
         jsM1q+l0sqSkjbaIvfobbDrYH9ZFXHbnI2CuEgoepy1bAgxhnOLhMaZoDWxhoLXPuafz
         1ScU0/jLIo8fvSdIWIOT+vvI50v7wnaoo3tQy8Wa37TXDAijYdr+Ue+WV/ROuE6pcfIj
         M/AW8NJ3DeX6/CLBY1Fpat6Lw4d7aORGUSoVl0jLcpsFSRKFKyPu+Vzm3kSFvVJTjG/N
         JJ3lRSUBm292kaNKQ1GqBvR1pk4NqX/V8JU+s7C5HZcWwJKNxadhENqnquglJXV9+7wT
         WGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5TqaiC6+5PjODgdBwHtICicD+dd5+ergNAw4nNe6Mow=;
        b=uf3dBN9ackipy8s2GFW8hSBWOw68V5pRx850FzUImROQvtLNrBU3JfGcWdRwbHOiWz
         8haNZglRkxmMmRrf4b9CSWK7ZpNCB8gn+Xwa0N/OHypj5IaYZHwXT/EdBQZqN/5joakx
         beudSWXPdq9m6K9kEJD9MV/AkuklLiDRMIesT9GwY7UKuS6B1mh1oA6uLfJoUAjX+MFi
         OZDnEyqNR/JtMsejrTsFqiWHS0xuluqmqo1f26DRHkrYXb4zev2S3j2RiRMP0VlVRsnD
         atUhpydSBjZO+U5byry2nPQJpldACHaHoW+X/NdSsq9K7KSsNaalLcDkTSo5o2MOeugv
         zCYg==
X-Gm-Message-State: ACrzQf3KiW/xheXXWs/Jm0zR52aKa25gwyZBt7BHEAP18GpFUmLVR9we
        Gdl7WMoGPsPtaom8/Pq0SNU=
X-Google-Smtp-Source: AMsMyM5F5q5V9Vn2GrnYbp7RXDz0oPM/LZ6ziKRO7Ee/lo2266CZVvwlbC0rUEtesrh+yp0ooOJ/7Q==
X-Received: by 2002:a63:4805:0:b0:43b:e1c9:32af with SMTP id v5-20020a634805000000b0043be1c932afmr970363pga.574.1663810951181;
        Wed, 21 Sep 2022 18:42:31 -0700 (PDT)
Received: from ?IPV6:2001:b400:e404:66d5:cf4:e9a8:56c5:fa2d? (2001-b400-e404-66d5-0cf4-e9a8-56c5-fa2d.emome-ip6.hinet.net. [2001:b400:e404:66d5:cf4:e9a8:56c5:fa2d])
        by smtp.gmail.com with ESMTPSA id w62-20020a623041000000b0053e156e9475sm2871524pfw.182.2022.09.21.18.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 18:42:30 -0700 (PDT)
Message-ID: <88bd277a-bda4-29ad-4157-09883303b470@gmail.com>
Date:   Thu, 22 Sep 2022 09:42:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next] power: supply: mt6370: Fix return value check in
 mt6370_chg_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     sre@kernel.org, chiaen_wu@richtek.com
References: <20220921152915.1506767-1-yangyingliang@huawei.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
In-Reply-To: <20220921152915.1506767-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/21/2022 11:29 PM, Yang Yingliang wrote:
> If create_singlethread_workqueue() fails, it returns a null pointer,
> replace IS_ERR() check with NULL pointer check.
> 
> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/power/supply/mt6370-charger.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> index 716cba259a7a..f27dae5043f5 100644
> --- a/drivers/power/supply/mt6370-charger.c
> +++ b/drivers/power/supply/mt6370-charger.c
> @@ -911,8 +911,8 @@ static int mt6370_chg_probe(struct platform_device *pdev)
>   	priv->attach = MT6370_ATTACH_STAT_DETACH;
>   
>   	priv->wq = create_singlethread_workqueue(dev_name(priv->dev));
> -	if (IS_ERR(priv->wq))
> -		return dev_err_probe(dev, PTR_ERR(priv->wq),
> +	if (!priv->wq)
> +		return dev_err_probe(dev, -ENOMEM,
>   				     "Failed to create workqueue\n");
>   
>   	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_wq, priv->wq);

Hi Yingliang,

In general this looks good to me. Thanks for catching this!

Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>

-- 
Best Regards,
ChiaEn Wu
