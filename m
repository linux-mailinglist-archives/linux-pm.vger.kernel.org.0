Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE971D35E5
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgENQDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENQC7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 12:02:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD44C061A0C
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 09:02:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so26198920wmc.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2020 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rwkg6NcmuyiutcFfh5YA0mfGI0aZdgB4df+NDCQLjvA=;
        b=Ub5cK8E/dCo7pMocQ2NNiQ58EPI9ikRp073Q9l52jS206xSr3xH4c19rTvSVMJ5wDM
         WFkSS+fBZAvs8KNGboa0JSnOxfMxFLdbNWEFsq05KyEnYDYvkbMBrFOg3fbnqPxAnlC7
         3epPxnvqLX2KKcIqEAnh82K2WuvXGMNqz7eQp3jAafhjMW9Gp4+eJrGIHuLgLsoas2/R
         L1RfFRt7D111ERFH1LeXbAEeA2+i16ZRMAFsNMMIjCRbHqWrIbHrPUdqFDQ227wnS2IN
         QIyrSZol10uYTXb7jBWPKX712ldR6zAi4z8CZyHi3vdAbe37xfHSZImIS8P4eerWumpg
         aO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rwkg6NcmuyiutcFfh5YA0mfGI0aZdgB4df+NDCQLjvA=;
        b=X6QXtTl5oyFmyFssVapFoWtiXQzDJddnhuQ3skZiZORvnZw5PS/+nmHc7ZoASW7vpS
         NDk0QOYb8yE/tNyiSGezZE4kr7GVirTpRgVTUCND4qgGcmrjcCPknTBB6VvgBQ2hTGTX
         J+O9zxvIUTKtUR6vnVz5AAqjUhMjqz/9jgz4Nir7yQ+g8/3YruS8BClBbcdnuhBTQdPZ
         VNcTgua/NxB6uCDXTMlKd3ut+8znEcOrDa1tTD64YnnAeB4w8Vas+3YwdXuYmi5I6Gck
         GKm+kw1XZkqvkEzs/cqkEAcHLp9ER3MyZCujYeOpRwJCODA8Rhm1sgEudNy3pIj1RFcE
         THgg==
X-Gm-Message-State: AGi0PuZroinqgVQVGsRugWRHlJdH4z6NwiNnvh4QuSXbdLGNtW1m0mCE
        NJ1IenREjArtBiOgvKNsIhvyaiRWNAfb0LuOqy/18A==
X-Google-Smtp-Source: APiQypJDRSvrTZHhjBQZu3IlgQbWdmzprWmqtKJvrbM4TDc7GY9N3dP1A1Sr+5e+0bLoeFJ4nd1hyRKipXKleoKqKzE=
X-Received: by 2002:a1c:2348:: with SMTP id j69mr33389182wmj.11.1589472177279;
 Thu, 14 May 2020 09:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
 <CAJZ5v0hqODC52Bogeo-2suROH63NmON=5a5K6OZEp1YYMYK_QA@mail.gmail.com>
 <CAJCQCtTxQw=P43wHM2ENX600Jm+BXU+f+=Wv09ijjiqWZoWsiQ@mail.gmail.com>
 <7163502.2kdGmH96AJ@kreacher> <CAJCQCtRAMgH4Qwfo7xqO2PQYedLSKBD9wmbj-T9aBvVYa2MGPQ@mail.gmail.com>
 <b4527188-5189-49f8-c776-74d47186fc35@kernel.dk>
In-Reply-To: <b4527188-5189-49f8-c776-74d47186fc35@kernel.dk>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Thu, 14 May 2020 10:02:40 -0600
Message-ID: <CAJCQCtTMWGwiH5ztmV+w3PHhQdr8XO_909Jqf-nCiNc6sJURDg@mail.gmail.com>
Subject: Re: 5.7 sleep/wake regression
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 8:09 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/13/20 12:11 AM, Chris Murphy wrote:
> > On Tue, May 12, 2020 at 6:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> On Monday, May 11, 2020 7:37:04 PM CEST Chris Murphy wrote:
> >>> On Mon, May 11, 2020 at 5:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>>
> >>>> On Mon, May 11, 2020 at 6:22 AM Chris Murphy <chris@colorremedies.com> wrote:
> >>>>>
> >>>>> Got an older Macbook Pro that does suspend to RAM and wake OK with
> >>>>> 5.6, but starting with git 47acac8cae28, it will not wake up. Instead
> >>>>> it has a black screen, gets hot, fans go to high, and it turns into a
> >>>>> hair dryer. So it's a regression.
> >>>>
> >>>> There is a known issue addressed by this patch:
> >>>>
> >>>> https://patchwork.kernel.org/patch/11538065/
> >>>>
> >>>> so can you please try it?
> >>>
> >>> Patch applied, but the problem remains.
> >>>
> >>> CPU is i7-2820QM and dmesg for the working sleep+wake case:
> >>> https://paste.centos.org/view/ea5b913d
> >>>
> >>> In the failed wake case, I note the following: the fade-in/out sleep
> >>> indicator light on the laptop is pulsing, suggests it did actually
> >>> enter sleep OK. When waking by spacebar press, this sleep indicator
> >>> light stops pulsing, the backlight does not come on, the laptop does
> >>> not respond to either ssh or ping. Following  a power reset and
> >>> reboot, the journal's last line is
> >>>
> >>> [   61.678347] fmac.local kernel: PM: suspend entry (deep)
> >>>
> >>> Let me know if I should resume bisect.
> >>
> >> Please first try to revert commit
> >>
> >> 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> >> objects for ASL create_field() operator")
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
>
> Yeah, it's definitely not that...
>
> > I'm not that great at git bisect so I'm not sure how to narrow it
> > down; offhand that doesn't seem a likely culprit.
>
> How reliable is the test you use to deem a given commit good or
> bad? It sucks in terms of time, but it may be useful to re-run
> the bisection and ensure that you don't ever have false positives.

100%. This laptop never fails to wake from S3. Dozens of sleep/wake
cycles on 5.6, 5.5, going way back. It's 100% fail on all 5.7 rc's.





--
Chris Murphy
