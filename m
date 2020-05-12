Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA701CF92B
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgELPau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 11:30:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43928 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgELPau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 11:30:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id i22so1965341oik.10;
        Tue, 12 May 2020 08:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtDSeBieq8eW80YMu3q9EWuFZBKApc+eT4Drp4f7k4U=;
        b=ZMRb4C8Uckd6SUzUgD0bFn9t3kIwURe8GcuNPcmjd0Nw2nJo+U8Vi2IYH2VDdB6Mn6
         ZA/ukl5WYtb/DpSI2bbtALpsIodVdXaA0mX6e7+OKpIx0LTHtpap+VmK8gKqB97UapvA
         WHdr4bvTIIAqvopWVCCKp1e4eZicdF5RTxIwQzv+q59vFtrsxeXrdkzYuygKtUU8vtG4
         WpXgsLJJyHFEdF7RFjzzYSsO19bIYdJIiItS1NXONH62+Y6OSU+vo+LdNyJlnPYn/8QX
         SC3Vx3RaSK/Z/8oq0UfcYDNCmnRf4qnloxGuLZce7rF2CjVMo1MZhX9XXD2gMeV+Zb0o
         nsBA==
X-Gm-Message-State: AGi0PuYD/b0fapC6IIZzeO7aG0aTkqx8XD0k7tqzm8p19QP3TLvLGMH1
        FtPzXUsgr/z3hIIfegv/D3q7oZZqWy4VYT3jvbQ=
X-Google-Smtp-Source: APiQypIO6qxrtteBpZQzQrJWP+YRfp+4SOjzkNa/wPWLVmHZfpzd+2rPITLy9aTdE+gZdql9F0Ofxia4rXPiLI8okAk=
X-Received: by 2002:aca:4254:: with SMTP id p81mr1720404oia.68.1589297448303;
 Tue, 12 May 2020 08:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200508111612.GA252673@google.com> <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com> <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com> <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com> <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com> <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com>
In-Reply-To: <20200512151120.GB101124@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 May 2020 17:30:36 +0200
Message-ID: <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
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

On Tue, May 12, 2020 at 5:11 PM Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 12 May 2020 at 16:08:56 (+0200), Rafael J. Wysocki wrote:
> > If some piece of kernel code is modular, it still needs to be build.
> > The difference is when and how it gets loaded, so can you possibly
> > elaborate here?
>
> Sure thing, sorry if that wasn't clear.

No worries.

> The end goal with GKI is the following: Google will release a single
> binary kernel image (signed, etc etc) that all devices using a given
> Android version will be required to use. That image is however going to
> be only for the core of the kernel (no drivers or anything of the sort).
> Vendors and OEMs, on their end, will be responsible to build and ship
> GKI-compatible modules for their respective devices. So, Android devices
> will eventually ship with a Google-issued GKI, plus a bunch of
> vendor-provided modules loaded during boot.

If that is the case, then I absolutely think that schedutil should be
part of the GKI.

Moreover, that would have been my opinion even if it had been modular
in the first place.

> This is a significant shift from the current model where vendors
> completely own the kernel, and are largely free to use the kernel config
> they want. Today, those who don't use schedutil are free to turn the
> config off, for example.

So why is this regarded as a good thing?

> But GKI changes that. The 'core' GKI config is effectively imposed to
> the entire ecosystem. As of now, because it is 'bool' we have no choice
> but to compile schedutil in the core GKI as some (most) partners use it.
> But as you can imagine, that is not the preferred option of those who
> _don't_ use schedutil.

OTOH, it may as well be an incentive for them to switch over and
report problems with it that they see.

I absolutely would like to make schedutil the clearly preferred option
and IMO avoiding to use it, especially for non-technical reasons,
should be clearly less attractive.

> Modularizing avoids any potential friction since
> the vendors who want to use it will be able load the module, and the
> others will simply not. That really is the reason for that series.

If the long-term target is for everyone to use schedutil, then I don't
quite see why making it easy to not include it in one's system is
going to help.

> Then there is an important question: why should upstream care about all
> that stuff? That's obviously debatable, but my biased opinion is that
> GKI is a good thing(TM). It's our opportunity to put some order in the
> android ecosystem and to reduce the delta with mainline. That'll
> definitely take time, and there will be Android-specific churn in GKI in
> the beginning, but we'd like to keep that as small as possible, and to
> converge to 0 looking forwards.

That's a good goal, but I'm not sure if the least resistance path to
it is the right one. :-)

Cheers!
