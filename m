Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA1453ADC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhKPUZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 15:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKPUZq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 15:25:46 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3568C061746
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 12:22:49 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f9so133630ioo.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O9VKvoceXwVaex9oUhrTDMbmORNpnJcPhpNAZgT+zc=;
        b=VoERw1nEsVGfo78krzq4syT9ErLsmGF1KC8F9uP520gHOLYkdoCzynrFOQyVrIRDCT
         D3SWW0MI4bGSgSxA80cVHcgj66c2pB55n8VHPDpamKVn/BSATzn3DDLnHqOnfWaCV7Hs
         vDUOvHfyEqv+SI/oyFDbUOLOj1aOyamfqebu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O9VKvoceXwVaex9oUhrTDMbmORNpnJcPhpNAZgT+zc=;
        b=ns4IpIwJ1YxVP58r5Qf9/MH2FtMPJCvBOBYCruCZAV9BjFmQn6YTwJucr2k5264ipX
         4jZJW8LkDanckNGxJeu5wXjYNILYDkhLU6eyItP/PhbKFmnKlVFhrN7/eykfm4KtQ7f+
         DTD+c1WD9ZRYoj2ZkoT5BjgTVOs7h5aQvDJSyF+vwqg/BoXw7nBjDo+dwyrPT9IUH7nS
         UCQRFbccbeeTyp/Tid6e9DIzXCq1aNOO0SkB6OQUewaZr5AI7pl8zaHv7UBVnPbHcyrf
         z73Fua+RTCQ/UtMMk9LzFpuUoy0U/RnsRZ5aHqxGfv2HXSJYBHQ5Rhw4TmBwbDw0kuYc
         tfeg==
X-Gm-Message-State: AOAM531LO1a0CeEPxmuCkxNAfgM4vTBaxd8Ypa6RTHkA2IEn45D13g7i
        lV8IZ4r11PQv0DBHwLqvlCtFb2W0gXrD1A==
X-Google-Smtp-Source: ABdhPJwmcO97dm3m3C/BF2S0kM2Q1gC3sYne9sC9/Pa57LOScm3EIlLKlyoCr1bw1U11uLkPKTw6Nw==
X-Received: by 2002:a05:6638:4113:: with SMTP id ay19mr8076487jab.149.1637094169050;
        Tue, 16 Nov 2021 12:22:49 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id u12sm11631321ilm.1.2021.11.16.12.22.48
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 12:22:48 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e8so411005ilu.9
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 12:22:48 -0800 (PST)
X-Received: by 2002:a92:6910:: with SMTP id e16mr6338204ilc.190.1637094167822;
 Tue, 16 Nov 2021 12:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
 <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com> <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 16 Nov 2021 12:22:11 -0800
X-Gmail-Original-Message-ID: <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com>
Message-ID: <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 9:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 15, 2021 at 6:13 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Gentle bump.
> >
> >
> > On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > snapshot_write() is inappropriately limiting the amount of data that can
> > > be written in cases where a partial page has already been written. For
> > > example, one would expect to be able to write 1 byte, then 4095 bytes to
> > > the snapshot device, and have both of those complete fully (since now
> > > we're aligned to a page again). But what ends up happening is we write 1
> > > byte, then 4094/4095 bytes complete successfully.
> > >
> > > The reason is that simple_write_to_buffer()'s second argument is the
> > > total size of the buffer, not the size of the buffer minus the offset.
> > > Since simple_write_to_buffer() accounts for the offset in its
> > > implementation, snapshot_write() can just pass the full page size
> > > directly down.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >
> > >  kernel/power/user.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > > index 740723bb388524..ad241b4ff64c58 100644
> > > --- a/kernel/power/user.c
> > > +++ b/kernel/power/user.c
> > > @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> > >                 if (res <= 0)
> > >                         goto unlock;
> > >         } else {
> > > -               res = PAGE_SIZE - pg_offp;
> > > +               res = PAGE_SIZE;
> > >         }
> > >
> > >         if (!data_of(data->handle)) {
> > > --
>
> Do you actually see this problem in practice?

Yes. I may fire up another thread to explain why I'm stuck doing a
partial page write, and how I might be able to stop doing that in the
future with some kernel help. But either way, this is a bug.
-Evan
