Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC27C791DB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfG2RRs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:17:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41549 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfG2RRs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 13:17:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so63320745ota.8
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H82CfpsAPxY1U4pICmy55gvPsfNE9tQu1bS2v8fGtDA=;
        b=hoTHoIe4KGfmjmWVbXeqcu2ZFyS3273iHszAwfnIijiaVLSvzliPZa86nMrhXe87ux
         CM9hn8aYM4If4h+4Y5c+mJIJPpVFX9SWC1i6+xlBF4Zh0SSzpQ+XZcijD1FopSIEGbym
         591+5DcB+Ute2WaU7H+qDuSLslk2Ga15lHChI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H82CfpsAPxY1U4pICmy55gvPsfNE9tQu1bS2v8fGtDA=;
        b=AKMsgu/qw03U5wjCyJPaD6m8f5w1E/OfhWjc0BpifGyAwagYC6ygHO0YFWkaawgUh8
         qN7nwiZiS0iET5RfbxzC+u/TsaSJMd974wbYWDO5kTznC1FHvizsLGA4hM6qc0C7a9+c
         gUa4Fe6IVhEqv3G0yK93REqbOS2OB4U3OmDGejVHTNW1og40R+fn9CyIos2oWgr61Mtv
         /s6G0Nfi2SdLdPdgzThnX2Ij5LWhiYNa6ksftsUAP2VFSR7ZjwpKnkaOvX6HsYjQEdhS
         2mkxKRfTn6mWFmwoTKCgyofXMz2SFrzl8DcPhnPENJoluYKbeuhK4ep9boPxp1Kgq7Ez
         mpUg==
X-Gm-Message-State: APjAAAVXY9026LiPRnxUii2jiQNWaE38c+/1xYwJh35gvU94/Mk1ridh
        mq7chRCkNrKOOEGtxOAWyFjelpEeiXo=
X-Google-Smtp-Source: APXvYqwNRfMFWlstzdAvPudqx5Ravrb+OjJs+qF8HxdLqqu5eUR0nmF64fqwaJIgdRafE0lkdFwmTQ==
X-Received: by 2002:a9d:711e:: with SMTP id n30mr77197726otj.97.1564420666153;
        Mon, 29 Jul 2019 10:17:46 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id c12sm21128013otn.68.2019.07.29.10.17.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 10:17:43 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id x21so24880131otq.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 10:17:42 -0700 (PDT)
X-Received: by 2002:a9d:19cd:: with SMTP id k71mr48832659otk.351.1564420662376;
 Mon, 29 Jul 2019 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
In-Reply-To: <1564387659-62064-1-git-send-email-rtresidd@electromag.com.au>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 29 Jul 2019 11:17:31 -0600
X-Gmail-Original-Message-ID: <CAHX4x86Afz2BXG476sVNNc4QP8jdO7F7n0QXqAG5+hRDwAAQGg@mail.gmail.com>
Message-ID: <CAHX4x86Afz2BXG476sVNNc4QP8jdO7F7n0QXqAG5+hRDwAAQGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        andrew.smirnov@gmail.com, Guenter Roeck <groeck@chromium.org>,
        david@lechnology.com, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net,
        Baolin Wang <baolin.wang@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 2:07 AM Richard Tresidder
<rtresidd@electromag.com.au> wrote:
>
> When a battery or batteries in a system are in parallel then one or more
> may not be providing any current to the system.
> This fixes an incorrect status indication of FULL for the battery simply
> because it wasn't discharging at that point in time.
> The battery will now be flagged as NOT CHARGING.
> Have also added the additional check for the battery FULL DISCHARGED flag
> which will now flag a status of EMPTY.
>
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
>
> Notes:
>     power/supply/sbs-battery: Fix confusing battery status when idle or empty
>
>     When a battery or batteries in a system are in parallel then one or more
>     may not be providing any current to the system.
>     This fixes an incorrect status indication of FULL for the battery simply
>     because it wasn't discharging at that point in time.
>     The battery will now be flagged as NOT CHARGING.
>     Have also added the additional check for the battery FULL DISCHARGED flag
>     which will now flag a status of EMPTY.
>
>     v2: Missed a later merge that should have been included in original patch
>     v3: Refactor the sbs_status_correct function to capture all the states for
>         normal operation rather than being spread across multile functions.
>
>  drivers/power/supply/power_supply_sysfs.c |  2 +-
>  drivers/power/supply/sbs-battery.c        | 44 +++++++++++--------------------
>  include/linux/power_supply.h              |  1 +
>  3 files changed, 18 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index f37ad4e..305e833 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -51,7 +51,7 @@
>  };
>
>  static const char * const power_supply_status_text[] = {
> -       "Unknown", "Charging", "Discharging", "Not charging", "Full"
> +       "Unknown", "Charging", "Discharging", "Not charging", "Full", "Empty"
>  };
>
>  static const char * const power_supply_charge_type_text[] = {
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 048d205..b28402d 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -293,16 +293,18 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)

