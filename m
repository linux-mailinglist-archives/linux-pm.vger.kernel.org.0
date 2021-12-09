Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35C46DFA9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Dec 2021 01:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhLIAua (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 19:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhLIAu3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 19:50:29 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B73C061746
        for <linux-pm@vger.kernel.org>; Wed,  8 Dec 2021 16:46:57 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso4565030ots.6
        for <linux-pm@vger.kernel.org>; Wed, 08 Dec 2021 16:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpoW87iA/iIxPhsnuawuVDx5Awiyx2eb9RPl0Kppvx0=;
        b=MLpSXh51BETWUCIuGtrwMQvEb3dtdGrOnsDM8r0JyFSTvG5kqBFSU3P8OVbl9mHq+W
         t4KiyuPMoirJeZ3JcUYMPuq0LrcWDscMG0zmu58vsCspsKoAhtWASwil0bSaLF3n8ETN
         lQhquRjw4PIs0qnoRwNSKbXpJKFa78lo6rcK+u2KEwsW7/C7pGwAoUjRv5DEhIHgc4vr
         ZKUvaAffEhWrcOf6/DRLuYNbNCgHLlJ/+zeGpVG9jcHrD/6/GtmYJAX2ncxtCABYkiOn
         kUc8zCUv03NwtMXSfabLMeasQghM0hxbYNTYnJ5Bm44KQTPNFIiT2Y5T/FGdOlCylub6
         r4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpoW87iA/iIxPhsnuawuVDx5Awiyx2eb9RPl0Kppvx0=;
        b=eHYOnHXEynx0p+xglPR/gq0hZccO9VjUz6mKbUbQogQkplrpO9KbNCNSNsa5UdOXqX
         bMVnB27HsEabaGBXnaQsWeEZIDavZihc9VBWhUFslCOh+d8+x7fiWr8hoiB1xsN4dyHV
         WAy7PPdnlVP7lpQie78IdniayT4D/Z7mdJS1vdJkXzifqF8gqO1/u3SUUzvRzf15E0P5
         dxjngoMXvWKJXCGAeBPRqMi47+XmE8lY6bH390vM5cK5ywnYM0FimAHYHko/EwRFVhRX
         saM34bR+iM8FXDDdAIuHA7Qapa8Of31jgsyzjpIcFn+kndFxzcd4WyCPGUoYpkDApqJI
         5HKg==
X-Gm-Message-State: AOAM532vin+2ecX3AgE6HW6TJE9iHzUraalPYIZIlQ2ZfyYQNuJwm8wZ
        x6aISw4G/xDJ1ItcW9p1A8BurPahDzppxbtTJLD1qOqf37eqww==
X-Google-Smtp-Source: ABdhPJyJ03Px+d9J/Z7BrIrMplsbSdHaHj/IVMdh+9NqWn61rL07ZfWnZNeWO8ZDw5GjAPy+KL4pSH5DeArnl2qUFGU=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr2585658otl.237.1639010816325;
 Wed, 08 Dec 2021 16:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20211206000651.4168035-1-linus.walleij@linaro.org> <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com>
In-Reply-To: <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Dec 2021 01:46:44 +0100
Message-ID: <CACRpkdaKmZp62DSB7oMbESRjXAH8ncfLyc3KioSDx2z-_JOK8A@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 8, 2021 at 7:46 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hmm.. LKML skipped on purpose(?)

Yeah, MAINTAINERS says this:

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:      Sebastian Reichel <sre@kernel.org>
L:      linux-pm@vger.kernel.org

LKML is only the bin where we put everything that doesn't have a proper
maintenance mailing list.

> On 12/6/21 02:06, Linus Walleij wrote:

> > This is awkward since I want to support tables of static battery
> > info by just assigning a pointer to all info based on e.g. a
> > compatible value in the device tree.
>
> Do you have a case where you have battery data in multiple DT nodes?
> Some kind of multi-battery use-case?

No it is a single battery. But the data is kept in the kernel and matched
per-battery, I pushed the latest code from my desk so you can see how
it looks in practice:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=ux500-href-charging-v5.16-rc1

> I'd like to understand how you plan
> to do mapping to compatibles - AFAIR, at the moment the compatible must
> be "simple-battery".

This is for the Samsung batteries using these bindings:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/power/supply/samsung,battery.yaml

> Do you plan to have multiple compatibles in the DT,
> one of them matching the "simple-battery", rest being used as a key? Or
> do you plan to use the charger compatible (charger which references the
> battery with the monitored-battery as a key? My initial feeling is that
> it kind of makes sense).

The Samsung battery bindings are already in use, I used them for
example in these:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ste-ab8500.dtsi

It's very simplistic:

battery: battery {
    compatible = "samsung,eb535151vu";
};
(...)

ab8500 {
   compatible = "stericsson,ab8500";
(...)
  ab8500_charger {
     compatible = "stericsson,ab8500-charger";
(...)
       monitored-battery = <&battery>;

> I was wondering how it would work out if the battery info was splitted
> to smaller (optional) pieces instead of being just one big struct? It
> kind of makes no sense to always reserve space for all of the
> calibration data arrays when some of them are likely to be missing...(?)

I suppose if footprint becomes a problem one can just split the
battery data into smaller files, and compile each one with a
KConfig.

As you can see in my example the Samsung batteries actually
share the same capacity table across three different batteries
so they actually benefit from being defined together when we
want to support all (which we do).

> something like:
>
> struct static_batinfo static_info;
> struct dynamic_batinfo *dynamic_info;
>
> power_supply_get_battery_info(bd->charger, &static_info, &dynamic_info)
>
> dynamic_info can be NULL if it is not expected.
> dynamic_info will be NULL'ed by call if it is not populated
> dynamic_info will be allocated if it is not NULL when called and if
> dynamic data is found from the firmware.

But we already (partly) do that, look in power_supply_get_battery_info()
as touched by this patch:

(...)
        list = of_get_property(battery_np, "resistance-temp-table", &len);
        if (!list || !len)
                goto out_ret_pointer;

        info->resist_table_size = len / (2 * sizeof(__be32));
        resist_table = info->resist_table = devm_kcalloc(&psy->dev,

info->resist_table_size,
                                                         sizeof(*resist_table),
                                                         GFP_KERNEL);

Notice the goto out_ret_pointer; we return the pointer without
allocating any resistance-temp-table if it is not present in the
device tree. The same can be done with static data and
consumers need to cope with some members being NULL.

I don't see the usecase for mixing static and dynamic info
really, I think we have two cases:

- All information about the battery obtained from one single
  key such as the compatible string (as for the Samsung
  SDI batteries)

- All information about the battery contained in the device
  tree (as for simple-battery)

The way discussion has been going in the device tree
community the "define it all in devicetree" approach is
kind of soft discouraged.

The simple-battery IMO should be for
things like prototypes or devices where you don't really
know which battery is connected so you will have some
locally modified device trees for them.

In the Samsung case, these phones are mechanically
designed to just fit with one battery, and this seems to
be what Samsung does consistently: a battery with one
physical characteristic should not fit physically in the
slot of a device with different requirements.

That said I see what you're doing with the init data in
the bd99954 charger driver and it is similar to what the
regulator subsystem does too.

> The dynamic data must be freed by (keep put batttery info API or just
> allow user to kfree?)

The way the drivers use it is that some just call
power_supply_get_battery_info() copy some values from the
struct power_supply_battery_info into its own structs and then
just call power_supply_put_battery_info() and get rid of it all
again, and then the use is zero. (bd99954 for example)

Other drivers keep it around and reference it but it is
lifecycled with devres to the psy so it goes away when
removing the module (etc).

Either way works I guess, I just have a habit of using the
kernel structs as-is.

> Or is this just adding a lot of extra complexity in order to save few
> bytes?

On a general note the footprint discussion is kind of dead because
the community does not really prioritize that. Nicolas Pitre
invested lots of time to make the kernel configurable and
strippable with the goal of using it for IoT targets in 2018, and there
just wasn't interest. But anyone can drive such change of course.

The power supply core isn't really the worst offender though.

> For me it is just
> troubling to always have all the arrays in battery data - and I still do
> like the ability to avoid dynamic allocation when we don't have much of
> the info in the DT.

I will probably need to add more entries to it as well and then I expect
to make them optional not compulsory, like what we do for resistance
already.

> > In the bd99954 charger driver we need to stop issuing
> > power_supply_put_battery_info() at the end of the probe since
> > the struct continues to be used after probe().
>
> Hm. Are you sure?

This driver was a challenge so no :) it uses the info
differently from all others.

I looked over your comments and I missed how the init
data is used and then discarded. I will respin the patch
and fix this.

Also I would love if you could test v2 on hardware!

> The patch didn't apply on v5.16-rc4

It's based on Sebastians tree so you need to use that, or just
grab my branch (should be possible to merge in v5.16-rc4
if you need)

Yours,
Linus Walleij
