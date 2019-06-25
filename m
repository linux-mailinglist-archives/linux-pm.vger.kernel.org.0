Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51A9528F1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfFYKE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 06:04:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32788 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYKE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 06:04:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id i4so16876258otk.0;
        Tue, 25 Jun 2019 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7iw8LBQxbFbstW7h748xeikkIjwfdpfAOak7Wc/2tw=;
        b=I9Vr2dk5UrP3odGn8jpvnMY6uNFcd8PGCwngA8OKtWebh363a8Fvp+ApsTvYgNZvlj
         9f5fhdDGItb7DfELBceaYLEpjrfmjR16L+G5LD2XSdOu2GvdSAtAEtZlr7oQ6UWxh1i8
         KYbGQeadShCvq+NAItHPzsXkQEl43Qj6ilSsQNV6cA89QDYeWxnA0ODZjMvXvPRqGEKk
         vBoPKkAQJkSesN0+hJ3V7eBOaUAHvQ6bFIdxlmUOjCYSs/L8HtQOuLrl945YpyTruWfX
         oooN6E6OVfC0wUAGe/FDGw4K7xPBUkeXwOgKEj2vqzaWZVahhmtlXRLYGv6Cr3jhBDwr
         7mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7iw8LBQxbFbstW7h748xeikkIjwfdpfAOak7Wc/2tw=;
        b=iMOtR6bfn23nx/Zq0WGF1rnkmodD72xYL46wmQdAwlMYYwTI8TGjGuy0gm1qoLqXCd
         nYZfI39wFNoK3nKpgbNmesOuKAAwJSA6OZkMMMUdO/ljCnxjXGpk4m3POQI7ThiqWKJQ
         lQRGcRr1Qa3doJ1v2zpLwgJY/QeulkxNQhQnVjbQryzN4VAHKygvE60XTXY+hM77DuHh
         ojUgoIG5SzLX7nDuWyhNl8moYKSgsm8PdpbpwkgN2HxHrRtZjWPD/UB+WtYXJWNgFh9T
         dafMDsM6VzRIOgeQe6DEWSUg/tZ0JTc9Uj54x6x6+UQgkXLdimb6k+yTMhHUg80GHw84
         YQ3A==
X-Gm-Message-State: APjAAAUPSqLI26qwQqwtC6WcrKYrKa4fKsLhTK7xh942ZRmdFSTV573j
        XFxK1R196awL4skBcY6JgorzSHZOqwJ4NsIpUFI=
X-Google-Smtp-Source: APXvYqxFTZtYsPbTyUdfIfqVxEPQuRr5TF3Vc4BqfdD39Li5rv8RSUrnCx2q2lF4EJ01PeaNqOHibIoWWLWX5S2n2kw=
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr31158527otf.3.1561457065038;
 Tue, 25 Jun 2019 03:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190507095248.17915-1-enric.balletbo@collabora.com> <20190523195438.GA110498@google.com>
In-Reply-To: <20190523195438.GA110498@google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 25 Jun 2019 12:04:13 +0200
Message-ID: <CAFqH_52mdHKGN6gA3HuRJrcBvG1GpE+LzAyLgJD_xeZAiHruFw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] power: supply: add input power and voltage limit properties
To:     Benson Leung <bleung@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sameer Nanda <snanda@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Adam.Thomson.Opensource@diasemi.com,
        Collabora Kernel ML <kernel@collabora.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian, Pavel,

Missatge de Benson Leung <bleung@google.com> del dia dj., 23 de maig
2019 a les 21:55:
>
> Hi Enric,
>
> On Tue, May 07, 2019 at 11:52:47AM +0200, Enric Balletbo i Serra wrote:
> > For thermal management strategy you might be interested on limit the
> > input power for a power supply. We already have current limit but
> > basically what we probably want is to limit power. So, introduce the
> > input_power_limit property.
> >
> > Although the common use case is limit the input power, in some
> > specific cases it is the voltage that is problematic (i.e some regulators
> > have different efficiencies at higher voltage resulting in more heat).
> > So introduce also the input_voltage_limit property.
> >
> > This happens in one Chromebook and is used on the Pixel C's thermal
> > management strategy to effectively limit the input power to 5V 3A when
> > the screen is on. When the screen is on, the display, the CPU, and the GPU
> > all contribute more heat to the system than while the screen is off, and
> > we made a tradeoff to throttle the charger in order to give more of the
> > thermal budget to those other components.
> >
> > So there's nothing fundamentally broken about the hardware that would
> > cause the Pixel C to malfunction if we were charging at 9V or 12V instead
> > of 5V when the screen is on, i.e. if userspace doesn't change this.
> >
> > What would happen is that you wouldn't meet Google's skin temperature
> > targets on the system if the charger was allowed to run at 9V or 12V with
> > the screen on.
> >
> > For folks hacking on Pixel Cs (which is now outside of Google's official
> > support window for Android) and customizing their own kernel and userspace
> > this would be acceptable, but we wanted to expose this feature in the
> > power supply properties because the feature does exist in the Emedded
> > Controller firmware of the Pixel C and all of Google's Chromebooks with
> > USB-C made since 2015 in case someone running an up to date kernel wanted
> > to limit the charging power for thermal or other reasons.
> >
> > This patch exposes a new property, similar to input current limit, to
> > re-configure the maximum voltage from the external supply at runtime
> > based on system-level knowledge or user input.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Reviewed-by: Guenter Roeck <groeck@chromium.org>
> > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>
> Reviewed-by: Benson Leung <bleung@chromium.org>
>

