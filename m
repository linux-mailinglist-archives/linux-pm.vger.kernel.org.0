Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB15401DA8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhIFPeA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 11:34:00 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46991 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbhIFPeA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 11:34:00 -0400
Received: by mail-oi1-f175.google.com with SMTP id w144so9205487oie.13
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 08:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7DNaKqHt0VIbb9sKiDl+zg7pvzmjSNSzzJ/S8FkWBg=;
        b=g+c9hOL+IXOabXvPwoq8jZyJTwYsWwFOVdi6ggZj559netEVG2E7jPRKCnarTYOmRW
         vQlTo8wzqAH6GNNI91Bkd87ZgEpEIWN/lTlZ0sLXf2Q6S1V6RDyGo86pQcDdcFkw3rD5
         wnLqxpNh2r9DvHhJBTJeT1vXwiFYBKewFQm7nfTpzHqNaQr2wBGoRhARxETC9UWLJu2/
         jWVSrGc7MUzaK578HjvSbDmKYh4qXy76vVEIXReYQI+M8u2oOEF10ZmHZafvlLxtpX4+
         0cCQgFRqXj2USpkhRl/wpLr07lOPBRPBMOxzum7NM523+SZS8wKi6a6q5+ZnS8p0UEn9
         V6rg==
X-Gm-Message-State: AOAM531FFyWn2yRc0dYQ0P9YZiC4I1ijQbRxQwgMm5HuYgjYUm4/l2i1
        pAcf8SZOZf89MgAiKaU7xFfhLim6L+lk6gsD/N00NL/2
X-Google-Smtp-Source: ABdhPJxopK21PR2zfbW1Tx1SZrBYRRYftcnXWD4hkxBqRICWDbjps1pPOSTagSp4isPZNgGReAy2MmF5qzMM5aGDTRY=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr8497381ois.69.1630942375221;
 Mon, 06 Sep 2021 08:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
 <20210902105037.GA136543@e120877-lin.cambridge.arm.com> <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
 <20210902134927.GA147718@e120877-lin.cambridge.arm.com> <CAJZ5v0hi=YDiO79YWPDHcHEVypwv7++Qjmz7JAjOs9O6ooGy+g@mail.gmail.com>
 <20210906081733.GA4151@e120877-lin.cambridge.arm.com> <CAJZ5v0jdF_79nq6z41x52bWfYq58+qrDxcLneXFgxdEwQhaAwA@mail.gmail.com>
 <20210906125349.GA51637@e120877-lin.cambridge.arm.com> <CAJZ5v0jgwRghYYK6Bxsb4vmr-O+-g=3v4+Y4G3qSDfAxfjzo5g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jgwRghYYK6Bxsb4vmr-O+-g=3v4+Y4G3qSDfAxfjzo5g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 17:32:44 +0200
Message-ID: <CAJZ5v0icn1sFBeZOUHCbHcV7aQoc9TbZg_2XN8LC1xRJephNbg@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 6, 2021 at 5:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Sep 6, 2021 at 2:53 PM Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
> >
> > On Mon, Sep 06, 2021 at 02:08:36PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Sep 6, 2021 at 10:17 AM Vincent Donnefort
> > > <vincent.donnefort@arm.com> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > >
> > > > > > > Moreover, if only efficient frequencies are to be used, RELATION_L
> > > > > > > needs to return min(policy->max, the closest efficient frequency equal
> > > > > > > to or above the target).
> > > > > >
> > > > > > You mean, never returning an inefficient frequency, unless there are no
> > > > > > efficient ones in the range policy->min policy->max ?
> > > > >
> > > > > No, that's not what I mean.
> > > > >
> > > > > First note that the target here is clamped between the policy min and
> > > > > max.  Also bear in mind that each of them is a frequency from the
> > > > > table, either efficient or inefficient.
> > > > >
> > > > > In the first step, search through the efficient frequencies only.
> > > > > That will return you something at or above the target.  If it is at
> > > > > the target, you're done.  If it is above the target, it may be either
> > > > > within or above the policy max.  If it is within the policy max,
> > > > > you're done.  If it is above the policy max, you need to search
> > > > > through the inefficient frequencies between the target and the policy
> > > > > max (and you know that there is at least one - the policy max itself).
> > > > >
> > > > > So what I said previously wasn't particularly precise, sorry about that.
> > > >
> > > > I might have missed something but it seems equivalent to what's currently done:
> > > >
> > > > Find the appropriate frequency, if inefficient go to the efficient one, if
> > > > above policy->max return the original inefficient frequency.
> > >
> > > It may or may not be equivalent depending on what the efficient one is.
> > >
> > > And what is there now doesn't work for RELATION_H if I'm not mistaken.
> >
> > With the current approach, RELATION_H would find the best frequency and then
> > resolve it to an efficient one if possible. The efficient one might overshoot
> > the target_freq, but isn't it a good thing ?
>
> No, it cannot.
>
> >  - If we consider only the efficient freqs in a first place, there's a risk we
> >    would return a frequency way smaller than the actual request.
> >
> >  - What are the gain in capping RELATION_H to the target_freq if we can find a
> >    frequency higher than the request that wouldn't use more energy than the
> >    target?
>
> There may be a power constraint, so RELATION_H should never go above the target.
>
> > RELATION_H is used in two DVFS governors: conservative and ondemand:
> >
> >   - Ondemand is using RELATION_H in the context of powerbias. It seems a usecase
> >     where it is not a problem to overshoot RELATION_H.
> >
> >   - Conservative is using RELATION_H when the load is increasing. Same as
> >     ondemand, I don't think we would have any gain by not overshooting the
> >     RELATION_H target.
>
> Well, let me repeat: the performance governor uses RELATION_H, so if
> you allow it to go above the policy limit, it will stay there forever.

You'll probably say that the we'll always use the inefficient
frequencies with the performance governor, so this doesn't matter,
which is fair enough, but let me say that I'm not particularly keen on
storing the efficient frequency intex in every row of the table for
every CPU in the system especially on systems where all frequencies
are efficient (and these are the majority AFAICS), because this is
just plain confusing and it causes you to wonder why it may be a good
idea to let the target to be overshot in the RELATION_H case which is
even more confusing.

Can we just perhaps avoid this possibly premature optimization and get
back to it when it has been demonstrated to be necessary?
