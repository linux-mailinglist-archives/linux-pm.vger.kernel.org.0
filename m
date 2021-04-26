Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2036B274
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDZLqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 07:46:48 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41543 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhDZLqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 07:46:43 -0400
Received: by mail-ot1-f48.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso43152504ott.8;
        Mon, 26 Apr 2021 04:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAIDuVH8i00+G+uA/94OXdBHZYwm26NpSzRxAAgV6ZQ=;
        b=Gl+7k0xF+AtzEUm5Pvaul14KNfLtxusDO5zBJGOt6dH4O4QPqtrQ5anGhjSgAFfSb0
         MZsr9g+KQbfl9ma6z3/te81+Ba5iPrjN1l560oNc3NlGA2zIh5QMM5blBzwkdvW2v7b3
         b28Xj2VHdQGbjpVWCRE9RzwuwiueE1Wgzw/avT07yEXJxaOwOdE11vU4SmmAB+xTRBXZ
         KS8QS5N4O1lp1oE0lVOhoCQ9KOqfJAHJkubNDZYPdT2BJeEbCja/KkVUPcZbLZxi3qXJ
         L/G72Ztf5yp1joYDyjzqMr71qVmAOFo4LFl3FRGLeXiZ9vB/J0jPqlhslE+xFdWEeFx4
         BoGA==
X-Gm-Message-State: AOAM533gc1B6Z3h0SEwKS08M6KzP9imDR8rcEgqxZP4XijBa1IeOiPVu
        GNLJDRMGH26XeBrwmRrnYSCxenLONUvDfHjb1WY=
X-Google-Smtp-Source: ABdhPJxnFsxMq8xR5VYnWaomE2CzeTMRWI9IfueWhIO7JbEHBp0tugwmFK6ypgRfxTtoOA5+dLtQNbEA0BZW2wWLYb0=
X-Received: by 2002:a05:6830:2458:: with SMTP id x24mr3424467otr.206.1619437562079;
 Mon, 26 Apr 2021 04:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210422164606.68231-1-krzysztof.kozlowski@canonical.com>
 <CAJZ5v0iUQBfrTtVmfrrDixZnnr1_THgaM1+mFu4TRT+OOYb2mw@mail.gmail.com> <a56096c4-0b64-ca16-8d5c-d086e96a436d@canonical.com>
In-Reply-To: <a56096c4-0b64-ca16-8d5c-d086e96a436d@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 13:45:47 +0200
Message-ID: <CAJZ5v0h2_4qjDqTS4Vm21e6CafqHZcjqj5p0Z8DWaAwUkkmtbA@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: document common mistake with pm_runtime_get_sync()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 5:03 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 23/04/2021 16:08, Rafael J. Wysocki wrote:
> > On Thu, Apr 22, 2021 at 6:46 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> pm_runtime_get_sync(), contradictory to intuition, does not drop the
> >> runtime PM usage counter on errors which lead to several wrong usages in
> >> drivers (missing the put).  pm_runtime_resume_and_get() was added as a
> >> better implementation so document the preference of using it, hoping it
> >> will stop bad patterns.
> >>
> >> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  Documentation/power/runtime_pm.rst | 4 +++-
> >>  include/linux/pm_runtime.h         | 3 +++
> >>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> >> index 18ae21bf7f92..478f08942811 100644
> >> --- a/Documentation/power/runtime_pm.rst
> >> +++ b/Documentation/power/runtime_pm.rst
> >> @@ -378,7 +378,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
> >>
> >>    `int pm_runtime_get_sync(struct device *dev);`
> >>      - increment the device's usage counter, run pm_runtime_resume(dev) and
> >> -      return its result
> >> +      return its result;
> >> +      be aware that it does not drop the device's usage counter on errors so
> >> +      usage of pm_runtime_resume_and_get(dev) usually results in cleaner code
> >
> > Whether or not it results in cleaner code depends on what that code does.
> >
> > If the code is
> >
> > pm_runtime_get_sync(dev);
> >
> > <Do something that will fail if the device is in a low-power state,
> > but there is no way to handle the failure gracefully anyway>
> >
> > pm_runtime_put(dev);
> >
> > then having to use pm_runtime_resume_and_get() instead of the
> > pm_runtime_get_sync() would be a nuisance.
> >
> > However, if the code wants to check the return value, that is:
> >
> > error = pm_runtime_resume_and_get(dev);
> > if (error)
> >         return error;
> >
> > <Do something that will crash and burn the system if the device is in
> > a low-power state>
> >
> > pm_runtime_put(dev);
> >
> > then obviously pm_runtime_resume_and_get() should be your choice.
> >
> > The rule of thumb seems to be whether or not the return value is going
> > to be used.
>
> Yes, you're right. What I wanted to point is that there is a pattern of
> missing put when using pm_runtime_get_sync() all over the kernel. It's
> quite common mistake because the interface is non-intuitive.
>
> Therefore I find worth to warn users of the API: usually, for simple
> cases, one should use the pm_runtime_resume_and_get(). This only a hint,
> matching common cases, but not every case. I am not claiming that one is
> better than other, just that old interface mislead in the past.
>
> Maybe you wish to rephrase the comment to:
> "be aware that it does not drop the device's usage counter on errors so
> check if pm_runtime_resume_and_get(dev) would result in a cleaner code"

I would say "so consider using pm_runtime_resume_and_get() instead of
it, especially if its return value is checked by the caller, as this
is likely to result in cleaner code."

IMO that should be sufficient to turn the reader's attention to the replacement.
