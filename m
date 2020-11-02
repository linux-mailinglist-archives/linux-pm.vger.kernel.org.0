Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131CE2A23D4
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 05:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgKBEwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 23:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgKBEwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 23:52:15 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5CC0617A6
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 20:52:14 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id x20so11794047ilj.8
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 20:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bMx8UXo7jgM71e2jW1S3HtCoXgh4nLffSFXKWvG7UI=;
        b=FDBifyBFAO4QLFomhfN/rZ01HewlhM/hYrkq621Qq4RvWtY/RltuO1dZ7sNhDn4ewq
         m9AHs/F7/KIPgDMj2nD5dzdp4rVRINNUg1t8g2m0vPr165pOZNzbVbkRBL8OEm9L4YSi
         k61fQoM5DgblhK7SS0veIGYJTUxrludeBy6/MMoG4xw+rN6wATdrqBJphrSZO+svzsUD
         yLNcVeEapLuGHsLVG/XOCWPDStVpuMF3p3ebaIqXc4O8zHkkbKhouAB6/zFlefRdgsaU
         4DipsHFYbFLWCoV1mrg2X8DVoz/fabup0pam1/hNovIvHPLdWRDAB3sGjujdsUsdyCjA
         13dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bMx8UXo7jgM71e2jW1S3HtCoXgh4nLffSFXKWvG7UI=;
        b=oiUv9iVzD8e6J7L0s0guuToUcr+vZdI64aGMh0nVACgP1Jh9LehqPP7fGRqbyn2gmd
         3vOkdavji7ShanzlDzFK/R9vM+j6VCOUalQz+wZ30JD3j8b1LEV+8EyEXJ4Aqu2NhVOq
         24Q2Lcx+wIUIeI+t6GXaQRNRHKshC8gMzhUKAFb3+9GJ3Ysj2OM9O/cFIPlF35e0zvAb
         Y4EcICWzUHoHx+6Pz9yG3ssDcs7896yJMbrK5nNB/EQCzOytZ3wc2SV07AGtGNo+GGDA
         F2cfPtnFXKG0zekzlZRlFZ3BnTyG7wu1qZLqqK5CQRv6r3HEbDvE5B8rmuSkFDBp+tcC
         nthA==
X-Gm-Message-State: AOAM530J5H4Sj9SERgijUD4FoPJ1wjbJYhFGyRcG2iOjck+TiJgDB2zC
        FpLT+jl+wAWIDTK5eDSBRRVOXn815po8jhb0p/730bLTrxY=
X-Google-Smtp-Source: ABdhPJzTB5qcnWaj0v43I/Gj+F71rC1FVeqz4g7linQ3qLoza+B+ysF/YMOM1ah+W5v1GLpfgyuxgYKUGy4vVGFg5vY=
X-Received: by 2002:a92:5b02:: with SMTP id p2mr9450310ilb.283.1604292732934;
 Sun, 01 Nov 2020 20:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20201024064955.GA30892@tsappmail.ltts.com> <3c1d6e03-729d-0357-8f69-aa742289bc3b@intel.com>
In-Reply-To: <3c1d6e03-729d-0357-8f69-aa742289bc3b@intel.com>
From:   ravisankarreddy lingareddy <ravisankarreddylingareddy@gmail.com>
Date:   Sun, 1 Nov 2020 20:52:02 -0800
Message-ID: <CAMpKaZCNJ5jn3OfxM6n4x7+GAsw=JeM9siNxDbzFfkDjfsH7Zg@mail.gmail.com>
Subject: Re: [PATCH] PM: Use WQ_MEM_RECLAIM flag for PM workqueue
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        masaya.takahashi@sony.com, Shingo.Takeuchi@sony.com,
        Srinavasa.Nagaraju@sony.com, soumya.x.khasnis@sonymobile.com,
        ravisankar.reddy@sony.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Please resend this with a CC to linux-pm@vger.kernel.org.

Thank you, I resend with a CC to linux-pm@vger.kernel.org.

> Also it would be good to know how to reproduce this issue.

Commit message says under high memory scenarios, try a memory pressure
test and do repeatedly  until the battery is under 20%.

> @Pavel,

> Does this need some kind of auditing to make sure we don't allocate memory from the code running in the workqueue, and thus further deadlocks?

I used WQ_MEM_RECLAIM in pm_wq workqueue to fix bug and no further
deadlocks are seen and tested on 4.9 and 4.19 kernel.

Best Regards,
Ravi


On Mon, Oct 26, 2020 at 4:23 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 10/24/2020 8:49 AM, Ravisankarreddy lingareddy wrote:
> > Deadlock is seen under below high memory usage scenario.
> >
> > kswapd waiting to reclaim memory is blocked on i/o kworker and pm_wq
> > context which needs to wakeup i/o kworker is waiting for kthread
> > creation which is again blocked in memory reclaim path.
> >
> > Use WQ_MEM_RECLAIM flag for PM workqueue to avoid this deadlock.
> >
> > Signed-off-by: Ravisankarreddy lingareddy <ravisankarreddylingareddy@gmail.com>
> > ---
> >   kernel/power/main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 40f86ec4ab30..ff5f3349e76f 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -933,7 +933,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
> >
> >   static int __init pm_start_workqueue(void)
> >   {
> > -     pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
> > +     pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
> >
> >       return pm_wq ? 0 : -ENOMEM;
> >   }
>
> Please resend this with a CC to linux-pm@vger.kernel.org.
>
> Also it would be good to know how to reproduce this issue.
>
>
