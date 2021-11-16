Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FEF453BAB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 22:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhKPVec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 16:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhKPVeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 16:34:31 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E46C061570
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 13:31:34 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so707440otk.13
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUi2v5p4busVJLwoRkcet3Kr3DkmjwiWgE3jP9exGZI=;
        b=XzVvE71vl+/uwebLwTTcjU0nuAOByBIK1OSbB0dv3aXOzajShIPHUkgs3g4VgVcyng
         bcLowqW2Y3qmXQ6gHBKTH0GNMtyG8YKRPwW2W/o6Abphg9CluzuMo0aXTT8lFCYJAhgZ
         d5IMWj+KWKnQ780egwQJitQAKvLlLFzuPB5O0Lccy5ap/xs9/oUZPRRrz25pzRxFrT76
         NXNCUj7gOz/jozdUgsPDDVYEIXJ4/ybthZBdh4ey6gmFKrBwuOZUds/E0s0bvkItPPjh
         UwgqjcSdVAUMAFNsTTNrdzVp7qT/913sy1fshhilMXBtdEYt/RDWmgmMVEehKzz4JhP7
         fEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUi2v5p4busVJLwoRkcet3Kr3DkmjwiWgE3jP9exGZI=;
        b=RrHAcgQPlMIMcUMRAQyU5pBXVX7oGwj3NCCYJ1Zrai1nYOAwqXn6CcQYZ6VT6l7NWO
         MYc/JGeq4JR4CqqafiMUGvG6lAStVPIITh5th0iMJdIJWMPsuokSL1tY7Z9llLP1kI4Q
         1RNQt/uO0Fqaq86uEUFfNOH+WHkg+ZHq+9LULzMXD3xWtfuwK54t79LArtYOcdJZl+pt
         6BGK/tX7L4nr1sqgmC23Q85D/Dz9nY8iqu86LiFc9hwNUqvEU6wFlnrIj+GwhNDIvtu5
         wH0Grd3cn5DD5K1STWE6oxWfpcMa26g9aiPUW8eLaUPolrNQrH7j8VB9oPn1GiWGHxG8
         JQvw==
X-Gm-Message-State: AOAM533Vbn9fnwpR8Koyf9rk1Oc8jiIi39p+tXNXAJwXVrHKb3QoIakM
        MFn8CUElu/jWI08YQZewl5jiO0FoLmyqMVqs57iSGIzWMVI=
X-Google-Smtp-Source: ABdhPJxLFAncwhX8PDpQe+ru+yctBoqbExslQf02k4e4MTrcjW5GO/cM34WfLjGdb9QXg5ZZJX4TbyYBFiFQPCSf0DU=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr8654921otl.237.1637098293843;
 Tue, 16 Nov 2021 13:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20211116001755.2132036-1-linus.walleij@linaro.org>
 <bbaa93fe-8a10-7c80-2b5d-c36b0968429f@fi.rohmeurope.com> <CACRpkdYNe8cMo016ZCtgnOLs2b5JzHXUB34KkNR_dzBRZQh8nA@mail.gmail.com>
 <e9458f4c-4520-4c13-13bf-a2c575fdbdfa@fi.rohmeurope.com>
In-Reply-To: <e9458f4c-4520-4c13-13bf-a2c575fdbdfa@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Nov 2021 22:31:21 +0100
Message-ID: <CACRpkdb4FMqmVgJtwGdFmn3ZG4xy4qoYnNZPQEqfvTYGBDnwNQ@mail.gmail.com>
Subject: Re: [PATCH v3] power: supply: core: Add kerneldoc to battery struct
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 4:19 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> [Me]
> > here I add a table to interpolate the temperature from an NTC
> > resistance to struct power_supply_battery_info.
>
> Yep. Thanks for sharing this. I'd just hoped there was Kelvins used
> instead of Celsius. Would also allow using negative temperatures as
> errors in functions like the *resist2temp*().

It's not really an issue with these functions since they can't fail
and never return errors anyway.

It'd be a bit thick to start to using Kelvin somewhere in the kernel
when everyone and it's dog is using Celsius, including the
sysfs ABI to IIO. Also the datasheets I've seen are using Celsius
for operating conditions.

If we need an error code it is better to pass the temperature
out in a *pointer argument and add a proper return code.

> > Apart from this I want to add:
> > maintainance charging A and B so essentially two voltage+current
> > levels after CV charging has finished, each with a safety timer so
> > 2 * 3 new properties to struct power_supply_battery_info.
> > But I haven't coded it yet.
>
> Ok. This does not sound like a complete rework :) I'll keep on eye what
> you cook up here ;)

Nah. I was thinking of breaking out all the CC/CV charging params
to its own struct, but it is better to do that when someone needs
it. I.e. the day someone wants to charge something else than
a Li-ion type battery, because e.g. a NiCd cell does not use CC/CV
charging IIUC.

> I have two overlapping changes methinks. One is switch to fw_node - API
> (not sure if it is useful), the other is not requiing the power_supply
> to be registered prior parsing the battery info. That way the drivers
> can truly use batinfo independently from (before registering to)
> power-supply class.

Sounds harmless, just keep them coming.

> Thanks :) I did re-spin the RFC - and already got reply from Rob's bots
> :| It's odd how I _never_ get the bindings right...

Nobody does. ;)

Yours,
Linus Walleij
