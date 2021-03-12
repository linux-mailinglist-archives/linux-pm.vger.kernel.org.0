Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC333998C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 23:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhCLWQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 17:16:05 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:35733 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhCLWQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 17:16:04 -0500
Received: by mail-ej1-f44.google.com with SMTP id dx17so56249121ejb.2;
        Fri, 12 Mar 2021 14:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTnFgkRrNhyDIIDutUBQeuTI7eGNqYLKDjmPe9hscB4=;
        b=afi3LvS5P0oewgeHnQlxDaHZ2MtN20ewA24iWcZ21u97aNUDq4c8mhjiJNSo3V/hxt
         l3pbmEK+DMRA/GVKbZyGKVJSfaKT9myE8GejkIhDBer3N235pxUDmce/bFHAXjRX/6uT
         0fw7KGHUpJuLyYnB++BEXUG4zF1flyYW8fmH6rQVwDny5m+0a8lQwgVUCNysjbn0wnkN
         0ZP+G6Z1iUCHnvhHlrxlvd4+XcLKrITEDwywA02d/1EOJv9+XF5h/E7OE0W0LnDrYyF0
         iBm5+z8W7YubYc6SBCpx2b41LM4EIzixvxC+Zp4fJPbyb4qb/t/rpcVjXE8OYNXceXFL
         SLhg==
X-Gm-Message-State: AOAM533k+U3N4gR9yoii60R+li9U/cIQ9decevfA48EuZPPcWNua1Q3M
        U0W9b9Vo6g67dVUlvS5jplZaA2941ikbGVORmXP8xKdj
X-Google-Smtp-Source: ABdhPJyNEKfdBHy42Gk4bEjnDsPbgnxPd4Zn2UlYyF1aOI9e4CuYM1k71uyT5juAEwcP01ExzsQh24FGb7b74P3fEGA=
X-Received: by 2002:a17:906:dfcc:: with SMTP id jt12mr11132874ejc.31.1615587362840;
 Fri, 12 Mar 2021 14:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20210116170725.5245-1-dsmythies@telus.net> <CAJvTdKm3h_msmu-NjTPY+09bLqyVL_-GCHnGFdNGdTcSZRP4zQ@mail.gmail.com>
 <CAAYoRsVYejQRByDz78jbv5cMfd+ctT8N3YxfOBndW8FJiuk9MA@mail.gmail.com>
In-Reply-To: <CAAYoRsVYejQRByDz78jbv5cMfd+ctT8N3YxfOBndW8FJiuk9MA@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 12 Mar 2021 17:15:51 -0500
Message-ID: <CAJvTdKkpbFqDRL9BP3Ri0Yeb0VMXv79dr+C=ym2+GWMRZEEYpw@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix TCC offset bit mask
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Doug,
The offset works for control.

However, it is erroneous to use it for reporting of the actual
temperature, like I did in turbostat.
Thus, I'm going to revert the patch that added it's use in turbostat
for the Temperature column.

thanks,
-Len

On Fri, Mar 12, 2021 at 1:26 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Len,
>
>
> thank you for your reply.
>
> On Thu, Mar 11, 2021 at 3:19 PM Len Brown <lenb@kernel.org> wrote:
> >
> > Thanks for the close read, Doug.
> >
> > This field size actually varies from system to system,
> > but the reality is that the offset is never that big, and so the
> > smaller mask is sufficient.
>
> Disagree.
>
> I want to use an offset of 26.
>
> > Finally, this may all be moot, because there is discussion that using
> > the offset this way is simply erroneous.
>
> Disagree.
> It works great.
> As far as I know/recall I was the only person that responded to Rui's thread
> "thermal/intel: introduce tcc cooling driver" [1]
> And, I spent quite a bit of time doing so.
> However, I agree the response seems different between the two systems
> under test, Rui's and mine.
>
> [1] https://marc.info/?l=linux-pm&m=161070345329806&w=2
>
> >  stay tuned.
>
> O.K.
>
> ... Doug
> >
> > -Len
> >
> >
> > On Sat, Jan 16, 2021 at 12:07 PM Doug Smythies <doug.smythies@gmail.com> wrote:
> > >
> > > The TCC offset mask is incorrect, resulting in
> > > incorrect target temperature calculations, if
> > > the offset is big enough to exceed the mask size.
> > >
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > ---
> > >  tools/power/x86/turbostat/turbostat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > > index 389ea5209a83..d7acdd4d16c4 100644
> > > --- a/tools/power/x86/turbostat/turbostat.c
> > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > @@ -4823,7 +4823,7 @@ int read_tcc_activation_temp()
> > >
> > >         target_c = (msr >> 16) & 0xFF;
> > >
> > > -       offset_c = (msr >> 24) & 0xF;
> > > +       offset_c = (msr >> 24) & 0x3F;
> > >
> > >         tcc = target_c - offset_c;
> > >
> > > --
> > > 2.25.1
> > >
> >
> >
> > --
> > Len Brown, Intel Open Source Technology Center



-- 
Len Brown, Intel Open Source Technology Center
