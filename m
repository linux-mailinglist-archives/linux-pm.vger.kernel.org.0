Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2F8324FA9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Feb 2021 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhBYMHc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 25 Feb 2021 07:07:32 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37411 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBYMHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2021 07:07:30 -0500
Received: by mail-oi1-f176.google.com with SMTP id l133so5839784oib.4;
        Thu, 25 Feb 2021 04:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7UvPTCRgz9liGqcyePe7weHBGn9Fm8WUz4WgzjQSZAA=;
        b=bjxX+f1rZqGZn6L/2THcBWxECpI1R8VooFV0lINR0kQvkcAgreKSSXGpvG6oV8WMBi
         NaT/nMzDSA6a0IzCs0uMu0R4v8JYfze3dL9dKEu5lyftNFaiabdpF0v7HlaU4MbfrFKH
         D+iH9rYdb3LaSisgZVfUvMUA2Rx6gbgLYYQ8zV2b8fKRwp7gzbHxLRWidk8ydH/oCaeU
         QWlgDvAeHzEJhQ1V2ioVuvNTthFhq8AYvI3cy5aSK3xpPAzz96+Huvoz0HLOhzODdpcr
         O3EPSiaVcuJyaeMfGLHY4/7XkMJyi38IqOFevZ0T5zdqXeaZwtsTz70loQC3P+u0ZGoq
         jZpg==
X-Gm-Message-State: AOAM533NUEAE3+NTOmrRl0rayEqfBZF2foBQCsxwujl6s9UUIAM5Y9vA
        EzPwuPoCeUS6c6retIXEGFDDH50wr2HUcQgh6vlOvsha
X-Google-Smtp-Source: ABdhPJyforWAkZ3pc6SXCMHCd4RJCZ3WZUx0PBFvj2wwC6XgwFn9HE1fCz/boSKXbwESRONq61U6T9hEHTbTXf/v6zc=
X-Received: by 2002:aca:3bc6:: with SMTP id i189mr1653518oia.71.1614254809370;
 Thu, 25 Feb 2021 04:06:49 -0800 (PST)
MIME-Version: 1.0
References: <1930477.9OOUKYNkGr@kreacher> <c3abadb0-eaae-5dd7-3ac7-507f8e4bc5ab@rock-chips.com>
In-Reply-To: <c3abadb0-eaae-5dd7-3ac7-507f8e4bc5ab@rock-chips.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Feb 2021 13:06:38 +0100
Message-ID: <CAJZ5v0ifd9_nh3AU0Keyfr2spwvdped++6mGYrUjPMYDUv6BLg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Update device status before letting
 suppliers suspend
To:     "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 25, 2021 at 2:32 AM elaine.zhang <zhangqing@rock-chips.com> wrote:
>
> Hi, Rafael:
>
> 在 2021/2/25 上午1:53, Rafael J. Wysocki 写道:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because the PM-runtime status of the device is not updated in
> > __rpm_callback(), attempts to suspend the suppliers of the given
> > device triggered by rpm_put_suppliers() called by it may fail.
> >
> > Fix this by making __rpm_callback() update the device's status to
> > RPM_SUSPENDED before calling rpm_put_suppliers() if the current
> > status of the device is RPM_SUSPENDING and the callback just invoked
> > by it has returned 0 (success).
> >
> > While at it, modify the code in __rpm_callback() to always check
> > the device's PM-runtime status under its PM lock.
> >
> > Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
> > Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> > Reported-by: elaine.zhang <zhangqing@rock-chips.com>
> > Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is different from the previously posted tentative patch, please retest.
> >
> > ---
> >   drivers/base/power/runtime.c |   61 +++++++++++++++++++++++++------------------
> >   1 file changed, 36 insertions(+), 25 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -325,22 +325,21 @@ static void rpm_put_suppliers(struct dev
> >   static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> >       __releases(&dev->power.lock) __acquires(&dev->power.lock)
> >   {
> > -     int retval, idx;
> >       bool use_links = dev->power.links_count > 0;
> > +     int retval, idx;
> > +     bool get, put;
> >
> >       if (dev->power.irq_safe) {
> >               spin_unlock(&dev->power.lock);
> > +     } else if (!use_links) {
> > +             spin_unlock_irq(&dev->power.lock);
> >       } else {
> > +             get = dev->power.runtime_status == RPM_RESUMING;
> > +
> >               spin_unlock_irq(&dev->power.lock);
> >
> > -             /*
> > -              * Resume suppliers if necessary.
> > -              *
> > -              * The device's runtime PM status cannot change until this
> > -              * routine returns, so it is safe to read the status outside of
> > -              * the lock.
> > -              */
> > -             if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> > +             /* Resume suppliers if necessary. */
> > +             if (get) {
> >                       idx = device_links_read_lock();
> >
> >                       retval = rpm_get_suppliers(dev);
> > @@ -355,24 +354,36 @@ static int __rpm_callback(int (*cb)(stru
> >
> >       if (dev->power.irq_safe) {
> >               spin_lock(&dev->power.lock);
> > -     } else {
> > -             /*
> > -              * If the device is suspending and the callback has returned
> > -              * success, drop the usage counters of the suppliers that have
> > -              * been reference counted on its resume.
> > -              *
> > -              * Do that if resume fails too.
> > -              */
> > -             if (use_links
> > -                 && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> > -                 || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> > -                     idx = device_links_read_lock();
> > +             return retval;
> > +     }
> >
> > - fail:
> > -                     rpm_put_suppliers(dev);
> > +     spin_lock_irq(&dev->power.lock);
> >
> > -                     device_links_read_unlock(idx);
> > -             }
> > +     if (!use_links)
> > +             return retval;
> > +
> > +     /*
> > +      * If the device is suspending and the callback has returned success,
> > +      * drop the usage counters of the suppliers that have been reference
> > +      * counted on its resume.
> > +      *
> > +      * Do that if the resume fails too.
> > +      */
> > +     put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
> > +     if (put)
> > +             __update_runtime_status(dev, RPM_SUSPENDED);
> > +     else
> > +             put = get && retval;
> > +
> > +     if (put) {
> > +             spin_unlock_irq(&dev->power.lock);
> > +
> > +             idx = device_links_read_lock();
> > +
> > +fail:
> > +             rpm_put_suppliers(dev);
> > +
> > +             device_links_read_unlock(idx);
> >
> >               spin_lock_irq(&dev->power.lock);
> >       }
> drivers/base/power/runtime.c: In function '__rpm_callback':
> drivers/base/power/runtime.c:355:13: warning: 'get' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
> error, forbidden warning:runtime.c:355

This really is a false-positive, because in fact the "get" variable
cannot be uninitialized at this point.

>     put = get && retval;
>
> There is a compilation error. I change it as:
>
> put = dev->power.runtime_status == RPM_SUSPENDING && retval;

I prefer to initialize "get" to false (even though that is not
strictly necessary).

> And test works well.Please check it.

OK, thanks for testing!

I will send an updated patch later today.
