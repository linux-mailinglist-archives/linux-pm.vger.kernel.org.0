Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716341CFC30
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 19:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgELRbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 13:31:06 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42105 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 13:31:06 -0400
Received: by mail-oo1-f67.google.com with SMTP id a83so1071528oob.9;
        Tue, 12 May 2020 10:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1rDBr2LZPsItx6oTianrE8hsJBryJBqNpicNCJ+hAs=;
        b=EhPKR/NRP0RukIDkdCDVe3PHbRB7rudpt1ez+EE+x6j8lqDdHDAWN4j0gDSdEa8xhp
         5CCIT4b4rTnFCHxd2GpT09RqZ2FtTj9NqRaYkVSN1tcwJvUpMYQ+Ns9xutb6Ngb3W6CY
         2ETqbsfQDW13qJQYFMFxm5/VqrVdRMC8i5jNRaFgTOzLX/9PsfUSnr4I4W3c43FyCFjX
         be0JwPk88TyoUPOWkRZnig1vs/JpOsJrlp18KmU5/yPZJF0d/2BliB+WDn0rKfeUASqi
         MiWevFYPZPMdJ/j2I4PVUSENJecK5gjby7Gh3jkwq7QtVJDzgTqLVMG0Vz+2+teR5QAs
         h3SQ==
X-Gm-Message-State: AGi0PuYzJ3vZgS4KoiX6B8rKUT3Xtfe/TtExxSRj35rPpRbDltZ38Hif
        i7tUquX1Qf+pmwckJzpICk35EJSnhOwhWIs0KWY=
X-Google-Smtp-Source: APiQypKndO1ilammFSxfSHkTTuvKf8k/4MMjBYODJ6DRYHfCIGjbXnCB2909MoBJph27lwy/hs1h5J+csCpw8WUFqGI=
X-Received: by 2002:a4a:a286:: with SMTP id h6mr18757126ool.38.1589304663700;
 Tue, 12 May 2020 10:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200508130507.GA10541@google.com> <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com> <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com> <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com> <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com> <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
 <20200512162630.GC101124@google.com>
In-Reply-To: <20200512162630.GC101124@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 May 2020 19:30:52 +0200
Message-ID: <CAJZ5v0ges4=e2HkHpVk4E1yF1VsBm9H5noqMz-MxX9DK_kt6Xg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
To:     Quentin Perret <qperret@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 12, 2020 at 6:26 PM Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 12 May 2020 at 17:30:36 (+0200), Rafael J. Wysocki wrote:
> > On Tue, May 12, 2020 at 5:11 PM Quentin Perret <qperret@google.com> wrote:
> > > The end goal with GKI is the following: Google will release a single
> > > binary kernel image (signed, etc etc) that all devices using a given
> > > Android version will be required to use. That image is however going to
> > > be only for the core of the kernel (no drivers or anything of the sort).
> > > Vendors and OEMs, on their end, will be responsible to build and ship
> > > GKI-compatible modules for their respective devices. So, Android devices
> > > will eventually ship with a Google-issued GKI, plus a bunch of
> > > vendor-provided modules loaded during boot.
> >
> > If that is the case, then I absolutely think that schedutil should be
> > part of the GKI.
> >
> > Moreover, that would have been my opinion even if it had been modular
> > in the first place.
>
> I definitely understand the feeling. Heck I contributed to schedutil, so
> I'd love to see the entire world run it :-)
>
> But my personal preference doesn't seem to matter in this world, sadly.
> The truth is, we cannot afford to be arbitrary in our decisions in GKI.
> Switching governors and such is a fully supported feature upstream, and
> it has been for a long time. Taking that away from partners is not the
> goal, nor the intention, of GKI.

It still will be possible with schedutil built-in, however.

> They will be able to choose whatever
> governor they want, because there are no *objective* reasons to not let
> them do that.

Which, again, is still possible with non-modular schedutil AFAICS.

I don't see any technical reason for making schedutil modular in the
context of GKI other than to make the GKI image smaller, but I don't
expect that to be significant enough.

Is there anything else I am missing?

> > > This is a significant shift from the current model where vendors
> > > completely own the kernel, and are largely free to use the kernel config
> > > they want. Today, those who don't use schedutil are free to turn the
> > > config off, for example.
> >
> > So why is this regarded as a good thing?
>
> You mean using something else than schedutil?

I mean why allowing people to compile schedutil out is regarded as a good thing.

> It is not seen as a good
> thing at all, at least not by me. But we have the same problem as
> upstream. We cannot remove the other governors or the governor API for a
> simple reason: they have users :/

I'm not saying about removing any of that.  I'm just trying to
understand why you need schedutil to be modular so as to make those
things possible.

Cheers!
