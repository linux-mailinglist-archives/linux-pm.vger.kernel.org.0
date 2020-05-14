Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE541D26D7
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgENFyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENFyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 01:54:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84716C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 22:54:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so2227836wra.7
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 22:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrRixFaK3qbLbJSTAOAVAGhKQtDzGIdm7NHvqZCg7Bw=;
        b=arWXR0uShXjGmk1nm+OHbkA7idbTNBe23fjM1FEzyO6cGhosULQzKf6UftY1pg3bCr
         g/6d9SjYz9eoaGJl1IM40roxTnIjtoPjX2tQ7xNPE2ifPiO++8EqrjRh0TNTWdPKbXwK
         j1+jzuwPPyDGKLjWJo1xtXY9xwFbx6w1Y4hPd3XuGtuc3WFOEiuFZWe0QkY5+tj55eG2
         ckOxcMm4bspaItR1+06tVlkLWskhd1vicDY9B84zYAgkeL4j/fwXPx4saxLKBvQzrbTk
         Ekzj9VY0O4DTQgReq2OFdkJ6Bf9frElGC8hiMR/MQ2MJFnfMNf3KXukay/RRyEaBVD/u
         9+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrRixFaK3qbLbJSTAOAVAGhKQtDzGIdm7NHvqZCg7Bw=;
        b=Fdj8YAv/JHrpi0xQstWOjY7dBm4o5027SXoA1GNY9vGNwTQ9UeF2Qdz5dl8FSD8dug
         BHOarZTSJaJ8T9VK7ZQ3ggkjggnWYmBzS4a94H/FjbAnzfbO0XP0BmFTLVT6fr5VzHmY
         FLnfP4Ua1kswQc7ri/xhBUHHYXnEMJJPxnAYqo5jWJJhcDRVBeUxfcqXZUH2qtha50wM
         xYDLMNn1ODN5NpljYmTONwCZSLhi9iVfH+/Ooy0lFGHivcjP6e5GjKvEkM4FmSFUZ/1i
         RBNPsYN65SapsKOOBzADf1sLQ7sJHPu1wz6jNf4EL6Gb1DHAwXkTOVx8ONUqqli6COaN
         BrOQ==
X-Gm-Message-State: AOAM531TErsK8dSzWEHZtooOT67uAnBed9AKK/3yoQtSubEzhXXqxNfo
        SX2U/q4/WxzsRh9Ycs1cbbZwRSxbFrsswAnoeq8gJQ==
X-Google-Smtp-Source: ABdhPJymgEtBVCcAn3pSyiF+v4bp+AdIwu3Mj+68Yl4gqeJ4t+isuhTkTY3hJDbhbyg8uA0VHLrvaA/VUeDn+J4cO80=
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr3380775wrx.42.1589435688197;
 Wed, 13 May 2020 22:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
 <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
 <7163502.2kdGmH96AJ@kreacher> <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
 <CAJZ5v0hMs_A1-=wLmjgdO8jhW-MA-JSxV8xuDPCxti+yxTW2JQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hMs_A1-=wLmjgdO8jhW-MA-JSxV8xuDPCxti+yxTW2JQ@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Wed, 13 May 2020 23:54:32 -0600
Message-ID: <CAJCQCtTowrKa=xWxjhzRqgV4b3Vh70fctaRaL8_7WdD+CGHY0A@mail.gmail.com>
Subject: Re: 5.7 sleep/wake regression
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 8:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 13, 2020 at 8:11 AM Chris Murphy <chris@colorremedies.com> wrote:
> >
> > On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
> > > > On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> > > > > >
> > > > > > Got an older Macbook Pro that does suspend to RAM and wake OK with
> > > > > > 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> > > > > > it has a black screen, gets hot, fans go to high, and it turns into a
> > > > > > hair dryer. So it's a regression.
> > > > >
> > > > > There is a known issue addressed by this patch:
> > > > >
> > > > > https://patchwork.kernel.org/patch/11538065/
> > > > >
> > > > > so can you please try it?
> > > >
> > > > Patch applied, but the problem remains.
> > > >
> > > > CPU is i7-2820QM and dmesg for the working sleep+wake case:
> > > > https://paste.centos.org/view/ea5b913d
> > > >
> > > > In the failed wake case, I note the following: the fade-in/out sleep
> > > > indicator light on the laptop is pulsing, suggests it did actually
> > > > enter sleep OK. When waking by spacebar press, this sleep indicator
> > > > light stops pulsing, the backlight does not come on, the laptop does
> > > > not respond to either ssh or ping. Following  a power reset and
> > > > reboot, the journal's last line is
> > > >
> > > > [   61.678347] fmac.local kernel: PM: suspend entry (deep)
> > > >
> > > > Let me know if I should resume bisect.
> > >
> > > Please first try to revert commit
> > >
> > > 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> > > objects for ASL create_field() operator")
> >
> > Still fails. Bisect says
> >
> > $ git bisect good
> > b41e98524e424d104aa7851d54fd65820759875a is the first bad commit
> > commit b41e98524e424d104aa7851d54fd65820759875a
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Mon Feb 17 09:52:41 2020 -0700
> >
> >     io_uring: add per-task callback handler
> >
> > I'm not that great at git bisect so I'm not sure how to narrow it
> > down; offhand that doesn't seem a likely culprit.
>
> I would try to revert it and see what happens. :-)

It won't revert.

$ git revert b41e98524e4
Auto-merging fs/io_uring.c
CONFLICT (content): Merge conflict in fs/io_uring.c
error: could not revert b41e98524e42... io_uring: add per-task callback handler


-- 
Chris Murphy
