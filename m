Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72922433A73
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhJSPdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJSPdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 11:33:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C01BC06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 08:31:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso3349887wmc.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hWPE/Y/ECpv7Nj8NIi2n9F0tYkWU75xKYRtFUZ6yu9s=;
        b=cXlmp7HR3xEDoFJWVos0V9Jwf9q4NPIIzfiDylFcxk4jSANGoVNmWY8OhtlMtn1ZRf
         jmcULs5B+rgkm9KmyKpFc+KQh+uTCu/G6xym7RP+EyjChNKrOYOTo2pQs8bpPryXSA49
         PhkQe3WiON7NbBNPvpiWYUGHQr2H8TBe1OEBPXHsjLgQv+VW4LEwVBHpPqm97NT3RMKT
         rXw1IHaPrxdibHGpIzN24IZxVYQZDTmKeNI5Uercj1qtVscydAgF+uz5RFiu0eLB8CJr
         m7FsjmdImme4i7w0zj1VePOBGg9DogBOQWQSkx4XuNcJ0MrJC0wgR4AgxbUQfTdPe27i
         GZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hWPE/Y/ECpv7Nj8NIi2n9F0tYkWU75xKYRtFUZ6yu9s=;
        b=1gHhn2+dlqgC0Jq0CM9ZUgPwBHSn1XCV0VpiRNgMJUvwHe44WgyJRONvKCqUCKRz08
         wF7HW3xKhBT2qNnaMQJAtFBjXdb8lDeAKnQwpjCfyFgjwryqXd4piz8Jb6E8sVMMwAu3
         vJ4heFd4NmkrD9syWPhfZ52v8ENRqpFkKSgv7R5Jn4OKVXrVKnDzYfaTxf57iKAgFLm6
         x5V464dDWMfhpbTe+aoDJ2sSJP9JMCyFBZzjYcfFHTP38QADw8Dvuzo28be+t+LlZiGw
         QejePKbeFQBmzFzd9s2KCUZV5npjsjo6iTH4BwHsTSVaJaHJt9JPVaQL1mndQoURHVCa
         dKyw==
X-Gm-Message-State: AOAM5324Yni3TNWJSAt1ttPbe87o7EjxaCPmWiFq+3WtyWWyjlNt5kdi
        r8pqEoZqSvNAVJXxID5KCbt6KA==
X-Google-Smtp-Source: ABdhPJwE++nuRUOafKF1FDx4c8fEJkumkcgktNXraYcUxFliyvGucR0udxGE/SIQDOsvk3Ceiioy2Q==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr6819075wmg.25.1634657491936;
        Tue, 19 Oct 2021 08:31:31 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id n9sm2650947wmq.6.2021.10.19.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:31:31 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:31:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 4/6] mfd: max77620: Use power off call chain API
Message-ID: <YW7k0SW73kcvyo2W@google.com>
References: <20211007060253.17049-1-digetx@gmail.com>
 <20211007060253.17049-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007060253.17049-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 07 Oct 2021, Dmitry Osipenko wrote:

> Use new power off call chain API which allows multiple power off handlers
> to coexist. Nexus 7 Android tablet can be powered off using MAX77663 PMIC
> and using a special bootloader command. At first the bootloader option
> should be tried, it will have a higher priority than the PMIC.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/max77620.c       | 22 +++++++++++++++-------
>  include/linux/mfd/max77620.h |  2 ++
>  2 files changed, 17 insertions(+), 7 deletions(-)

I don't have a problem with the approach in general.

I guess it's up to the relevant maintainers to decide.

> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index fec2096474ad..ad40eed1f0c6 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c
> @@ -31,11 +31,10 @@
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -static struct max77620_chip *max77620_scratch;
> -
>  static const struct resource gpio_resources[] = {
>  	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
>  };
> @@ -483,13 +482,17 @@ static int max77620_read_es_version(struct max77620_chip *chip)
>  	return ret;
>  }
>  
> -static void max77620_pm_power_off(void)
> +static int max77620_pm_power_off(struct notifier_block *nb,
> +				 unsigned long reboot_mode, void *data)
>  {
> -	struct max77620_chip *chip = max77620_scratch;
> +	struct max77620_chip *chip = container_of(nb, struct max77620_chip,
> +						  pm_off_nb);
>  
>  	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
>  			   MAX77620_ONOFFCNFG1_SFT_RST,
>  			   MAX77620_ONOFFCNFG1_SFT_RST);
> +
> +	return NOTIFY_DONE;
>  }
>  
>  static int max77620_probe(struct i2c_client *client,
> @@ -566,9 +569,14 @@ static int max77620_probe(struct i2c_client *client,
>  	}
>  
>  	pm_off = of_device_is_system_power_controller(client->dev.of_node);
> -	if (pm_off && !pm_power_off) {
> -		max77620_scratch = chip;
> -		pm_power_off = max77620_pm_power_off;
> +	if (pm_off) {
> +		chip->pm_off_nb.notifier_call = max77620_pm_power_off;
> +		chip->pm_off_nb.priority = 128;
> +
> +		ret = devm_register_poweroff_handler(chip->dev, &chip->pm_off_nb);
> +		if (ret < 0)
> +			dev_err(chip->dev,
> +				"Failed to register poweroff handler: %d\n", ret);
>  	}
>  
>  	return 0;
> diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
> index f552ef5b1100..99de4f8c9cbf 100644
> --- a/include/linux/mfd/max77620.h
> +++ b/include/linux/mfd/max77620.h
> @@ -8,6 +8,7 @@
>  #ifndef _MFD_MAX77620_H_
>  #define _MFD_MAX77620_H_
>  
> +#include <linux/notifier.h>
>  #include <linux/types.h>
>  
>  /* GLOBAL, PMIC, GPIO, FPS, ONOFFC, CID Registers */
> @@ -327,6 +328,7 @@ enum max77620_chip_id {
>  struct max77620_chip {
>  	struct device *dev;
>  	struct regmap *rmap;
> +	struct notifier_block pm_off_nb;
>  
>  	int chip_irq;
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
