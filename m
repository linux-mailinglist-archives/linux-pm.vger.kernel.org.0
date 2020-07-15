Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA4220317
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 05:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGODvb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 23:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgGODvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 23:51:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CCCC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:51:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l6so1553552plt.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XL4t1R7KO+iiuMm12j+xjnscuEfFndInUHw84PmBU/0=;
        b=ylZ7LAUr7v3nNsUSJz4QBwWUkMu5K8QLciZp5z1a5hp2fILGp0VPgza+2a7vL1RduE
         2orVyqzcsKEpygHUPltAqLIr7lS8ANkLD2UvrG3NeNrUr0iCJuegFHD/qgy9qiev1Ofh
         biJRAcpw2pf18vEbtOTRXsI0rlMQ8Hg0QHQi+R8s274ANV6PYW+FcTW8YAdnq+d2YVnn
         7Gjf2vX/8npSCLhwZnlk9c96vbwS9kVfhGLc9PZZmZOftJba8Va7Y+G1Dd4sIjKVt/IK
         TMd5jMtoM77db2UokF5JBiagwoOdQ5RHgFSmN+6T5mxXMd7VFZ8dMnyFpWHhRT7YVrCs
         lt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XL4t1R7KO+iiuMm12j+xjnscuEfFndInUHw84PmBU/0=;
        b=roSnBQba4FkEKWWD0Z58RGtqzKr8W0vAWnq/uSK8AWxP/8c76n5n0m798yGDCim1ue
         9sxmd61eYdK7h6k9Wi2O1nluBmAYMeP7wxDGujyouV59YmguZs1CE9txyFm951saFRRw
         l4Ok77H1vJv/KkAi8b8te+NeTGciylj7KBcvyMr+cQPL+Zs5mqWZh1zDOn7ItLMnC9jb
         3bFkcMLDVtfgmQU2IycSoAW0kg4D2LKywRK2b4twiWaXvrSVDUWLCaXRxukEryjxmZbU
         d8mvTQGkkhc6ktNZuNJDM/lABa+X3gCNYulNu5DqdxoY2IMjq5zrNGap34Em8Unl+M3+
         MISw==
X-Gm-Message-State: AOAM532UX3Mre4iEt/WN1Z737ZY3q9wCxipBB8vfhkNoVOk2bsM4rdMw
        NtBEl8d1JqOwH16wMSvY2Qd7mg==
X-Google-Smtp-Source: ABdhPJz/fr4UJ94q97HnzrCpojOj2P5clVmMzwu1+0cWBhjM/jhe2/UJORYoOQc0tflEF8L9/1W8yQ==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr6492581plr.246.1594785090510;
        Tue, 14 Jul 2020 20:51:30 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id r17sm546201pfg.62.2020.07.14.20.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:51:29 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:21:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715035128.3j7xegbdz4bourxz@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <20200715030706.prxya7fyylscoy25@vireshk-i7>
 <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 20:49, Olof Johansson wrote:
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

Fantastic. Thanks.

-- 
viresh
