Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1746FA89
	for <lists+linux-pm@lfdr.de>; Fri, 10 Dec 2021 06:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhLJGB0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Dec 2021 01:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhLJGB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Dec 2021 01:01:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC76C061746
        for <linux-pm@vger.kernel.org>; Thu,  9 Dec 2021 21:57:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e3so26889084edu.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Dec 2021 21:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTqpfJiLnztwa9HoRNAf2LpayxnrREu90eRKIaaa2IY=;
        b=DrGa4FdIqMqr8zU5EhypyRBwlq0S/XhugJfYfnodUytvQ7W0fT5M+os5LhOwp4B2q2
         DwiVxImrHaD5crCULxepQ4r4BTw4Y3ZLOpA+z9TIqry10aPmtnKr87qKChHKJNxmWrBA
         D+7tzN3BAXvyv6J3y3RSZXaMD7lDRoX7KxgZUb7h87av1d65nC7E7JjAJOC3Zzg1Qu8N
         hPxNdh2m1dkfYe3iyvylYpfI4kUtSqPQ/4k/GAWTjlNkNrmOc66dBg34AUVSYygfvaQ+
         Bp8w/I3EDtwfkhTaoBfYDINGF5eMLxI0vN9z6mxHQIZ0dbgtyN0hIIXOZNKS9p/CfNqL
         6ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTqpfJiLnztwa9HoRNAf2LpayxnrREu90eRKIaaa2IY=;
        b=Ad3T81EabnVORbMQ9S/Iq0oUxglv4WO1msmWT2TJyECSXJsoRUFOlt5d8v26Ra/uCr
         tRZGmc52BMOvZXzcTVJS/M0160B2eC37mRD6EMi72dvZWBxdNbiUYh6da/hnqg0ehFc2
         7oQnlP558whir6gEPGaYnajTdF+K4SUygcj+YsHMr/EXr1Otjppe6iEvWxlWdpymvA+N
         pP3wXD099REa9iLsKchmxjQWiC+GuQPkjK9ul9X4iq/6ePNJhgZhYOTQKFSM1IGiyvJO
         sQPZeR4D4KPMLJvgHCbOXFGGnQqM/gAuSocIfB8RJjriCwrBdYmVn/Av5YG6An3SKjRU
         C7xw==
X-Gm-Message-State: AOAM532T5jIRbgx0mLK0VvLH2wejknfRl45Z4aYFFQAvcJNzPtQAJiBl
        G/rmBsE2sSHsk9VSM4Xc8iZqH3ZA5aqi3URP69Q=
X-Google-Smtp-Source: ABdhPJw+6+67NNvYaUu7c0O599J6YtHg1OAHr1LDESdiNfqUNIFU5c1lhQ1N73TFTxkVgyem5VLhETc1iqPxJLkc/dc=
X-Received: by 2002:a17:906:1613:: with SMTP id m19mr22195064ejd.136.1639115870267;
 Thu, 09 Dec 2021 21:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20211206000651.4168035-1-linus.walleij@linaro.org>
 <7228bbd0-4428-18d2-8cef-df9a9c789d41@gmail.com> <CACRpkdaKmZp62DSB7oMbESRjXAH8ncfLyc3KioSDx2z-_JOK8A@mail.gmail.com>
In-Reply-To: <CACRpkdaKmZp62DSB7oMbESRjXAH8ncfLyc3KioSDx2z-_JOK8A@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Fri, 10 Dec 2021 07:57:39 +0200
Message-ID: <CANhJrGMHr=VLAwe-Tvyg70nN4ArjHa8UHKZODwrufK1r+rRNcA@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply_core: Pass pointer to battery info
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi deee Ho peeps!

Hmm.. I see I accidentally sent this from my gmail address. I guess
all tags (like RBT) should be sent from the address which is used in
the tag? (I've two accounts in the same client and occasionally send
from the wrong one...)

On Thu, Dec 9, 2021 at 2:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Dec 8, 2021 at 7:46 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> > Hmm.. LKML skipped on purpose(?)
>
> LKML is only the bin where we put everything that doesn't have a proper
> maintenance mailing list.

Oh. I was under the impression that the LKML is collecting more or
less all the messages. I am pretty sure the get_maintainers.pl does
always add the LKML too. (I almost never look the MAINTAINERS directly
but rely on the get_maintainer.pl to do the _almost_ right thing). I
should probably revise my list subscriptions then to ensure my filters
won't miss interesting patches. Good to know this.

> > On 12/6/21 02:06, Linus Walleij wrote:
>
> > > This is awkward since I want to support tables of static battery
> > > info by just assigning a pointer to all info based on e.g. a
> > > compatible value in the device tree.
> >
> > Do you have a case where you have battery data in multiple DT nodes?
> > Some kind of multi-battery use-case?
>
> No it is a single battery. But the data is kept in the kernel and matched
> per-battery, I pushed the latest code from my desk so you can see how
> it looks in practice:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/commit/?h=ux500-href-charging-v5.16-rc1

