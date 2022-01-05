Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C473D48511F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jan 2022 11:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiAEK2s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jan 2022 05:28:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbiAEK2r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jan 2022 05:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641378526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEs6uEOn5bynEz7H/JxvWjPO6yvH3MXk25LcscMmWok=;
        b=S5MdtMUExVmDKMRtis8KvFJE6YKFeCHG8ewPzA0NDFn0+JBHSyJ+ih5nGuWZOF1/AxqtJO
        I/PUM5T1w0RnEiiSlHEMbsnMmcdwISkgdCqIhcA/SLQJ9Ns1joYIvSL7lxZRVx4OvnXviK
        6mqAcLMWClINBSGksh52Ts0cSJLGNgc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-OKflcxRmOx2VuajdLcbU5A-1; Wed, 05 Jan 2022 05:28:45 -0500
X-MC-Unique: OKflcxRmOx2VuajdLcbU5A-1
Received: by mail-ed1-f69.google.com with SMTP id w6-20020a05640234c600b003f916e1b615so18425135edc.17
        for <linux-pm@vger.kernel.org>; Wed, 05 Jan 2022 02:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pEs6uEOn5bynEz7H/JxvWjPO6yvH3MXk25LcscMmWok=;
        b=cJRHmGDF6QA+aF3LFx9VFzXDvWssr9TOTB01IH1aBGClqdzTYU/JC86WlziGEPpjcT
         6gMPCl9r1yOu0KwK8da4XGW8Bu6lYQ7AvU513hshDIMhlhV75VAd38yWl/KdZB2QWZr6
         SUcRDv97TdFy5NUJlcsEonPN84Zfg+dixVzowbuYLY1nE5aPAadfFWGdKpHzxmQQRN7H
         1v1jxN0XPkTwtbPPY1TUxpe2nfN9uxfmrqkvojJu41w+KAE8Dfy0IWBmmOMcpoPlYV/I
         CfIlYUr6aLciwsXfc8eCceC2haxYwRjXcHfvxfP1l4XfgkBuNHEFXQCg60dRK7hTl0RQ
         reUw==
X-Gm-Message-State: AOAM532Slr30VUq/w+/NUNfAk0/4qwmLb2sMRVqcGilHaRlF7wxSpIJL
        rhT6nKKPfXyE/bvE/ygRm7bh3+8sSSmkULl8efDRnMuNrSOJL9NxG6bhywVuevrhfCFNlYVK90G
        ZOJvNmBGAfjIn9LqV44M=
X-Received: by 2002:a17:907:9718:: with SMTP id jg24mr42841194ejc.621.1641378524619;
        Wed, 05 Jan 2022 02:28:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6UIdx5aTKSAp+tVkzkYzs4g2klQ7TVpLQjANWXLL8Hr+DDRKHqorl53qYM+VF2XnWm49aQA==
X-Received: by 2002:a17:907:9718:: with SMTP id jg24mr42841181ejc.621.1641378524464;
        Wed, 05 Jan 2022 02:28:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id p7sm15606637edu.84.2022.01.05.02.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 02:28:44 -0800 (PST)
Message-ID: <230c479e-00fa-7e04-beca-876c6c28e414@redhat.com>
Date:   Wed, 5 Jan 2022 11:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Warning since "power: supply: add charge_behaviour attributes"
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>
References: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Heiner,

On 1/5/22 00:03, Heiner Kallweit wrote:
> Since 1b0b6cc8030d ("power: supply: add charge_behaviour attributes") I get the following warning:
> power_supply_init_attrs: Property 37 skipped because it is missing from power_supply_attrs
> Seems the patch misses the following:
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 2cfce2b2e..ef5109102 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -179,6 +179,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>         POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
>         POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>         POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> +       POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
>         POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
>         POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
>         POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> 
> Didn't this show up when testing before submitting the patch?

Thank you for reporting this.

The warning did show up in dmesg, but the attribute still works despite the warning
because it is injected as an "extra" property through the drivers/acpi/battery.c
battery_hook_register() mechanism which uses device_add_groups() to add extra
properties handled by vendor specific extensions.

These extra properties do not use the drivers/power/supply/power_supply_sysfs.c
registered attributed handlers and this caused us to miss this, since everything
still works fine for the current user of the new charge_behaviour attribute
despite the warning.

And we completely missed the warning in dmesg.

Regards,

Hans

