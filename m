Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB63385DB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 07:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhCLG0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 01:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhCLG0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 01:26:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6CDC061761
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 22:26:14 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k2so1627973ili.4
        for <linux-pm@vger.kernel.org>; Thu, 11 Mar 2021 22:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0qqxn9d92aoqYJoz6Fe423j5eYy1VZ6WOqrH+BLQFc=;
        b=WTH1Ss5QdJSCirAjYWLMEp+yc+UiudzJNNNJD/XYVANXtdKSg1/KqijdnMRh1EW4CQ
         NM7zlpykBtbl8Unb5uM/h+iwpngfHHuYgLsBUSZFcuuF2kVLotiQO4U0vuqpQIuiLW2h
         NwTtuJlREvXUAmcLfl1ODO905+dKyAZsRrlIC9bLpmZLndIpPjDURSZAD/GGvLwRi/2Q
         iejTVZwUDgGOBe7Ris9P2gWZWR/8ToDIM+y63XAFivjW/HHMeZFdF1zO6SIvT6yF+MXt
         dVzzfQQGWQSKCzmPInyxo/9fSLA6P+Ck3neNwEE0fXQFWMMIYfFDykthUcFWq4DqZpZN
         s9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0qqxn9d92aoqYJoz6Fe423j5eYy1VZ6WOqrH+BLQFc=;
        b=WC/JpB4UynO/FRfNVLUJa1OVMAVRkd20dw6Fp2AmVhgBNXIdNTbOtJ1hF1DslyIxAX
         NkVyssLycNNw9Py/ZQd5SVLH/O2/CVJdAeJ+WZkpmxrFvE2aehiOsngsvuKpWc78S1G9
         E6WzZlf29mI8Qk56PMEcnowLqL8OdiPnzS1vkknomBOtOxgdLOOZMU1YAH+aWXPbSWQ6
         CcrwlobIWwKTCEWgXYmIi/i8rgur1U6V/XYxtbIMrHfKoc76xAjwckMHz0J2sbYGz7Sx
         JkMl9ah3pGHooedt9I3HUco+tNTFxZO80Dj7SOQa38xq8tZ8ZO295Nr0MX2HT6pMnMsO
         OpZA==
X-Gm-Message-State: AOAM531DuJfE4+MaRMSjkrO644eWA8a047+rE89jWTYNmUVS+OBzNrWm
        zdsIjk8upd9zXRb80m2bCoV+9Ku0EqAlBue/A0ZjDg==
X-Google-Smtp-Source: ABdhPJxWWvl7xTn8efGrKNtuVUB+C0Qr7JY3SOIoAeN+1JAFAU2kz3GFa1WzrBg/QduyjnBbZKNnqP7vmPwjrcBMyvc=
X-Received: by 2002:a92:6511:: with SMTP id z17mr1715365ilb.232.1615530374036;
 Thu, 11 Mar 2021 22:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20210116170725.5245-1-dsmythies@telus.net> <CAJvTdKm3h_msmu-NjTPY+09bLqyVL_-GCHnGFdNGdTcSZRP4zQ@mail.gmail.com>
In-Reply-To: <CAJvTdKm3h_msmu-NjTPY+09bLqyVL_-GCHnGFdNGdTcSZRP4zQ@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 11 Mar 2021 22:26:02 -0800
Message-ID: <CAAYoRsVYejQRByDz78jbv5cMfd+ctT8N3YxfOBndW8FJiuk9MA@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: Fix TCC offset bit mask
To:     Len Brown <lenb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Len,


thank you for your reply.

On Thu, Mar 11, 2021 at 3:19 PM Len Brown <lenb@kernel.org> wrote:
>
> Thanks for the close read, Doug.
>
> This field size actually varies from system to system,
> but the reality is that the offset is never that big, and so the
> smaller mask is sufficient.

Disagree.

I want to use an offset of 26.

> Finally, this may all be moot, because there is discussion that using
> the offset this way is simply erroneous.

Disagree.
It works great.
As far as I know/recall I was the only person that responded to Rui's thread
"thermal/intel: introduce tcc cooling driver" [1]
And, I spent quite a bit of time doing so.
However, I agree the response seems different between the two systems
under test, Rui's and mine.

[1] https://marc.info/?l=linux-pm&m=161070345329806&w=2

>  stay tuned.

O.K.

... Doug
>
> -Len
>
>
> On Sat, Jan 16, 2021 at 12:07 PM Doug Smythies <doug.smythies@gmail.com> wrote:
> >
> > The TCC offset mask is incorrect, resulting in
> > incorrect target temperature calculations, if
> > the offset is big enough to exceed the mask size.
> >
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > index 389ea5209a83..d7acdd4d16c4 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -4823,7 +4823,7 @@ int read_tcc_activation_temp()
> >
> >         target_c = (msr >> 16) & 0xFF;
> >
> > -       offset_c = (msr >> 24) & 0xF;
> > +       offset_c = (msr >> 24) & 0x3F;
> >
> >         tcc = target_c - offset_c;
> >
> > --
> > 2.25.1
> >
>
>
> --
> Len Brown, Intel Open Source Technology Center
