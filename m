Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDCD339EDE
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 16:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhCMPRD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Mar 2021 10:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhCMPQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Mar 2021 10:16:40 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2FC061574
        for <linux-pm@vger.kernel.org>; Sat, 13 Mar 2021 07:16:39 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id p10so5362795ils.9
        for <linux-pm@vger.kernel.org>; Sat, 13 Mar 2021 07:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bx9YKE7djfRDbvG/EReeeOxeC1xP/y2DgKagfSaju7s=;
        b=FwQcHCgALVnUwbkiKx+5VCM+o2rXXCEEdf5EUyA3NlNNXHHVYgH6g+M7ZfKPDwuzrP
         AFiorwohVqP1K6/SVA+ccbDVWlTzXbRxphjwHi93ZgtiOQgnvwQ++3eNrqiWPIfIYjux
         EVb0CiDweiFQ/KN12Xm9kAQiUQXU5sLx9q5R1NkL6ogyAtxITaQJ0UYQt+/HznE4GT/t
         FUuCHOtpcVxQMlhR5KzGGbBC5LcJuu/2xPbdYBLAqwi695YfIUSuLZ1CRW9P7xzA6RjU
         G6HUbBYGTnrCRaEsYhHuh4OjLXWrH+V50BtrQC8QHtdISPxvmrgL0+JsNnBE9Ui0vvjm
         WQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bx9YKE7djfRDbvG/EReeeOxeC1xP/y2DgKagfSaju7s=;
        b=o3dEYSy1clcEVSl0DE3WuUtWjae+3KE45aM/6FZUvyHnjWh0eq+VtdH3T6f32yxgJ+
         6mR3KN3OZ4fxVFF/CnYmYDOYGnlYJVlpytcjtmr7BNhF6TLpU0IcLJbXna8itJBh7p2v
         pXvV63h1fyXjilPaeQQl/fXVbwfESZ9lK5FqfqzhpxBj2uKwKRlBcYNbqeP0Q6eaduEE
         N2HzJ15zUxykRxW31Q5VQkIOJW1qoRY216hxOkXGrJfuW6BpF/lMnQqbEC4zifw89K9V
         Bd10OCohLis5SpJTQJYRboutgnVkIdpK+ymTxEMmoCXIZcqrE9r5S8BuPhrlEwnjaz8a
         Blqg==
X-Gm-Message-State: AOAM531aqujzNX1dnTEELwe4WsnlhKZtnN5yzaqSs7O22C3GgaYXC53O
        Ke31/fbzHIt3gcJ0qDodysyoVR75fsnVYbSJj56hoA==
X-Google-Smtp-Source: ABdhPJzMJ4ejq9KAxf9dC0IOE1eCovLVkFVlTcsGq5qoTSH22PZeU9ekzsQUlmbW+sUsQQMRqQTZv5dpqkVNEdvoeJs=
X-Received: by 2002:a92:6511:: with SMTP id z17mr6428777ilb.232.1615648599075;
 Sat, 13 Mar 2021 07:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20210116170725.5245-1-dsmythies@telus.net> <CAJvTdKm3h_msmu-NjTPY+09bLqyVL_-GCHnGFdNGdTcSZRP4zQ@mail.gmail.com>
 <CAAYoRsVYejQRByDz78jbv5cMfd+ctT8N3YxfOBndW8FJiuk9MA@mail.gmail.com> <CAJvTdKkpbFqDRL9BP3Ri0Yeb0VMXv79dr+C=ym2+GWMRZEEYpw@mail.gmail.com>
In-Reply-To: <CAJvTdKkpbFqDRL9BP3Ri0Yeb0VMXv79dr+C=ym2+GWMRZEEYpw@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sat, 13 Mar 2021 07:16:27 -0800
Message-ID: <CAAYoRsXX74eDQ_vCdLnyNQhMutwE4TWMZsB7HeW5tu4kxVEFJQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix TCC offset bit mask
To:     Len Brown <lenb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 2:16 PM Len Brown <lenb@kernel.org> wrote:
>
> Doug,
> The offset works for control.
>
> However, it is erroneous to use it for reporting of the actual
> temperature, like I did in turbostat.

Agreed.
I have been running with a correction for that for a while,
and as discussed on Rui's thread.
But this bit mask correction patch is still needed isn't it?
for this:
cpu4: MSR_IA32_TEMPERATURE_TARGET: 0x1a64100d (90 C) (100 default - 10 offset)
which should be this:
cpu4: MSR_IA32_TEMPERATURE_TARGET: 0x1a64100d (74 C) (100 default - 26 offset)

But yes, I do now see the field size is only 4 bits for some parts.

... Doug

> Thus, I'm going to revert the patch that added it's use in turbostat
> for the Temperature column.
>
> thanks,
> -Len
>
> On Fri, Mar 12, 2021 at 1:26 AM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > Hi Len,
> >
> >
> > thank you for your reply.
> >
> > On Thu, Mar 11, 2021 at 3:19 PM Len Brown <lenb@kernel.org> wrote:
> > >
> > > Thanks for the close read, Doug.
> > >
> > > This field size actually varies from system to system,
> > > but the reality is that the offset is never that big, and so the
> > > smaller mask is sufficient.
> >
> > Disagree.
> >
> > I want to use an offset of 26.
> >
> > > Finally, this may all be moot, because there is discussion that using
> > > the offset this way is simply erroneous.
> >
> > Disagree.
> > It works great.
> > As far as I know/recall I was the only person that responded to Rui's thread
> > "thermal/intel: introduce tcc cooling driver" [1]
> > And, I spent quite a bit of time doing so.
> > However, I agree the response seems different between the two systems
> > under test, Rui's and mine.
> >
> > [1] https://marc.info/?l=linux-pm&m=161070345329806&w=2
> >
> > >  stay tuned.
> >
> > O.K.
> >
> > ... Doug
> > >
> > > -Len
> > >
> > >
> > > On Sat, Jan 16, 2021 at 12:07 PM Doug Smythies <doug.smythies@gmail.com> wrote:
> > > >
> > > > The TCC offset mask is incorrect, resulting in
> > > > incorrect target temperature calculations, if
> > > > the offset is big enough to exceed the mask size.
> > > >
> > > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > > > ---
> > > >  tools/power/x86/turbostat/turbostat.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > > > index 389ea5209a83..d7acdd4d16c4 100644
> > > > --- a/tools/power/x86/turbostat/turbostat.c
> > > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > > @@ -4823,7 +4823,7 @@ int read_tcc_activation_temp()
> > > >
> > > >         target_c = (msr >> 16) & 0xFF;
> > > >
> > > > -       offset_c = (msr >> 24) & 0xF;
> > > > +       offset_c = (msr >> 24) & 0x3F;
> > > >
> > > >         tcc = target_c - offset_c;
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > >
> > > --
> > > Len Brown, Intel Open Source Technology Center
>
>
>
> --
> Len Brown, Intel Open Source Technology Center
