Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06B1322985
	for <lists+linux-pm@lfdr.de>; Tue, 23 Feb 2021 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBWLb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Feb 2021 06:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhBWLb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 06:31:56 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357FC061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 03:31:16 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i13so3971687vsr.13
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 03:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BA70Z4Cp7J5+ZpZeMM/trZlzFHS5yV8ayZ5uFgJhuZk=;
        b=gf8p8KMHsd9CA0siKk82Lszs4u6CGS6YKyJ127U+EExvFi6z5nf1luCMmbvOzog/ge
         dPCoO+Nzfxqx4jO5BYgTTw6BgnP3copiQzjGL75/S7GwYZ3FYdwalztydokuB7iaEkeD
         Eh4rHd4Oom5JscudM5svzqnXuHSWQ+w7zyUXQbRxCJA8kobK0q2M9z1jxfQHgN8u1VOk
         n/HrK1LQP0q51Ygn2Uypv9EzbLYaSoBElIaJZCr4hYC3rCLAS382Esl0WP6e13v8BOF1
         KeoGZOvn6CdHyDd4tKVBazfP6i6U9ByJF3mRBK6qKbITPdZjTr71r3DI/qegkFN6LIi+
         uYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BA70Z4Cp7J5+ZpZeMM/trZlzFHS5yV8ayZ5uFgJhuZk=;
        b=p+h+OUtg/4bGqnj/3AkYMoWKHeGJkxEnrIF5uL/Phq/Ct8uGlEeqrAfzmcLF5CGduN
         Kefy28Imj8zne3ilOrrZxB57yaZn0+dow2nB1YB4SJLVxS8zgd0/9ICX61P+fQsUnycW
         OPAOq6oi6IWFC1nuKIlTfsP43ERuI1/7fHOjm9j2eG4r5mjh1q1efgbrQvO0rwJ9xGtb
         B3hW2ctwXW4E/7bSgJkvrdy5adHfeeG9KGJ6vSXFfDxGUouqeyyPH/8ALlQd+K0QQ4G3
         icsvFiZSnAtwpFxWP0/Z+pkr7x/7uuIvRnPO2Dl7dJmfpGvvCPFU7Qahg6Zz0Wecf0L0
         iNLw==
X-Gm-Message-State: AOAM5307lbxrB62X2BqeUj6/JgijMbxOfQzNw+5P4MbGhghabsiNuuHZ
        NbiaYwiU3k1SN6kOotss5nao/5lMuyvjIwYTBEih+A==
X-Google-Smtp-Source: ABdhPJyXYhBhEwTKbdp+vRL6qQZUCo7hco9V8cmRawQyImpfzgtyiCw4shSSN5y3807VL27XZdRotUkDtHJAG4L8YqI=
X-Received: by 2002:a67:c787:: with SMTP id t7mr16388450vsk.48.1614079875445;
 Tue, 23 Feb 2021 03:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20210120172939160049119@rock-chips.com>
In-Reply-To: <20210120172939160049119@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Feb 2021 12:30:39 +0100
Message-ID: <CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com>
Subject: Re: [REPORT_ISSUE]: RK3399 pd power down failed
To:     "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>,
        rjw <rjw@rjwysocki.net>
Cc:     heiko <heiko@sntech.de>, Finley Xiao <finley.xiao@rock-chips.com>,
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

On Wed, 20 Jan 2021 at 10:30, zhangqing@rock-chips.com
<zhangqing@rock-chips.com> wrote:
>
> Hi, Heiko :
>
> In rk3399 evb board,  I found a probabilistic problem about PD. Turning o=
ff PD occasionally failed.
>
> log show=EF=BC=9A
> Open the vop
> #modetest -M rockchip -s 42@36:1536x2048 -P 31@36:1536x2048@AR24 -a
>
> close the vop
> #enter
>
>  # cat sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> pd_vopl                         off
> pd_vopb                         on
>     /devices/platform/ff903f00.iommu                     suspended
>     /devices/platform/ff900000.vop                          suspended
>
> I have checked the codes and concluded that there is a window of time for=
 PD to be closed when using the device link. Once queue_work is executed im=
