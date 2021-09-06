Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D36401AF8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbhIFMJ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 08:09:57 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43898 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241957AbhIFMJ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 08:09:57 -0400
Received: by mail-ot1-f53.google.com with SMTP id x10-20020a056830408a00b004f26cead745so8513102ott.10
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 05:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5pk5y6gKDVMJwSGFI3AllVU0ilmGCKw8WHHRV/7IxM=;
        b=qK2UcK9jOydAWP/HpOChaOLWaDKcstjN4EkLUngljFeoHEFOQrzj1o5iNA0tnLqhe2
         ZX0r5ZQhkkjktHpbJVLixV96euK74H97J7Fm/ws4YFydrwTtth4LTxT4d926qrFU3cz0
         NKr+xFlAChE5cmCorh7xyZi02Yc7om2vmgydH8F7wfF0c0MxmdNrRShRs73A7LikpobH
         yIwTFGGkam5TtW7SRdNNPaA+Nz6M1+lkM7S2gkQyeFuSGt6WHQapkFIw5IEKy/ym2BS0
         auO3+Dq4SCNc4uJlil1bjF5qYV6B5Z8NgFAU0jDNLbi+EDEt/gIsgTZnXUNLJIMIxDlP
         uacw==
X-Gm-Message-State: AOAM530vtzKlabjaTMIIShgBCoswD8SP5btWVCmCLe1P49y4iofILqFN
        gWMLGQXuR3fpYZtxH9db+Hh/paRZLOgUEMOKCKo=
X-Google-Smtp-Source: ABdhPJzCzfjQZk6dDtswTk2v4e+bEykPiZwx/dbKlbCKaARAHd5FOC7m6IEAK1i2cY13agPmsWZPgDMmmiwV7LDib8c=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr10726670ote.319.1630930132204;
 Mon, 06 Sep 2021 05:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
 <20210902105037.GA136543@e120877-lin.cambridge.arm.com> <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
 <20210902134927.GA147718@e120877-lin.cambridge.arm.com> <CAJZ5v0hi=YDiO79YWPDHcHEVypwv7++Qjmz7JAjOs9O6ooGy+g@mail.gmail.com>
 <20210906081733.GA4151@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210906081733.GA4151@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Sep 2021 14:08:36 +0200
Message-ID: <CAJZ5v0jdF_79nq6z41x52bWfYq58+qrDxcLneXFgxdEwQhaAwA@mail.gmail.com>
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

On Mon, Sep 6, 2021 at 10:17 AM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > > >
> > > > Moreover, if only efficient frequencies are to be used, RELATION_L
> > > > needs to return min(policy->max, the closest efficient frequency equal
> > > > to or above the target).
> > >
> > > You mean, never returning an inefficient frequency, unless there are no
> > > efficient ones in the range policy->min policy->max ?
> >
> > No, that's not what I mean.
> >
> > First note that the target here is clamped between the policy min and
> > max.  Also bear in mind that each of them is a frequency from the
> > table, either efficient or inefficient.
> >
> > In the first step, search through the efficient frequencies only.
> > That will return you something at or above the target.  If it is at
> > the target, you're done.  If it is above the target, it may be either
> > within or above the policy max.  If it is within the policy max,
> > you're done.  If it is above the policy max, you need to search
> > through the inefficient frequencies between the target and the policy
> > max (and you know that there is at least one - the policy max itself).
> >
> > So what I said previously wasn't particularly precise, sorry about that.
>
> I might have missed something but it seems equivalent to what's currently done:
>
> Find the appropriate frequency, if inefficient go to the efficient one, if
> above policy->max return the original inefficient frequency.

It may or may not be equivalent depending on what the efficient one is.

And what is there now doesn't work for RELATION_H if I'm not mistaken.
