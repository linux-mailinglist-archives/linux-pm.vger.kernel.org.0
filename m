Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC34B14647F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 10:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAWJYB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 23 Jan 2020 04:24:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42309 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWJYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 04:24:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id 18so2254172oin.9;
        Thu, 23 Jan 2020 01:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PnJZAhJsiiWhg7NwdHJX7FMNohHhmjw2d2yqHeP5FkI=;
        b=SXgUnFsxfr31S5NH9n7Jje80/qLYr8hZgqcYscHgsgBQ3SJGemtJJSzn3lQhg0HzFv
         XG29rkx0kPjFXK7J1etyAzemzN6LUTLSGgwyFDKZ73P2ueTpT1+dN2tvAuWplkiRn2xZ
         L3W5LHuX3N8fCJDupJQ2YjP9mnqU9DhoZenpZljBmQDUB3UNcOheS+D1dTAokZ9l8tGJ
         uj/07/UPBoH8P7Kx+y8cF50Mj/xkEVL9dZkcdnn3HMMBNRg3SZAtH8noJUqtmrt40dfK
         yfUghRxCsGmlbx3OfY962AorMD7UnkKH+xsjVU/WZd4c52LnyQRdYPyfIVsDgTAblgt9
         4Aqg==
X-Gm-Message-State: APjAAAXwfTpzZFYWQA6qh9MB/dCIhCVhf2UZXJSTbckZGA13oHnDNGa5
        yb8qoqi5qwmYEK4LScQTYro0hTtjM0owbZSyDjg=
X-Google-Smtp-Source: APXvYqwzjG65Goc9dRVOljJMk8nj2GR0kejdwxXnxZZWYRclj75dA4ZPvk7xIwYrI/r0GtiIars7IzmDu7mrCEfpjbE=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr10298863oig.103.1579771440745;
 Thu, 23 Jan 2020 01:24:00 -0800 (PST)
MIME-Version: 1.0
References: <2601275.1tEomSadG4@kreacher> <c5a2d11f-86fe-663d-f0ad-ed6ea0da871e@lge.com>
In-Reply-To: <c5a2d11f-86fe-663d-f0ad-ed6ea0da871e@lge.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 10:23:47 +0100
Message-ID: <CAJZ5v0iyJG6fNJ7XQNe0y4KdfAqZiOBG0_f64gtmg26j=ty=NQ@mail.gmail.com>
Subject: Re: [PATCH] PM: core: Fix handling of devices deleted during
 system-wide resume
To:     Chanho Min <chanho.min@lge.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daewoong Kim <daewoong00.kim@lge.com>,
        Lee Gunho <gunho.lee@lge.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 23, 2020 at 3:14 AM Chanho Min <chanho.min@lge.com> wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a device is deleted by one of its system-wide resume callbacks
> > (for example, because it does not appear to be present or accessible
> > any more) along with its children, the resume of the children may
> > continue leading to use-after-free errors and other issues
> > (potentially).
> >
> > Namely, if the device's children are resumed asynchronously, their
> > resume may have been scheduled already before the device's callback
> > runs and so the device may be deleted while dpm_wait_for_superior()
> > is being executed for them.  The memory taken up by the parent device
> > object may be freed then while dpm_wait() is waiting for the parent's
> > resume callback to complete, which leads to a use-after-free.
> > Moreover, the resume of the children is really not expected to
> > continue after they have been unregistered, so it must be terminated
> > right away in that case.Seokjoo Lee <seokjoo.lee@lge.com>
> >
> > To address this problem, modify dpm_wait_for_superior() to check
> > if the target device is still there in the system-wide PM list of
> > devices and if so, to increment its parent's reference counter, both
> > under dpm_list_mtx which prevents device_del() running for the child
> > from dropping the parent's reference counter prematurely.
> >
> > If the device is not present in the system-wide PM list of devices
> > any more, the resume of it cannot continue, so check that again after
> > dpm_wait() returns, which means that the parent's callback has been
> > completed, and pass the result of that check to the caller of
> > dpm_wait_for_superior() to allow it to abort the device's resume
> > if it is not there any more.
> >
> > Link: https://lore.kernel.org/linux-pm/1579568452-27253-1-git-send-email-chanho.min@lge.com
> > Reported-by: Chanho Min <chanho.min@lge.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/base/power/main.c |   42 +++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 37 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/main.cSeokjoo Lee <seokjoo.lee@lge.com>
> > +++ linux-pm/drivers/base/power/main.c20. 1. 23. 오전 8:11에 Rafael J. Wysocki 이(가) 쓴 글:
> > @@ -273,10 +273,38 @@ static void dpm_wait_for_suppliers(struc
> >       device_links_read_unlock(idx);
> >   }
> >
> > -static void dpm_wait_for_superior(struct device *dev, bool async)
> > +static bool dpm_wait_for_superior(struct device *dev, bool async)
> >   {
> > -     dpm_wait(dev->parent, async);
> > +     struct device *parent;board
> > +
> > +     /*
> > +      * If the device is resumed asynchronously and the parent's callback
> > +      * deletes both the device and the parent itself, the parent object may
> > +      * be freed while this function is running, so avoid that by reference
> > +      * counting the parent once more unless the device has been deleted
> > +      * already (in which case return right away).
> > +      */
> > +     mutex_lock(&dpm_list_mtx);
> > +
> > +     if (!device_pm_initialized(dev)) {20. 1. 23. 오전 8:11에 Rafael J. Wysocki 이(가) 쓴 글:
> > +             mutex_unlock(&dpm_list_mtx);
> > +             return false;
> > +     }
> > +
> > +     parent = get_device(dev->parent);
> > +
> > +     mutex_unlock(&dpm_list_mtx);
> > +
> > +     dpm_wait(parent, async);
> > +     put_device(parent);
> > +
> >       dpm_wait_for_suppliers(dev, async);
> > +
> > +     /*
> > +      * If the parent's callback has deleted the device, attempting to resume
> > +      * it would be invalid, so avoid doing that then.
> > +      */
> > +     return device_pm_initialized(dev);20. 1. 23. 오전 8:11에 Rafael J. Wysocki 이(가) 쓴 글:
> >   }
> >
> >   static void dpm_wait_for_consumers(struct device *dev, bool async)
> > @@ -621,7 +649,8 @@ static int device_resume_noirq(struct de
> >       if (!dev->power.is_noirq_suspended)
> >               goto Out;
> >
> > -     dpm_wait_for_superior(dev, async);
> > +     if (!dpm_wait_for_superior(dev, async))
> > +             goto Out;
> >
> >       skip_resume = dev_pm_may_skip_resume(dev);
> >
> > @@ -829,7 +858,8 @@ static int device_resume_early(struct de
> >       if (!dev->power.is_late_suspended)
> >               goto Out;
> >
> > -     dpm_wait_for_superior(dev, async);Seokjoo Lee <seokjoo.lee@lge.com>
> > +     if (!dpm_wait_for_superior(dev, async))
> > +             goto Out;
> >
> >       callback = dpm_subsys_resume_early_cb(dev, state, &info);
> >
> > @@ -944,7 +974,9 @@ static int device_resume(struct device *
> >               goto Complete;
> >       }
> >
> > -     dpm_wait_for_superior(dev, async);
> > +     if (!dpm_wait_for_superior(dev, async))
> > +             goto Complete;
> > +
> >       dpm_watchdog_set(&wd, dev);
> >       device_lock(dev);Thanks, This seems to solve the rare hang on our target.
> Actually, the problem is occurred in v4.4.
> Shouldn't it apply to -stable?

Yes, it should, but I'll add a "stable" tag later.
