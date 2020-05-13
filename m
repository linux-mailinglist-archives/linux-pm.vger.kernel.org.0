Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0419F1D06F4
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgEMGLW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 02:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgEMGLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 02:11:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9CC061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:11:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so12942392wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 23:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5UbLg8H/RfPIEunKuhmZEY6BfagAvEq5/IHXlSz8xw=;
        b=Lx7oPXJ2jM03JSrIpx8iduP89evd19cp6TzRMIunLsgQLysqyVchh24APy0b36nin2
         tHHxp7b6UhpRhecpGkH0WVeEODc8gXdgqFShEMPrj7SFNoyiIEepYQXnN/78mHaS+DAD
         npbLjS1/gcaMNTDEhy29eae5VODCc7MNU23ci+WQumUNnYkHklsXCtlEus+ZqIUWtnqI
         apJmYLmNMavDkg3/6JK1fvP5aBl9uzEpASKglHVVvIURKiQAYnKQDkMuSJz5+PU5WinB
         aiwKfFY+GoIR2r1xU+Yi8w50xGGl13dgqgTqV9HhmPgfvi/0d7wJPEPAFLKKuBOSs2be
         DarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5UbLg8H/RfPIEunKuhmZEY6BfagAvEq5/IHXlSz8xw=;
        b=WfQZz7I0i0JfJ3w3kFkw7XVr5u0oUi77d776P6042KLPB6CUmZVAkOZEstKTaClSOs
         z4hvVidsOTWqLuaB/FT9MMjfZDCErUbgME/0KPhKMR3NMwpmK9jh4s/yTJ04RBbSw1Q6
         VNvzZTDOBfPx8u4EJSNHDeRK2yMexil+R/9KlyRA53DGtQgEf8ewxHoWvjMUW9qo7SjQ
         a6ODRRX0T1ytwHb+WRAcO6lR7mMc16WdLGm9ZSOmANHInZ5SzeoJR42azGqEpKiqUZZh
         MBNHHi1JV9jnYKhD/1o83AV3Ay7G/FhWDSKf+Usz1/NbxfwYjLuR0qCmg2VJ6iPuGQEa
         e2kg==
X-Gm-Message-State: AGi0PuZEyzlP1wad5X6h3C6Ek68alq389c+nm4m6Xw9v7HcYEPddsRyb
        S3YbSDntddaIDxlM4aNHSuIIr8TN95lP5XUNNIFw5owDNo/yEQ==
X-Google-Smtp-Source: APiQypKM2+jm/+sEHNBHR0+OX/fKNo9Zh0aGrBQhRLbYJvHg942mOhV1x8i5TuJyxitFuMWxMQFQH9rCywLZ8pDAbxo=
X-Received: by 2002:a7b:c413:: with SMTP id k19mr15187446wmi.124.1589350280425;
 Tue, 12 May 2020 23:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
 <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com> <7163502.2kdGmH96AJ@kreacher>
In-Reply-To: <7163502.2kdGmH96AJ@kreacher>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Wed, 13 May 2020 00:11:04 -0600
Message-ID: <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
Subject: Re: 5.7 sleep/wake regression
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
> > On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> > > >
> > > > Got an older Macbook Pro that does suspend to RAM and wake OK with
> > > > 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> > > > it has a black screen, gets hot, fans go to high, and it turns into a
> > > > hair dryer. So it's a regression.
> > >
> > > There is a known issue addressed by this patch:
> > >
> > > https://patchwork.kernel.org/patch/11538065/
> > >
> > > so can you please try it?
> >
> > Patch applied, but the problem remains.
> >
> > CPU is i7-2820QM and dmesg for the working sleep+wake case:
> > https://paste.centos.org/view/ea5b913d
> >
> > In the failed wake case, I note the following: the fade-in/out sleep
> > indicator light on the laptop is pulsing, suggests it did actually
> > enter sleep OK. When waking by spacebar press, this sleep indicator
> > light stops pulsing, the backlight does not come on, the laptop does
> > not respond to either ssh or ping. Following  a power reset and
> > reboot, the journal's last line is
> >
> > [   61.678347] fmac.local kernel: PM: suspend entry (deep)
> >
> > Let me know if I should resume bisect.
>
> Please first try to revert commit
>
> 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> objects for ASL create_field() operator")

Still fails. Bisect says

$ git bisect good
b41e98524e424d104aa7851d54fd65820759875a is the first bad commit
commit b41e98524e424d104aa7851d54fd65820759875a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Feb 17 09:52:41 2020 -0700

    io_uring: add per-task callback handler

I'm not that great at git bisect so I'm not sure how to narrow it
down; offhand that doesn't seem a likely culprit.

$ git bisect log
git bisect start
# good: [7111951b8d4973bda27ff663f2cf18b663d15b48] Linux 5.6
git bisect good 7111951b8d4973bda27ff663f2cf18b663d15b48
# bad: [47acac8cae28b36668bf89400c56b7fdebca3e75] Merge tag
'hwmon-for-v5.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect bad 47acac8cae28b36668bf89400c56b7fdebca3e75
# good: [1592614838cb52f4313ceff64894e2ca78591498] Merge tag
'for-5.7/drivers-2020-03-29' of git://git.kernel.dk/linux-block
git bisect good 1592614838cb52f4313ceff64894e2ca78591498
# good: [7af51678b6d367ee93dc3d21e72ecf15be50fcb1] docs:
deprecated.rst: Add BUG()-family
git bisect good 7af51678b6d367ee93dc3d21e72ecf15be50fcb1
# good: [7af51678b6d367ee93dc3d21e72ecf15be50fcb1] docs:
deprecated.rst: Add BUG()-family
git bisect good 7af51678b6d367ee93dc3d21e72ecf15be50fcb1
# bad: [377ad0c28c1df7b0634e697f34bdea8325f39a66] Merge tag
'erofs-for-5.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
git bisect bad 377ad0c28c1df7b0634e697f34bdea8325f39a66
# bad: [bcda7baaa3f15c7a95db3c024bb046d6e298f76b] io_uring: support
buffer selection for OP_READ and OP_RECV
git bisect bad bcda7baaa3f15c7a95db3c024bb046d6e298f76b
# bad: [b41e98524e424d104aa7851d54fd65820759875a] io_uring: add
per-task callback handler
git bisect bad b41e98524e424d104aa7851d54fd65820759875a
# good: [7d67af2c013402537385dae343a2d0f6a4cb3bfd] io_uring: add
splice(2) support
git bisect good 7d67af2c013402537385dae343a2d0f6a4cb3bfd
# good: [5eae8619907a1389dbd1b4a1049caf52782c0916] io_uring: remove
IO_WQ_WORK_CB
git bisect good 5eae8619907a1389dbd1b4a1049caf52782c0916
# good: [6fb614920b38bbf3c1c7fcd944c6d9b5d746103d] task_work_run:
don't take ->pi_lock unconditionally
git bisect good 6fb614920b38bbf3c1c7fcd944c6d9b5d746103d
# good: [c2f2eb7d2c1cdc37fa9633bae96f381d33ee7a14] io_uring: store
io_kiocb in wait->private
git bisect good c2f2eb7d2c1cdc37fa9633bae96f381d33ee7a14
# first bad commit: [b41e98524e424d104aa7851d54fd65820759875a]
io_uring: add per-task callback handler
$



-- 
Chris Murphy
