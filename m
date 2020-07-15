Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE0220512
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgGOGgM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgGOGgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:36:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D465C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:36:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so1158658wru.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KDUw/p8DtJDnQnEVAJVG2yQivQjSwBAN+u3RJMI5C9M=;
        b=LSZT6nxj4ttqP+kcl0xXx7k4ieooPzTPhig26hkGekfVkTtaH2JHD7+dmxhRfBfbm9
         uKPMX+hERxM6t42+4N6Xh0vvgnPAfsFn5um87k5Hky68u56FiBTANQ6c0XV9/ywqemtP
         CFHDRfgAs54jtev5fUuTHNM4XmDz+cyusdsqI8vFKQQipJSfmX8Cm9q8GsL8E/P6QhKi
         OlSqCFgn7c90mzyzrNpJBBX6xzzYbAhAWwoD8Q4p4gH4v4H0l4HxkwqNA2okUfvvEvek
         kJEW5+lu08HFJmq/k1o7p4bwNczt54wfoHeMEZaxoZ3WcW7Kt+Irk30DRPMp9W+2+k01
         vKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KDUw/p8DtJDnQnEVAJVG2yQivQjSwBAN+u3RJMI5C9M=;
        b=JRyQHMq3vt2bCD777bC9xs+q9nXRaVbl1Mc8hW+fUAFLNtkxh0s0fh/xTqYN1WRmqk
         u7BIGGZrpI+70sKsjhl3bv54thMgovTHLClq5FF2FjtyzHiqZqRwHowVC5qx7vG94ZTd
         dUG32szaNaaXso3Godk458QKWMRo26pDWpZyZJOT6+GYeQHs4FLP0srIU5GAmtz5Z4cJ
         rBL7zFL3WHYcOB+tC9nvP8oASeXP3sCr+gLpcnOTXWYyRjBTZCn1AKcgjBbHXkXTf1Ry
         li9ZYs5l/nPmfJ7e/hFCPuy0m4So/89Tz8xMZDEAChZhF8kqiwRv8ywjC0wnj70jF8Zp
         YEhg==
X-Gm-Message-State: AOAM533RYshdu1WEbro0O7gAAtKByJMfNXqceydmGp3d1A0j0iYM+vg7
        DVn9yZbA7zZH5rr0jExxWW/nzg==
X-Google-Smtp-Source: ABdhPJwP41jKAMrf4wkPV4iNxv1bwG2M4VTNHS/q1DEIPWOuxYBzr/NmcFF3W0hhLv4v0tGbkjwtPQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr10046135wrq.101.1594794969893;
        Tue, 14 Jul 2020 23:36:09 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id k126sm2040627wmf.3.2020.07.14.23.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:36:09 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:36:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715063607.GQ1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <20200715030706.prxya7fyylscoy25@vireshk-i7>
 <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Olof Johansson wrote:

> On Tue, Jul 14, 2020 at 8:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > If function callers and providers do not share the same prototypes the
> > > compiler complains of missing prototypes.  Fix this by moving the
> > > already existing prototypes out to a mutually convenient location.
> > >
> > > Fixes the following W=1 kernel build warning(s):
> > >
> > >  drivers/cpufreq/pasemi-cpufreq.c:109:5: warning: no previous prototype for ‘check_astate’ [-Wmissing-prototypes]
> > >  109 | int check_astate(void)
> > >  | ^~~~~~~~~~~~
> > >  drivers/cpufreq/pasemi-cpufreq.c:114:6: warning: no previous prototype for ‘restore_astate’ [-Wmissing-prototypes]
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
> >
> > Is there no sane way we can include this file directly to the cpufreq
> > file ?
> 
> Yep. arch/powerpc seems to be in the search path for modules on powerpc, so:
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index c66f566a854cb..815645170c4de 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -22,6 +22,8 @@
>  #include <asm/time.h>
>  #include <asm/smp.h>
> 
> +#include <platforms/pasemi/pasemi.h>
> +
>  #define SDCASR_REG             0x0100
>  #define SDCASR_REG_STRIDE      0x1000
>  #define SDCPWR_CFGA0_REG       0x0100

I searched for "include.*platforms/" in drivers/, and was scared off
this method since no one else does this.

But if it's a reasonable solution, great.  Will fix.

Thanks Olof.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
