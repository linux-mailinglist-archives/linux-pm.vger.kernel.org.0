Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39D323C16
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 13:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBXMu6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Feb 2021 07:50:58 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34220 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhBXMu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 07:50:57 -0500
Received: by mail-ot1-f43.google.com with SMTP id b16so2033165otq.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 04:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKjKi7mocSw8ViiWmT6lfQr3sON+8D6k2wvtZXamjTg=;
        b=XIElRFj/rDpm3JA5il5Asb5bB1aCQ84po8Sjce1+zyFlgqQwGMkylAVKZGBCK2YKIB
         /mNR1PWSgq3l8uiSwWMwZJF9eem2EdjMA6P6PeLH78O9VJB0v3YAn5JRFX1VbneRjiEx
         R70Xkbyop2jw1U5guenDDotjKAPjdR5Press5NsM5ZkvBBdLM1/B6GvopIwn0PYsT+tk
         M7q3Qsw2MJm+L+XZZ3Oph572hz4K0PKSsBrQ6zdCh2vJKf3lksz5vC/3LzwaWUv8zd8w
         kWMH4Zw9zxFokp87G1HF/q9QYvnZ1fv/868H2JnNozf+ZH1QtQl6Ut7+mPoR+lbbs/s+
         j6Gg==
X-Gm-Message-State: AOAM531bsY/BgfnjaAca99wwPF2FgQS1bHQVD9gLdrmWzhhh59ZvfJXM
        EJ6BaVjelvz6e1so0gsMIND5gbG0d5FFwvJOaQk=
X-Google-Smtp-Source: ABdhPJxfn4Vgnyd1YfBtd1hl0M79H5Mza06LtHvCy08BO9JW2HCtmP7+TjF2yXsi38VOVCml43YPjUghmUI/miEQEx0=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr20618394ota.321.1614171015854;
 Wed, 24 Feb 2021 04:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20210120172939160049119@rock-chips.com> <CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com>
 <5598462.KkIXRrj88c@kreacher> <CAPDyKFphWe=Xu+tuhpoqUUuKV3oW57DNWgZ1X8ceEnN+RE_gpw@mail.gmail.com>
In-Reply-To: <CAPDyKFphWe=Xu+tuhpoqUUuKV3oW57DNWgZ1X8ceEnN+RE_gpw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Feb 2021 13:50:04 +0100
Message-ID: <CAJZ5v0grDtJAqLqzPb=xVLBH14_epv7x0s2Se5srzzSR6rKd5w@mail.gmail.com>
Subject: Re: [REPORT_ISSUE]: RK3399 pd power down failed
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>,
        heiko <heiko@sntech.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        "len.brown" <len.brown@intel.com>, pavel <pavel@ucw.cz>,
        gregkh <gregkh@linuxfoundation.org>,
        khilman <khilman@kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        "Huang, Tao" <huangtao@rock-chips.com>,
        =?UTF-8?B?6LCi5L+u6ZGr?= <tony.xie@rock-chips.com>,
        =?UTF-8?B?5p2o5Yev?= <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 24, 2021 at 10:46 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Feb 2021 at 18:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, February 23, 2021 12:30:39 PM CET Ulf Hansson wrote:
