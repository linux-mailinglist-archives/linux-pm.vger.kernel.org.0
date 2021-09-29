Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2689E41C9D2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 18:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbhI2QMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbhI2QLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 12:11:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2ECC0A8852
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 09:05:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e7so3223715pgk.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iPZWDAx0qWwZzHFVEm3VSfYd1Fg6OsO8uQ8mpVALYQU=;
        b=AXrVwPojIE4uuzG7pPTAKD3WXTkIW7u8otsUFj+JRd4GoZvtN/YQthTvdooEZbcZo7
         aHywxGXY5hlm4zvz9jQa+9ggg80V44AKmst/0zbHFY9+CJtQBjSKd9WVrXoYgWsQG26z
         tgAjdSm5Q1n2kkrehCHUTZo4hOmdCAvGPBoMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPZWDAx0qWwZzHFVEm3VSfYd1Fg6OsO8uQ8mpVALYQU=;
        b=4C+N0oQQGcdAVJr532QrfUt29o9reXAYK82Vs1oUjg/+WmqWNoH1BshoAWIX392A3I
         2FKzSVWdvOrXQg85qukz/c7L1Mw2L12VEizO9jkSIU/6MT+hMc97YgMdZtiZbiZq158d
         9XOSrkp/JN9qS5hXJhtYlvhPQt89cWawj3xUm0e3s44IZfzck2B93VnNZzZ2v6wQIrEk
         bM9uRxn2uM9ovLDi7GmdXq29IeTKbqJI9r2p0iabXpsZZudBUKM5jYF3FDg/pv4wdXy+
         M9a87ELL3WoGzLJKT3ELvGDV+ZkZy9hOe8aHXxe2BAUPF4a7BEF6NfGv4ZaafG4d/8j8
         r6sg==
X-Gm-Message-State: AOAM533dyExNH+gQjX7eVFfsk+/KAT1G7CLuwkhVMuHTrdd3bTxj6GdA
        iuTgocoL/FGabXn53FPSDJjYig==
X-Google-Smtp-Source: ABdhPJwYQb4hg5NWlIAGORTVH1GszFgHnOpA6V9qlo0sosJpSk16u7/1gK7AbpU2wJpHAI1HFMGQzA==
X-Received: by 2002:a62:1943:0:b0:444:f894:e19d with SMTP id 64-20020a621943000000b00444f894e19dmr659672pfz.36.1632931541989;
        Wed, 29 Sep 2021 09:05:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2f10:2763:4825:1f01])
        by smtp.gmail.com with UTF8SMTPSA id x9sm2479313pjp.50.2021.09.29.09.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:05:41 -0700 (PDT)
Date:   Wed, 29 Sep 2021 09:05:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Fix a build failure due to
 psy_has_property() definition location
Message-ID: <YVSO1NYeegW/trvr@google.com>
References: <20210929130218.26598-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929130218.26598-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi SeongJae,

thanks for the fix!

Geert sent a similar patch earlier:

https://patchwork.kernel.org/project/linux-pm/patch/7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be/

On Wed, Sep 29, 2021 at 01:02:18PM +0000, SeongJae Park wrote:
> Commit 9ba533eb99bb ("power: supply: core: Add psy_has_property()") in -next
> tree defines 'psy_has_property()' when 'CONFIG_THERMAL' is set.  But, it is
> also called from '__power_supply_register()', which is defined even if
> 'CONFIG_THERMAL' is unset.  As a result, the build fails when 'CONFIG_THERMAL'
> is undefined as below.
> 
>     .../drivers/power/supply/power_supply_core.c: In function '__power_supply_register':
>     .../drivers/power/supply/power_supply_core.c:1137:6: error: implicit declaration of function 'psy_has_property' [-Werror=implicit-function-declaration]
>      1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>           |      ^~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>     .../scripts/Makefile.build:288: recipe for target 'drivers/power/supply/power_supply_core.o' failed
>     make[4]: *** [drivers/power/supply/power_supply_core.o] Error 1
> 
> This commit fixes the issue by moving the definition out of the '#ifdef' block.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 75575ea45f21..fc12a4f407f4 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -951,6 +951,22 @@ void power_supply_unreg_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
>  
> +static bool psy_has_property(const struct power_supply_desc *psy_desc,
> +			     enum power_supply_property psp)
> +{
> +	bool found = false;
> +	int i;
> +
> +	for (i = 0; i < psy_desc->num_properties; i++) {
> +		if (psy_desc->properties[i] == psp) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	return found;
> +}
> +
>  #ifdef CONFIG_THERMAL
>  static int power_supply_read_temp(struct thermal_zone_device *tzd,
>  		int *temp)
> @@ -975,22 +991,6 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
>  	.get_temp = power_supply_read_temp,
>  };
>  
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> -{
> -	bool found = false;
> -	int i;
> -
> -	for (i = 0; i < psy_desc->num_properties; i++) {
> -		if (psy_desc->properties[i] == psp) {
> -			found = true;
> -			break;
> -		}
> -	}
> -
> -	return found;
> -}
> -
>  static int psy_register_thermal(struct power_supply *psy)
>  {
>  	int ret;
> -- 
> 2.17.1
> 
