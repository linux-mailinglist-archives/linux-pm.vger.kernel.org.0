Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A4A195D3C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 18:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0R41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 13:56:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45787 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0R41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 13:56:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so11126533ljc.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2020 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XJ2lQP0L57szcIAapEMR6VNQIKCSdKLAQyLg27/wjk=;
        b=sakGwuM/GdjgxKI2AGd28p9S/IME7y/sCz13stu0h8IWyWad4IpKBpQxSQ+b+N9EBb
         jtpIWt3bwUouljneSCzLa08hg96BqRyQl+Ydi00AuH8IvRtGjUEbeDne2MK9YSw8Pdkz
         OC4SecEImyHq16xiTYVSIV7ySiv/iJacTGl6lLuLMz9Wi5gOgqoB7bgaWLgOfIVkzmwa
         FBRA2fBY0ygUsd5B6qrPsBMSNdGHiA7oHt3CFtjS8Uhiuq7Y9l8+E7sKXjrnTxupDIFl
         z1O8Hy4NFDXBnXF5Ab7XdPt1/uwQFRMUbfk69pvyN/cf5l4INs/0ODjwmxWFCGKmuLXO
         Zt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XJ2lQP0L57szcIAapEMR6VNQIKCSdKLAQyLg27/wjk=;
        b=hLA+EPJRFonVtAJVU1mua9Xd6wNue3oeFRVFqxBEFs1pKJtR7mm6COVBPS+AyeZ1AQ
         WyPPtrVdkfq2CIQ5/o8jcakhR5PypvSkNrzyVSb3O68ZlvPJ2jJ/NEtRl0ueCKyX4Uar
         /Eddj5T0CjCgEiqxY9b+rjQ+MAlfmKJy0hLsUdZnLfubTutF93lLxS4vT3/12MLbO16z
         P6wp5x+vlU+lwrdnMXz5yKqvCJEhZnyEFsU6EPviaFEeZugTp10NRZJNhvOvI0wlJATR
         aDfhowo/XWxaBF0a12lCGTtW5eWbSaGSjbeQepGfbqndZnJk5tIvkZx0T+PLhLWXyBIu
         kvJw==
X-Gm-Message-State: AGi0Pubo5Raa/uUSmfmEKHNNhvsNBxZKqqScoIpWcXag8sEzsZC+R1Fk
        oyIGkui6NURW/KslltPM+s0FTlQX44yWuCTipazx3w==
X-Google-Smtp-Source: APiQypI+St/TLugxs8HDkgbOKp8wyBAPN5zl90AWgAhsEWY/AicEjEmZzv4UQ/6dyuK7UuoP0iHnFQ3hXtSjiJTj1sQ=
X-Received: by 2002:a2e:a495:: with SMTP id h21mr78247lji.123.1585331784702;
 Fri, 27 Mar 2020 10:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com> <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 27 Mar 2020 23:26:13 +0530
Message-ID: <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        fntoth@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The kernel warning noticed on arm64 juno-r2 device running linux
next-20200326 and next-20200327

[   36.077086] ------------[ cut here ]------------
[   36.081752] amba 20010000.etf: deferred probe timeout, ignoring dependency
[   36.081859] WARNING: CPU: 1 PID: 42 at drivers/base/dd.c:270
driver_deferred_probe_check_state+0x54/0x80
[   36.098242] Modules linked in: fuse
[   36.101753] CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted
5.6.0-rc7-next-20200327 #1
[   36.109427] Hardware name: ARM Juno development board (r2) (DT)
[   36.115372] Workqueue: events amba_deferred_retry_func
[   36.120526] pstate: 60000005 (nZCv daif -PAN -UAO)
[   36.125334] pc : driver_deferred_probe_check_state+0x54/0x80
[   36.131010] lr : driver_deferred_probe_check_state+0x54/0x80
[   36.136680] sp : ffff000934e0fae0
[   36.140001] x29: ffff000934e0fae0 x28: ffff000934db5608
[   36.145337] x27: ffffa00013c63240 x26: ffff000934f2a800
[   36.150668] x25: 0000000000000001 x24: fffffffffffffffe
[   36.155996] x23: ffff000934c6ab80 x22: ffffa00011b39ea0
[   36.161322] x21: ffff000934f2a800 x20: ffffa00011905fe0
[   36.166649] x19: ffff000934f2a800 x18: 0000000000000000
[   36.171974] x17: 0000000000000000 x16: 0000000000000000
[   36.177299] x15: 0000000000000000 x14: 003d090000000000
[   36.182625] x13: 00003d0900000000 x12: ffff9400027ef445
[   36.187952] x11: 1ffff400027ef444 x10: ffff9400027ef444
[   36.193278] x9 : dfffa00000000000 x8 : 0000000000000000
[   36.198603] x7 : 0000000000000001 x6 : ffffa00013f7a220
[   36.203929] x5 : 0000000000000004 x4 : dfffa00000000000
[   36.209255] x3 : ffffa000101a74ec x2 : ffff8001269c1f26
[   36.214581] x1 : da1107b7b6a8fb00 x0 : 0000000000000000
[   36.219906] Call trace:
[   36.222369]  driver_deferred_probe_check_state+0x54/0x80
[   36.227698]  __genpd_dev_pm_attach+0x264/0x2a0
[   36.232154]  genpd_dev_pm_attach+0x68/0x78
[   36.236265]  dev_pm_domain_attach+0x6c/0x70
[   36.240463]  amba_device_try_add+0xec/0x3f8
[   36.244659]  amba_deferred_retry_func+0x84/0x158
[   36.249301]  process_one_work+0x3f0/0x660
[   36.253326]  worker_thread+0x74/0x698
[   36.256997]  kthread+0x218/0x220
[   36.260236]  ret_from_fork+0x10/0x1c
[   36.263819] ---[ end trace c637c10e549bd716 ]---#

Full test log,
https://lkft.validation.linaro.org/scheduler/job/1317079#L981

On Tue, 24 Mar 2020 at 18:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There is a place in the code where open-coded version of list entry accessors
> > list_last_entry() is used.
> >
> > Replace that with the standard macro.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> > ---
> > v2: no change
> >  drivers/base/dd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index efd0e4c16ba5..27a4d51b5bba 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -1226,7 +1226,7 @@ void driver_detach(struct device_driver *drv)
> >                         spin_unlock(&drv->p->klist_devices.k_lock);
> >                         break;
> >                 }
> > -               dev_prv = list_entry(drv->p->klist_devices.k_list.prev,
> > +               dev_prv = list_last_entry(&drv->p->klist_devices.k_list,
> >                                      struct device_private,
> >                                      knode_driver.n_node);
> >                 dev = dev_prv->device;

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git describe: next-20200327
  kernel-config:
https://builds.tuxbuild.com/nqmmxorUbC1qTWp42iEKjQ/kernel.config


-- 
Linaro LKFT
https://lkft.linaro.org