> > > On Wed, 20 Jan 2021 at 10:30, zhangqing@rock-chips.com
> > > <zhangqing@rock-chips.com> wrote:
> > > >
> > > > Hi, Heiko :
> > > >
> > > > In rk3399 evb board,  I found a probabilistic problem about PD. Turning off PD occasionally failed.
> > > >
> > > > log show：
> > > > Open the vop
> > > > #modetest -M rockchip -s 42@36:1536x2048 -P 31@36:1536x2048@AR24 -a
> > > >
> > > > close the vop
> > > > #enter
> > > >
> > > >  # cat sys/kernel/debug/pm_genpd/pm_genpd_summary
> > > > domain                          status          slaves
> > > >     /device                                             runtime status
> > > > ----------------------------------------------------------------------
> > > > pd_vopl                         off
> > > > pd_vopb                         on
> > > >     /devices/platform/ff903f00.iommu                     suspended
> > > >     /devices/platform/ff900000.vop                          suspended
> > > >
> > > > I have checked the codes and concluded that there is a window of time for PD to be closed when using the device link. Once queue_work is executed immediately,  PD power off may be failed.
> > > > The process is as follows:
> > > >
> > > > VOP requests to power off PD:
> > > > pm_runtime_put_sync(vop->dev)
> > > >     -> rpm_idle(vop)
> > > >         -> rpm_suspend(vop)
> > > >             -> __update_runtime_status(dev, RPM_SUSPENDING)
> > > >                 -> rpm_callback(vop)
> > > >                     -> __rpm_callback(vop)
> > > >                         -> do power off pd callback(genpd_power_off)
> > > >                             -> list_for_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspending， ff903f00.iommu : active，so not_suspended = 2 return -EBUSY; Not really power off PD。
> > > >                                 -> Handle link device callbacks according to device link（rpm_put_suppliers）
> > > >                                     -> pm_runtime_put(link->supplier)
> > > >                                         -> queue_work(pm_wq, &dev->power.work), execute immediately
> > > >                                             ->rpm_idle(iommu)
> > > >                                                 -> rpm_suspend(iommu)
> > > >                                                     -> rpm_callback(iommu)
> > > >                                                         -> rk_iommu_suspend
> > > >                                                             ->  do power off pd callback(genpd_power_off)
> > > >                                                                 -> list_for_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspending， ff903f00.iommu : suspending，so not_suspended = 2 return -EBUSY; Not really power off PD。
> > > >                                                                     -> iommu do __update_runtime_status(dev, RPM_SUSPENDED)
> > > >                                                                         -> vop do __update_runtime_status(dev, RPM_SUSPENDED)
> > >
> > > So, rpm_suspend() tries to suspend the supplier device link via
> > > rpm_put_suppliers(), before it has updated its consumer device's state
> > > to RPM_SUSPENDED.
> > >
> > > This looks worrying to me, both because it's seems wrong to allow a
> > > supplier to be suspended before a consumers device's state has reached
> > > RPM_SUSPENDED - but also because it's not consistent with the way we
> > > treat parent/child devices. The child's state will always be set to
> > > RPM_SUSPENDED, before we try to suspend its parent by calling
> > > rpm_idle() for it in rpm_suspend().
> > >
> > > Rafael, what's your take on this? Would it make sense to align the
> > > behavior for consumer/supplier-links in rpm_suspend() according to
> > > child/parents?
> >
> > Suspending the suppliers before changing the consumer RPM status to
> > "suspended" is indeed incorrect, which is something I overlooked when
> > writing the code in question.
> >
> > Fortunately, it seems to be relatively easy to address.
> >
> > Please see the appended tentative patch (untested).  It also avoids reading
> > runtime_status outside the lock which is arguably fishy.
>
> Great, thanks for your quick reply!
>
> A minor comment on the below change, but otherwise feel free add my
> reviewed-by tag.

Thanks!

I'm going to submit an updated patch that avoids some unnecessary
locking overhead.

> >
> > ---
> >  drivers/base/power/runtime.c |   24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -330,7 +330,11 @@ static int __rpm_callback(int (*cb)(stru
> >
> >         if (dev->power.irq_safe) {
> >                 spin_unlock(&dev->power.lock);
> > +       } else if (!use_links) {
> > +               spin_unlock_irq(&dev->power.lock);
> >         } else {
> > +               bool get = dev->power.runtime_status == RPM_RESUMING;
> > +
> >                 spin_unlock_irq(&dev->power.lock);
> >
> >                 /*
> > @@ -340,7 +344,7 @@ static int __rpm_callback(int (*cb)(stru
> >                  * routine returns, so it is safe to read the status outside of
> >                  * the lock.
> >                  */
> > -               if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> > +               if (get) {
> >                         idx = device_links_read_lock();
> >
> >                         retval = rpm_get_suppliers(dev);
> > @@ -355,7 +359,21 @@ static int __rpm_callback(int (*cb)(stru
> >
> >         if (dev->power.irq_safe) {
> >                 spin_lock(&dev->power.lock);
> > +       } if (!use_links) {
>
> This should be an "else if", I think.

Yes, it should, thanks!

> > +               spin_lock_irq(&dev->power.lock);
> >         } else {
> > +               bool put;
> > +
> > +               spin_lock_irq(&dev->power.lock);
> > +
> > +               put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
> > +               if (put)
> > +                       __update_runtime_status(dev, RPM_SUSPENDED);
> > +               else
> > +                       put = dev->power.runtime_status == RPM_RESUMING && retval;
> > +
> > +               spin_unlock_irq(&dev->power.lock);
> > +
> >                 /*
> >                  * If the device is suspending and the callback has returned
> >                  * success, drop the usage counters of the suppliers that have
> > @@ -363,9 +381,7 @@ static int __rpm_callback(int (*cb)(stru
> >                  *
> >                  * Do that if resume fails too.
> >                  */
> > -               if (use_links
> > -                   && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> > -                   || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> > +               if (put) {
> >                         idx = device_links_read_lock();
> >
> >   fail:
> >
> >
> >
