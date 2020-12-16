Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273102DBDBD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 10:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgLPJgi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 04:36:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgLPJgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 04:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608111312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FkFaV1sj5tXDICgVYoVeFoC7TWW7hfY+jYxB8b3Zi0=;
        b=hTzorJzuNUYVE4FdduuRpja6wqqFCd6H0A3BX8lyDkkYSl75/+628zAJmEKmyf3bq8REwv
        F6Orl9THb6RZPtxePz3snf7AbE+IAOR4g1neettUH6kK6bFBBB2Md5Vx9PF/tv4XfUcVGn
        q7OdR58Ne6uVZiN/a0ERgHJPJdmukFg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173--htg4A3IPVeJfZUNxJ4T0Q-1; Wed, 16 Dec 2020 04:35:10 -0500
X-MC-Unique: -htg4A3IPVeJfZUNxJ4T0Q-1
Received: by mail-ej1-f70.google.com with SMTP id k3so7150615ejr.16
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 01:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0FkFaV1sj5tXDICgVYoVeFoC7TWW7hfY+jYxB8b3Zi0=;
        b=sM4xMlBHPAx5gtdXCaYA75qoHbP/g5rRJbGhZDLFqAyD8N281wG12de6AEU4l6EQxV
         ejNPTDgpvqFPXARGSL4v0PQhnnKPmdaKuCuiLBFzc0RbnjBbFUK7oAOLjDCp8RPStoQF
         /NJSZe87EjAnX9hGl7ZH0egVTkx9FCiYzPGtTaUoYDsMpS5W/pi8XH8ITdgyfz7PQjBD
         FVjI4yyI2Kv9BtFEraIE4NX+w3fVNGlOnKVTzXPNrTarJv2o2Cp3thZvWqL81IBX93jF
         2+bcaQPHYqU+nXhtCpsvsqbawaT6DoTUd70GJZtBObtSi8EusfevLVY88eeeNEBpiGuq
         MrYA==
X-Gm-Message-State: AOAM531giTT8Z9lPpfZpx1qfW5f2bWGb0+PRxh2yNxidhiKqSwRrsFR8
        7M1psO+EUbxjK/bXxFkRGhGO3j+3xOjUqLmz5zx/MX+uFmki4i3j9np/KmMS8YxgEip+ahl92B1
        GnVvCzweFqZDzw3R6HEtcYCFICKlVrDOPQMZPW8ml8lUjZqD08Z6OowX68qgS2DJUycwxSRc=
X-Received: by 2002:a05:6402:1383:: with SMTP id b3mr5793811edv.100.1608111308724;
        Wed, 16 Dec 2020 01:35:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdvUjdbm6lMsgwUA3NC9QrUMdVeACLNPgHnfMNWmcx6VcZyChBkpMa7OKH9C0JK8iWlLEIiw==
X-Received: by 2002:a05:6402:1383:: with SMTP id b3mr5793790edv.100.1608111308457;
        Wed, 16 Dec 2020 01:35:08 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id l22sm975568ejk.14.2020.12.16.01.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 01:35:07 -0800 (PST)
Subject: Re: [PATCH] power: supply: axp288_charger: switch to using
 devm_add_action_or_reset()
To:     Tian Tao <tiantao6@hisilicon.com>, sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org
References: <1608098978-53068-1-git-send-email-tiantao6@hisilicon.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d5788ae9-2526-e24e-5337-e62670a71935@redhat.com>
Date:   Wed, 16 Dec 2020 10:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608098978-53068-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thank you for your patch, but see comments inline.

On 12/16/20 7:09 AM, Tian Tao wrote:
> switch to using devm_add_action_or_reset() instead of devm_add_action.

This just states what you are changing, not why. If you cannot explain
why you are changing something, then possible the change is wrong or
at least unnecessary.

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/power/supply/axp288_charger.c | 2 +-
>  kernel/dma/map_benchmark.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index a4df1ea..6480c2e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -855,7 +855,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Cancel our work on cleanup, register this before the notifiers */
> -	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
> +	ret = devm_add_action_or_reset(dev, axp288_charger_cancel_work, info);

As the comment 1 line above the devm_add_action states, the action gets
registered *before* the notifiers get registered, so before the work can
ever be triggered.

IOW there is no need for the reset here. It cannot hurt, but it is not
necessay, so NACK.


>  	if (ret)
>  		return ret;
>  
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 19f6616..775191d 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -294,7 +294,7 @@ static int __map_benchmark_probe(struct device *dev)
>  		return -ENOMEM;
>  	map->dev = dev;
>  
> -	ret = devm_add_action(dev, map_benchmark_remove_debugfs, map);
> +	ret = devm_add_action_or_reset(dev, map_benchmark_remove_debugfs, map);
>  	if (ret) {
>  		pr_err("Can't add debugfs remove action\n");
>  		return ret;
> 

And this seems to belong in another patch entirely.

Regards,

Hans

