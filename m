Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3E7E104A
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 17:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjKDP5P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjKDP5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 11:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C390D47
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699113389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu0yxQVgh8LZcS06ybl4uuzt7ICJ1NlebM+PyuIfalc=;
        b=Nf/huB3i5QnF+crZfMr4AUav60vVzMm/d+CHUeoDuFylKZB2OB/najW8m2RhsTzH1cf3Iq
        Phgdl0snAaRL1ZC+h4mAZBpUJO86fXd1X8srXzgtm918OO3IdNMAqVE0BHjT/Cc3jMu9in
        VFpi4RGjPXDIk/0J79Mbfy2xe2g0Cxw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-JoSw9NX0OQuUuRf9asrYPQ-1; Sat, 04 Nov 2023 11:56:27 -0400
X-MC-Unique: JoSw9NX0OQuUuRf9asrYPQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso220131866b.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Nov 2023 08:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699113386; x=1699718186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tu0yxQVgh8LZcS06ybl4uuzt7ICJ1NlebM+PyuIfalc=;
        b=OT5k8S38/w8qInzqFpJJI6a9tBM+jMGfLxIJfAcvPRNe2t6jjrY4TVFfFrVlsSm8dr
         Lc4g7QNFf+v+zx+JcWqRjFWr/FWqS18vCzXMgD9I2T5p09YdE9WULK2kCQeigc/qITne
         8nsqJBjWpxxhbUhzd1Dsc8wPI7qY5TDAiL/aN92URI2uSlYATQyF4Rv0N1ipaxgVZRYl
         3QciAEsK5TvznIivTZ3XzKe+eu8xCzcb8g6+rnmcEe/bDXvQpUACptH7SdEEHAheK74a
         NIx9DFcNOnnT4+X77budc2BMIVud4dqndJIn1GalMmgxG01j9J2nBuCkMbNA5+VbzYti
         LASg==
X-Gm-Message-State: AOJu0YyplRqmSXtGPlLi9FZn7FRtQngYf02n435Scx+jA9afEGGm83CC
        o3OfLzJdVZcK7fKgq+MfBVR+nOpVC1lomZzonlAIsUAR6lQWVh9m6Z5rECBuENE+9t7nWVELg0b
        yEWMfWTSiD8DtI6yLJrs=
X-Received: by 2002:a17:907:d2a:b0:9de:cfa1:f072 with SMTP id gn42-20020a1709070d2a00b009decfa1f072mr807495ejc.25.1699113386585;
        Sat, 04 Nov 2023 08:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+DKP1FMkR8SLdZDfao0XD7Ls7CDn0QfL8+3lymuJOxppHd8ZmET41G37Zyo4X2YI9O7/zw==
X-Received: by 2002:a17:907:d2a:b0:9de:cfa1:f072 with SMTP id gn42-20020a1709070d2a00b009decfa1f072mr807490ejc.25.1699113386250;
        Sat, 04 Nov 2023 08:56:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id uz29-20020a170907119d00b009920e9a3a73sm2077712ejb.115.2023.11.04.08.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 08:56:25 -0700 (PDT)
Message-ID: <c79c8955-36b0-d2bd-f70d-ce898afcbeab@redhat.com>
Date:   Sat, 4 Nov 2023 16:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] power: supply: bq27xxx: Stop and start delayed work in
 suspend and resume
Content-Language: en-US, nl
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>
References: <20231104154920.68585-1-marex@denx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231104154920.68585-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 11/4/23 16:49, Marek Vasut wrote:
> This driver uses delayed work to perform periodic battery state read out.
> This delayed work is not stopped across suspend and resume cycle. The
> read out can occur early in the resume cycle. In case of an I2C variant
> of this hardware, that read out triggers I2C transfer. That I2C transfer
> may happen while the I2C controller is still suspended, which produces a
> WARNING in the kernel log.
> 
> Fix this by introducing trivial PM ops, which stop the delayed work before
> the system enters suspend, and schedule the delayed work right after the
> system resumes.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 22 ++++++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c |  1 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 4296600e8912a..1c4a9d1377442 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -2162,6 +2162,28 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
>  }
>  EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int bq27xxx_battery_suspend(struct device *dev)
> +{
> +	struct bq27xxx_device_info *di = dev_get_drvdata(dev);
> +
> +	cancel_delayed_work(&di->work);
> +	return 0;
> +}
> +
> +static int bq27xxx_battery_resume(struct device *dev)
> +{
> +	struct bq27xxx_device_info *di = dev_get_drvdata(dev);
> +
> +	schedule_delayed_work(&di->work, 0);
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +SIMPLE_DEV_PM_OPS(bq27xxx_battery_battery_pm_ops,
> +		  bq27xxx_battery_suspend, bq27xxx_battery_resume);
> +EXPORT_SYMBOL_GPL(bq27xxx_battery_battery_pm_ops);
> +
>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>  MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index 9b5475590518f..3a1798b0c1a79 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -295,6 +295,7 @@ static struct i2c_driver bq27xxx_battery_i2c_driver = {
>  	.driver = {
>  		.name = "bq27xxx-battery",
>  		.of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
> +		.pm = &bq27xxx_battery_battery_pm_ops,
>  	},
>  	.probe = bq27xxx_battery_i2c_probe,
>  	.remove = bq27xxx_battery_i2c_remove,
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 7c8d65414a70a..7d8025fb74b70 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -83,5 +83,6 @@ struct bq27xxx_device_info {
>  void bq27xxx_battery_update(struct bq27xxx_device_info *di);
>  int bq27xxx_battery_setup(struct bq27xxx_device_info *di);
>  void bq27xxx_battery_teardown(struct bq27xxx_device_info *di);
> +extern const struct dev_pm_ops bq27xxx_battery_battery_pm_ops;
>  
>  #endif

