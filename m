Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE38C130718
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgAEKkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:40:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41830 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgAEKkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:40:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so45135590eds.8;
        Sun, 05 Jan 2020 02:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IKLNBut8VZHn5Bc1hHVBWD4nCcixp8m9evnyOmGDd4=;
        b=qjyz2wRvGd07hs0/SdmgWb6YARAgr6DTBfdrh4sA8l5P7QdWvOkCi2Cq4AhbK4s0Sv
         sk8g/u7UYjMYK0RjxD1Jl1gtlfE25JwVHS7Oa2i2aQ91selYiEV33Vp+Y0fUyTRXZHvh
         Dk6Gfdcu3qXz0PYqYXDmXQvzPaOV35p6fxD90fj007b69CmlFW+F7cxOlGIAtLLTZ1ZU
         Zj8wX9tUugdoKpkgBFG9te2zPqTA6yRMHfLLmh9RLdior+qlFi9hCuu0TuwIBhMsofdX
         wvci7ok7JYEV9dBad2ZF1w9vRHAaE7wnXiGTFHVAn2xDCEcXveHKGJpxc+TgTg/0uAtz
         g+SA==
X-Gm-Message-State: APjAAAWjkgHcbh23LFkdztba0vm2L0RLrsE66h+KciLx1qEyHdSgLFCY
        C1luiUqBjW2+WZhzoJ8LY+qcrIJqDz4=
X-Google-Smtp-Source: APXvYqyF0SH+DbjwmmU7gaajmIENPDfAjl8hkT0Ii9v+SHuRnWqHxWSG1HcCaZZH8DHZbBHIY5WnUg==
X-Received: by 2002:a05:6402:12d1:: with SMTP id k17mr101877687edx.291.1578220821008;
        Sun, 05 Jan 2020 02:40:21 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id bm18sm7359329edb.97.2020.01.05.02.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:40:20 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id a5so12138914wmb.0;
        Sun, 05 Jan 2020 02:40:20 -0800 (PST)
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr27163799wmp.109.1578220820179;
 Sun, 05 Jan 2020 02:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-8-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-8-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:40:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67esqWZnKa8QNQAp8w-fhN+hM=zO9kUdzO9vFgr0FbfEQ@mail.gmail.com>
Message-ID: <CAGb2v67esqWZnKa8QNQAp8w-fhN+hM=zO9kUdzO9vFgr0FbfEQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 7/9] power: supply: axp20x_usb_power:
 Allow offlining
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>
> AXP803/AXP813 have a flag that enables/disables the USB power supply
> input. Allow control of this flag via the ONLINE property on those
> variants.
>
> It may be necessary to offline the USB power supply input when using
> the USB port in OTG mode, or to allow userspace to disable charging.

Any idea how the former would be implemented? AFAIK this isn't allowed
right now.

As for disabling charging, wouldn't it make more sense to disable the
charger?

Either way, these are not directly related to the changes. I'm just curious.

> When the USB VBUS input is disabled via the PATH_SEL bit, the VBUS_USED
> bit in PWR_INPUT_STATUS is cleared, so there is no change needed when
> getting the property.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index 2d7272e19a87..68443f264dff 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -29,6 +29,9 @@
>
>  #define AXP20X_USB_STATUS_VBUS_VALID   BIT(2)
>
> +#define AXP20X_VBUS_PATH_SEL           BIT(7)
> +#define AXP20X_VBUS_PATH_SEL_OFFSET    7
> +
>  #define AXP20X_VBUS_VHOLD_uV(b)                (4000000 + (((b) >> 3) & 7) * 100000)
>  #define AXP20X_VBUS_VHOLD_MASK         GENMASK(5, 3)
>  #define AXP20X_VBUS_VHOLD_OFFSET       3
> @@ -263,6 +266,16 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>         return 0;
>  }
>
> +static int axp813_usb_power_set_online(struct axp20x_usb_power *power,
> +                                      int intval)
> +{
> +       int val = !intval << AXP20X_VBUS_PATH_SEL_OFFSET;
> +
> +       return regmap_update_bits(power->regmap,
> +                                 AXP20X_VBUS_IPSOUT_MGMT,
> +                                 AXP20X_VBUS_PATH_SEL, val);
> +}
> +
>  static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
>                                             int intval)
>  {
> @@ -344,6 +357,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
>         struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
>
>         switch (psp) {
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               return axp813_usb_power_set_online(power, val->intval);
> +

I would add a comment here pointing to the next change as to why there's
only an axp813-specific callback used here.

>         case POWER_SUPPLY_PROP_VOLTAGE_MIN:
>                 return axp20x_usb_power_set_voltage_min(power, val->intval);
>
> @@ -363,6 +379,17 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
>  static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
>                                            enum power_supply_property psp)
>  {
> +       struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +
> +       /*
> +        * Both AXP2xx and AXP8xx have a VBUS path select flag.
> +        * On AXP2xx, setting the flag enables VBUS (ignoring N_VBUSEN).
> +        * On AXP8xx, setting the flag disables VBUS (ignoring N_VBUSEN).
> +        * So we only expose the control on AXP8xx where it is meaningful.
> +        */
> +       if (psp == POWER_SUPPLY_PROP_ONLINE)
> +               return power->axp20x_id == AXP813_ID;
> +
>         return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
>                psp == POWER_SUPPLY_PROP_CURRENT_MAX;
>  }
> --

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
