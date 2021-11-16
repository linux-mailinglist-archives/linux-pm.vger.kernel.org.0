Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154C4538E8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhKPR5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 12:57:32 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41640 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbhKPR5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 12:57:31 -0500
Received: by mail-ot1-f48.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so34911874ote.8;
        Tue, 16 Nov 2021 09:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXDt0RkwKybhTwND35SQv0CCA/kyIjvi5ZotU+2B+iw=;
        b=RB/OOsZf9QrqwMik09uQPvhVAmmKBlmwKGGG7UZNBPH9ysqCOQUOfWpPx98KLYywjr
         mVgVg3wfJn9tq3f9g19WUrISv6pB0CUrKEf7xUSNMpguIyqzhyVB7Gp6Oht1xlfLM2ax
         7IMg3imNwbNWxUvUauXIgK2oH2XlK3DVbt83ffFaFM04rIipcwv7JlLJut9sYb6lg0q5
         DZKuCL92g0euHqgDTa+keCFDahv4W944W+zdmLvKUvVwwxvszBMfLwExah8F0JtXm9Mb
         luVFtxPXnLVan4z8A6q1cnCELZk4/M55zkzfD+DJs4AJ0LqbV215SmR6cZjuVeo1Y4Nk
         ukfA==
X-Gm-Message-State: AOAM533FDuh/+D2ExDkksVojeKbdytlEqLO17/JjJwB/UyK1YPSvYZZj
        6vA/7N/jQE42+5he44xZ5c0XeAXQEgzObPy5qUk=
X-Google-Smtp-Source: ABdhPJy1DkExIrQjiTLjLjJg6/hbOSAx87vK3ScdMsV3WD+Pi1mfvVPTHei+w8y9IGVs5oNOL+A2MScqrvZYfli0sW8=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr7792422otu.254.1637085273341;
 Tue, 16 Nov 2021 09:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
 <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
In-Reply-To: <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 18:54:22 +0100
Message-ID: <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     Evan Green <evgreen@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 15, 2021 at 6:13 PM Evan Green <evgreen@chromium.org> wrote:
>
> Gentle bump.
>
>
> On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > snapshot_write() is inappropriately limiting the amount of data that can
> > be written in cases where a partial page has already been written. For
> > example, one would expect to be able to write 1 byte, then 4095 bytes to
> > the snapshot device, and have both of those complete fully (since now
> > we're aligned to a page again). But what ends up happening is we write 1
> > byte, then 4094/4095 bytes complete successfully.
> >
> > The reason is that simple_write_to_buffer()'s second argument is the
> > total size of the buffer, not the size of the buffer minus the offset.
> > Since simple_write_to_buffer() accounts for the offset in its
> > implementation, snapshot_write() can just pass the full page size
> > directly down.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >  kernel/power/user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > index 740723bb388524..ad241b4ff64c58 100644
> > --- a/kernel/power/user.c
> > +++ b/kernel/power/user.c
> > @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> >                 if (res <= 0)
> >                         goto unlock;
> >         } else {
> > -               res = PAGE_SIZE - pg_offp;
> > +               res = PAGE_SIZE;
> >         }
> >
> >         if (!data_of(data->handle)) {
> > --

Do you actually see this problem in practice?