We're close to the merge window so I'm wondering if there are more
concerns on this patchset?

Thanks,
~ Enric

> > ---
> >
> > Changes in v4:
> > - Add also input_power_limit.
> >
> > Changes in v3:
> > - Improve commit log and documentation with Benson comments.
> >
> > Changes in v2:
> > - Document the new property in ABI/testing/sysfs-class-power.
> > - Add the Reviewed-by Guenter Roeck tag.
> >
> >  Documentation/ABI/testing/sysfs-class-power | 32 +++++++++++++++++++++
> >  Documentation/power/power_supply_class.txt  |  4 +++
> >  drivers/power/supply/power_supply_sysfs.c   |  2 ++
> >  include/linux/power_supply.h                |  2 ++
> >  4 files changed, 40 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index 5e23e22dce1b..962a27a1daf8 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -331,10 +331,42 @@ Description:
> >               supply. Normally this is configured based on the type of
> >               connection made (e.g. A configured SDP should output a maximum
> >               of 500mA so the input current limit is set to the same value).
> > +             Use preferably input_power_limit, and for problems that can be
> > +             solved using power limit use input_current_limit.
> >
> >               Access: Read, Write
> >               Valid values: Represented in microamps
> >
> > +What:                /sys/class/power_supply/<supply_name>/input_voltage_limit
> > +Date:                May 2019
> > +Contact:     linux-pm@vger.kernel.org
> > +Description:
> > +             This entry configures the incoming VBUS voltage limit currently
> > +             set in the supply. Normally this is configured based on
> > +             system-level knowledge or user input (e.g. This is part of the
> > +             Pixel C's thermal management strategy to effectively limit the
> > +             input power to 5V when the screen is on to meet Google's skin
> > +             temperature targets). Note that this feature should not be
> > +             used for safety critical things.
> > +             Use preferably input_power_limit, and for problems that can be
> > +             solved using power limit use input_voltage_limit.
> > +
> > +             Access: Read, Write
> > +             Valid values: Represented in microvolts
> > +
> > +What:                /sys/class/power_supply/<supply_name>/input_power_limit
> > +Date:                May 2019
> > +Contact:     linux-pm@vger.kernel.org
> > +Description:
> > +             This entry configures the incoming power limit currently set
> > +             in the supply. Normally this is configured based on
> > +             system-level knowledge or user input. Use preferably this
> > +             feature to limit the incoming power and use current/voltage
> > +             limit only for problems that can be solved using power limit.
> > +
> > +             Access: Read, Write
> > +             Valid values: Represented in microwatts
> > +
> >  What:                /sys/class/power_supply/<supply_name>/online,
> >  Date:                May 2007
> >  Contact:     linux-pm@vger.kernel.org
> > diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
> > index 300d37896e51..1e3c705111db 100644
> > --- a/Documentation/power/power_supply_class.txt
> > +++ b/Documentation/power/power_supply_class.txt
> > @@ -137,6 +137,10 @@ power supply object.
> >
> >  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
> >  the current drawn from a charging source.
> > +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
> > +the voltage limit from a charging source.
> > +INPUT_POWER_LIMIT - input power limit programmed by charger. Indicates
> > +the power limit from a charging source.
> >
> >  CHARGE_CONTROL_LIMIT - current charge control limit setting
> >  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index 5358a80d854f..860db617d241 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -275,6 +275,8 @@ static struct device_attribute power_supply_attrs[] = {
> >       POWER_SUPPLY_ATTR(charge_control_limit),
> >       POWER_SUPPLY_ATTR(charge_control_limit_max),
> >       POWER_SUPPLY_ATTR(input_current_limit),
> > +     POWER_SUPPLY_ATTR(input_voltage_limit),
> > +     POWER_SUPPLY_ATTR(input_power_limit),
> >       POWER_SUPPLY_ATTR(energy_full_design),
> >       POWER_SUPPLY_ATTR(energy_empty_design),
> >       POWER_SUPPLY_ATTR(energy_full),
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 2f9c201a54d1..ba135a5d8996 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -122,6 +122,8 @@ enum power_supply_property {
> >       POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
> >       POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> >       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> > +     POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> > +     POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
> >       POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> >       POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
> >       POWER_SUPPLY_PROP_ENERGY_FULL,
> > --
> > 2.20.1
> >
>
> --
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org
