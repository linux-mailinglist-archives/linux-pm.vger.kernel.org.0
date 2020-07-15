Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941782202E9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgGOD1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 23:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGOD1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 23:27:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D20C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:27:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l17so732008iok.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/6qvp5WHZj/oa9tsQs7daglYAIrSHRjqnbn4LJYVqYM=;
        b=ZEbB4gSyyVHw+IqRwjZPPSBGmJ1kW6qrI3GlqPzdjDUvIsbGFKVZ+/nKoDRVsb50DA
         xwru94gf4SU4rS8VnQlP4S8oo+/KGKnprsAgKDgnODbTRc1yV0SBjDlAL6hamUrpX7dg
         nEx9aWnWfqbkS4I82KGBsr1NbL5lrFwJwGnhQ+E1yC0BlfiSgYTF1a7DenrZ8qr2mPuh
         R4BQKmo4xnSbLNVEXs4GdOGxxkS6o2Xs7mjqBXcPRR2LMkuZUcCB9lzKL+kNAFm+L/1l
         cFRBkY5q26k0Lf4O5yj8NY0qaU/9G/8KOfklwi2xPEUDGOsg7HalAHkigm9R86E4PF1F
         GAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/6qvp5WHZj/oa9tsQs7daglYAIrSHRjqnbn4LJYVqYM=;
        b=A7X2fBEDMedUPtnmZrhTzKKDOKOr0SOIvBo/On2yWI/E3TKJVECCtVI4K7W9MYdhPP
         POUPCHnLe62L5jMUEPP3n4WTOf6SgTO7cFXlfzpqoiy6FsQ9yzXGp3itZMR5QJddOZKe
         ybuaNkIQwuWL9LTUdjHCZFvePqB1upUVzpXMPthnyc3iv+ZKbDrSJV+9sYxMOCl8wcpa
         s8/rPxnVLUqQrEmMgsRlV3szws7ezu9yN6h33gM1nHSxkNI3Z2vmxytAmIYU4DBweOtr
         j0eg6pQvLVh1FCphZ6/m2EoZyo4rtkMiYQ/4U7QfOIb8bxlJqDOgieS0Gd0kTTAsyQWA
         8Ytw==
X-Gm-Message-State: AOAM53056nmp1NHOYa6S2jqzDcHCy7mAuzuPMkjxpnmi49wrk7XtlPug
        y6/aTezl6F4+eSZvN70A0Y3WMrU7fPxb3sUoq4NAAQ==
X-Google-Smtp-Source: ABdhPJzxESu7ZTsM8aFjcJhDG3lJKuIu8Kw/lLhq4wzNp1GQnFoGez4u1gAOdT+YRS9L0Tnnx500tXibztageq3WwBw=
X-Received: by 2002:a6b:c80a:: with SMTP id y10mr8120079iof.67.1594783621833;
 Tue, 14 Jul 2020 20:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org> <20200714145049.2496163-6-lee.jones@linaro.org>
In-Reply-To: <20200714145049.2496163-6-lee.jones@linaro.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 14 Jul 2020 20:26:50 -0700
Message-ID: <CAOesGMjCZMyWLe+tpNFstC88odeSCKS8bM6Oj9cpaj6j7U94rQ@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 7:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> If function callers and providers do not share the same prototypes the
> compiler complains of missing prototypes.  Fix this by moving the
> already existing prototypes out to a mutually convenient location.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype f=
or =E2=80=98check_astate=E2=80=99 [-Wmissing-prototypes]
>  109 | int check_astate(void)
>  | ^~~~~~~~~~~~
>  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype f=
or =E2=80=98restore_astate=E2=80=99 [-Wmissing-prototypes]
>  114 | void restore_astate(int cpu)
>  | ^~~~~~~~~~~~~~
>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/powerpc/platforms/pasemi/pasemi.h    | 15 ------------
>  arch/powerpc/platforms/pasemi/powersave.S |  2 ++
>  drivers/cpufreq/pasemi-cpufreq.c          |  1 +
>  include/linux/platform_data/pasemi.h      | 28 +++++++++++++++++++++++
>  4 files changed, 31 insertions(+), 15 deletions(-)
>  create mode 100644 include/linux/platform_data/pasemi.h
>
> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platfo=
rms/pasemi/pasemi.h
> index 70b56048ed1be..528d81ef748ad 100644
> --- a/arch/powerpc/platforms/pasemi/pasemi.h
> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
> @@ -15,21 +15,6 @@ extern void __init pasemi_map_registers(void);
>  extern void idle_spin(void);
>  extern void idle_doze(void);
>
> -/* Restore astate to last set */
> -#ifdef CONFIG_PPC_PASEMI_CPUFREQ
> -extern int check_astate(void);
> -extern void restore_astate(int cpu);
> -#else
> -static inline int check_astate(void)
> -{
> -       /* Always return >0 so we never power save */
> -       return 1;
> -}
> -static inline void restore_astate(int cpu)
> -{
> -}
> -#endif
> -
>  extern struct pci_controller_ops pasemi_pci_controller_ops;
>
>  #endif /* _PASEMI_PASEMI_H */
> diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/pla=
tforms/pasemi/powersave.S
> index d0215d5329ca7..7747b48963286 100644
> --- a/arch/powerpc/platforms/pasemi/powersave.S
> +++ b/arch/powerpc/platforms/pasemi/powersave.S
> @@ -5,6 +5,8 @@
>   * Maintained by: Olof Johansson <olof@lixom.net>
>   */
>
> +#include <linux/platform_data/pasemi.h>
> +
>  #include <asm/processor.h>
>  #include <asm/page.h>
>  #include <asm/ppc_asm.h>
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cp=
ufreq.c
> index c66f566a854cb..c6bb3ecc90ef3 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -15,6 +15,7 @@
>  #include <linux/timer.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_data/pasemi.h>
>
>  #include <asm/hw_irq.h>
>  #include <asm/io.h>
> diff --git a/include/linux/platform_data/pasemi.h b/include/linux/platfor=
m_data/pasemi.h
> new file mode 100644
> index 0000000000000..3fed0687fcc9a
> --- /dev/null
> +++ b/include/linux/platform_data/pasemi.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Linaro Ltd.
> + *
> + * Author: Lee Jones <lee.jones@linaro.org>
> + */

Absolutely not. It's neither your copyright, nor your authorship.


-Olof
