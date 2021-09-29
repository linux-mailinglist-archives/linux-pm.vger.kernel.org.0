Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5F41C9C3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbhI2QLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbhI2QL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 12:11:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD7C09B048
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 09:04:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso125344pjb.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ZLKzrScsQnzTs84HcwL2ejPyedqmbqKclbJYZ0BcZA=;
        b=aSTJn7IPpezQwdt5L3ACV/zO+CgIPfSg9Btwag4MWyrXK4YkEWaVw71JQ+FAjtPnJb
         pMBKw6Ckj0/4I/NektvZjUhMoRqOI7qsCF18zFuMlZafOZl1T3tenlrHLqsQqM16oWg2
         29FsLFg1cOsMvTNR04CVPUWRGiJ9mbI4e2b3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZLKzrScsQnzTs84HcwL2ejPyedqmbqKclbJYZ0BcZA=;
        b=dPhg/gmihrPHO1vPFQci9NG3L9wLhx4zXY94CuaouUYP8kzrgBxtEWeb1v1lxdJSne
         XD6WcKF34MEWeaQkPBAOrlXNMIc85EzcCZilBh8Byx10OUq5NUxLwx5qbs50i/FmjktN
         IJMPFQJmpsQqpcaVBEn94FHbGSBoFeyw21KjZY0Jtb+pPi7eaB3PhxQXWgpd52ajlkOg
         OmroKvC3KiOPgOV1bRuSGAFQ8OGRoRc6jrENaJ2bQVwh1sjCucOfFOSxXr3uJPsfiTKD
         VK6iXFL/bFe6AnEh8icSMS9BQjT+TKCYGHj45EtyoF8rKRUpWFFTo0A9hh1MBjj8AqRn
         OdrA==
X-Gm-Message-State: AOAM531PuvC8N2R9Qih2BxsvIZDHJEsdQ64ff/JshrxtQw8c4X142WAL
        0+kMjZDddEZM2Y5Otwa80kL/2Q==
X-Google-Smtp-Source: ABdhPJwp7xMcWLHJahwnmdPWenVYDmD898crmWNntH+OIdTH+mMdXb+gNkNCW5DMJZS7QBluu9r1FQ==
X-Received: by 2002:a17:90a:cc9:: with SMTP id 9mr7424948pjt.142.1632931474872;
        Wed, 29 Sep 2021 09:04:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2f10:2763:4825:1f01])
        by smtp.gmail.com with UTF8SMTPSA id z85sm251870pfc.162.2021.09.29.09.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:04:34 -0700 (PDT)
Date:   Wed, 29 Sep 2021 09:04:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     trix@redhat.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: move psy_has_property()
Message-ID: <YVSOkUuEP6uSjMOB@google.com>
References: <20210928144046.272926-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210928144046.272926-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tom,

thanks for the fix!

Geert sent a similar patch earlier:

https://patchwork.kernel.org/project/linux-pm/patch/7b35a74f2c2ad19c8dc1ca60c59e48a14288677f.1632830348.git.geert+renesas@glider.be/

On Tue, Sep 28, 2021 at 07:40:46AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A ranconfig produces this error
> power_supply_core.c:1137:6: error: implicit declaration
>   of function 'psy_has_property'
>  1137 |  if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> 
> psy_has_property() compiling is conditional on THERMAL.  It is used
> in __power_supply_register() to check a non thermal property.
> So move psy_has_property() out of the THERMAL conditional.
> 
> Fixes: 9ba533eb99bb ("power: supply: core: Add psy_has_property()")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/power/supply/power_supply_core.c | 32 ++++++++++++------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 75575ea45f21dd..fc12a4f407f431 100644
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
> 2.26.3
> 
