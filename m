Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7E485125
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jan 2022 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiAEKbA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jan 2022 05:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbiAEKbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jan 2022 05:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641378659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovKEcBuGUxRcIqX7+7Lc1LhGOcGu9eIzTSGCkr9JHjQ=;
        b=YfuqPCkm0stj1o4iX98Tme2glYoIMWi2diURc7XnRIPIErqW8UrshVYbGUjk2mDDdkhtxm
        viM7xR/1auuY0nv7CjCgEQxQSBtEOsE/ZbyzWcl+uMmLi8iNiJA/DkIAsWjNdM1WYTKJem
        goQ6pKb4HcMpGv5QNQwtkMkkeMH0LWw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-e4x7Pf7mOqK9HzLH71YJ6Q-1; Wed, 05 Jan 2022 05:30:58 -0500
X-MC-Unique: e4x7Pf7mOqK9HzLH71YJ6Q-1
Received: by mail-ed1-f70.google.com with SMTP id h6-20020a056402280600b003f9967993aeso6773472ede.10
        for <linux-pm@vger.kernel.org>; Wed, 05 Jan 2022 02:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ovKEcBuGUxRcIqX7+7Lc1LhGOcGu9eIzTSGCkr9JHjQ=;
        b=6z4zIECT6b/ZWnzlc/SKCZNHOe7sY6qaifkalO+TctEo+iTBE0U/dcZO8Mq4sBldps
         Rus1Y4fGtmvVE83peCnmKyROBhEoB1fstxZ4690fyEQhVCU8Zi3e44lk8K/NuN/iolOo
         XnvpcCuA7LrIDjxBT408QtxHjoO1AFWE/vWOqELgbWFjAnmCQiK+kNtLGoqHgj4gamBW
         vmT/PKY8RrYQbiVUoXuza24oLl1VDsWmoEr4sJCDndrbNOzYm0IV85K6ZCneKSw+GmeX
         utApQ5trRRcTuFemlzcGENeBeXGJaY8zwc7OgmtD/rtmzKWWJSCP4GJ+mUn4phOoVY8a
         7FdA==
X-Gm-Message-State: AOAM531y/V58dtfPyn581yVqXLI3EiVxJortc0TQ3cuVsUZDIum2t6UY
        Ew/z9t7RSdkwtwgGuUAoJngYsEWey2b0FlzwMn51CLPlhXiVpU1h6jiy0WRAP7yeb10/dk//NKh
        wQVVB0DhFebvh3P7aSt8=
X-Received: by 2002:a50:d691:: with SMTP id r17mr19993644edi.317.1641378657544;
        Wed, 05 Jan 2022 02:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIKB5M55j/fahdZeeAr4EDryyr/QVqa5pfGZpdaCwuQnD57LLrKcSnvTyqlhr2FH+9DLD+Lw==
X-Received: by 2002:a50:d691:: with SMTP id r17mr19993626edi.317.1641378657320;
        Wed, 05 Jan 2022 02:30:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id sh33sm3676809ejc.27.2022.01.05.02.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 02:30:56 -0800 (PST)
Message-ID: <e2795c56-f424-28ea-1c2b-b962403b0ada@redhat.com>
Date:   Wed, 5 Jan 2022 11:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] power: supply: fix charge_behaviour attribute
 initialization
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
 <20220105064239.2689-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220105064239.2689-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/5/22 07:42, Thomas Weißschuh wrote:
> All properties have to be added to power_supply_attrs which was missed
> before.
> 
> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for the quick fix.

Since the base commit for this is from pdx86/for-next I'm merging this
fix through the pdx86 tree too:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 5e3b8c15ddbe..491ffec7bf47 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -178,6 +178,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>  	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> +	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
>  	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>  	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> 
> base-commit: 998e7ea8c641fc6bbca1acd478c6824733ac9851
> 

