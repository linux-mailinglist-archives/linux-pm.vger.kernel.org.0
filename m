Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8FA45BF79
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 13:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbhKXM66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 07:58:58 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41945 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344237AbhKXM52 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 07:57:28 -0500
Received: by mail-oi1-f178.google.com with SMTP id u74so5120765oie.8;
        Wed, 24 Nov 2021 04:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymQHNu/HcjKJIpfHdM0oTSjwIp52WV3gOdu73KDgh+k=;
        b=TbA+dsYUdfwEEDYeOyEmRLu/ABtdSQtFS5lZ1NfODUR5Z4uT1ifMu3YRhC4LVnBXia
         o9qgpsdi07bVTS7k3zhCn16UDFjP0YXIt0X7y1OwQ8NoK8/Y7MCFxmg16ZBaqgCS4f+y
         5pWlB93tEKc9Vupih5bH9KB6PVyFJSZfMJgDhpl69Z/RyJ+qV5FRJOeuLo/h0MSFZU48
         1bTO+wvQHwcb/aDzhvaczMQglimhNtloVPlvc3IDs7D2ljKC671rJbkYidrOMksBd7Go
         rNPRMeKaY3LgludEqt1f2bwoc0xJ5vftEOhU0BJ5C8QMXHfZvTXJ/zNzwmsr1y3NUvds
         Xbrw==
X-Gm-Message-State: AOAM531P0HeFijrQ/uO/Sbbs1zDpSqz/7JrY9oc1/se6MZD+UE0LKxdD
        xAmC7LTQfFxzvgTjRulii0rwvTu+B+68dc2VchwfAAR0
X-Google-Smtp-Source: ABdhPJw8E05v+Ge/qWAiqStNgjc9LY7vhBX+bqhMNBggf0tDmC955iWPx13SsafQw0l17L4KnezEStGqa+pXGnh2Cno=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr5635167oiw.154.1637758458448;
 Wed, 24 Nov 2021 04:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
 <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
 <CAJZ5v0hsGFHxcTb8PUkGSm9oas1wdquB=euofS19zriRc1CXYw@mail.gmail.com> <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com>
In-Reply-To: <CAE=gft6CjUhkcrmcjVEOp5S+rgqN1_ZGTKbK0DierTanu0d16A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 13:54:07 +0100
Message-ID: <CAJZ5v0gamixc4dkBEXJjjw5zQynuz8BkQ9xv8YpbjkTkdMb2TQ@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     Evan Green <evgreen@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 9:22 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Tue, Nov 16, 2021 at 9:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Nov 15, 2021 at 6:13 PM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > Gentle bump.
> > >
> > >
> > > On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
> > > >
> > > > snapshot_write() is inappropriately limiting the amount of data that can
> > > > be written in cases where a partial page has already been written. For
> > > > example, one would expect to be able to write 1 byte, then 4095 bytes to
> > > > the snapshot device, and have both of those complete fully (since now
> > > > we're aligned to a page again). But what ends up happening is we write 1
> > > > byte, then 4094/4095 bytes complete successfully.
> > > >
> > > > The reason is that simple_write_to_buffer()'s second argument is the
> > > > total size of the buffer, not the size of the buffer minus the offset.
> > > > Since simple_write_to_buffer() accounts for the offset in its
> > > > implementation, snapshot_write() can just pass the full page size
> > > > directly down.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > ---
> > > >
> > > >  kernel/power/user.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > > > index 740723bb388524..ad241b4ff64c58 100644
> > > > --- a/kernel/power/user.c
> > > > +++ b/kernel/power/user.c
> > > > @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
> > > >                 if (res <= 0)
> > > >                         goto unlock;
> > > >         } else {
> > > > -               res = PAGE_SIZE - pg_offp;
> > > > +               res = PAGE_SIZE;
> > > >         }
> > > >
> > > >         if (!data_of(data->handle)) {
> > > > --
> >
> > Do you actually see this problem in practice?
>
> Yes. I may fire up another thread to explain why I'm stuck doing a
> partial page write, and how I might be able to stop doing that in the
> future with some kernel help. But either way, this is a bug.

OK, patch applied as 5.16-rc material.

I guess it should go into -stable kernels too?
