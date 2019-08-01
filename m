Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66F67E237
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfHASeh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 14:34:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43511 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfHASeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 14:34:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id j11so18050984otp.10
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUCcMouh0WO52+e0adQwOKzErR3ljNy4cs3bF3C1u1k=;
        b=izCAK6tbIWTL6XLXegvw14s6+xaXPO8v5Qdl7Tf1/WnGZ819VyecArGftwnoelv8lA
         5HGC4Xg4T4BzYB1KwMNYQ5mMLMXD0TD+NpT8s7QD1lxMihjVPfS36nyccDcWAM3TTmyg
         rdx7BsR+PqSEEEsa+tx0jCqrcEExhIRu4uBNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUCcMouh0WO52+e0adQwOKzErR3ljNy4cs3bF3C1u1k=;
        b=pCzOoVZbA4A7Tbaf+bJsU3NaCKWHTJx7963JFPAg5q4dFhrRlYR71955ZREVs1D3Hb
         3/1oGmBM5ApEv9kyKvIuEH/XMGeKdJo1JDDxOkjUgfRBstiw8ivKt71P4xg6HcXuS/OR
         deADf4t8Ws9isf0FTL7nLqxW2vb6oJPWVr6AGM63AUhZVMeuf8kb8pAbdmOyBMTEwgwq
         YqbWfOlN9V/rWfRz+702bOGyVtLtIyAvf6ughFt/s+MkhLLZDR2hjQWCwGP8SZI1j45x
         V/XzsH/JvyWqcEmQHolYrRJYXaWq0hCDt48R4tv43iu8ZuRD2CiWUtFShNHBu3meOS0x
         VtmA==
X-Gm-Message-State: APjAAAWURBuD5fmCgAvyKRazdkO2/cMTxgIiuj+7h/MdD5RXDLtci6To
        EbAxanWlMw31jtNFHPMuPiXLQTIC2a4=
X-Google-Smtp-Source: APXvYqwG5/7/CyAWwI10pQrokmwROJivlj9DeFulKIdN6oaHZ4OSYB6fl+Ky7z+oOZZv5RA7QMshmw==
X-Received: by 2002:a9d:6c4a:: with SMTP id g10mr68068255otq.31.1564684474485;
        Thu, 01 Aug 2019 11:34:34 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id b138sm24771046oii.7.2019.08.01.11.34.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 11:34:31 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id g7so54746027oia.8
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 11:34:30 -0700 (PDT)
X-Received: by 2002:aca:488e:: with SMTP id v136mr119143oia.49.1564684470454;
 Thu, 01 Aug 2019 11:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <1564452025-12673-1-git-send-email-rtresidd@electromag.com.au>
In-Reply-To: <1564452025-12673-1-git-send-email-rtresidd@electromag.com.au>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 1 Aug 2019 12:34:18 -0600
X-Gmail-Original-Message-ID: <CAHX4x87gVfmKVmj2O_riwV57Qb8X-MtKCUp6e=3UYuii4TVg0Q@mail.gmail.com>
Message-ID: <CAHX4x87gVfmKVmj2O_riwV57Qb8X-MtKCUp6e=3UYuii4TVg0Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power/supply/sbs-battery: Fix confusing battery
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

Thanks Richard, I still would like some more opinions
on this changing the userspace experience, but LGTM
otherwise.

Reviewed-by: Nick Crews <ncrews@chromium.org>

On Mon, Jul 29, 2019 at 8:00 PM Richard Tresidder
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
>     v4: Remove unnecessary brackets, rename sbs_status_correct to
>         sbs_correct_battery_status
>
>  drivers/power/supply/power_supply_sysfs.c |  2 +-
>  drivers/power/supply/sbs-battery.c        | 46 ++++++++++++-------------------
>  include/linux/power_supply.h              |  1 +
>  3 files changed, 19 insertions(+), 30 deletions(-)
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
> index 048d205..3ed70d4 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -283,7 +283,7 @@ static int sbs_write_word_data(struct i2c_client *client, u8 address,
>         return 0;
>  }
>
> -static int sbs_status_correct(struct i2c_client *client, int *intval)
> +static int sbs_correct_battery_status(struct i2c_client *client, int *status)
>  {
>         int ret;
>
> @@ -293,16 +293,18 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
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
> +               *status = POWER_SUPPLY_STATUS_CHARGING;
> +       else if (ret < 0)
> +               *status = POWER_SUPPLY_STATUS_DISCHARGING;
> +       else {
> +               /* Current is 0, so how full is the battery? */
> +               if (*status & BATTERY_FULL_CHARGED)
> +                       *status = POWER_SUPPLY_STATUS_FULL;
> +               else if (*status & BATTERY_FULL_DISCHARGED)
> +                       *status = POWER_SUPPLY_STATUS_EMPTY;
> +               else
> +                       *status = POWER_SUPPLY_STATUS_NOT_CHARGING;
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
> +               ret = sbs_correct_battery_status(client, &val->intval);
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
> +       if (ret < 0 || sbs_correct_battery_status(chip->client, &ret) < 0) {
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
