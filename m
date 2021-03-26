Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C290634AD0C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCZRC1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 13:02:27 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:35375 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCZRB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 13:01:59 -0400
Received: by mail-ot1-f49.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so5844758oto.2;
        Fri, 26 Mar 2021 10:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j39tFeNSOySBzRr0wRwu5Hg3GUh0t1N0ZoAe65Kuhwc=;
        b=ClRXMBeuamL9zd7JCu7Kxykdh3j35FuNYh77lBuXaUYAOx4/6oDzCFWtdAf6XiBTMz
         FtoDkUQLJpJnSXvFj5GSESWbgQE2AWv8euTAX6rjrNPXsxEB+0Ay0caD1E0JKiq5MQaR
         i+v8UJVWOnY98Y3thMg2PwkN0PCON4X7OhWVD2vW6/GAEiY/Dcny8b/INPeZQXpdij0N
         iIhbfExBGkcKTXKz2SFwC0tx3VaY6Lm/Ao4E6HOMtH2tKgSAV9FUo+oVdjV93pDpBwU7
         F2muCpAzEyHGMhHq8pT3901bfa3pjLscs4ePWwq2ZxhKu067W0oz/8Wuc9BpmzoZELLz
         9+Jg==
X-Gm-Message-State: AOAM530E9O5gve/zfITYabe/zjxXfkUdLKTli1r+kXOrSvzf2uLhmjH2
        xk5T/DfABeqQ2ViplVxl0ZQTfDyKxp3TEYCOebA=
X-Google-Smtp-Source: ABdhPJzhdEB0Upgt5eIFHCBU3pd8mUn/BbOPMYqJ4636WlCPkQ08Kxo6XhTvOV2M+da8gU3J8MYPGzJ4TRX+Zi4A/iw=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr12982365otf.206.1616778118573;
 Fri, 26 Mar 2021 10:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210311123708.23501-1-frederic@kernel.org> <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <20210325131400.GA938586@lothringen> <5712356.lOV4Wx5bFT@kreacher>
 <YTBPR01MB326253A7B094A2F603488EA8C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <CAJZ5v0h2BZdj4ds1NUKUcdJ_WCZe-0EogE1k5qbJkoEGFkjJyw@mail.gmail.com> <YTBPR01MB3262C64BEB4DBA0ED48F3168C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YTBPR01MB3262C64BEB4DBA0ED48F3168C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Mar 2021 18:01:47 +0100
Message-ID: <CAJZ5v0ihHPm22+r_FD=edrz7-4u_tnjHVZ9GdyN3O8w5FLbGBg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19ubw==?=
        =?UTF-8?B?aHpfZ2V0X3NsZWVwX2xlbmd0aCgpIGZyb20gcmV0dXJuaW5nIG5lZ2F0aXZlIHZhbHVl?=
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 25, 2021 at 9:37 PM Zhou Ti (x2019cwm) <x2019cwm@stfx.ca> wrote:
>
> On March 25, 2021 15:50, Rafael J. Wysocki wrote:
> > On Thu, Mar 25, 2021 at 8:18 PM Zhou Ti (x2019cwm) <x2019cwm@stfx.ca> wrote:
> > >
> > > On March 25, 2021 14:56, Rafael J. Wysocki wrote:
> > > > On Thursday, March 25, 2021 2:14:00 PM CET Frederic Weisbecker wrote:
> > > > > On Tue, Mar 16, 2021 at 04:08:08PM +0000, Zhou Ti (x2019cwm) wrote:
> > > > > > But I don't think it's a good idea to handle this in callers, because logically the function shouldn't return negative values. Returning 0 directly would allow idle governors to get another chance to select again.
> > > > >
> > > > > Hmm, I'm going to leave the last word to Rafael since cpuidle are the only
> > > > > callers of this. In any case we need to fix it.
> > > >
> > > > Yes, we do.
> > > >
> > > > So I said that I preferred to address this in the callers and the reason why
> > > > is because, for example, for the teo governor it would be a matter of using
> > > > a different data type to store the tick_nohz_get_sleep_length() return value,
> > > > like in the (untested) patch below.
> > > >
> > > > So at least in this case there is no need to add any new branches anywhere.
> > > >
> > > > I'm still not sure about menu, because it is more complicated, but even if
> > > > that one needs an extra branch, that is a win already.
> > >
> > > I would like to point out the potential trouble that fixing this issue in the
> > > callers could cause.
> > >
> > > 1. This function is called multiple times in menu governor and TEO
> > > governor.
> >
> > What do you mean by "multiple times"?
> >
> > Each of the governors calls it once per cycle and its previous return
> > value is not used in the next cycle at least in teo.
>
> I remember a governor called this function twice in a cycle, I guess I remember
> wrong.

That obviously depends on the governor, but both teo and menu call it
once per cycle.

> > > I'm not sure that receiving results using signed integers is enough
> > > to solve all the problems, in the worst case it may require increasing
> > > the logical complexity of the code.
> >
> > That is a valid concern, so it is a tradeoff between increasing the
> > logical complexity of the code and adding branches to it.
> >
> > > 2. This function is important for developing idle governor.
> > > If the problem is not fixed in the function itself, then this potential
> > > pitfall should be explicitly stated in the documentation.
> >
> > That I can agree with.
> >
> > > This is because
> > > it is difficult to predict from the definition and naming of the function
> > > that it might return a negative number. I actually discovered this anomaly
> > > when I was doing data analysis on my own idle governor. For some idle control
> > > algorithms, this exception return could lead to serious consequences,
> > > because negative return logically won't happen.
> >
> > Well, it's a matter of how to take the possible negative return value
> > into account so it does not affect the result of the computations.
>
> I think it is challenging for some algorithms to take negative return values
> into account properly. For TEO (and even menu), it is possible to
> solve the problem by just changing the way the data is received is because the
> learning mechanism for both algorithms is simple.

Of course this depends on the governor.

> One of the interesting things about the CPUIdle subsystem is that it is well
> suited to introduce machine learning and probabilistic statistical methods.

You need to remember that the governor code runs in the idle loop
context which is expected to be reasonably fast.

That's why we are worrying about individual branches here.

> This means that many of the more complex and data-sensitive algorithms can
> potentially be explored. In the best case we will still need to add additional
> code complexity to a new algorithm.

So I'm not sure what the problem with adding an upfront negative value
check to the governor is.

> It would reduce a lot of unnecessary considerations (for example, highlight
> this shortcoming in the documentation) if we could ensure that this function
> would work as it is logically defined. But I don't really understand
> how much of a burden adding an extra branch would impose, so I don't know if
> this tradeoff is worth it.

It ultimately depends on the governor, which is why I think that the
negative value check should be done by the governor, if needed, and
not by the function called by it, because in the latter case the check
may be redundant and we end up with an extra branch (or two branches
in this particular case) for no good reason whatsoever.

Yes, there are governors which simply can do the negative value check
upfront right after calling that function and ensure that they will
not deal with negative values going forward.  This is probably what
I'll do in the menu case.

However, if the governor is simple enough and it can avoid doing the
explicit negative value check, I don't see a reason to do that check
elsewhere "just in case".
