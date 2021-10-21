Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471A436AA2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJUSjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUSjE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 14:39:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6740C0613B9
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 11:36:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g8so1423353ljn.4
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFwenL5XcnRNpptcSA2cgOLSm+ikdKJzsWm5PgT8Ins=;
        b=OJyAvfRJ5jZ79JXyHWkRZUCQ6cXZuVSfYnKgESe+bsyL3wQqD44nkm0/2lfr5lcyFf
         VBb3ct4DjtXApDhsHmiFbZIHXzj9yPNKlyqvtrQP5QKGGBzf+zqOAtdOq7ld5PYn0Y1c
         YsXdIBJEDq1Xo89E6wOO3IoCxmPrioKOp4gyOTLLNYSc/n2tmPwxilfBXEsL1/E9n9t1
         7E9oP7oOqWi4oLQCtK3dS7vc/N4iJhAgISb6/VYI4OSFChBnOFPYVnRLhdIJUn9zPAGU
         PWHJW6RifcIdWE2vOhl1qflAZ7Zt7nPeVLqK9gme/u+y2fp8GzTxELWCpxwEyaO1xdBv
         lNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFwenL5XcnRNpptcSA2cgOLSm+ikdKJzsWm5PgT8Ins=;
        b=5mhtqcAEVSzZW6h1RfudVrKn2np6eP1c+ua0oDBJEssHq1RrZgNEr74OGQz4yl/Tr7
         EbHz5hdz44tFLK4mkWJxkLTizJKiIRuDiU1Jm+dqSuFan0mWnJhzwEpsT2/ksiSZBpnY
         GRz/w8f6ezoyG6xfKlbgwfE+8/wjmtH68YLQkbfzQw0GUNHUghyGx+DCbPFnWgobC29q
         c1V9NMeewmz4K0Etj6pNQhzkChnvBO44SybKMD5I3srqXnoUqXsqCSV0RACPvFBzhN6j
         W83OZ+4oqqoXBzbA2zH2yk8riYaYnoRslWJ1MbZfPLXlrLfXuAR6TDk4/+yhDgr5cVrr
         euaw==
X-Gm-Message-State: AOAM531Nu+4Za7A6V/OBMpcslpae4wgSw1IpVo3XjjLpLC4bObucAj/o
        zLpZNd/muci/jE8U6qzfmKdlnkHzFNNwIKwqIkxctQ==
X-Google-Smtp-Source: ABdhPJwGOsMz5QFRlmpb6JZFAIgHv9elGXxwNYz7PZKIiQHm8PfGg/+RNbZ53CiJ/VwESknIgbQm0+6A0ALPFlGANwg=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr7921763ljp.367.1634841406007;
 Thu, 21 Oct 2021 11:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAJZ5v0jQM3VDy_U8TiC3601ivSYVXyT5jJVjLt8qyMWE49zOeg@mail.gmail.com>
 <CAPDyKFouHn95Lwgx+PbK9itQP13U70ZiZbDr3jQd41KsvXMtqQ@mail.gmail.com> <CAJZ5v0hjdpyFGF5zPUX8RUaVW7Tk+qr9RwbGt-7C0Wxyx03TLg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hjdpyFGF5zPUX8RUaVW7Tk+qr9RwbGt-7C0Wxyx03TLg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 20:36:08 +0200
Message-ID: <CAPDyKFpts0t=dgNzktnv7vOjRepHnitKjgU=OJKxFkwr-q0c2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> > > > > >
> > > > > > > Additionally, since find_deepest_state() is being called for
> > > > > > > cpuidle_enter_s2idle() too, we would need to treat the new
> > > > > > > CPUIDLE_STATE_DISABLED_ flag in a special way, right?
> > > > > >
> > > > > > No, it already checks "disabled".
> > > > >
> > > > > Yes, but that would be wrong.
> > > >
> > > > Hmmm.
> > > >
> > > > > The use case I want to support, for cpuidle-psci, is to allow all idle
> > > > > states in suspend-to-idle,
> > > >
> > > > So does PM-runtime work in suspend-to-idle?  How?
> > > >
> > > > > but prevent those that rely on runtime PM
> > > > > (after it has been disabled) for the regular idle path.
> > > >
> > > > Do you have a special suspend-to-idle handling of those states that
> > > > doesn't require PM-runtime?
> > >
> > > Regardless, pausing cpuidle in the suspend-to-idle path simply doesn't
> > > make sense at all, so this needs to be taken care of in the first
> > > place.
> >
> > Right, I do agree, don't get me wrong. But, do we really want to treat
> > s2-to-idle differently, compared to s2-to-ram in regards to this?
> >
> > Wouldn't it be a lot easier to let cpuidle drivers to opt-out for
> > cpuidle_pause|resume(), no matter whether it's for s2-to-idle or
> > s2-to-ram?
>
> I don't think so.
>
> Suspend-to-idle resume cpuidle after pausing it which is just plain
> confusing and waste of energy and the fact that the system-wide
> suspend flow interferes with using PM-runtime for implementing cpuidle
> callbacks at the low level really is an orthogonal problem.

It's certainly an orthogonal problem, I agree. However, trying to
solve it in two different ways, may not really be worth the effort, in
my opinion.

As I kind of pointed out in the earlier reply, I am not sure there are
any other relatively easy solutions available, to fix the problem for
runtime PM based cpuidle drivers. We probably need to call
cpuidle_pause() (or similar) in some way.

>
> > >
> > > The problem with PM-runtime being unavailable after dpm_suspend()
> > > needs to be addressed in a different way IMO, because it only affects
> > > one specific use case.
> >
> > It's one specific case so far, but we have the riscv driver on its
> > way, which would suffer from the same problem.
>
> So perhaps they should be advised about this issue.

Yes, I will let them know - and hopefully I will soon also be able to
provide them with a fix. :-)

>
> > Anyway, an option is to figure out what platforms and cpuidle drivers,
> > that really needs cpuidle_pause|resume() at this point and make an
> > opt-in solution instead.
>
> None of them need to pause cpuidle for suspend-to-idle AFAICS.

I assume so too, otherwise things would have been broken when
cpuidle_resume() is called in s2idle_enter(). But, it's still a bit
unclear.

>
> Some may want it in the non-s2idle suspend path, but I'm not sure
> about the exact point where cpuidle needs to be paused in this case.
> Possibly before offlining the nonboot CPUs.

Okay.

Note that, I assume it would be okay to also pause cpuidle a bit
earlier in these cases, like in dpm_suspend() for example. The point
is, it's really a limited short period of time for when cpuidle would
be paused, so I doubt it would have any impact on the consumed energy.
Right?

>
> > This could then be used by runtime PM based
> > cpuidle drivers as well. Would that be a way forward?
>
> The PM-runtime case should be addressed directly IMO, we only need to
> figure out how to do that.

If you have any other suggestions, I am listening. :-)

>
> I'm wondering how you are dealing with the case when user space
> prevents pd_dev from suspending via sysfs, for that matter.

That should work fine during runtime - because runtime PM is enabled
for the device.

Kind regards
Uffe
