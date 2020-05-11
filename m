Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF11CD459
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgEKJA4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgEKJAz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 05:00:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB3C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 02:00:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m12so12267305wmc.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wa/Y2/bNwa7PXMvT6DW64UeJSTspYD/LSAH6iEazKOc=;
        b=YsLTnXaTfSkk+gitFPtm2o6ATLjnO7icsxuhJnZpaehw1rj0nfmZQ6UOlrXRq4cVqj
         QusXJ2zuMye43VqG66KOJJUG+kpo7nyfe+CPAbv+PUzG9UzG07/IWNxxMkxLOWw9Zx8Z
         UfuQ5vd2cj+ZaHPKp6S9ArYDMlxY6nsO/NwrehHYYxyQfqd8AuOIK5Q5EhZs8K6KQmM4
         /GH8zG1zU79H+6yPAGTWOuvUiVRCViKlMFQQFi24xBBtIIaBswRIwxrQUaW2Vdk0cBwV
         ID+NrFbzROL7rZSan6HdldhuLVmHPaAlmGCyvXQBxKjBvWrGGiRn6hrDzgYjnY2Os69K
         kaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wa/Y2/bNwa7PXMvT6DW64UeJSTspYD/LSAH6iEazKOc=;
        b=KLyDTRrTVWnF7zFnv6YpyKOkQ+/lXjWSEIuH5nnoW67ZItrVYJ1eEf1zIaWczpeR4R
         9ktaJ/LxFYOAUT0j2R4QrFoAr0vO6V5b0taDVEdJx9lOdp688/S9j0rtgUhzmuFr/ISx
         mVdd7LU+Moh1hVmpXG9DCZX1iVL0Fx7OLmS9Ct1nuvAuh8kd5T/Fzif9GG7a6f1yWYuy
         6wPvVxwwn3v/ugn2NPEuu+tP1feFBTG/d9WT/g8LJ1StXVKlpLmQqetjL+DiP++YY9lq
         GZQJBrD7G/QO49xcadVIQ6C333nupLaj0RFunXBKpj0thRoFqELron8S83yoiDR0xjOi
         Krew==
X-Gm-Message-State: AGi0PuaCeexntlscwRWrad1QEL4Ok1OKikHFTJGfRryD6Rm9scYCfEFR
        Wa1UzzlFCzcoifPJ5n/WXR/myQ==
X-Google-Smtp-Source: APiQypKB+Txh2Fatl+gQF7BtCPr6FGIyK3loGqkAPWInNYppvSCyOhLpTqx9lgsS930LO3mO8bDQYQ==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr8753076wmf.26.1589187653646;
        Mon, 11 May 2020 02:00:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id q17sm8884940wmk.36.2020.05.11.02.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:00:52 -0700 (PDT)
Date:   Mon, 11 May 2020 10:00:49 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, yzaikin@google.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200511090049.GA229633@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Friday 08 May 2020 at 15:40:34 (+0200), Rafael J. Wysocki wrote:
> On Fri, May 8, 2020 at 3:05 PM Quentin Perret <qperret@google.com> wrote:
> >
> > On Friday 08 May 2020 at 13:31:41 (+0200), Peter Zijlstra wrote:
> > > On Fri, May 08, 2020 at 12:16:12PM +0100, Quentin Perret wrote:
> > > > However, the point I tried to make here is orthogonal to that. As of
> > > > today using another governor than schedutil is fully supported upstream,
> > > > and in fact it isn't even enabled by default for most archs. If vendors
> > > > feel like using something else makes their product better, then I don't
> > > > see why I need to argue with them about that. And frankly I don't see
> > > > that support being removed from upstream any time soon.
> > >
> > > Right, it'll take a while to get there. But that doesn't mean we
> > > shouldn't encourage schedutil usage wherever and whenever possible. That
> > > includes not making it easier to not use it.
> > >
> > > In that respect making it modular goes against our ultimate goal (world
> > > domination, <mad giggles here>).
> >
> > Right, I definitely understand the sentiment. OTOH, things like that
> > give vendors weapons against GKI ('you-force-us-to-build-in-things-we-dont't-want'
> > etc etc). That _is_ true to some extent, but it's important we make sure
> > to keep this to an absolute minimum, otherwise GKI just won't happen
> > (and I really think that'd be a shame, GKI _is_ a good thing for
> > upstream).
> >
> > And sure, schedutil isn't that big, and we can make an exception. But
> > I'm sure you know what happens when you starting making exceptions ;)
> 
> This is a very weak argument, if it can be regarded as an argument at all.

Well, fair enough :)

> You will have to make exceptions, the question is how many and on what
> criteria and you really need to figure that out for the GKI plan.

The base idea is, anything that we know from experience is used by
everybody can be built in, anything else will need investigation. And as
you've understood, schedutil falls in that second category.

> > So, all in all, I don't think the series actively makes schedutil worse
> > by adding out-of-line calls in the hot path or anything like that, and
> > having it as a module helps with GKI which I'm arguing is a good thing
> > in the grand scheme of things.
> 
> Frankly, I'm not sure if it really helps.

Oh, why not?

> The idea of making schedutil modular seems to be based on the
> observation that it is not part of the core kernel, which I don't
> agree with.

Right, so that I think is the core of the discussion.

> Arguably, things like util clamps need it to work as
> expected.

Sure, but loading sugov dynamically as a module doesn't change much does
it?

If you are referring to the Kconfig dependency of uclamp on schedutil,
then that is a good point and I will argue that it should be removed.
In fact I'll add a patch to v2 that does just that, with the following
rationale:
 - it is obsolete: the reason that dependency was added originally was
   because sugov was the only place where util clamps where taken into
   accounts. But that is no longer true -- we check them in the capacity
   aware wake-up path as well, which is entirely independent from the
   currently running governor;
 - because of the above, it is (now) largely useless: a compile time
   dependency doesn't guarantee we are actually running with schedutil
   at all;
 - it is artificial: there are no actual compilation dependencies
   between sugov and uclamp, everything will compile just fine without
   that 'depends on';

Or maybe you were thinking of something else?

> > That of course is only true if we can
> > agree on a reasonable set of exported symbols, so I'll give others some
> > time to complain and see if I can post a v2 addressing these issues!
> 
> This isn't just about exported symbols, it is about what is regarded
> as essential and what isn't.

Right, the exported symbols are, IMO, quite interesting because they
show how 'core' the governor is. But what exactly do you mean by
'essential' here? Essential in what sense?

Thanks,
Quentin
