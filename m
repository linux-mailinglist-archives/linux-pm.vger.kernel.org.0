Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5543239CA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhBXJqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 04:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhBXJoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 04:44:10 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD237C06178C
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 01:43:29 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id l192so754906vsd.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sr6OJw0MV6YNSbaXH424e+wXpSbrO4/l8Oz+otM/UVo=;
        b=gAofhg1xTUhonjHAD0Q4+3AjFB3rzUpFw5cNxHdAxmhd+3/tT4TgHry6HgbaSmvZ0y
         yppkGqnyNlNy+5nPoMqhHM8lxkOa1mGE+CT2NkjcmLmPJleMi9oOyV/VvAwgcmp4ADkT
         tahgtv47cmVyTuwip7tYuNHJ9/ojH756uwUQpUULcNdSkHZMwE3tXxjByKu3GXx7+jSA
         1+HwsjIcX/1bQapNnOzRpKe0gtlkDC6NodSTmeWco0goVPn0MhE0IX1DGJ8ALdqmkQml
         IgekdNicAHzQPydb2s/GltwdwoThH+46ndVR2FwrsO8Vwg0tGMYeqVWqDSqF+Sp+bSKq
         QQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sr6OJw0MV6YNSbaXH424e+wXpSbrO4/l8Oz+otM/UVo=;
        b=XAPtxh10WOnLt8Ik9I9/O78NisW/yPQPtgZHa3t+tao2fiErXXNZyH5xcHVpy36m7d
         hkOOChfS159BT3afynAIOcdNhtS8BFd2xwJcdJwWAtyZ9tCYuiksujS5Om1cGFDimhuR
         GxSx1vZDRKDz0mDXbyYGUzWvu0dzCNv0dsmb1rKVp5q6B+8eAIYss8BzpVxYTNJ7h92P
         tDNdrfXu7C58aSGGW++274Ql74Hzj605eg6zWVgXwAblV4IY1si5EfRzMP0+m2suYEXG
         a/06TcYl8OZ1U6gF4zRnWJXEW76/Q/8QRg6/VxebFZeBZTPK6cA8bnseI8jRGDDcui0h
         H8jw==
X-Gm-Message-State: AOAM531iu7tSB+TjmYD89llYZLroPCW0xm1wzmmxyt0/AJZVvejt8Vk5
        zCXps4qXIqsKOeL/ZR/VR2rdwsfOhS+X2U4nmv5oRw==
X-Google-Smtp-Source: ABdhPJzZgRHomzHeqMa1zQzFW6nGkmVRtZkJZQViQD5a0HCzFL7EO/cSWUsI4zFLP27gRM7HYTmmfmS7ntGnsl80PC4=
X-Received: by 2002:a67:f98a:: with SMTP id b10mr10217522vsq.19.1614159808865;
 Wed, 24 Feb 2021 01:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20210120172939160049119@rock-chips.com> <CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com>
 <5598462.KkIXRrj88c@kreacher>
In-Reply-To: <5598462.KkIXRrj88c@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Feb 2021 10:42:52 +0100
Message-ID: <CAPDyKFphWe=Xu+tuhpoqUUuKV3oW57DNWgZ1X8ceEnN+RE_gpw@mail.gmail.com>
Subject: Re: [REPORT_ISSUE]: RK3399 pd power down failed
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Feb 2021 at 18:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, February 23, 2021 12:30:39 PM CET Ulf Hansson wrote:
> > On Wed, 20 Jan 2021 at 10:30, zhangqing@rock-chips.com
> > <zhangqing@rock-chips.com> wrote:
> > >
> > > Hi, Heiko :
> > >
> > > In rk3399 evb board,  I found a probabilistic problem about PD. Turni=
ng off PD occasionally failed.
> > >
> > > log show=EF=BC=9A
> > > Open the vop
> > > #modetest -M rockchip -s 42@36:1536x2048 -P 31@36:1536x2048@AR24 -a
> > >
> > > close the vop
> > > #enter
> > >
> > >  # cat sys/kernel/debug/pm_genpd/pm_genpd_summary
> > > domain                          status          slaves
> > >     /device                                             runtime statu=
s
> > > ---------------------------------------------------------------------=
-
> > > pd_vopl                         off
> > > pd_vopb                         on
> > >     /devices/platform/ff903f00.iommu                     suspended
> > >     /devices/platform/ff900000.vop                          suspended
> > >
> > > I have checked the codes and concluded that there is a window of time=
 for PD to be closed when using the device link. Once queue_work is execute=