mediately,  PD power off may be failed.
> The process is as follows:
>
> VOP requests to power off PD:
> pm_runtime_put_sync(vop->dev)
>     -> rpm_idle(vop)
>         -> rpm_suspend(vop)
>             -> __update_runtime_status(dev, RPM_SUSPENDING)
>                 -> rpm_callback(vop)
>                     -> __rpm_callback(vop)
>                         -> do power off pd callback(genpd_power_off)
>                             -> list_for_each_entry(pdd, &genpd->dev_list,=
 list_node), ff900000.vop: suspending=EF=BC=8C ff903f00.iommu : active=EF=
=BC=8Cso not_suspended =3D 2 return -EBUSY; Not really power off PD=E3=80=
=82
>                                 -> Handle link device callbacks according=
 to device link=EF=BC=88rpm_put_suppliers=EF=BC=89
>                                     -> pm_runtime_put(link->supplier)
>                                         -> queue_work(pm_wq, &dev->power.=
work), execute immediately
>                                             ->rpm_idle(iommu)
>                                                 -> rpm_suspend(iommu)
>                                                     -> rpm_callback(iommu=
)
>                                                         -> rk_iommu_suspe=
nd
>                                                             ->  do power =
off pd callback(genpd_power_off)
>                                                                 -> list_f=
or_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspending=
=EF=BC=8C ff903f00.iommu : suspending=EF=BC=8Cso not_suspended =3D 2 return=
 -EBUSY; Not really power off PD=E3=80=82
>                                                                     -> io=
mmu do __update_runtime_status(dev, RPM_SUSPENDED)
>                                                                         -=
> vop do __update_runtime_status(dev, RPM_SUSPENDED)

So, rpm_suspend() tries to suspend the supplier device link via
rpm_put_suppliers(), before it has updated its consumer device's state
to RPM_SUSPENDED.

This looks worrying to me, both because it's seems wrong to allow a
supplier to be suspended before a consumers device's state has reached
RPM_SUSPENDED - but also because it's not consistent with the way we
treat parent/child devices. The child's state will always be set to
RPM_SUSPENDED, before we try to suspend its parent by calling
rpm_idle() for it in rpm_suspend().

Rafael, what's your take on this? Would it make sense to align the
behavior for consumer/supplier-links in rpm_suspend() according to
child/parents?

>
> So the whole process goes down, the PD is not really power off, but the s=
tate of the child devices is SUSPENDED.
> Pm_runtime_put (link->supplier) used to power off PD is asynchronous and =
is added to queue_work(pm_wq, &dev-bbb>wer-work);
> If the queue_work is queued, the PD shutdown will succeed
> The call is as follows:
>
> VOP requests to power off PD:
> pm_runtime_put_sync(vop->dev)
>     -> rpm_idle(vop)
>         -> rpm_suspend(vop)
>             -> __update_runtime_status(dev, RPM_SUSPENDING)
>                 -> rpm_callback(vop)
>                     -> __rpm_callback(vop)
>                         -> do power off pd callback(genpd_power_off)
>                             ->  list_for_each_entry(pdd, &genpd->dev_list=
, list_node), ff900000.vop: suspending=EF=BC=8C ff903f00.iommu : active=EF=
=BC=8Cso not_suspended =3D 2 return -EBUSY; Not really power off PD=E3=80=
=82
>                                  -> Handle link device callbacks accordin=
g to device link=EF=BC=88rpm_put_suppliers=EF=BC=89
>                                     -> pm_runtime_put(link->supplier)
>                                          -> queue_work(pm_wq, &dev->power=
.work),
>                                              -> vop do  __update_runtime_=
status(dev, RPM_SUSPENDED)
>                                                 -> do queue_work (pm_runt=
ime_work)
>                                                     ->  rpm_idle(iommu)
>                                                          -> rpm_suspend(i=
ommu)
>                                                             -> do callbac=
k( rk_iommu_suspend)
>                                                                 -> do cal=
lback (genpd_power_off)
>                                                                     -> li=
st_for_each_entry(pdd, &genpd->dev_list, list_node), ff900000.vop: suspende=
d=EF=BC=8C ff903f00.iommu : suspending=EF=BC=8Cso not_suspended =3D 1; do _=
genpd_power_off, Really turn off PD=E3=80=82
>                                                                         -=
> iommu do  __update_runtime_status(dev, RPM_SUSPENDED)
>

[...]

Kind regards
Uffe
