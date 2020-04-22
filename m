Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9610B1B4301
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDVLTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbgDVLTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 07:19:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BBC03C1A8;
        Wed, 22 Apr 2020 04:19:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t63so1862460wmt.3;
        Wed, 22 Apr 2020 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7/BLLLzInoLEb37soX3+1vL3RtGn9XG8RZCsed4AJ9c=;
        b=oUTgC1unxTNGrkAobClJd3vMl93zNO/UG9sew82P03MXYQ4rmYgpS/jNEsC8/IjsuO
         LkKguB7oNb4bGuTbzHBllpAhxn3+63mBROzFkDPFBW+kT1G0tP4gyNo8cdaTDsyJdoRz
         Rpvd0p5lsQ9Wo2H36YDdR3vsGXrekUxZwtHvwSqhcvUXvEJu8Yz1vEKg0fyKdYVV6gZB
         0f5f8p0ivFh5QknqNKoQEwQ145mL54XRBY7vcwehMcHXs5cSknvRVZ8rQGqE9VH2wfaT
         Du8MAd7Kj49xguqMZ+USRzoE+6ptCYGK7N3NMIcD2I1f/nvJRe9sY8uISbgsCmfhyDdH
         wm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7/BLLLzInoLEb37soX3+1vL3RtGn9XG8RZCsed4AJ9c=;
        b=sfn+g8bbG+WwBYkYjJdF6AELohAr29ysotPjE5JFPnK8s9z9o46NEFsWYDMyKYFMAt
         3fWsrbjHrhdpgTAFWy49gyCcHwWBsojFo65/kh8RqRLSVNIWTS1EwhVyh/ofZVx0K7rY
         tNFj//mlkbQg8a/jPdf3BFag+ED4XOrZ1GvCARU72OJS0Fb0YD5WOPcS3AyxkKD+ZFCr
         ZKJbeJo6LjK3e/L+4NBnWXp8Zc21L9Wq1LIIJZo4+c/0Wg+ebZkyfHjBSVTgof33YuJB
         /yp8q+zuMs4dgzU/ERUWfv2YvnKmgldJWFJi2Eum1ftWhxLTy+/CZ701lUhYSZxJDs6I
         LATw==
X-Gm-Message-State: AGi0PuagiZsUuCCXFjiuTWejvi+dCZp/7O+aFd1mv/5yBxRcHxI0R/Bi
        addPnxNY3vF+WZUMDO8/4kmLf1WtiOIaGFrZHq0=
X-Google-Smtp-Source: APiQypIQ+Vy+uvK/1QosWrOTLYLYcq7DWz9hj//AA2zDdrxKxVawab0mF8LGoNDzB3sMob8o/y+VOvU1EptwDlX+9UE=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr9591767wmj.3.1587554361895;
 Wed, 22 Apr 2020 04:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200422051529.30757-1-zhang.lyra@gmail.com> <CAJZ5v0ikL3avFomZVqtBhfEjeauN-5ZUm9kZwzG=Vo+Ks0AiyA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ikL3avFomZVqtBhfEjeauN-5ZUm9kZwzG=Vo+Ks0AiyA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 22 Apr 2020 19:18:45 +0800
Message-ID: <CAAfSe-sVEEPOrq_ZzB1z59uXTfhmNh=+U_QvgaTcd4U1=9Tfvg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: call devfreq_suspend/resume and
 cpufreq_suspend/resume in pairs.
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Wang <vincent.wang@unisoc.com>,
        Samer Xie <samer.xie@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

(Behalf Of Vincent Wang)

Thanks for your comments, please see my answers below.

On Wed, 22 Apr 2020 at 17:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Apr 22, 2020 at 7:15 AM Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
> >
> > From: Vincent Wang <vincent.wang@unisoc.com>
> >
> > If dpm_prepare() fails in dpm_suspend_start(), dpm_suspend() can't be
> > called.
>
> That's correct.
>
> > And then, devfreq_suspend() and cpufreq_suspend() will not be
> > called in the suspend flow.
>
> Right.
>
> > But in the resiume flow, devfreq_resume() and cpufreq_resume() will
> > be called.
>
> Right, and they are expected to cope with the situation.
>
> > This patch will ensure that devfreq_suspend/devfreq_resume and
> > cpufreq_suspend/cpufreq_resume are called in pairs.
>
> So why is it better to do this than to make devfreq_resume() meet the
> expectations?

Yes=EF=BC=8Cwe found an issue with cpufreq schedutil governor on kernel4.14=
,
and I think the issue should haven't been changed on the latest
version of kernel.

In the function dpm_suspend_start(), dpm_suspend() would not be
exceuted if return error from device_prepare() [1]. So
cpufreq_cpufreq() will not be called, then
cpufreq_remove_update_util_hook() will not be called either, and so
cpufreq_update_util_data will not be NULL.

In the dpm resume flow, sugov_start() will be called, in which
sg_cpu.update_util will be set to 0.

And since cpufreq_update_util_data is not NULL, data->func will not be
set and is still NULL which actually is sg_cpu.update_util.

void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
                        void (*func)(struct update_util_data *data, u64 tim=
e,
                                     unsigned int flags))
{
[...]
        if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
                return;

        data->func =3D func;
[...]
}

When cpufreq_update_util() is called by scheduler, there will be a
NULL pointer issue.


[1] https://elixir.bootlin.com/linux/v5.7-rc1/source/drivers/base/power/mai=
n.c#L2052


>
> > Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
> > Signed-off-by: Samer Xie <samer.xie@unisoc.com>
> > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >  drivers/base/power/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index fdd508a78ffd..eb3d987d43e0 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1866,9 +1866,6 @@ int dpm_suspend(pm_message_t state)
> >         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> >         might_sleep();
> >
> > -       devfreq_suspend();
> > -       cpufreq_suspend();
> > -
> >         mutex_lock(&dpm_list_mtx);
> >         pm_transition =3D state;
> >         async_error =3D 0;
> > @@ -1988,6 +1985,9 @@ int dpm_prepare(pm_message_t state)
> >         trace_suspend_resume(TPS("dpm_prepare"), state.event, true);
> >         might_sleep();
> >
> > +       devfreq_suspend();
> > +       cpufreq_suspend();
> > +
> >         /*
> >          * Give a chance for the known devices to complete their probes=
, before
> >          * disable probing of devices. This sync point is important at =
least
> > --
> > 2.20.1
> >
