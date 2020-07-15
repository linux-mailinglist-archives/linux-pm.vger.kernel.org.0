Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91122055B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGOGq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgGOGq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:46:56 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF219C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:46:55 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q3so1049900ilt.8
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ia+M7c1s6u4QzvRmg9F+yYUkSaBCxJOCiZePFvIuDVc=;
        b=D+l25n5bcv1TSbCDuyiTk2BK9pkdINNUwW67aGOacRlIyk0ySLjsGWzDcPBj31btQV
         uDr2HcZeXtm3d3NwwZOa3vRzLezh5c0YssPAMkbS4z+ueh4VLm6jhtIsezInCY+VOLYl
         BWZMjKveeau7A9dBxlUHol1MsZAX4gMmGiQ22HEQSAMHuE1v8qFSSyrhqJ/IvSH0bD1O
         mBebeftKbgCJRjoXd4nqNPwbuhndA7VOSBCMd+m7SUzXm4ERmEfKnrRO9kPL69Dl3KM4
         KsO97+80nmLk1lFqu5rINAAxsAApi+EPfJlcn8P3YWd2UyctKlIKgf7jwSTcD25f0bRS
         0frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ia+M7c1s6u4QzvRmg9F+yYUkSaBCxJOCiZePFvIuDVc=;
        b=QODF9R31n4A5LmYD6zyhMPdR60swxUsdMy5UXzMVCNX32YpuP+AsJs1Uv8F0z271lH
         m5ci2nCJTLjHG5SojAh5PW8zvtR7BlrrgjFeQwo5r/PDgFzGFZFBmTEis9S2Dwg1Z3Ee
         mQp7vwctw9YVNV6G04ZmFTBwiZnJKIiMvagW7QyZe/MGFJPCW6C8OXdawjzGV/2l56s1
         xIOXqEqSSvC6hhmJqYlfeKU96ruhkh8Qgr+M/Y20ga3E+CUVC/d+VuAvLBC125dl2OlY
         Y+iJNSzAKyjSsQExMUKBSfx5BQ96BMaGWpuOtyCUUGfZ6ZJkQy2JTU6ctEeDePTpfuig
         uhxg==
X-Gm-Message-State: AOAM533i3376392VwULl7MXPe6O1SUWXoCpkTbCd05qb0scxpezL0wz4
        4w9mTU1ibMq/2kmHb29kA2ABF672FjUiB4aRUbBdBQ==
X-Google-Smtp-Source: ABdhPJyNtTQ6tjiuB0fOsiGMKDn204hJD42fgcPc/S+ZwIlU4lbiCn47FJ7HiWLEM0DrOPmZUmzgdMVyttDg+xz5UnM=
X-Received: by 2002:a92:49c3:: with SMTP id k64mr7793042ilg.278.1594795615165;
 Tue, 14 Jul 2020 23:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org> <CAOesGMjCZMyWLe+tpNFstC88odeSCKS8bM6Oj9cpaj6j7U94rQ@mail.gmail.com>
 <20200715063311.GP1398296@dell>
In-Reply-To: <20200715063311.GP1398296@dell>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 14 Jul 2020 23:46:44 -0700
Message-ID: <CAOesGMjnyq7iRQBopBQ2Dn7ziNGo4cjdKhceL0=gxrt1MuZY1g@mail.gmail.com>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 11:33 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 14 Jul 2020, Olof Johansson wrote:
>
> > On Tue, Jul 14, 2020 at 7:50 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > If function callers and providers do not share the same prototypes th=
e
> > > compiler complains of missing prototypes.  Fix this by moving the
> > > already existing prototypes out to a mutually convenient location.
> > >
> > > Fixes the following W=3D1 kernel build warning(s):
> > >
> > >  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototy=
pe for =E2=80=98check_astate=E2=80=99 [-Wmissing-prototypes]
> > >  109 | int check_astate(void)
> > >  | ^~~~~~~~~~~~
> > >  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototy=
pe for =E2=80=98restore_astate=E2=80=99 [-Wmissing-prototypes]
> > >  114 | void restore_astate(int cpu)
> > >  | ^~~~~~~~~~~~~~
> > >
> > > Cc: Olof Johansson <olof@lixom.net>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
> > >  arch/powerpc/platforms/pasemi/powersave.S |  2 ++
> > >  drivers/cpufreq/pasemi-cpufreq.c          |  1 +
> > >  include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++=
++
> > >  4 files changed, 31 insertions(+), 15 deletions(-)
> > >  create mode 100644 include/linux/platform_data/pasemi.h
> > >
> > > diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/pl=
atforms/pasemi/pasemi.h
> > > index 70b56048ed1be..528d81ef748ad 100644
> > > --- a/arch/powerpc/platforms/pasemi/pasemi.h
> > > +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> > > @@ -15,21 +15,6 @@ extern void __init pasemi_map_registers(void);
> > >  extern void idle_spin(void);
> > >  extern void idle_doze(void);
> > >
> > > -/* Restore astate to last set */
> > > -#ifdef CONFIG_PPC_PASEMI_CPUFREQ
> > > -extern int check_astate(void);
> > > -extern void restore_astate(int cpu);
> > > -#else
> > > -static inline int check_astate(void)
> > > -{
> > > -       /* Always return >0 so we never power save */
> > > -       return 1;
> > > -}
> > > -static inline void restore_astate(int cpu)
> > > -{
> > > -}
> > > -#endif
> > > -
> > >  extern struct pci_controller_ops pasemi_pci_controller_ops;
> > >
> > >  #endif /* _PASEMI_PASEMI_H */
> > > diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc=
/platforms/pasemi/powersave.S
> > > index d0215d5329ca7..7747b48963286 100644
> > > --- a/arch/powerpc/platforms/pasemi/powersave.S
> > > +++ b/arch/powerpc/platforms/pasemi/powersave.S
> > > @@ -5,6 +5,8 @@
> > >   * Maintained by: Olof Johansson <olof@lixom.net>
> > >   */
> > >
> > > +#include <linux/platform_data/pasemi.h>
> > > +
> > >  #include <asm/processor.h>
> > >  #include <asm/page.h>
> > >  #include <asm/ppc_asm.h>
> > > diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasem=
i-cpufreq.c
> > > index c66f566a854cb..c6bb3ecc90ef3 100644
> > > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/timer.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of_address.h>
> > > +#include <linux/platform_data/pasemi.h>
> > >
> > >  #include <asm/hw_irq.h>
> > >  #include <asm/io.h>
> > > diff --git a/include/linux/platform_data/pasemi.h b/include/linux/pla=
tform_data/pasemi.h
> > > new file mode 100644
> > > index 0000000000000..3fed0687fcc9a
> > > --- /dev/null
> > > +++ b/include/linux/platform_data/pasemi.h
> > > @@ -0,0 +1,28 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020 Linaro Ltd.
> > > + *
> > > + * Author: Lee Jones <lee.jones@linaro.org>
> > > + */
> >
> > Absolutely not. It's neither your copyright, nor your authorship.
>
> The file was new.  Anyway, the point is now moot.

The contents was copied and pasted from other material, not originally
produced by you.

I suggest you consult with Linaro lawyers on how to handle this if you
have to do something like it in the future.


-Olof
