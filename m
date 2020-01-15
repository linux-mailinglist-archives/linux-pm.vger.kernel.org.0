Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E588113BC18
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAOJLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 04:11:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34525 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOJLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 04:11:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id w5so4231553wmi.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 01:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeuN6KDh+6iCs0yefxABXjKIW5aWbQor/ERBSv2qacI=;
        b=GDTFY4dcCmTGGPSve+M1bTEAQjvCBU/tMypr2r8kI4cMCcX1vmAscW8m45Y4d1tbqC
         NSNJBQR9867sr7kP+diomY2SqBZzJKrnW7xtimTg42x033rdCBK6VoozdhSsiG8l2gBC
         uKhZ9YvcBBLnnd8OKFAWvowD7om/bFRVOI/beizGki0g4idHkl6+Xpg/CT+A0f6PDuG/
         pHLPSrhJU6G7Aqlb9Hn1z+4nkLBwowXzIr9j1DWSldK75NFC6Uj4+FAAcCu016ZJS2PZ
         J2qSAx3h8mhWTSfU+ny9wFcBM1OMEITKifu91YxCivJD7CzonD4O1x6LN33uc92NbSi1
         +kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeuN6KDh+6iCs0yefxABXjKIW5aWbQor/ERBSv2qacI=;
        b=JLAxAptHuNUAxjvtdujbDa30VQaHbAp019T0qX86lDPeAhI6VrhUy1/SA7iHMEVRoa
         npCAjZbrqt7D2MMCbggorvsuqv5kqihgEvX84wVjvIZnzc2+uaWehClNpFMwnv/EmLlO
         X//Wb/9lQqpU3rMYvnkB/9rpGZVJuFpIYG5jFxPv/B66tBdcN/q7isy8MCDErLkwPE4b
         O36aMx665thIrMQUI+JaBop8u7lWCM9eOtJAR+ktP8P6lvLnF0AhX+uhP/GfyrwARDHw
         71luN30mS/C+Qq2sU4b1CmnnErFWzDTyOuV3ocVBwRyzUXURQj62OzI12f2iV9u6lH1x
         7xvA==
X-Gm-Message-State: APjAAAUyJl2OxR5m+MkypWJJ/0trMDjcsFlnu5RjV/I0bdnAyQAQ88TW
        wncfN1MVrwrbeW3J8bWcNOqS6ll/VwSJURsn8a97WQ==
X-Google-Smtp-Source: APXvYqyl/Un01NOPl2ocAmtn/GIeu1fCN1+833Wd4YgI+7a/clfr9xxom1NobiU+MF7o8Dfbe+pnloJ5zaD/x950+iM=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr31994910wmj.117.1579079459339;
 Wed, 15 Jan 2020 01:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20191223211309.GA4609@sig21.net> <CAG_fn=UgU3vibsaug6p35Xs1dzLgBecA48t-PqS9OtRTHNu54g@mail.gmail.com>
 <CAG_fn=VjzJSguf4ZB2x8Xn=U9MCHyfyqd2DVwPPC36t5+S+VsQ@mail.gmail.com> <38519837.OfHf9z5LDp@kreacher>
In-Reply-To: <38519837.OfHf9z5LDp@kreacher>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 15 Jan 2020 10:10:48 +0100
Message-ID: <CAG_fn=UwBjv94QKjrMR1cd_ZvzX-SuTYoMo7pHFSZNGuQvUxxg@mail.gmail.com>
Subject: Re: init_on_free breaks hibernate
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Johannes Stezenbach <js@sig21.net>, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 14, 2020 at 11:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, January 14, 2020 12:38:53 PM CET Alexander Potapenko wrote:
> > > > Strange about the resume=/dev/vda, it worked for me the way I described it.
> > > > Maybe device numbers are dynamic, 254:0 is what I got from ls -l /dev/vda.
> > > Indeed, for me it's 253:0, and resuming from console works with that number.
> > >
> > > > > The memory corruption is also reproducible for me, taking a look.
> > > >
> >
> > I think I know what is causing the problem.
> > Upon resume the free pages may contain stale information from the
> > kernel that initiated the resume.
> > There's clear_free_pages()
> > (https://elixir.bootlin.com/linux/latest/source/kernel/power/snapshot.c#L1148)
> > that clears the pages in the case CONFIG_PAGE_POISONING_ZERO is
> > enabled, we just need to reuse it for init_on_free.
> > See the potential fix below.
> >
> > Rafael, Pavel, I've noticed that in the setup suggested by Johannes
> > even the defconfig kernel with heap initialization cannot hibernate
> > more than twice, the third hibernate hangs.
> > Is that a known problem?
>
> No, it is not.

Sorry for the typo. Actually, the defconfig _without_ heap
initialization cannot hibernate more than twice.
