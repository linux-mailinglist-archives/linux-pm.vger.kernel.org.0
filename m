Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049DD4621FC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhK2UUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Nov 2021 15:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhK2URp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Nov 2021 15:17:45 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22431C06FD52
        for <linux-pm@vger.kernel.org>; Mon, 29 Nov 2021 08:50:44 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id j7so18070562ilk.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Nov 2021 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuXSCi3W5k4YjYyZpaX5+bo97wFIHp81oIVUYJL00SI=;
        b=UyFcnTVKWLAVQm/9FbeKbsayqMz78WqtkFPrc9up7Rg6PAgQyOYZBDiW6xdgBaTHte
         a5jAPCEY9vOXO424NLcgUoU766WQrmmXjp6V6U7NH/WL++ftTSLEfk/WyU5IwWMvm2sE
         n8Boy1Qiz7bHNekvogxyghLcGUCJVbrvZ5AKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuXSCi3W5k4YjYyZpaX5+bo97wFIHp81oIVUYJL00SI=;
        b=CtUfjZw6DZtCS83AXcu+fEHONJsVHxwNEzrO29d0Tee2r2ckOWmzgaN0WoArz93OD0
         oZm71fxmCA6JcUznEE/UA5wgMAv09mWQyCHqvjxnFnml/93Ko3I4/yPUBDONn57rasaF
         VssJofMDcG8JgL22hVXpx6Amf2hAfxPqqCUmvG1jsdPEm6fcTjvyYpSHLhj8Ss8RlqHg
         B6fWHgjfd7o7FLZoJWVOHLhNBJmCDYkcJx+YV6sivSoICK17/pLJcOoXQFLbxFTnemd7
         zvs6fK4bAI5HXPcRW383eCLDpCNGGJnATIiofOuPn1UfX+5rk6TUjn5pue+8un8y6Xkp
         onNw==
X-Gm-Message-State: AOAM530smLeiUI+T2X+xGhnpoVQyXcb6/Ck0FvCUXcK6N5iv02HOiDD2
        YPshQZzqyhxzdJ5p/2l4ie6v3TC2LdyLMw==
X-Google-Smtp-Source: ABdhPJzUQuSVShro41d3qTa7/WmiJU5mU/n8k3l4+VmJQwAE7iNx62mqk3UXjFKX0RSZwrAHJSA3QA==
X-Received: by 2002:a05:6e02:1d19:: with SMTP id i25mr54514167ila.9.1638204643378;
        Mon, 29 Nov 2021 08:50:43 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id t6sm10741064iov.39.2021.11.29.08.50.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 08:50:42 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id w4so18057362ilv.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Nov 2021 08:50:42 -0800 (PST)
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr10809909ilu.114.1638204642437;
 Mon, 29 Nov 2021 08:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
 <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
 <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
 <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com> <CAJZ5v0gamixc4dkBEXJjjw5zQynuz8BkQ9xv8YpbjkTkdMb2TQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gamixc4dkBEXJjjw5zQynuz8BkQ9xv8YpbjkTkdMb2TQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 29 Nov 2021 08:50:06 -0800
X-Gmail-Original-Message-ID: <CAE=gft6o0JxhDgazPA5DVbL6hQ+36D_GkzgN-AuR3YA43NSqaw@mail.gmail.com>
Message-ID: <CAE=gft6o0JxhDgazPA5DVbL6hQ+36D_GkzgN-AuR3YA43NSqaw@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 24, 2021 at 4:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 16, 2021 at 9:22 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Tue, Nov 16, 2021 at 9:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Nov 15, 2021 at 6:13 PM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > Gentle bump.
> > > >
> > > >
> > > > On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
> > > > >
> > > > > snapshot_write() is inappropriately limiting the amount of data that can
> > > > > be written in cases where a partial page has already been written. For
> > > > > example, one would expect to be able to write 1 byte, then 4095 bytes to
> > > > > the snapshot device, and have both of those complete fully (since now
> > > > > we're aligned to a page again). But what ends up happening is we write 1
> > > > > byte, then 4094/4095 bytes complete successfully.
> > > > >
> > > > > The reason is that simple_write_to_buffer()'s second argument is the
> > > > > total size of the buffer, not the size of the buffer minus the offset.
> > > > > Since simple_write_to_buffer() accounts for the offset in its
> > > > > implementation, snapshot_write() can just pass the full page size
> > > > > directly down.
> > > > >
> > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > ---
> > > > >
> > > > >  kernel/power/user.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > > > > index 740723bb388524..ad241b4ff64c58 100644
> > > > > --- a/kernel/power/user.c
> > > > > +++ b/kernel/power/user.c
> > > > > @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> > > > >                 if (res <= 0)
> > > > >                         goto unlock;
> > > > >         } else {
> > > > > -               res = PAGE_SIZE - pg_offp;
> > > > > +               res = PAGE_SIZE;
> > > > >         }
> > > > >
> > > > >         if (!data_of(data->handle)) {
> > > > > --
> > >
> > > Do you actually see this problem in practice?
> >
> > Yes. I may fire up another thread to explain why I'm stuck doing a
> > partial page write, and how I might be able to stop doing that in the
> > future with some kernel help. But either way, this is a bug.
>
> OK, patch applied as 5.16-rc material.
>
> I guess it should go into -stable kernels too?

Yes, putting it into -stable would make sense also. I should have CCed
them originally, doing that now.
-Evan
