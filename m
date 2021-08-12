Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E583EA76C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhHLPU4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 11:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235613AbhHLPUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 11:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628781629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5OMPPEs9ujuHSvx/fxuwi84cH52/9VQwos/NS7fl/I=;
        b=KFtcVHyjgffkDWLkZNaBv0HYO5e8SSFSE1k9ZUSABCgXcp0wr3LUG9WGzar9+qlt4+lvlp
        XzWpmj5KHHJJk14sWLARJgw3NPiceKl9uba25sIup+hlewZE0jqdP/CLcWbzt0/FnD5/Fg
        veZh4BdKmCjzy4ZW2/3GGon7Vfxq2ng=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-clRrRTZUOfewAIHYfEjM2w-1; Thu, 12 Aug 2021 11:20:28 -0400
X-MC-Unique: clRrRTZUOfewAIHYfEjM2w-1
Received: by mail-ed1-f69.google.com with SMTP id v11-20020a056402348bb02903be68e116adso3186678edc.14
        for <linux-pm@vger.kernel.org>; Thu, 12 Aug 2021 08:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5OMPPEs9ujuHSvx/fxuwi84cH52/9VQwos/NS7fl/I=;
        b=hIgBNxLYA59/QDNRvBOR/JS8g2fcT2XLyxOCTiPz0k7wmFKSYh0d+8+9frcCWLYVaZ
         K6EiP+e5yMnlnWdP5YW+KG1Imp2oEoUEu6z/rGRHfjCNB2A3lagg4bIh9rQlW9A/gbTJ
         dbQa5UJYzrDMvNnnwKnAL0G+SO513Vsp4fbYhb5w0YT475F/6gZoc4Zpygn0NZds8DJW
         Cjxn2594DhM8fj5kDiqDcmkm2i5bE/dpdcLfJfme4jVL/qsxi71NsEpmiB1t4g93Auz4
         OLHD+ooX9KaRKhcr3FaIDG3ddWZ3z8XoMivYvP/vmdIY2JgTwUOi5fa6aMziJmFLxpRt
         DSYg==
X-Gm-Message-State: AOAM5336hIklG8rNBWkimUtRVm97KrTh1dLOwa99vRlbaTg7+G2e/vOG
        oEJEkQUWEcKO+b55JnJp1VtMidkkE2QKwqwvhUGkG1WC9UHbVi28nKdf9hXpAUmfd1VHzRHi8/J
        qErDXGyRq1MVTzR5WMm8=
X-Received: by 2002:a17:906:b782:: with SMTP id dt2mr2289074ejb.294.1628781626988;
        Thu, 12 Aug 2021 08:20:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywupV1SnYcXA6ApxaFvollFdpNxIJ9e+zDqIZXTpGac6DGPWBaUtFJCw4GtFfotIFaTRHwOw==
X-Received: by 2002:a17:906:b782:: with SMTP id dt2mr2289061ejb.294.1628781626752;
        Thu, 12 Aug 2021 08:20:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jo17sm941344ejb.40.2021.08.12.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:20:26 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_charger: Use the defined variable
 to clean code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, sre@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210811104929.24608-1-tangbin@cmss.chinamobile.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <60b7038f-2c68-4559-6a97-a5f2bc97647f@redhat.com>
Date:   Thu, 12 Aug 2021 17:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811104929.24608-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/11/21 12:49 PM, Tang Bin wrote:
> Use the defined variable "dev" to make the code cleaner.
> 
> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/power/supply/axp288_charger.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index a4df1ea92..b9553be9b 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -813,7 +813,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	if (val == 0)
>  		return -ENODEV;
>  
> -	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> @@ -823,7 +823,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  
>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
>  	if (info->cable.edev == NULL) {
> -		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
> +		dev_dbg(dev, "%s is not ready, probe deferred\n",
>  			AXP288_EXTCON_DEV_NAME);
>  		return -EPROBE_DEFER;
>  	}
> @@ -834,8 +834,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
>  			return -EPROBE_DEFER;
>  		}
> -		dev_info(&pdev->dev,
> -			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> +		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
>  
>  	platform_set_drvdata(pdev, info);
> @@ -874,7 +873,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
>  	if (info->otg.cable) {
> -		ret = devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
> +		ret = devm_extcon_register_notifier(dev, info->otg.cable,
>  					EXTCON_USB_HOST, &info->otg.id_nb);
>  		if (ret) {
>  			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> @@ -899,7 +898,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  					NULL, axp288_charger_irq_thread_handler,
>  					IRQF_ONESHOT, info->pdev->name, info);
>  		if (ret) {
> -			dev_err(&pdev->dev, "failed to request interrupt=%d\n",
> +			dev_err(dev, "failed to request interrupt=%d\n",
>  								info->irq[i]);
>  			return ret;
>  		}
> 

