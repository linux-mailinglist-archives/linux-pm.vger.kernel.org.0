Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D991F644A03
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiLFRMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 12:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiLFRMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 12:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A136C40
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670346688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPkPcvfaPz48jc0UYff1aSc6omF1TVd5SJibXGywp0M=;
        b=MgFrrTpUhWN907OxHum5S0vQEHX0lVRJ/S9fev/R5ZJoYaBBeMDPtf7M85bzXEsWfFuVTF
        wNfes2aNdi0ZIPqjVDqjqaPSdffyuy68Uhjowb4RFyB+btr9AoT/cwZfvPkIJkXiMUxwdq
        9Zrk/V4kXyZGI2JbGyGI+7eeBzHb/oU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-9Oyz7yRdPnSGCYGNkONK5Q-1; Tue, 06 Dec 2022 12:11:26 -0500
X-MC-Unique: 9Oyz7yRdPnSGCYGNkONK5Q-1
Received: by mail-ed1-f70.google.com with SMTP id t4-20020a056402524400b004620845ba7bso8290420edd.4
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 09:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPkPcvfaPz48jc0UYff1aSc6omF1TVd5SJibXGywp0M=;
        b=Nqog5nRxCG0vlKxysY3WvsxYjXEWSfqXwX//0ayzEGUfkuVwI58F7b7xVDUliwENns
         AnmGaqkO6ZRQT/ateJtJy4N0jCi359r5G/RMw2rylq9ZeZ/7E2/+grDVko5kSbYqC8Ec
         IBi1/D52Q20LRn3KQmM4vrGkF0j32ofuOcnWn40kyf4a1ZMdxJS1ZgV6ZKwcH6eu44Vq
         ei55urtGQcPt2K6NtHS7e2yjC5dwguX6kIKuf7IXlkw1sVA50sXWNooUXkf6PxnY2T9F
         xxwwlw0Y8hVtBiQK1lQK9PApFPSdwY0xvReGx0qgNM8KVEdQyN0Nded/+1sFp97QFIjd
         gUGA==
X-Gm-Message-State: ANoB5plELwX4quRi1XrpduP+7120XZveQfjZZF7cZpf5N0e82wyDaD7Z
        X4C8hQGaClBJXQ/RAjpViyc6DJbzs8Ale3g2//B9dHwJ1NlqoyyXH0Iy/6P4D467SdHO9jibXB7
        ksV8G6TQ7qT9mPsy3RNA=
X-Received: by 2002:a05:6402:f27:b0:46b:d117:e5 with SMTP id i39-20020a0564020f2700b0046bd11700e5mr23914633eda.411.1670346685109;
        Tue, 06 Dec 2022 09:11:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4kXmB5VEXxS8ZIzq8dnCTJ/A7cGUeZsXyamxBde2S13/9khkZyU12cD3qyFNxIgwVoRPZY5A==
X-Received: by 2002:a05:6402:f27:b0:46b:d117:e5 with SMTP id i39-20020a0564020f2700b0046bd11700e5mr23914614eda.411.1670346684972;
        Tue, 06 Dec 2022 09:11:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402015a00b00461bacee867sm1209637edu.25.2022.12.06.09.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:11:24 -0800 (PST)
Message-ID: <1184e45f-d88c-b8b1-952d-7d6bd1ae2129@redhat.com>
Date:   Tue, 6 Dec 2022 18:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] power: supply: Added check for negative values
Content-Language: en-US, nl
To:     Denis Arefev <arefev@swemel.ru>, Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        trufanov@swemel.ru, vfh@swemel.ru
References: <20221206091723.28656-1-arefev@swemel.ru>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221206091723.28656-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/6/22 10:17, Denis Arefev wrote:
> Variable 'pirq', which may receive negative value
> in platform_get_irq().
> Used as an index in a function regmap_irq_get_virq().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index 148eb8105803..36c7039c99c2 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -640,6 +640,8 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
>  
>  	for (i = 0; i < AXP288_FG_INTR_NUM; i++) {
>  		pirq = platform_get_irq(info->pdev, i);
> +		if (pirq < 0)
> +			continue;
>  		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
>  		if (info->irq[i] < 0) {
>  			dev_warn(&info->pdev->dev,

