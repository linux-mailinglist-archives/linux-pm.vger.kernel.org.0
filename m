Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622D834747D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 10:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhCXJZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 05:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbhCXJZT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 05:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616577918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiJLpsb7sBqIFEZS6k034QylOs9bBEzr4nsRk/aiDe8=;
        b=ZHDvb8yHlVG5wTwDM6eDRiW0HaHj5y0aYes7xSA5EBXz34lGGuKqiSL0G6lzeKlLmfamEm
        lUDWFhiCbEh8bHnSG87IUL4zzZ2IiworLcC7XlpC8622G0xa5r34B+iMCHGwPo0Hp5HwmS
        BGJcIVyIjYmD5DFxvG8VhmlSxwS2dZA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-eyFfRJ8gMqmOq9hRtTIfzg-1; Wed, 24 Mar 2021 05:25:16 -0400
X-MC-Unique: eyFfRJ8gMqmOq9hRtTIfzg-1
Received: by mail-ej1-f71.google.com with SMTP id gn30so640899ejc.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 02:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KiJLpsb7sBqIFEZS6k034QylOs9bBEzr4nsRk/aiDe8=;
        b=amRW38r4rFGDOxSGK29PycDcgkTvnqAiu+c4mDdjuFbvuuyqNVfAPyl3oFEi4WgrbE
         Jycz9lv5x2vVsromqKtW0WD+mmZ+q8Sq/4Q9/QO7SlJbaDNtEe/xB7ZclECpKrGNXPGq
         INDiYZcDlN+A0S7l6KJPSbaxpFrcs855IW6NLmb2yne1sxG7U1+dkdChxylJtzK/VqFa
         PVNUVmzNVfT0LnxuAm4XRV1R/IlrkctzciLrxhZXGAO9+x0dBfV7T6DLxLj2Nz40eCsU
         Pp4uU3v1/7fvApdchUYar3pio6IkkdEUWfXujYxD1UVTA5OstwdKcfHJrlaLoO5FTHii
         y+vA==
X-Gm-Message-State: AOAM531t2pzJBb1IiLUyAEZkFi+PDmNWgv/E++QtdmPpipRnx5aKRig8
        K3FbuUHVV4wGC2YCqGnREoqZy93yFIVaJLp27RuX2uhZfagO5zp0DQQ1q19Ozq9ZkJRCVmn2va+
        SUDCpK5vzypmJv/5/UKrjiUsL9hEWfDyJ7vB0cRGHIHc+TGss12YubqtsPf1ko3WS18GdYAg=
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr2411492ede.271.1616577915115;
        Wed, 24 Mar 2021 02:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8V99Ml56KJxiioMzpj7liCOYIdYohqtPnMXbGUTkOxugweGmjzgcdLDZgoJhNHBmZAVkj8g==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr2411467ede.271.1616577914888;
        Wed, 24 Mar 2021 02:25:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q26sm632370eja.45.2021.03.24.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 02:25:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init
 fails
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1860d4e8-2e3a-fe05-cab9-782f3e35b9ab@redhat.com>
Date:   Wed, 24 Mar 2021 10:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/24/21 10:21 AM, Matti Vaittinen wrote:
> Add error print for probe failure when resource managed work-queue
> initialization fails.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-gpio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
> index 4105df74f2b0..8ea2cda8f7f3 100644
> --- a/drivers/extcon/extcon-gpio.c
> +++ b/drivers/extcon/extcon-gpio.c
> @@ -114,8 +114,10 @@ static int gpio_extcon_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = devm_delayed_work_autocancel(dev, &data->work, gpio_extcon_work);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize delayed_work");
>  		return ret;
> +	}

The only ret which we can have here is -ENOMEM and as a rule we don't log
errors for those, because the kernel memory-management code already complains
loudly when this happens.

So IMHO this patch should be dropped.

Regards,

Hans




>  
>  	/*
>  	 * Request the interrupt of gpio to detect whether external connector
> 

