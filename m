Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F77220503
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGOGdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOGdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:33:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7AC061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:33:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so1195608wrw.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y2qcTFRplfCRbFvrbAjUi/DYmcVFTMj5+qY7L5YUn3g=;
        b=h4/iE3yxYK2RYq6qpnojpD6+UR6MvFYLI+m+LMjY3IiZ31k0422hJntIJgNyudY6Mr
         +2mRz6PdJyKG6sp16kW8JHuEkSyk5dn7gJs4yHaPj57fCMkHuPWy64zn/JjB60ShP5RO
         YXsTdIYy4WCBuE9kcKFwRmmZSFvlM/ZeJ0pYS1hQ+DkU8ESol734oWaCOXrxrY0xOoSt
         lBHGH9st9rHW7LnOtIxDPj4SGE8xhb296UajDEpMqg2BzcVlbtwrLSaS9UfJIcHy3o8G
         xSRKrtE5qXquE8ZoHoa5tZabj1UUClxA5eqa7A/bS0PUWsBcjzvy5Cm1+s5grty0Ieh/
         M4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y2qcTFRplfCRbFvrbAjUi/DYmcVFTMj5+qY7L5YUn3g=;
        b=STIqMefNmyCqm5bB6KElNLd3p31P+axCkbsZLSUOnGM++KrCs1nQwQOTGT6m2pkQrL
         FyKF46Rz7w6nHZr39zL3cbNGKYZyA3mHbnoQxsrgqu9lgwwnaBbKzjtn3MA4nj/+zsrN
         JVLfv1Djni1V9VMGYznULwvO5UzjmV0kHQTk/KaeiWLACjNQWjEDLSolU3FBMJ3Rmvve
         bfq3gzTFQCAYAzFZz2GqqClPP8rPS2RH095XGdRtPbBQppWythiI+3szWz0fXyyFYN8K
         am9g8nr18DOKJcX5cXTB5ZEK1lKJhzoSOhkolaMJ3ZilyOb77SAqbjEsyTM4uw0a2YAc
         CKDA==
X-Gm-Message-State: AOAM53040I7oJURVJrR02vTSvCOerGKV9/xXbfkqDFqmVKi8QMe6U74a
        f8WhSGSUhnduFvrDnr0gomK+0Q==
X-Google-Smtp-Source: ABdhPJxgAooVf8n6ZWE9GYzvdRZD0S2ak/Kw75UBc2D120epcdLLt5p8ihYwrvyL1wj8a8x4nZJYXQ==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr10310242wrw.29.1594794793952;
        Tue, 14 Jul 2020 23:33:13 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id o21sm1868151wmh.18.2020.07.14.23.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:33:13 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:33:11 +0100
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
Message-ID: <20200715063311.GP1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <CAOesGMjCZMyWLe+tpNFstC88odeSCKS8bM6Oj9cpaj6j7U94rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMjCZMyWLe+tpNFstC88odeSCKS8bM6Oj9cpaj6j7U94rQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Olof Johansson wrote:

> On Tue, Jul 14, 2020 at 7:50 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > If function callers and providers do not share the same prototypes the
> > compiler complains of missing prototypes.  Fix this by moving the
> > already existing prototypes out to a mutually convenient location.
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
> >  109 | int check_astate(void)
> >  | ^~~~~~~~~~~~
> >  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
> >  114 | void restore_astate(int cpu)
> >  | ^~~~~~~~~~~~~~
> >
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
> >  arch/powerpc/platforms/pasemi/powersave.S |  2 ++
> >  drivers/cpufreq/pasemi-cpufreq.c          |  1 +
> >  include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++++
> >  4 files changed, 31 insertions(+), 15 deletions(-)
> >  create mode 100644 include/linux/platform_data/pasemi.h
> >
> > diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
> > index 70b56048ed1be..528d81ef748ad 100644
> > --- a/arch/powerpc/platforms/pasemi/pasemi.h
> > +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> > @@ -15,21 +15,6 @@ extern void __init pasemi_map_registers(void);
> >  extern void idle_spin(void);
> >  extern void idle_doze(void);
> >
> > -/* Restore astate to last set */
> > -#ifdef CONFIG_PPC_PASEMI_CPUFREQ
> > -extern int check_astate(void);
> > -extern void restore_astate(int cpu);
> > -#else
> > -static inline int check_astate(void)
> > -{
> > -       /* Always return >0 so we never power save */
> > -       return 1;
> > -}
> > -static inline void restore_astate(int cpu)
> > -{
> > -}
> > -#endif
> > -
> >  extern struct pci_controller_ops pasemi_pci_controller_ops;
> >
> >  #endif /* _PASEMI_PASEMI_H */
> > diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/platforms/pasemi/powersave.S
> > index d0215d5329ca7..7747b48963286 100644
> > --- a/arch/powerpc/platforms/pasemi/powersave.S
> > +++ b/arch/powerpc/platforms/pasemi/powersave.S
> > @@ -5,6 +5,8 @@
> >   * Maintained by: Olof Johansson <olof@lixom.net>
> >   */
> >
> > +#include <linux/platform_data/pasemi.h>
> > +
> >  #include <asm/processor.h>
> >  #include <asm/page.h>
> >  #include <asm/ppc_asm.h>
> > diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> > index c66f566a854cb..c6bb3ecc90ef3 100644
> > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/timer.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> > +#include <linux/platform_data/pasemi.h>
> >
> >  #include <asm/hw_irq.h>
> >  #include <asm/io.h>
> > diff --git a/include/linux/platform_data/pasemi.h b/include/linux/platform_data/pasemi.h
> > new file mode 100644
> > index 0000000000000..3fed0687fcc9a
> > --- /dev/null
> > +++ b/include/linux/platform_data/pasemi.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020 Linaro Ltd.
> > + *
> > + * Author: Lee Jones <lee.jones@linaro.org>
> > + */
> 
> Absolutely not. It's neither your copyright, nor your authorship.

The file was new.  Anyway, the point is now moot.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
