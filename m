Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F37220642
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgGOHdL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOHdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 03:33:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD2BC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:33:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so1349806wrw.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wmbKlH24uvS6PFbXX3LEAN6VBDJeDWBV7/Mc/Rg+Ty0=;
        b=XLfbeliQBIxfzuEdJ6BSJN0hTG5AH+Aps/ocThG1hmBXHOwiBv45/K/zlKEuf1FVGq
         pF1HSnrGly3PhOw2wqEuut+AP/2ABNiXyggcJ8kw6Jx1tqbL5UtDS2MJ48ewoqiLF/wo
         Y9IL+MpB5iy9hwA/cmHZP4PAzZBnCzMQcy4Qafg+NNzv2oog5elXkFBWQXXnj0kdqd7H
         k1/v3yGQBi0W8YHQtFhPYH5XbXxJyJzWNojpzTYGqkF/8Lkqqs5jGMd39PtNdoJx7LAb
         d4g3LSArT8GxnVpNKJYmmHQ/HNyaHNhbJ4wvGjujosza+LaHlG1FIksuYvHoL+9r9BMy
         R4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wmbKlH24uvS6PFbXX3LEAN6VBDJeDWBV7/Mc/Rg+Ty0=;
        b=hM091SKSvO7aEki+ShPx5ILMjs/Q5rxIkZVDYBOV96UAQKZoViWJHwiQVx7PEISrot
         9WTknaHfLcrx4A1/2Tywjhdpc8mX2smd1z9ezlVl5Ac8puQ4bklDDandh+MD7v9cKKfc
         W6LOYRIp7sF25clgIa21zE9ds8Bu+2SPxRmPsOlaMK+3ECXwXsmMw1UGR0oe4/ETRITj
         xkyhC7dZ7VpPsEhVzuMwdPO1R+AyjTCpJRDsVpxYDe9eQHwMcgkxpm4QAvnz/tfV0dHE
         D69YA1dBfSC6eROWAQBMMFIEPfKFYl5n46gd990laF80jQA6XGaPE4Udi5PdNpRlw0ge
         8dyA==
X-Gm-Message-State: AOAM530pMsMVpDa57F1WtJqb9F5QcXi075XxO+T87V2zTtuhSTFv+frc
        1/vKNvTUTEbKVN9I9r3qMX2BjZiSq6s=
X-Google-Smtp-Source: ABdhPJx/db+3VnXHf7RP7JypvYwr4I9OcFDVh94EnRiCQpX8HDA6f6Aeq7Q8V2SEw5anyKtMc+TKsQ==
X-Received: by 2002:adf:a111:: with SMTP id o17mr9606713wro.257.1594798388100;
        Wed, 15 Jul 2020 00:33:08 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id c194sm2143003wme.8.2020.07.15.00.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:33:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:33:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715073305.GY1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <CAOesGMjCZMyWLe+tpNFstC88odeSCKS8bM6Oj9cpaj6j7U94rQ@mail.gmail.com>
 <20200715063311.GP1398296@dell>
 <CAOesGMjnyq7iRQBopBQ2Dn7ziNGo4cjdKhceL0=gxrt1MuZY1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMjnyq7iRQBopBQ2Dn7ziNGo4cjdKhceL0=gxrt1MuZY1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Olof Johansson wrote:

> On Tue, Jul 14, 2020 at 11:33 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 14 Jul 2020, Olof Johansson wrote:
> >
> > > On Tue, Jul 14, 2020 at 7:50 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > If function callers and providers do not share the same prototypes the
> > > > compiler complains of missing prototypes.  Fix this by moving the
> > > > already existing prototypes out to a mutually convenient location.
> > > >
> > > > Fixes the following W=1 kernel build warning(s):
> > > >
> > > >  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
> > > >  109 | int check_astate(void)
> > > >  | ^~~~~~~~~~~~
> > > >  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
> > > >  114 | void restore_astate(int cpu)
> > > >  | ^~~~~~~~~~~~~~
> > > >
> > > > Cc: Olof Johansson <olof@lixom.net>
> > > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > Cc: Paul Mackerras <paulus@samba.org>
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
> > > >  arch/powerpc/platforms/pasemi/powersave.S |  2 ++
> > > >  drivers/cpufreq/pasemi-cpufreq.c          |  1 +
> > > >  include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++++
> > > >  4 files changed, 31 insertions(+), 15 deletions(-)
> > > >  create mode 100644 include/linux/platform_data/pasemi.h
> > > >
> > > > diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
> > > > index 70b56048ed1be..528d81ef748ad 100644
> > > > --- a/arch/powerpc/platforms/pasemi/pasemi.h
> > > > +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> > > > @@ -15,21 +15,6 @@ extern void __init pasemi_map_registers(void);
> > > >  extern void idle_spin(void);
> > > >  extern void idle_doze(void);
> > > >
> > > > -/* Restore astate to last set */
> > > > -#ifdef CONFIG_PPC_PASEMI_CPUFREQ
> > > > -extern int check_astate(void);
> > > > -extern void restore_astate(int cpu);
> > > > -#else
> > > > -static inline int check_astate(void)
> > > > -{
> > > > -       /* Always return >0 so we never power save */
> > > > -       return 1;
> > > > -}
> > > > -static inline void restore_astate(int cpu)
> > > > -{
> > > > -}
> > > > -#endif
> > > > -
> > > >  extern struct pci_controller_ops pasemi_pci_controller_ops;
> > > >
> > > >  #endif /* _PASEMI_PASEMI_H */
> > > > diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/platforms/pasemi/powersave.S
> > > > index d0215d5329ca7..7747b48963286 100644
> > > > --- a/arch/powerpc/platforms/pasemi/powersave.S
> > > > +++ b/arch/powerpc/platforms/pasemi/powersave.S
> > > > @@ -5,6 +5,8 @@
> > > >   * Maintained by: Olof Johansson <olof@lixom.net>
> > > >   */
> > > >
> > > > +#include <linux/platform_data/pasemi.h>
> > > > +
> > > >  #include <asm/processor.h>
> > > >  #include <asm/page.h>
> > > >  #include <asm/ppc_asm.h>
> > > > diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> > > > index c66f566a854cb..c6bb3ecc90ef3 100644
> > > > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > > > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/timer.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_address.h>
> > > > +#include <linux/platform_data/pasemi.h>
> > > >
> > > >  #include <asm/hw_irq.h>
> > > >  #include <asm/io.h>
> > > > diff --git a/include/linux/platform_data/pasemi.h b/include/linux/platform_data/pasemi.h
> > > > new file mode 100644
> > > > index 0000000000000..3fed0687fcc9a
> > > > --- /dev/null
> > > > +++ b/include/linux/platform_data/pasemi.h
> > > > @@ -0,0 +1,28 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (C) 2020 Linaro Ltd.
> > > > + *
> > > > + * Author: Lee Jones <lee.jones@linaro.org>
> > > > + */
> > >
> > > Absolutely not. It's neither your copyright, nor your authorship.
> >
> > The file was new.  Anyway, the point is now moot.
> 
> The contents was copied and pasted from other material, not originally
> produced by you.
> 
> I suggest you consult with Linaro lawyers on how to handle this if you
> have to do something like it in the future.

Very well.  Thanks for the heads-up.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
