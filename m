Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C137771C
	for <lists+linux-pm@lfdr.de>; Sun,  9 May 2021 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhEIPHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 May 2021 11:07:14 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38631 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhEIPHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 May 2021 11:07:13 -0400
Received: by mail-lj1-f176.google.com with SMTP id v6so17651370ljj.5;
        Sun, 09 May 2021 08:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OQjw04OJR2D4IqoTtXU0N4drQxCgCETBxjmIRrkObds=;
        b=fIAMHNKevosjt4dyL6cre+Vvd7IaA4cO2h09izNbUpQsgQaDhdPnWQQWv++HJvkxoL
         tA3XZkSJ3d1zSVLjINfCcZ4ckt2cj2apFElL7Zt4oOCdJxPgZnwfkd8bwTHynw9gBE/W
         NV4Q+eaB+3BIGf7uShoSFLErEnCJQcX3NtGkah6sH31SSN84nZmngmfM1bTdkDTM80Tt
         pJmaevRqFFZvifI6NioIWDM9oucTyk+yyni1alfX9IqCe6Wf/YRrvWNFYMgw9K6BVaiE
         N8zAFhzK4FAl/3SOjWwRMs+lQIiSxNewD/QhZZEXz6TzicqIEl3lhjKwyLns6tJ5AAWD
         TEbw==
X-Gm-Message-State: AOAM530TyT9Vp/dNeC5IWhS2okJuaagGH4LH+fUAL7y7nw3mCOGcwFTg
        tBzEINDPw0kWEYPZsayGSPxRTmu7hJ/Ttg==
X-Google-Smtp-Source: ABdhPJzRcT+xfJZpru0kNQwPbQoQxC80kteh6gI6yOm+3/Ly3/+jDMEP1fGZx4NYxI3tuuiIB3tfjg==
X-Received: by 2002:a2e:8756:: with SMTP id q22mr16773180ljj.414.1620572769323;
        Sun, 09 May 2021 08:06:09 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v14sm1938381lfo.76.2021.05.09.08.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 08:06:08 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id b7so17637121ljr.4;
        Sun, 09 May 2021 08:06:08 -0700 (PDT)
X-Received: by 2002:a2e:9810:: with SMTP id a16mr17138024ljj.78.1620572768750;
 Sun, 09 May 2021 08:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com> <20210505112902.GC5302@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20210505112902.GC5302@lemon.iwr.uni-heidelberg.de>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 9 May 2021 23:05:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v64UN6=26QiQLqSWmNJPo49bPOQ3Q-Oz=LsbZz3JcszU0Q@mail.gmail.com>
Message-ID: <CAGb2v64UN6=26QiQLqSWmNJPo49bPOQ3Q-Oz=LsbZz3JcszU0Q@mail.gmail.com>
Subject: Re: [PATCH] power: supply: axp20x_battery: implement writeable status
 to enable/disable battery charging
To:     Hermann.Lauer@uni-heidelberg.de
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, May 5, 2021 at 7:29 PM <Hermann.Lauer@uni-heidelberg.de> wrote:
>
> Dear Maintainers,
>
> this patch allows enabling/disabling charging for the axp209 PMIC through a
> writeable status property.

  ^ writable

>
> This works on the axp209 of Banana {Pi M1+,Pro}. I have no access to
> the other chips the driver deals with.

This should work on all the AXP chips, as it's the same bit that
controls the charger on all of them.

> Thanks to ChenYu for the idea and greetings
>   Hermann
>
> Signed-off-by: Hermann.Lauer@uni-heidelberg.de

The patch itself looks good, but your commit message needs a bit of
cleanup. Your commit message should only include details about the
patch, especially why the patch was done, which is kind of missing.
"What" was done is already obvious when looking at the body of the
patch.

Any pleasantries and other comments addressed to maintainers should
be included after the "---" so as not to be included in git history.


Thanks
ChenYu


> ---
>  drivers/power/supply/axp20x_battery.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -40,6 +40,7 @@
>  #define AXP209_FG_PERCENT              GENMASK(6, 0)
>  #define AXP22X_FG_VALID                        BIT(7)
>
> +#define AXP20X_CHRG_CTRL1_ENABLE       BIT(7)
>  #define AXP20X_CHRG_CTRL1_TGT_VOLT     GENMASK(6, 5)
>  #define AXP20X_CHRG_CTRL1_TGT_4_1V     (0 << 5)
>  #define AXP20X_CHRG_CTRL1_TGT_4_15V    (1 << 5)
> @@ -468,7 +469,17 @@
>         case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>                 return axp20x_set_max_constant_charge_current(axp20x_batt,
>                                                               val->intval);
> +       case POWER_SUPPLY_PROP_STATUS:
> +               switch (val->intval) {
> +               case POWER_SUPPLY_STATUS_CHARGING:
> +                       return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> +                               AXP20X_CHRG_CTRL1_ENABLE, AXP20X_CHRG_CTRL1_ENABLE);
>
> +               case POWER_SUPPLY_STATUS_DISCHARGING:
> +               case POWER_SUPPLY_STATUS_NOT_CHARGING:
> +                       return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> +                               AXP20X_CHRG_CTRL1_ENABLE, 0);
> +       }
>         default:
>                 return -EINVAL;
>         }
> @@ -491,7 +502,8 @@
>  static int axp20x_battery_prop_writeable(struct power_supply *psy,
>                                          enum power_supply_property psp)
>  {
> -       return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
> +       return psp == POWER_SUPPLY_PROP_STATUS ||
> +              psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
>                psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
>                psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
>                psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
