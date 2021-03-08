Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F833130E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHQMR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:12:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCHQMD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 11:12:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4E3565235;
        Mon,  8 Mar 2021 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219923;
        bh=PnOHJ4G+5EmJMFVlbGQ4fvuJX8KgofxN3t9LVJiywC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MP67ByoaHs0VfXPbljCRVE/8AfOreQa1l+wjoKfoExMF3mRwTx21x7p+RhUqFdfYh
         WLZp0NH3qRM5dD6nz4eMgfP8Y/ty6uBZGOX1OCDFvALDF3r8ORQ7V2nUHWt5mq4KGF
         Y4iWXyyvHMeYz/ehc8FvMQTRZSEOQNtD8jnH4TVsIGSSh0k6rjz2CUi8PadfOtqj4t
         mVKBcpdiAdfkPraSqY3s1dkXVqyrZ4Bb/SxTF+uazNth7EFAowe4eNXT5DysNpLzce
         MYMGCMIlA/mp6fHOQziOPCglm5gso9UIY6NqxA22GAZR9XKPFmca+OWgAfoAhpKQdB
         8wtK8OAJN+FGw==
Received: by mail-ej1-f54.google.com with SMTP id jt13so21547745ejb.0;
        Mon, 08 Mar 2021 08:12:02 -0800 (PST)
X-Gm-Message-State: AOAM531x688/09RdXa7vzJp7H6v0kJ2mLAyOETJMVbn88a3GOaO7WsTf
        WZXNOgXI9mKwRjRO4chA8cpl23cG8eFA6ArtNf4=
X-Google-Smtp-Source: ABdhPJwsytMJ3l8SH58S2YSa3Zg6m5CkjAB0N1JRxT67XfBuzmWWv0tJg2hDQeAGXp3wez5EGxkEiJJMSgobwOfTv8A=
X-Received: by 2002:a17:906:f1c8:: with SMTP id gx8mr16144598ejb.385.1615219921364;
 Mon, 08 Mar 2021 08:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20210308152935.2263935-1-arnd@kernel.org> <12c5050f-feb3-e07f-45d2-5e89b678841a@kernel.org>
 <CAK8P3a3xEw9yiVY-dDmQEKTSPSXaZJEhXEQ2M=7ZoUA8_P5Qzg@mail.gmail.com>
In-Reply-To: <CAK8P3a3xEw9yiVY-dDmQEKTSPSXaZJEhXEQ2M=7ZoUA8_P5Qzg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 8 Mar 2021 17:11:48 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc0u+BH35W5s_6tCbvM_Rr4K3Y0kjAbPMM9=+VZTzr3FA@mail.gmail.com>
Message-ID: <CAJKOXPc0u+BH35W5s_6tCbvM_Rr4K3Y0kjAbPMM9=+VZTzr3FA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency unconditional
To:     Arnd Bergmann <arnd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 8 Mar 2021 at 17:02, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Mar 8, 2021 at 4:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 08/03/2021 16:29, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Some of the extcon interfaces have a fallback implementation that can
> > > be used when EXTCON is disabled, but some others do not, causing a
> > > build failure:
> > >
> > > drivers/power/supply/max8997_charger.c:261:9: error: implicit declaration of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-function-declaration]
> > >                 ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> > >                       ^
> > > drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm_extcon_register_notifier'?
> > > include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' declared here
> > > static inline int devm_extcon_register_notifier(struct device *dev,
> > >
> > > I assume there is no reason to actually build this driver without extcon
> > > support, so a hard dependency is the easiest fix. Alternatively the
> > > header file could be extended to provide additional inline stubs.
> >
> > Hi Arnd,
> >
> > Thanks for the patch but I think I got it covered with:
> > https://lore.kernel.org/lkml/20210215100610.19911-2-cw00.choi@samsung.com/
> > (sent via extcon tree).
> >
> > Did you experience a new/different issue?
>
> The patch should be fine and address the problem, I just didn't see it was
> already fixed in linux-next as I'm still testing on mainline (rc2 at
> the moment).
>
> I assume the fix will make it into a future -rc then.

It's still only in linux-next via extcon tree, so it seems Greg did
not take it yet.

Chanwoo,
You might need to follow up on this, so your pull request won't get lost.

Best regards,
Krzysztof