1. Thanks.

> > I'd like to understand how you plan
> > to do mapping to compatibles - AFAIR, at the moment the compatible must
> > be "simple-battery".
>
> This is for the Samsung batteries using these bindings:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/power/supply/samsung,battery.yaml

2. Thanks.

>
> > Do you plan to have multiple compatibles in the DT,
> > one of them matching the "simple-battery", rest being used as a key? Or
> > do you plan to use the charger compatible (charger which references the
> > battery with the monitored-battery as a key? My initial feeling is that
> > it kind of makes sense).
>
> The Samsung battery bindings are already in use, I used them for
> example in these:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ste-ab8500.dtsi
>
> It's very simplistic:
>
> battery: battery {
>     compatible = "samsung,eb535151vu";
> };
> (...)
>
> ab8500 {
>    compatible = "stericsson,ab8500";
> (...)
>   ab8500_charger {
>      compatible = "stericsson,ab8500-charger";
> (...)
>        monitored-battery = <&battery>;

3. Thanks.

>
> > I was wondering how it would work out if the battery info was splitted
> > to smaller (optional) pieces instead of being just one big struct? It
> > kind of makes no sense to always reserve space for all of the
> > calibration data arrays when some of them are likely to be missing...(?)
>
> I suppose if footprint becomes a problem one can just split the
> battery data into smaller files, and compile each one with a
> KConfig.
>
> As you can see in my example the Samsung batteries actually
> share the same capacity table across three different batteries
> so they actually benefit from being defined together when we
> want to support all (which we do).

Thanks 4.
I think I am about to learn something. I didn't think we could use
KConfig to flag-out some of the battery-data - or to give some
battery-data as "configured-in" values.

> > something like:
> >
> > struct static_batinfo static_info;
> > struct dynamic_batinfo *dynamic_info;
> >
> > power_supply_get_battery_info(bd->charger, &static_info, &dynamic_info)
> >
> > dynamic_info can be NULL if it is not expected.
> > dynamic_info will be NULL'ed by call if it is not populated
> > dynamic_info will be allocated if it is not NULL when called and if
> > dynamic data is found from the firmware.
>
> But we already (partly) do that, look in power_supply_get_battery_info()
> as touched by this patch:
>
> (...)
>         list = of_get_property(battery_np, "resistance-temp-table", &len);
>         if (!list || !len)
>                 goto out_ret_pointer;
>
>         info->resist_table_size = len / (2 * sizeof(__be32));
>         resist_table = info->resist_table = devm_kcalloc(&psy->dev,
>
> info->resist_table_size,
>                                                          sizeof(*resist_table),
>                                                          GFP_KERNEL);
>
> Notice the goto out_ret_pointer; we return the pointer without
> allocating any resistance-temp-table if it is not present in the
> device tree. The same can be done with static data and
> consumers need to cope with some members being NULL.

Please, don't get me wrong. I do think your patch improves the
situation in a sense. It becomes more obvious one needs to use the
put_battery_info() as battery data is now clearly allocated. I just
wondered if we could still handle batteries which do not have
data-arrays w/o the allocation/freeing. Well, I tend to agree with you
here now so please just ignore my babbling regarding the allocation.

> I don't see the usecase for mixing static and dynamic info
> really, I think we have two cases:
>
> - All information about the battery obtained from one single
>   key such as the compatible string (as for the Samsung
>   SDI batteries)

> - All information about the battery contained in the device
>   tree (as for simple-battery)
>
> The way discussion has been going in the device tree
> community the "define it all in devicetree" approach is
> kind of soft discouraged.

Thanks! This is likely to teach me a thing or two! I feel I owe you a
beer should we ever met :]

> > For me it is just
> > troubling to always have all the arrays in battery data - and I still do
> > like the ability to avoid dynamic allocation when we don't have much of
> > the info in the DT.
>
> I will probably need to add more entries to it as well and then I expect
> to make them optional not compulsory, like what we do for resistance
> already.

Ok.

> Also I would love if you could test v2 on hardware!

I don't have a real device with battery connected - but I thinkI do
have a break-out board with BD99954 lying around somewhere. I'll see
if I remember how to wire it to a beagle-bone - and if I do, then I
can try some very limited testing. Adding automated tests for the
BD99954 is still on my TODO-list, somewhere at the bottom of it... :(

>
> > The patch didn't apply on v5.16-rc4
>
> It's based on Sebastians tree so you need to use that, or just
> grab my branch (should be possible to merge in v5.16-rc4
> if you need)

Yeah, one more remotes to my work-area git won't change a thing ^_^;
It's already a horrible mess :rolleyes:

>
> Yours,
> Linus Walleij



-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Matti "Maz" Vaittinen

When you feel blue, no one sees your tears...
When your down, no one understands your struggle...
When you feel happy, no one notices your smile...
But fart just once...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
