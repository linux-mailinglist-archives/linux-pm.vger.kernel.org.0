Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3E35ACC1
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhDJKnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Apr 2021 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJKnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Apr 2021 06:43:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DBDC061762;
        Sat, 10 Apr 2021 03:42:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a6so8003240wrw.8;
        Sat, 10 Apr 2021 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=beqXmyN/B6cqbpsqWboqXC093wFDZXtHxegRtfCiZ7w=;
        b=Wr/N858Sv12bK0tZW055XDCUmopKrOk8HO82GpGqYPbqbcV72wYT+P+bYD49nfZ0AZ
         fE/mALOO+YayhhBV2416RRh8IRKrz1INCg5iIMWzkgTrFquDF0LoU4JWuXR8CVaztMYN
         QEtTT3xYPYxgRxv7aclmuGABAWfEWjgv985jt3PsVhatwrjysjrfBR3BDEu/orFLdlCq
         8DlXOX4Wze5Q20PAyzg2XWlTLQ1nynX65DKKAeqS+9mP3EIavogYhhmuP3/YZ0knUWDg
         xOOyls0PVhb/j8SVSPVd89bD7kwgk/VK0Z5CE32rDQ6HeA6rOrVahAeOUFii/G45WK9e
         3LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=beqXmyN/B6cqbpsqWboqXC093wFDZXtHxegRtfCiZ7w=;
        b=G72NJInyml0zhjCfNqT31d2V9aHtRpuDeIXTaI4KsDRtqapo29iLcIYzreQd5kPkMn
         qcIk9pOHY2R3/hmZMA/y6MdeAFTFiYxxbL8KqPWxZdKVpA33MVrUSggmxjqtHUhGBs/F
         Zltr3HNVt7Esw1ts/sx4gb5jQ5C3NNb9/c4I1f/olSTJmMpJcvE9RSTm6Kybe5iEgOdR
         8hvcIvHp8/HNqtl0T2UHKbftSQ/RzgEITt1CYjJCRF6leYImPby+jmuLJAplXprg5FB+
         2hUyBVGlYEu5PDLzd8+PhV3dd98WWTOv80BfvEysBWwu2sys0QXsU2cGcYTJTEmOO9ff
         uH5g==
X-Gm-Message-State: AOAM532M0CpMpKxVKoFsYii/xsF5P/3dnStIsfouzQSAWIKy3B1ADSvR
        KVeNUHx5k5X8oQWIKtvn0Cc=
X-Google-Smtp-Source: ABdhPJy+aCPMYLmeYp0VFbLTKkdvlqeiMp/S/7YyOKw5IaEzVwDI73QfyIBFtr+fEU55GZZ/smpcfg==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr22134572wrr.425.1618051365932;
        Sat, 10 Apr 2021 03:42:45 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea306d.dip0.t-ipconnect.de. [217.234.48.109])
        by smtp.gmail.com with ESMTPSA id z15sm2067086wrv.39.2021.04.10.03.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 03:42:45 -0700 (PDT)
Subject: Re: [PATCH -next] power: supply: Make symbol 'surface_ac_pm_ops'
 static
To:     Qiheng Lin <linqiheng@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210410041249.12846-1-linqiheng@huawei.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c5edfe56-eebe-55c0-e30f-4a552934d0b8@gmail.com>
Date:   Sat, 10 Apr 2021 12:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210410041249.12846-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/10/21 6:12 AM, Qiheng Lin wrote:
> The sparse tool complains as follows:
> 
> drivers/power/supply/surface_charger.c:229:1: warning:
>   symbol 'surface_ac_pm_ops' was not declared. Should it be static?
> 
> This symbol is not used outside of surface_charger.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/power/supply/surface_charger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
> index c2dd7e604d14..81a5b79822c9 100644
> --- a/drivers/power/supply/surface_charger.c
> +++ b/drivers/power/supply/surface_charger.c
> @@ -226,7 +226,7 @@ static int __maybe_unused surface_ac_resume(struct device *dev)
>   {
>   	return spwr_ac_recheck(dev_get_drvdata(dev));
>   }
> -SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
> +static SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
>   
>   static int surface_ac_probe(struct ssam_device *sdev)
>   {
> 
