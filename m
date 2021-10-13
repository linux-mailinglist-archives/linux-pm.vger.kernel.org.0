Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1939142BF37
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhJMLv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 07:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhJMLv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 07:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634125763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJjX6iP5jQlCHxnRLEuZ4AA4AtdWwT375BFtLCNF4AE=;
        b=e5jIR4kDoT4367YZZI5v7kP5Z42SN3jVzr6Q0EkWAvAXQOWFJ6LBxC5qF5k33sAWhp79kQ
        sdKWON22ql3bs8C6PHvi3rhY9pnMwriGNiTmpTAJFCPUUU8puTkPME1pky6UFjgniffcLv
        evOAoHTZOjEb5FLEyktk1vw6eRyI9Ds=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-PJEdT4R7OlqHVVqgfdh6Kg-1; Wed, 13 Oct 2021 07:49:21 -0400
X-MC-Unique: PJEdT4R7OlqHVVqgfdh6Kg-1
Received: by mail-ed1-f70.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so1969753edv.10
        for <linux-pm@vger.kernel.org>; Wed, 13 Oct 2021 04:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eJjX6iP5jQlCHxnRLEuZ4AA4AtdWwT375BFtLCNF4AE=;
        b=kO4G86ptB6mJisyKLp5iJXf8/VyHqE0duhxtUKe6jkaayfvzxSjCMk+UQloGDGUVv2
         +oNOh0oBEztbLyCrVqh41ab8xvaJUwRn2y31v6HkVZkYnUvTcDLd0D75Ff3MYgfxE5V/
         CCooQWsnD1vmAPBRa4g/crC7DFlY7cuACmhNFygXijfuxpLIH0dACfnypm5f7NCpiHsb
         raYetX9aceTcMWP0phK/d/mP4FUh8QSWzciXrK7thbJaH5+3aGJhVl9eylZzY6dZc3lj
         jPN6CTrD6aI9Tnmzb8LgEAWT4hDgBmJt9fWEurT2zPWi0836ldK08GEilZ1kkM9lbARX
         FnTg==
X-Gm-Message-State: AOAM5327Se0WtuMcpSItQ3do289JSwt/h6/DLFMOgS6aphFocWto/g0q
        vcfXAPiUwjJvkN7+/4ElclOIIyqRH3qH7cnTh5s2Y2TXhUUVZQV5LKBQcD7VmsOGtyxQy5ksBcU
        qQpX7oXRPQFd/Tan/fZw=
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr18502112ejo.411.1634125760829;
        Wed, 13 Oct 2021 04:49:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZvpsePPQnw9IhyB+5gS1lX/EreOcYLH7NI6W+AjHXoDk1vgsss7IWIJ/DRWo5XsSsfEGzFg==
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr18502094ejo.411.1634125760635;
        Wed, 13 Oct 2021 04:49:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ke24sm6427207ejc.73.2021.10.13.04.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 04:49:20 -0700 (PDT)
Subject: Re: [PATCH -next] power: supply: axp288_charger: Fix missing
 mutex_init()
To:     Wei Yongjun <weiyongjun1@huawei.com>, Kate Hsuan <hpa@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20211013093115.2841167-1-weiyongjun1@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d3690325-9d55-607b-cf51-048f634ef7b5@redhat.com>
Date:   Wed, 13 Oct 2021 13:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211013093115.2841167-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 10/13/21 11:31 AM, Wei Yongjun wrote:
> The driver allocates the mutex but not initialize it.
> Use mutex_init() on it to initialize it correctly.
> 
> Fixes: ed229454856e ("power: supply: axp288-charger: Optimize register reading method")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks, patch looks good to me
(I should have catched this myself during review...) :

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/axp288_charger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index fd4983c98fd9..9987b1731e38 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -865,6 +865,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -ENOMEM;
>  
> +	mutex_init(&info->lock);
>  	info->pdev = pdev;
>  	info->regmap = axp20x->regmap;
>  	info->regmap_irqc = axp20x->regmap_irqc;
> 

