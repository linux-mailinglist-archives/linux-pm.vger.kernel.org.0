Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39023312E0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCHQIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhCHQHn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 11:07:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA226521D;
        Mon,  8 Mar 2021 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219662;
        bh=Vu42IV7ZXaIeA1ZoS++Jn2nkyEha5CRWuT2F/IoA4Ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qgLhXh0P9MKgHyP9nng2r3+VFBdjTVUwafBibFXl5dR/UigV/h2NLPGIxjQNjNooh
         fuvKDUt2fVK6Rc4UxTbpjvD9gzApeahmNsz8q/JtYjuxLK8yc99cZhdQ9s3oVdHw27
         Z9hBq/6NxEcdWQiDvRK3cHfvGgDM9htzhr+eptSrMkcjL+e+j3+g7OpxOHvUGziYhP
         u8dPch5pka5zCAOFP69AMD0XxN+GyZdsbjWdo8VNC28uugnfdKmCkUUPmXr11EYwFQ
         JFV/orXslxyDgiFM86H1DHxIHL0ePUDDCOgsGJyr9vsBQ0vSENj2HgusDEO7wYkXnt
         GgWnSQeTrYBXg==
Received: by mail-oi1-f171.google.com with SMTP id v192so3905136oia.5;
        Mon, 08 Mar 2021 08:07:42 -0800 (PST)
X-Gm-Message-State: AOAM5312Y7nkX8ur2b5NmWUwWGNnFAqMwhx5VrYBre++SEescGjzFErK
        hg2bEm+XYzxQzE5ndBzQ6pTAsBlhre9t0pt1iD0=
X-Google-Smtp-Source: ABdhPJyK04IppWdnzH9/fkDaeFOevn1AwN7A0AEb6rbOb2J61wpP8maGSUL+RRHiwRUbFElhvzbxxIUGEirm3X2/zMQ=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr16924304oib.67.1615219661893;
 Mon, 08 Mar 2021 08:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20210308152935.2263935-1-arnd@kernel.org> <7ca68ba756672ab937550f6ffd2b07dbd1b021d1.camel@fi.rohmeurope.com>
In-Reply-To: <7ca68ba756672ab937550f6ffd2b07dbd1b021d1.camel@fi.rohmeurope.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Mar 2021 17:07:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ssi+S_axTKowKgszqBkBNdh4+bi-UCUOb2jWiVu18Ag@mail.gmail.com>
Message-ID: <CAK8P3a1ssi+S_axTKowKgszqBkBNdh4+bi-UCUOb2jWiVu18Ag@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency unconditional
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 4:52 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Hello Arnd,
>
> On Mon, 2021-03-08 at 16:29 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I assume there is no reason to actually build this driver without
> > extcon
> > support, so a hard dependency is the easiest fix. Alternatively the
> > header file could be extended to provide additional inline stubs.
>
> I am absolutely not insisting this but it would be better if there was
> no hard dependency. I've tried couple of times to do changes to bunch
> of drivers (added some devm-functionality or generic definitions or -
> you name it) and I always end up at least compile-testing changes to
> multiple drivers. I always repeat following:
>
> 1. Manually hack the Makefiles to compile changed drivers as modules
>
> 2. Try CONFIG_COMPLILE_TEST
>  - unfortunately not too widely supported
>
> 3. Manually hack more to get drivers with 'hard dependencies' compiled
> - occasionally ending up to commenting out the calls with dependencies.
>
> So, if adding the stub is straightforward I'd vote for it.
>
> But I guess you know this quite well so I am just giving my 10 cents -
> decision can be yours :)

As Krzysztof said, he's already fixed this in linux-next the way you
prefer. Both approaches are common, and subsystem maintainers
have different preferences. I more or less picked one at random
here.

The main downside of the 'depends on FOO || !FOO' dependency is
that new developers tend to be confused by the syntax. It also
means you don't easily catch the problem with building the driver as
built-in if the dependency is missing, these can go unnoticed for a
long time until someone runs into the wrong randconfig build.

      Arnd