d immediately,  PD power off may be failed.
> > > The process is as follows:
> > >
> > > VOP requests to power off PD:
> > > pm_runtime_put_sync(vop->dev)
> > >     -> rpm_idle(vop)
> > >         -> rpm_suspend(vop)
> > >             -> __update_runtime_status(dev, RPM_SUSPENDING)
> > >                 -> rpm_callback(vop)
> > >                     -> __rpm_callback(vop)
> > >                         -> do power off pd callback(genpd_power_off)
> > >                             -> list_for_each_entry(pdd, &genpd->dev_l=
ist, list_node), ff900000.vop: suspending=EF=BC=8C ff903f00.iommu : active=
=EF=BC=8Cso not_suspended =3D 2 return -EBUSY; Not really power off PD=E3=
=80=82
> > >                                 -> Handle link device callbacks accor=
ding to device link=EF=BC=88rpm_put_suppliers=EF=BC=89
> > >                                     -> pm_runtime_put(link->supplier)
> > >                                         -> queue_work(pm_wq, &dev->po=
wer.work), execute immediately
> > >                                             ->rpm_idle(iommu)
> > >                                                 -> rpm_suspend(iommu)
> > >                                                     -> rpm_callback(i=
ommu)
> > >                                                         -> rk_iommu_s=
uspend
> > >                                                             ->  do po=
wer off pd callback(genpd_power_off)
> > >                                                                 -> li=
st_for_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspendi=
ng=EF=BC=8C ff903f00.iommu : suspending=EF=BC=8Cso not_suspended =3D 2 retu=
rn -EBUSY; Not really power off PD=E3=80=82
> > >                                                                     -=
> iommu do __update_runtime_status(dev, RPM_SUSPENDED)
> > >                                                                      =
   -> vop do __update_runtime_status(dev, RPM_SUSPENDED)
> >
> > So, rpm_suspend() tries to suspend the supplier device link via
> > rpm_put_suppliers(), before it has updated its consumer device's state
> > to RPM_SUSPENDED.
> >
> > This looks worrying to me, both because it's seems wrong to allow a
> > supplier to be suspended before a consumers device's state has reached
> > RPM_SUSPENDED - but also because it's not consistent with the way we
> > treat parent/child devices. The child's state will always be set to
> > RPM_SUSPENDED, before we try to suspend its parent by calling
> > rpm_idle() for it in rpm_suspend().
> >
> > Rafael, what's your take on this? Would it make sense to align the
> > behavior for consumer/supplier-links in rpm_suspend() according to
> > child/parents?
>
> Suspending the suppliers before changing the consumer RPM status to
> "suspended" is indeed incorrect, which is something I overlooked when
> writing the code in question.
>
> Fortunately, it seems to be relatively easy to address.
>
> Please see the appended tentative patch (untested).  It also avoids readi=
ng
> runtime_status outside the lock which is arguably fishy.

Great, thanks for your quick reply!

A minor comment on the below change, but otherwise feel free add my
reviewed-by tag.

Kind regards
Uffe

>
> ---
>  drivers/base/power/runtime.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -330,7 +330,11 @@ static int __rpm_callback(int (*cb)(stru
>
>         if (dev->power.irq_safe) {
>                 spin_unlock(&dev->power.lock);
> +       } else if (!use_links) {
> +               spin_unlock_irq(&dev->power.lock);
>         } else {
> +               bool get =3D dev->power.runtime_status =3D=3D RPM_RESUMIN=
G;
> +
>                 spin_unlock_irq(&dev->power.lock);
>
>                 /*
> @@ -340,7 +344,7 @@ static int __rpm_callback(int (*cb)(stru
>                  * routine returns, so it is safe to read the status outs=
ide of
>                  * the lock.
>                  */
> -               if (use_links && dev->power.runtime_status =3D=3D RPM_RES=
UMING) {
> +               if (get) {
>                         idx =3D device_links_read_lock();
>
>                         retval =3D rpm_get_suppliers(dev);
> @@ -355,7 +359,21 @@ static int __rpm_callback(int (*cb)(stru
>
>         if (dev->power.irq_safe) {
>                 spin_lock(&dev->power.lock);
> +       } if (!use_links) {

This should be an "else if", I think.

> +               spin_lock_irq(&dev->power.lock);
>         } else {
> +               bool put;
> +
> +               spin_lock_irq(&dev->power.lock);
> +
> +               put =3D dev->power.runtime_status =3D=3D RPM_SUSPENDING &=
& !retval;
> +               if (put)
> +                       __update_runtime_status(dev, RPM_SUSPENDED);
> +               else
> +                       put =3D dev->power.runtime_status =3D=3D RPM_RESU=
MING && retval;
> +
> +               spin_unlock_irq(&dev->power.lock);
> +
>                 /*
>                  * If the device is suspending and the callback has retur=
ned
>                  * success, drop the usage counters of the suppliers that=
 have
> @@ -363,9 +381,7 @@ static int __rpm_callback(int (*cb)(stru
>                  *
>                  * Do that if resume fails too.
>                  */
> -               if (use_links
> -                   && ((dev->power.runtime_status =3D=3D RPM_SUSPENDING =
&& !retval)
> -                   || (dev->power.runtime_status =3D=3D RPM_RESUMING && =
retval))) {
> +               if (put) {
>                         idx =3D device_links_read_lock();
>
>   fail:
>
>
>
