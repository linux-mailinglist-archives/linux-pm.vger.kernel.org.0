Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4B35ACBC
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhDJKl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Apr 2021 06:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJKl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Apr 2021 06:41:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E547C061762;
        Sat, 10 Apr 2021 03:41:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so7984829wrw.10;
        Sat, 10 Apr 2021 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qb8YcwmVjCvWFlIO3GJpj9CyVTAbrtiPYaokYJsc6zU=;
        b=uKxwHHfW6z6r9sCgf/UAbjP/xhWeWCW7x2+4FAWp74+p+3Dnow4c3GnlyMKReBLxtm
         lLvIygdSSl+uhEvzFRtbi3qh+QZBE5qDtEFSK5juYuUfl3lN8ekfbelAWm7GIloq0MU9
         5P0QS3fMgt2Rug/txjIaZhX9+OjTzTGTTjgq0pI7ZafDZGsFYJ1HUF3z16SiXLWq2S82
         M/oaif8BnDbw2uhDFCNb0PrltAbKIQFArTFbRAqYJoJ0ani9ksaXeUc9dvZZk1R7DO4v
         nwiTvWwcQoObPdrVsCfK/u5NdFKGDlvNw8X/NHKGQi36joph8dNoz9yW12dNMw37IEKD
         18mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qb8YcwmVjCvWFlIO3GJpj9CyVTAbrtiPYaokYJsc6zU=;
        b=RrktLmy6L2tkmRQP0HDLl2juQjqXZmzMoafCgMXLU1Jq5T5ZGfuUKEn+mjGRZkONvF
         /oYL9j187PQuOzhFfs/iaotTgQayIVQWEcrxt2S58IfthnuhnwQZpRpc9ZOpCXb+twcr
         OGqY/DukaN2MsQf9JTp575O9sb0rGI6kyHxeVMf8mmzxYivCn1fCWGL1+s1x5p9uJxkB
         bQoCV7ig8N2PBvAwW9RNFKy24oOlekMnNX9r+rPEDke+14FaMQFAhSxMZiMrCzkBm9EM
         s8lC0OHshUPCLTr+CLwfPfsPy4V6TyiUXSoy4Msc0c52VouwlTuEwD0blmSQobsZLHDb
         tDWA==
X-Gm-Message-State: AOAM533ux0IHLyWxuJt3AfGcBKS82Z/ju9vyT44Smkfm71ymWJ9EtCK8
        lMxM0ME0qhy2Wg8IrGlAhq3Cp6IUll4=
X-Google-Smtp-Source: ABdhPJygiTo6NoNb+c5+WZ8H7OctCHMmGFH3/02qw1dh179Y5Q5KGoFrUSnRcOmVYoHInCwvELfHxg==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr22362806wrg.298.1618051272682;
        Sat, 10 Apr 2021 03:41:12 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea306d.dip0.t-ipconnect.de. [217.234.48.109])
        by smtp.gmail.com with ESMTPSA id w22sm7433524wmc.13.2021.04.10.03.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 03:41:12 -0700 (PDT)
Subject: Re: [PATCH -next] power: supply: Make some symbols static
To:     Qiheng Lin <linqiheng@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210410041246.12791-1-linqiheng@huawei.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <3026d506-4755-4885-4d22-9f589a660221@gmail.com>
Date:   Sat, 10 Apr 2021 12:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210410041246.12791-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/10/21 6:12 AM, Qiheng Lin wrote:
> The sparse tool complains as follows:
> 
> drivers/power/supply/surface_battery.c:700:1: warning:
>   symbol 'dev_attr_alarm' was not declared. Should it be static?
> drivers/power/supply/surface_battery.c:805:1: warning:
>   symbol 'surface_battery_pm_ops' was not declared. Should it be static?
> 
> This symbol is not used outside of surface_battery.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/power/supply/surface_battery.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
> index 4116dd839ecd..7efa431a62b2 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -697,7 +697,7 @@ static ssize_t alarm_store(struct device *dev, struct device_attribute *attr, co
>   	return count;
>   }
>   
> -DEVICE_ATTR_RW(alarm);
> +static DEVICE_ATTR_RW(alarm);
>   
>   static struct attribute *spwr_battery_attrs[] = {
>   	&dev_attr_alarm.attr,
> @@ -802,7 +802,7 @@ static int __maybe_unused surface_battery_resume(struct device *dev)
>   {
>   	return spwr_battery_recheck_full(dev_get_drvdata(dev));
>   }
> -SIMPLE_DEV_PM_OPS(surface_battery_pm_ops, NULL, surface_battery_resume);
> +static SIMPLE_DEV_PM_OPS(surface_battery_pm_ops, NULL, surface_battery_resume);
>   
>   static int surface_battery_probe(struct ssam_device *sdev)
>   {
> 
