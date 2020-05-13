Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC41F1D16F8
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbgEMOEz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 10:04:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33460 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgEMOEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 10:04:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id o24so21513475oic.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 07:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8vCveonwldpz9VYdrLFfwU0qaQkrrwXQ2h0T0AYccA=;
        b=RccIWpbOX8tt8mhlsiCn3/rM5+jvmTsl/Ozh/3Y3CY+UTNRPjP8kjJlTTnFMpDR6TQ
         l4vZ9jiJS30wUQ/AyrnwHnrg2fs8SZaLItMW+sLz90FtFiEbQeYLn/VmCJSCc4xUqN7c
         Tu81JyEJO8xWrfYRMBqj1xbXv01g8tnIUiz7QZP1FT3NXJFia9Fo9ST8EBtpy+3H9n+Z
         1Sk5pWd1Hm5+6i6NnhdRYIaQyNxnF1ED777R9Fbf0ZZ+o2sqY4JidrHWKkazM6pVi3d0
         w7kb6JpfKQNcHUgitx9lReL1AyfBIIQopk7g4ccsiiWsnYEpdb92jOPGndiF46ERFF7r
         5BrA==
X-Gm-Message-State: AGi0PuYNyfNg/sp7oUHvGeC96AnusnHwppqX4RigM07aVuGVMgfDkH8x
        HkEr9IhxY5VGsZZvvb0dOkCVN7YwYcMgGA8wqdo=
X-Google-Smtp-Source: APiQypLMhqqR1D5BjGOxk+tM9Lvd+VAQq9nrIY2mq7d99ZFATzxIsRBVg4KDp6dY+YtL1fFpyqX4zsd4oCv/nsSK2dY=
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr6437919oib.103.1589378694116;
 Wed, 13 May 2020 07:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
 <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
 <7163502.2kdGmH96AJ@kreacher> <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
In-Reply-To: <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 May 2020 16:04:41 +0200
Message-ID: <CAJZ5v0hMs_A1-=wLmjgdO8jhW-MA-JSxV8xuDPCxti+yxTW2JQ@mail.gmail.com>
Subject: Re: 5.7 sleep/wake regression
To:     Chris Murphy <chris@colorremedies.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 8:11 AM Chris Murphy <chris@colorremedies.com> wrote:
>
> On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
> > > On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> > > > >
> > > > > Got an older Macbook Pro that does suspend to RAM and wake OK with
> > > > > 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> > > > > it has a black screen, gets hot, fans go to high, and it turns into a
> > > > > hair dryer. So it's a regression.
> > > >
> > > > There is a known issue addressed by this patch:
> > > >
> > > > https://patchwork.kernel.org/patch/11538065/
> > > >
> > > > so can you please try it?
> > >
> > > Patch applied, but the problem remains.
> > >
> > > CPU is i7-2820QM and dmesg for the working sleep+wake case:
> > > https://paste.centos.org/view/ea5b913d
> > >
> > > In the failed wake case, I note the following: the fade-in/out sleep
> > > indicator light on the laptop is pulsing, suggests it did actually
> > > enter sleep OK. When waking by spacebar press, this sleep indicator
> > > light stops pulsing, the backlight does not come on, the laptop does
> > > not respond to either ssh or ping. Following  a power reset and
> > > reboot, the journal's last line is
> > >
> > > [   61.678347] fmac.local kernel: PM: suspend entry (deep)
> > >
> > > Let me know if I should resume bisect.
> >
> > Please first try to revert commit
> >
> > 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> > objects for ASL create_field() operator")
>
> Still fails. Bisect says
>
> $ git bisect good
> b41e98524e424d104aa7851d54fd65820759875a is the first bad commit
> commit b41e98524e424d104aa7851d54fd65820759875a
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Feb 17 09:52:41 2020 -0700
>
>     io_uring: add per-task callback handler
>
> I'm not that great at git bisect so I'm not sure how to narrow it
> down; offhand that doesn't seem a likely culprit.

I would try to revert it and see what happens. :-)
