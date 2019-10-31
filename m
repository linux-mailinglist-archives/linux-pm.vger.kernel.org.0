Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6AEB168
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJaNoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:44:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32815 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfJaNoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 09:44:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so2747118plk.0;
        Thu, 31 Oct 2019 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6y88ku+FJUdhUiHptjPqtjsXAaLtim+0IMiXfQe0l/c=;
        b=kClnC7uqlGiwNBff2eaN3FaYdxv5GrMNnthtVrwqhPlHJljqFTEXJZzuIjlRIGFBN/
         lTW2cRQwEnuymUIsC1BdAnKUkxXQlyy4qUGLW7H+21IDwluFVOgB2NBYsA1gM43Ze5ck
         7zva61eyFN0Cb5wlXmYqEG9a2FqWIAugG+kLwktpwJybmZ5u58mo2L0uxgWR+lhJu3rW
         m53QcaXYV/ii8xvRpfWiQh0ZB3JvMaaX/VrBEl31nuUHf76qYKJcmz+EdaoD9DbyDxV1
         dtfYhutD2qWJ9ab9JKfYi9gd0k7nqLLeYC66WMUS2jjCfrDf8hb1rhzZRuuqiulY6b5P
         yfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6y88ku+FJUdhUiHptjPqtjsXAaLtim+0IMiXfQe0l/c=;
        b=F/1Dd32oty7UkSzazJk2p0VTpZreLfTJmTChNKQEuKwNGaoSJi4NeC+4pOTxOj0OTQ
         iy58+Rh7QHZlkCLfVCAMhq2pRsTnEfnkGklII5snPCzI7dOgkV6+98bGdzQkPj+X/68V
         wC2GOonW5p63o8HWtJItyiOJ0iJLPru4IZHGdkef6EEsX8Bs4yWSJKWAaHlo/LYms8w+
         0OI4EMlcLya1ZWKfEp6wi/8p21zGIwGe5CNKeaqR4DSgut9VbD0VhKiUI4iktPYCtQfK
         p64dgErJDnIf6bCYH1p3fcdEM4b5aEez8aNsOonYWedna9DHDIvugKc71rU09TAJuKdz
         gDjg==
X-Gm-Message-State: APjAAAXydNFzHsqVJzaP1GPSR0PevgTkWrnjf60eABx0x136lYNGCKpN
        rknXJBjuEur9gdHlqkd1Gaow9Dbhw9bnFpA64SQ=
X-Google-Smtp-Source: APXvYqyrzR6XIZRktDipu31wJpoWbBpvOQtSu9Q2KrNNdkdWl4+Sjukv611CtJUqK2iIR07BYZ5EvACGUByZf7+Yg3M=
X-Received: by 2002:a17:902:7786:: with SMTP id o6mr6654785pll.109.1572529477869;
 Thu, 31 Oct 2019 06:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191029223214.18889-1-linux@roeck-us.net> <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
