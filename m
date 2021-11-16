Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCA452F9A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 11:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhKPLBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 06:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhKPLBS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 06:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637060301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kY0B8yGVYk8MaOQx8xvl+ZB1I0VF4H2dddqWO+tZ2pc=;
        b=XdXnV8zWUe2u7QFcfv4ESqCbDuppkxfU1epWwpC2PSo47wtiUx/DtVWrl7z9op9YTmMGYk
        1LAwpXz85tUV/axlSH2d1HnJk7u1V/6Pg0tRz0LRqEiRwwbdouCIUOcPDIuZ6pAsHTIagW
        RndFcqnmnhsvSzOsebiw/7pNCQcHXkQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-gZZHgv5OPQG92wmoiegwMQ-1; Tue, 16 Nov 2021 05:58:19 -0500
X-MC-Unique: gZZHgv5OPQG92wmoiegwMQ-1
Received: by mail-ed1-f72.google.com with SMTP id f4-20020a50e084000000b003db585bc274so16774681edl.17
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 02:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kY0B8yGVYk8MaOQx8xvl+ZB1I0VF4H2dddqWO+tZ2pc=;
        b=Ictjszyp9Xhm414brPN7AfPpZE8lNTsM7W127GaQH+A/rYnMNyFgvEaSxh9Pw1BOsl
         mXZEvIAHsV6VfR/2jRuYlj3+VeXQ+Gl3fxKLlUSDgMAqQMAmdQUsKets+S7ubuB7T5iT
         Q88OErwFcs2VQ0+F/zUosUtkV6tbs1FkIaAmzH1RDxyLtgSBqybg4APz0gGzFOs9sLBO
         0mPXjMcjxMnn+dV5LHQT8I4UW9YF78QakGwZU/2SFzBEH+7Ldx5kpuMwsuQQlTYAc+0x
         WA6DoPwmLztgPNhhrX+jqaFb+h3RmjDGqqVRsw9U1dJJ0arPC25o9ETL3IIHdrxz+dYu
         APxA==
X-Gm-Message-State: AOAM5328GOXO4sa9YIS+SPMnk2uQepBjNNuwC9ms+CnJgn4iXCJSvvsy
        1axXTG5aHsxpvJuMFjN54sUQ7DtvrjGr+ihvDCUrIpVf78mo7eU5neTauj5AAgK4FnjG6qy/mWj
        z23Iq32MOe+V08UQzQa4=
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr8757032ejc.249.1637060298615;
        Tue, 16 Nov 2021 02:58:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIEbJVQs6Ie/485xAX3626rJajgjdDhHYqVaN7DlmCbvpayCdiFexQj8i/fiIF/lTRfUn0LQ==
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr8756992ejc.249.1637060298317;
        Tue, 16 Nov 2021 02:58:18 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bo20sm9304943edb.31.2021.11.16.02.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:58:18 -0800 (PST)
Message-ID: <09a66da1-1a8b-a668-3179-81670303ea37@redhat.com>
Date:   Tue, 16 Nov 2021 11:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] platform/x86: thinkpad_acpi: support inhibit-charge
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
References: <20211113104225.141333-1-linux@weissschuh.net>
 <20211113104225.141333-5-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211113104225.141333-5-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

Thank you for working on this!

