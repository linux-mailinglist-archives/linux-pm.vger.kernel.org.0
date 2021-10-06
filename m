Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF86A4243AD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbhJFRH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 13:07:56 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38449 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhJFRHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 13:07:55 -0400
Received: by mail-ot1-f50.google.com with SMTP id c6-20020a9d2786000000b005471981d559so3944898otb.5;
        Wed, 06 Oct 2021 10:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EM+Wl6eBiWECCDpdSNRpq7eFaWzLzTZMv3EuyjrwM+g=;
        b=2Aw8sUif8kDem1mJCFn+ivumjLxib/Ua8nn6a/VRPBPZWDNfvE5I0FL3n3DGedbyA4
         2LI2p470J8uPx9o6nQtE6RZgJ2hDBIv7oNbxCNV3vqfkG0qjLlyclFeVPq/NlrFOHf62
         FzFvMglSsWq5YH6G3CIHPyp1sTXFrJCFo9UugbDBVTyeUEPl/n0kQ5iYooy/N+k/Igug
         zplOisyIZj/XoNv+S0+hwv1d06MJqxSHecKOwprffiSbhjtXSZi3WT5Aibj+oseBDAl/
         Bxr7YFUk0l5sJvjzGaraYf8SANbvHaGiKw2YGnHwzHwNTJJlLFZOVG8xIAVTcpkKzOV6
         tOYg==
X-Gm-Message-State: AOAM531c69X3hdbBUsBbaMVlcvf/BDxvTpng3xVzcilFy6ZCOxJuI8wu
        Z3UOnPJYj0ngeEQXGErVKVGHmVP2JVywAYXVzB4=
X-Google-Smtp-Source: ABdhPJxjMutc/WGD+pWtxNie5AqpQJdVYp3RNBUzjyrSca96SvtQWegTxgpJYi1qgbKMe8J/ttTNP+2+XIqPesGiSlA=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr20428139otu.86.1633539962654;
 Wed, 06 Oct 2021 10:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155427.1591196-1-john@metanate.com> <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
 <20211005181706.66102578.john@metanate.com>
In-Reply-To: <20211005181706.66102578.john@metanate.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Oct 2021 19:05:50 +0200
Message-ID: <CAJZ5v0iFKYvM+rn68VaAbM4=ZLAQBR_UPzvAuKqVLQuP=ZJPew@mail.gmail.com>
Subject: Re: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
To:     John Keeping <john@metanate.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-rt-users@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 5, 2021 at 7:17 PM John Keeping <john@metanate.com> wrote:
>
> On Tue, 5 Oct 2021 18:38:27 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 5, 2021 at 6:14 PM John Keeping <john@metanate.com> wrote:
> > >
> > > With PREEMPT_RT spin_unlock() is identical to spin_unlock_irq() so there
> > > is no reason to have a special case using the former.  Furthermore,
> > > spin_unlock() enables preemption meaning that a task in RESUMING or
> > > SUSPENDING state may be preempted by a higher priority task running
> > > pm_runtime_get_sync() leading to a livelock.
> > >
> > > Use the non-irq_safe path for all waiting so that the waiting task will
> > > block.
> > >
> > > Note that this changes only the waiting behaviour of irq_safe, other
> > > uses are left unchanged so that the parent device always remains active
> > > in the same way as !RT.
> > >
> > > Signed-off-by: John Keeping <john@metanate.com>
> >
> > So basically, the idea is that the irq_safe flag should have no effect
> > when CONFIG_PREEMPT_RT is set, right?
> >
> > Wouldn't it be cleaner to make it not present at all in that case?
>
> Yes, just replacing pm_runtime_irq_safe() with an empty function would
> also fix it, but I'm not sure if that will have unexpected effects from
> the parent device suspending/resuming, especially in terms of latency
> for handling interrupts.

Well, the code as is doesn't work with CONFIG_PREEMPT_RT set anyway in general.

Also this is not just pm_runtime_irq_safe(), but every access to this
flag (and there's more  of them than just the ones changed below).

What about putting the flag under #ifdef CONFIG_PREEMPT_RT and
providing read/write accessor helpers for it that will be empty in
RT-enabled kernels?

> > > ---
> > >  drivers/base/power/runtime.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 96972d5f6ef3..5e0d349fab4e 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -347,8 +347,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> > >  {
> > >         int retval = 0, idx;
> > >         bool use_links = dev->power.links_count > 0;
> > > +       bool irq_safe = dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT);
> > >
> > > -       if (dev->power.irq_safe) {
> > > +       if (irq_safe) {
> > >                 spin_unlock(&dev->power.lock);
> > >         } else {
> > >                 spin_unlock_irq(&dev->power.lock);
> > > @@ -376,7 +377,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> > >         if (cb)
> > >                 retval = cb(dev);
> > >
> > > -       if (dev->power.irq_safe) {
> > > +       if (irq_safe) {
> > >                 spin_lock(&dev->power.lock);
> > >         } else {
> > >                 /*
> > > @@ -596,7 +597,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> > >                         goto out;
> > >                 }
> > >
> > > -               if (dev->power.irq_safe) {
> > > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > >                         spin_unlock(&dev->power.lock);
> > >
> > >                         cpu_relax();
> > > @@ -777,7 +778,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >                         goto out;
> > >                 }
> > >
> > > -               if (dev->power.irq_safe) {
> > > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > >                         spin_unlock(&dev->power.lock);
> > >
> > >                         cpu_relax();
> > > --
> > > 2.33.0
> > >
>