sbs_status_correct() sounds like it is checking for a condition. Change
to sbs_correct_status() or sbs_correct_battery_status() to imply that it
is performing an action. Also, change "intval" to "status"?

>
>         ret = (s16)ret;
>
> -       /* Not drawing current means full (cannot be not charging) */
> -       if (ret == 0)
> -               *intval = POWER_SUPPLY_STATUS_FULL;
> -
> -       if (*intval == POWER_SUPPLY_STATUS_FULL) {
> -               /* Drawing or providing current when full */
> -               if (ret > 0)
> -                       *intval = POWER_SUPPLY_STATUS_CHARGING;
> -               else if (ret < 0)
> -                       *intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +       if (ret > 0)
> +               *intval = POWER_SUPPLY_STATUS_CHARGING;
> +       else if (ret < 0)
> +               *intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +       else {
> +               /* Current is 0, so how full is the battery? */
> +               if (*intval & BATTERY_FULL_CHARGED)
> +                       *intval = POWER_SUPPLY_STATUS_FULL;
> +               else if (*intval & BATTERY_FULL_DISCHARGED)
> +                       *intval = POWER_SUPPLY_STATUS_EMPTY;
> +               else
> +                       *intval = POWER_SUPPLY_STATUS_NOT_CHARGING;

This will cause some behavior changes for users. Can we get the opinion
of someone familiar with the users of this driver as to whether this is OK?

>         }
>
>         return 0;
> @@ -421,14 +423,9 @@ static int sbs_get_battery_property(struct i2c_client *client,
>                         return 0;
>                 }
>
> -               if (ret & BATTERY_FULL_CHARGED)
> -                       val->intval = POWER_SUPPLY_STATUS_FULL;
> -               else if (ret & BATTERY_DISCHARGING)
> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> -                       val->intval = POWER_SUPPLY_STATUS_CHARGING;
> -
> -               sbs_status_correct(client, &val->intval);
> +               ret = sbs_status_correct(client, &val->intval);
> +               if (ret < 0)
> +                       return ret;
>
>                 if (chip->poll_time == 0)
>                         chip->last_state = val->intval;
> @@ -773,20 +770,11 @@ static void sbs_delayed_work(struct work_struct *work)
>
>         ret = sbs_read_word_data(chip->client, sbs_data[REG_STATUS].addr);
>         /* if the read failed, give up on this work */
> -       if (ret < 0) {
> +       if ((ret < 0) || (sbs_status_correct(chip->client, &ret) < 0)) {
>                 chip->poll_time = 0;
>                 return;
>         }
>
> -       if (ret & BATTERY_FULL_CHARGED)
> -               ret = POWER_SUPPLY_STATUS_FULL;
> -       else if (ret & BATTERY_DISCHARGING)
> -               ret = POWER_SUPPLY_STATUS_DISCHARGING;
> -       else
> -               ret = POWER_SUPPLY_STATUS_CHARGING;
> -
> -       sbs_status_correct(chip->client, &ret);
> -
>         if (chip->last_state != ret) {
>                 chip->poll_time = 0;
>                 power_supply_changed(chip->power_supply);
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 28413f7..8fb10ec 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -37,6 +37,7 @@ enum {
>         POWER_SUPPLY_STATUS_DISCHARGING,
>         POWER_SUPPLY_STATUS_NOT_CHARGING,
>         POWER_SUPPLY_STATUS_FULL,
> +       POWER_SUPPLY_STATUS_EMPTY,
>  };
>
>  /* What algorithm is the charger using? */
> --
> 1.8.3.1
>
