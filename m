Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5DC45F536
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKZTfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 14:35:24 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46025 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhKZTdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 14:33:24 -0500
Received: by mail-ot1-f43.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso15252020otf.12;
        Fri, 26 Nov 2021 11:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0Ds7jWfKymmq417H8ZAqR46BLCCsJEqfr+3f1b84Y0=;
        b=dCuY87a10JjYtW8PIdU3kou/VjBg5+xpOCUxrsnwa8Xf/zX/gluvqCXpZ1QlvCcKRi
         wKsKzZm47oB0t2Acpn5o2K1S43fW2IbPRYYcPYBPG5VrHxZ+GzKgVa+UsEwTsKy3sht4
         mBhxlxrP+t2KiJssprCCyXEqR1EP4Ej3aUkmY5646AuXS4++kYvibEF+OhRgEZUQ9ui5
         0kANv0TkbLABd5ODfvX8+1ghRZ8S0SrhKJNo5ovTzfgBFTD6c/ZwCDX9pQR1mKOwAl6O
         wrp3VXDPY+lrOBX2y9cJgUFozsde5G8/tVkhEzGc+6qT2iZazS3teMtv31a1O1t359Fu
         LCpw==
X-Gm-Message-State: AOAM533AK9hUBvUnKuDPE1ormLxWMOU1WqfLQHiL2PGrSV24tDLnCeSd
        Ya/iMMjOptVNTSgFMgThbWE6V03CgdKP2+ol1lI=
X-Google-Smtp-Source: ABdhPJy/OnHHxYJcyA4pvtVU62Jn57J07ierdEuYoO4nzllyf/tL7K4g963mQLlcAd5k78q6PTvqlx+QUT9m3Ighf0E=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr30253933otu.254.1637955010619;
 Fri, 26 Nov 2021 11:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org> <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com> <CAAYoRsXLTYKGK_doqDqgerQ+uW3UhMYki7FfBy3cAhbfXiCrXA@mail.gmail.com>
In-Reply-To: <CAAYoRsXLTYKGK_doqDqgerQ+uW3UhMYki7FfBy3cAhbfXiCrXA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Nov 2021 20:29:58 +0100
Message-ID: <CAJZ5v0hDa4dmEJD0EYnOzfDBNC-GU99DM_d7bsTCCoSaP-o3CA@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 8:10 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Fri, Nov 26, 2021 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Hi Doug,
> >
> > On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
> > >
> > > Hi Daniel,
> > >
> > > This patch introduces a regression, at least on my test system.
> > > I can no longer change CPU frequency scaling drivers, for example
> > > from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
> > > (A.K.A. active mode). The task just hangs forever.
> > >
> > > I bisected the kernel and got this commit as the result.
> > > As a double check, I reverted this commit:
> > > 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
> > > on kernel 5.16-rc2 and the issue was resolved.
> > >
> > > While your email is fairly old, I observe that it was only included as of
> > > kernel 5.16-rc1.
> > >
> > > Command Example that never completes:
> > >
> > > $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
> > >
> > > syslog excerpt attached.
> >
> > This looks like it may be problematic:
> >
> > diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> > index f6076de39540..98841524a782 100644
> > --- a/drivers/powercap/dtpm_cpu.c
> > +++ b/drivers/powercap/dtpm_cpu.c
> > @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> >        return ret;
> > }
> >
> > -int dtpm_register_cpu(struct dtpm *parent)
> > +static int __init dtpm_cpu_init(void)
> > {
> >        int ret;
> >
> > so please try to remove the __init annotation from dtpm_cpu_init() and
> > see if that helps.
>
> Hi Rafael,
>
> That did not fix the issue.
> Just to be clear this is what I did, on top of 5.16-rc2:
>
> $ git diff
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index b740866b228d..26d1a87bdec6 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -231,7 +231,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>         return ret;
>  }
>
> -static int __init dtpm_cpu_init(void)
> +static int dtpm_cpu_init(void)
>  {
>         int ret;

OK

This needs to be fixed or we'll need to revert commit
7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c for 5.16.
