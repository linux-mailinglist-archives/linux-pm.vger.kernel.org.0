Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0327F1D2C0C
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgENKBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 06:01:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65458 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgENKBc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 06:01:32 -0400
Received: from 89-64-84-17.dynamic.chello.pl (89.64.84.17) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 3eb25ceebfb78a86; Thu, 14 May 2020 12:01:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Murphy <chris@colorremedies.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: 5.7 sleep/wake regression
Date:   Thu, 14 May 2020 12:01:29 +0200
Message-ID: <4108819.xVErsNMLeE@kreacher>
In-Reply-To: <CAJCQCtTowrKa=xWxjhzRqgV4b3Vh70fctaRaL8_7WdD+CGHY0A@mail.gmail.com>
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com> <CAJZ5v0hMs_A1-=wLmjgdO8jhW-MA-JSxV8xuDPCxti+yxTW2JQ@mail.gmail.com> <CAJCQCtTowrKa=xWxjhzRqgV4b3Vh70fctaRaL8_7WdD+CGHY0A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, May 14, 2020 7:54:32 AM CEST Chris Murphy wrote:
> On Wed, May 13, 2020 at 8:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, May 13, 2020 at 8:11 AM Chris Murphy <chris@colorremedies.com> wrote:
> > >
> > > On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
> > > > > On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> > > > > > >
> > > > > > > Got an older Macbook Pro that does suspend to RAM and wake OK with
> > > > > > > 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> > > > > > > it has a black screen, gets hot, fans go to high, and it turns into a
> > > > > > > hair dryer. So it's a regression.
> > > > > >
> > > > > > There is a known issue addressed by this patch:
> > > > > >
> > > > > > https://patchwork.kernel.org/patch/11538065/
> > > > > >
> > > > > > so can you please try it?
> > > > >
> > > > > Patch applied, but the problem remains.
> > > > >
> > > > > CPU is i7-2820QM and dmesg for the working sleep+wake case:
> > > > > https://paste.centos.org/view/ea5b913d
> > > > >
> > > > > In the failed wake case, I note the following: the fade-in/out sleep
> > > > > indicator light on the laptop is pulsing, suggests it did actually
> > > > > enter sleep OK. When waking by spacebar press, this sleep indicator
> > > > > light stops pulsing, the backlight does not come on, the laptop does
> > > > > not respond to either ssh or ping. Following  a power reset and
> > > > > reboot, the journal's last line is
> > > > >
> > > > > [   61.678347] fmac.local kernel: PM: suspend entry (deep)
> > > > >
> > > > > Let me know if I should resume bisect.
> > > >
> > > > Please first try to revert commit
> > > >
> > > > 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> > > > objects for ASL create_field() operator")
> > >
> > > Still fails. Bisect says
> > >
> > > $ git bisect good
> > > b41e98524e424d104aa7851d54fd65820759875a is the first bad commit
> > > commit b41e98524e424d104aa7851d54fd65820759875a
> > > Author: Jens Axboe <axboe@kernel.dk>
> > > Date:   Mon Feb 17 09:52:41 2020 -0700
> > >
> > >     io_uring: add per-task callback handler
> > >
> > > I'm not that great at git bisect so I'm not sure how to narrow it
> > > down; offhand that doesn't seem a likely culprit.
> >
> > I would try to revert it and see what happens. :-)
> 
> It won't revert.
> 
> $ git revert b41e98524e4
> Auto-merging fs/io_uring.c
> CONFLICT (content): Merge conflict in fs/io_uring.c
> error: could not revert b41e98524e42... io_uring: add per-task callback handler

So there are commits on top of it that would need to be reverted as well.

Never mind.  As Jens said, it is unlikely that this particular commit
introduced the problem anyway.



