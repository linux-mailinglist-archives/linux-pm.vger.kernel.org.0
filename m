Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05600401E08
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbhIFQF3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 12:05:29 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38805 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbhIFQF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 12:05:28 -0400
Received: by mail-oi1-f176.google.com with SMTP id bd1so7353662oib.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 09:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Z5d/IhXgDeaThCiNRYlVBRsZaCWiJLV++60L9vTJ6w=;
        b=LjJ8q2H5VsIe5y4dUvYl1fGbwwDfaBA4xjOmhWNXwf1nvOW1k2XYi6i1EkkcXLkjRU
         1CMojHNC30orLSeyXAaNy/357PrbOO90KoVtK102X8fvFOv9p6lwUmHwRsXop/Iy3bre
         J59ykpR72XtvBF0DXUqhIZuuTvS5m6rO0UQrJeIc4DZk1azfAUMGvnJZcR9Fqp4QCIxn
         gobzYFy8rReFzkAhi+np+226R9OWfvMyFaPCrR89VVOacyoD9YmRvcBehA+y19FxDtyh
         dLW3rAMW6oe0Yx/Z+yK1FAHTxqiT9MK3LeDWTRhD7SqgtEr7CGXrjjR8LmktAA6RnvQE
         FjCg==
X-Gm-Message-State: AOAM531pte9PMiMdmuwhVT3qeidRPVpvIexISF+f/hHlKQJNNbkSeh7t
        oFGxyxogowLlLuu660mYMm75gB550xbVgI5jUmI=
X-Google-Smtp-Source: ABdhPJzPfqktpjjks2hYuPyu0wm1dwXgmN2TXVUcHSD+BsQDfPfwgxk9krJbQThuXMawT9LD4VcRLhscC97Uls6MFjM=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr9052033oie.71.1630944263436;
 Mon, 06 Sep 2021 09:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
 <20210902105037.GA136543@e120877-lin.cambridge.arm.com> <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
 <20210902134927.GA147718@e120877-lin.cambridge.arm.com> <CAJZ5v0hi=YDiO79YWPDHcHEVypwv7++Qjmz7JAjOs9O6ooGy+g@mail.gmail.com>
 <20210906081733.GA4151@e120877-lin.cambridge.arm.com> <CAJZ5v0jdF_79nq6z41x52bWfYq58+qrDxcLneXFgxdEwQhaAwA@mail.gmail.com>
 <20210906125349.GA51637@e120877-lin.cambridge.arm.com> <CAJZ5v0jgwRghYYK6Bxsb4vmr-O+-g=3v4+Y4G3qSDfAxfjzo5g@mail.gmail.com>
 <20210906153831.GA62741@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210906153831.GA62741@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 18:04:12 +0200
Message-ID: <CAJZ5v0g5_4s_2vDrOD64f+OhTG5RQ_0oc-a+HsOj92FncJOW=A@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Sep 6, 2021 at 5:38 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On Mon, Sep 06, 2021 at 05:16:32PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 6, 2021 at 2:53 PM Vincent Donnefort
> > <vincent.donnefort@arm.com> wrote:
> > >
> > > On Mon, Sep 06, 2021 at 02:08:36PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Sep 6, 2021 at 10:17 AM Vincent Donnefort
> > > > <vincent.donnefort@arm.com> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > >
> > > > > > > > Moreover, if only efficient frequencies are to be used, RELATION_L
> > > > > > > > needs to return min(policy->max, the closest efficient frequency equal
> > > > > > > > to or above the target).
> > > > > > >
> > > > > > > You mean, never returning an inefficient frequency, unless there are no
> > > > > > > efficient ones in the range policy->min policy->max ?
> > > > > >
> > > > > > No, that's not what I mean.
> > > > > >
> > > > > > First note that the target here is clamped between the policy min and
> > > > > > max.  Also bear in mind that each of them is a frequency from the
> > > > > > table, either efficient or inefficient.
> > > > > >
> > > > > > In the first step, search through the efficient frequencies only.
> > > > > > That will return you something at or above the target.  If it is at
> > > > > > the target, you're done.  If it is above the target, it may be either
> > > > > > within or above the policy max.  If it is within the policy max,
> > > > > > you're done.  If it is above the policy max, you need to search
> > > > > > through the inefficient frequencies between the target and the policy
> > > > > > max (and you know that there is at least one - the policy max itself).
> > > > > >
> > > > > > So what I said previously wasn't particularly precise, sorry about that.
> > > > >
> > > > > I might have missed something but it seems equivalent to what's currently done:
> > > > >
> > > > > Find the appropriate frequency, if inefficient go to the efficient one, if
> > > > > above policy->max return the original inefficient frequency.
> > > >
> > > > It may or may not be equivalent depending on what the efficient one is.
> > > >
> > > > And what is there now doesn't work for RELATION_H if I'm not mistaken.
> > >
> > > With the current approach, RELATION_H would find the best frequency and then
> > > resolve it to an efficient one if possible. The efficient one might overshoot
> > > the target_freq, but isn't it a good thing ?
> >
> > No, it cannot.
> >
> > >  - If we consider only the efficient freqs in a first place, there's a risk we
> > >    would return a frequency way smaller than the actual request.
> > >
> > >  - What are the gain in capping RELATION_H to the target_freq if we can find a
> > >    frequency higher than the request that wouldn't use more energy than the
> > >    target?
> >
> > There may be a power constraint, so RELATION_H should never go above the target.
>
> Fair enough, let's not overshoot RELATION_H's target and only return (if
> possible) an efficient freq <= target_freq

Thanks!

Please also note that there is a similar problem in the current patch
set for RELATION_C.

Namely, say that there are four frequencies, f_a < f_b < f_c < f_d,
such that f_b - f_a == f_d - f_c == (f_c - f_b) / 2 and f_a, f_d are
efficient.  If the efficient frequencies are preferred and the target
falls between f_b and f_c, the current series will always return f_d
(if I understand it correctly), whereas if the search is limited to
the efficient frequencies, f_a will often be closer to the target than
f_d (50% of the time under random distribution of target values).

> >
> > > RELATION_H is used in two DVFS governors: conservative and ondemand:
> > >
> > >   - Ondemand is using RELATION_H in the context of powerbias. It seems a usecase
> > >     where it is not a problem to overshoot RELATION_H.
> > >
> > >   - Conservative is using RELATION_H when the load is increasing. Same as
> > >     ondemand, I don't think we would have any gain by not overshooting the
> > >     RELATION_H target.
> >
> > Well, let me repeat: the performance governor uses RELATION_H, so if
> > you allow it to go above the policy limit, it will stay there forever.
>
> The performance governor isn't concerned by this change, I was only talking
> about conservative and ondemand. Also overshooting policy->max wouldn't have
> ever happened.

Right.