In-Reply-To: <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 31 Oct 2019 22:44:26 +0900
Message-ID: <CAC5umygHEcVJQskfX0Ef4Z5Ti5B1-zKbmvvAbPPi4YtcQsV-WA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B410=E6=9C=8831=E6=97=A5(=E6=9C=A8) 11:20 Guenter Roeck <linux@r=
oeck-us.net>:
>
> On 10/30/19 4:16 AM, Akinobu Mita wrote:
> > 2019=E5=B9=B410=E6=9C=8830=E6=97=A5(=E6=B0=B4) 7:32 Guenter Roeck <linu=
x@roeck-us.net>:
> >>
> >> nvme devices report temperature information in the controller informat=
ion
> >> (for limits) and in the smart log. Currently, the only means to retrie=
ve
> >> this information is the nvme command line interface, which requires
> >> super-user privileges.
> >>
> >> At the same time, it would be desirable to use NVME temperature inform=
ation
> >> for thermal control.
> >>
> >> This patch adds support to read NVME temperatures from the kernel usin=
g the
> >> hwmon API and adds temperature zones for NVME drives. The thermal subs=
ystem
> >> can use this information to set thermal policies, and userspace can ac=
cess
> >> it using libsensors and/or the "sensors" command.
> >>
> >> Example output from the "sensors" command:
> >>
> >> nvme0-pci-0100
> >> Adapter: PCI adapter
> >> Composite:    +39.0=C2=B0C  (high =3D +85.0=C2=B0C, crit =3D +85.0=C2=
=B0C)
> >> Sensor 1:     +39.0=C2=B0C
> >> Sensor 2:     +41.0=C2=B0C
> >>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >> v2: Use devm_kfree() to release memory in error path
> >>
> >>   drivers/nvme/host/Kconfig      |  10 ++
> >>   drivers/nvme/host/Makefile     |   1 +
> >>   drivers/nvme/host/core.c       |   5 +
> >>   drivers/nvme/host/nvme-hwmon.c | 163 +++++++++++++++++++++++++++++++=
++
> >>   drivers/nvme/host/nvme.h       |   8 ++
> >>   5 files changed, 187 insertions(+)
> >>   create mode 100644 drivers/nvme/host/nvme-hwmon.c
> >>
> >> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> >> index 2b36f052bfb9..aeb49e16e386 100644
> >> --- a/drivers/nvme/host/Kconfig
> >> +++ b/drivers/nvme/host/Kconfig
> >> @@ -23,6 +23,16 @@ config NVME_MULTIPATH
> >>             /dev/nvmeXnY device will show up for each NVMe namespaces,
> >>             even if it is accessible through multiple controllers.
> >>
> >> +config NVME_HWMON
> >> +       bool "NVME hardware monitoring"
> >> +       depends on (NVME_CORE=3Dy && HWMON=3Dy) || (NVME_CORE=3Dm && H=
WMON)
> >> +       help
> >> +         This provides support for NVME hardware monitoring. If enabl=
ed,
> >> +         a hardware monitoring device will be created for each NVME d=
rive
> >> +         in the system.
> >> +
> >> +         If unsure, say N.
> >> +
> >>   config NVME_FABRICS
> >>          tristate
> >>
> >> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> >> index 8a4b671c5f0c..03de4797a877 100644
> >> --- a/drivers/nvme/host/Makefile
> >> +++ b/drivers/nvme/host/Makefile
> >> @@ -14,6 +14,7 @@ nvme-core-$(CONFIG_TRACING)           +=3D trace.o
> >>   nvme-core-$(CONFIG_NVME_MULTIPATH)     +=3D multipath.o
> >>   nvme-core-$(CONFIG_NVM)                        +=3D lightnvm.o
> >>   nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)   +=3D fault_inject.o
> >> +nvme-core-$(CONFIG_NVME_HWMON)         +=3D nvme-hwmon.o
> >>
> >>   nvme-y                                 +=3D pci.o
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index fa7ba09dca77..fc1d4b146717 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -2796,6 +2796,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >>          ctrl->oncs =3D le16_to_cpu(id->oncs);
> >>          ctrl->mtfa =3D le16_to_cpu(id->mtfa);
> >>          ctrl->oaes =3D le32_to_cpu(id->oaes);
> >> +       ctrl->wctemp =3D le16_to_cpu(id->wctemp);
> >> +       ctrl->cctemp =3D le16_to_cpu(id->cctemp);
> >> +
> >>          atomic_set(&ctrl->abort_limit, id->acl + 1);
> >>          ctrl->vwc =3D id->vwc;
> >>          if (id->mdts)
> >> @@ -2897,6 +2900,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> >>
> >>          ctrl->identified =3D true;
> >>
> >> +       nvme_hwmon_init(ctrl);
> >> +
> >>          return 0;
> >>
> >>   out_free:
> >
> > The nvme_init_identify() can be called multiple time in nvme ctrl's
> > lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
> > should we need to prevent nvme_hwmon_init() from registering hwmon
> > device more than twice?
> >
> > In the nvme thermal zone patchset[1], thernal zone is registered in
> > nvme_init_identify and unregistered in nvme_stop_ctrl().
> >
>
> Doesn't that mean that the initialization should happen in nvme_start_ctr=
l()
> and not here ?

Seems possible.  But I would like to ask maintainers' opinion.