On 11/13/21 11:42, Thomas Weißschuh wrote:
> This adds support for the inhibit-charge charge_behaviour through the
> embedded controller of ThinkPads.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> This patch is based on https://lore.kernel.org/platform-driver-x86/d2808930-5840-6ffb-3a59-d235cdb1fe16@gmail.com/
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 55 +++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index e8c98e9aff71..7cd6475240b2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9321,6 +9321,8 @@ static struct ibm_struct mute_led_driver_data = {
>  #define SET_STOP	"BCSS"
>  #define GET_DISCHARGE	"BDSG"
>  #define SET_DISCHARGE	"BDSS"
> +#define GET_INHIBIT	"PSSG"
> +#define SET_INHIBIT	"BICS"
>  
>  enum {
>  	BAT_ANY = 0,
> @@ -9338,6 +9340,7 @@ enum {
>  	THRESHOLD_START,
>  	THRESHOLD_STOP,
>  	FORCE_DISCHARGE,
> +	INHIBIT_CHARGE,
>  };
>  
>  struct tpacpi_battery_data {
> @@ -9409,6 +9412,13 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
>  		/* The force discharge status is in bit 0 */
>  		*ret = *ret & 0x01;
>  		return 0;
> +	case INHIBIT_CHARGE:
> +		/* This is actually reading peak shift state, like tpacpi-bat does */
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
> +			return -ENODEV;
> +		/* The inhibit charge status is in bit 0 */
> +		*ret = *ret & 0x01;
> +		return 0;
>  	default:
>  		pr_crit("wrong parameter: %d", what);
>  		return -EINVAL;
> @@ -9447,6 +9457,22 @@ static int tpacpi_battery_set(int what, int battery, int value)
>  			return -ENODEV;
>  		}
>  		return 0;
> +	case INHIBIT_CHARGE:
> +		/* When setting inhibit charge, we set a default value of
> +		 * always breaking on AC detach and the effective time is set to
> +		 * be permanent.
> +		 * The battery ID is in bits 4-5, 2 bits,
> +		 * the effective time is in bits 8-23, 2 bytes.
> +		 * A time of FFFF indicates forever.
> +		 */
> +		param = value;
> +		param |= battery << 4;
> +		param |= 0xFFFF << 8;
> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_INHIBIT, &ret, param))) {
> +			pr_err("failed to set inhibit charge on %d", battery);
> +			return -ENODEV;
> +		}
> +		return 0;
>  	default:
>  		pr_crit("wrong parameter: %d", what);
>  		return -EINVAL;
> @@ -9467,6 +9493,8 @@ static int tpacpi_battery_probe(int battery)
>  	 * 4) Check for support
>  	 * 5) Get the current force discharge status
>  	 * 6) Check for support
> +	 * 7) Get the current inhibit charge status
> +	 * 8) Check for support
>  	 */
>  	if (acpi_has_method(hkey_handle, GET_START)) {
>  		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> @@ -9513,6 +9541,16 @@ static int tpacpi_battery_probe(int battery)
>  			battery_info.batteries[battery].charge_behaviours |=
>  				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
>  	}
> +	if (acpi_has_method(hkey_handle, GET_INHIBIT)) {
> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, &ret, battery))) {
> +			pr_err("Error probing battery inhibit charge; %d\n", battery);
> +			return -ENODEV;
> +		}
> +		/* Support is marked in bit 5 */
> +		if (ret & BIT(5))
> +			battery_info.batteries[battery].charge_behaviours |=
> +				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
> +	}
>  
>  	battery_info.batteries[battery].charge_behaviours |=
>  		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
> @@ -9673,6 +9711,11 @@ static ssize_t charge_behaviour_show(struct device *dev,
>  			return -ENODEV;
>  		if (ret)
>  			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> +	} else if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {

The use of else-if here seems wrong, this suggests that batterys can never
support both force-discharge and inhibit-charge behavior, which they can, so this
means that active can now never get set to BEHAVIOUR_INHIBIT_CHARGE on
batteries which support both.

So AFAICT the else part of the else if should be dropped here, making this
a new stand alone if block.

For the other parts of the set lets wait and see what Sebastian has to say.

Regards,

Hans



> +		if (tpacpi_battery_get(INHIBIT_CHARGE, battery, &ret))
> +			return -ENODEV;
> +		if (ret)
> +			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
>  	}
>  
>  	return power_supply_charge_behaviour_show(dev, available, active, buf);
> @@ -9710,12 +9753,20 @@ static ssize_t charge_behaviour_store(struct device *dev,
>  	switch (selected) {
>  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
>  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> -		if (ret < 0)
> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
> +		if (ret)
>  			return ret;
>  		break;
>  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
>  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 1);
> -		if (ret < 0)
> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
> +		if (ret)
> +			return ret;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 1) || ret;
> +		if (ret)
>  			return ret;
>  		break;
>  	default:
> 

