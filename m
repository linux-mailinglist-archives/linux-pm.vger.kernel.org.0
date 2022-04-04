Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098E4F0DBF
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 05:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbiDDDlc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Apr 2022 23:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDDDlc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2022 23:41:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE53981C
        for <linux-pm@vger.kernel.org>; Sun,  3 Apr 2022 20:39:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d3so1675484wrb.7
        for <linux-pm@vger.kernel.org>; Sun, 03 Apr 2022 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8/aVwpSbq6P9VWydiIc4i/5KLXIXBAm03QUmehMn90=;
        b=lvqfyewAeZVZqnq38NmTEFXQ21z8cKjlNzK3dv5woldXyrCqvq1J7jEQEA5dPfELwR
         DI8ctTyRcE/aoMdkRHYV0PCd0WM99O9wl2WEI7ZO613MqLOz7aXq8C/JTpJXdvL4piF5
         BJTr6R9edkG1Aj9Yj9vLqS/hGQVmverEBL88kWQPvnGPhUFIF0VTDuZHXqjZhjfd10qy
         kgifni6hKujgSDPN3/ita0Px+guu9OHnsDxggxD9jXZqhEY4aUu9zYucgbed9Lnen2Cx
         JaqtT0skohJQtlUlwTjTLPPogHDPuS90d9c5XEoNzSL2sfknfpvo6smUyrBNJyXzBcJt
         UPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8/aVwpSbq6P9VWydiIc4i/5KLXIXBAm03QUmehMn90=;
        b=BCedJtKfQD1FaeZOvzq6SVEQsvaMgyg91dWM7czRxsERu9QFzr8Nr5JIEeKyL933Vh
         PEfLsRpSTYLQJsUaL1i+Lq4I8QJAMkwpGEP1ELLCVo27BTtkoA6tgPWynLAEoQuELysb
         uzUwXKVCvfA5ONnSncZpj+pJtWBCkKBPsK1TKFJ4y8+XrVzWqJgSsH+/LbqMOGEWs4qx
         IaEklRNJ4IRszWyugoJZ6TIFFV2SFieUnplUvb9CYV47/3uNvcUFQDaOUcUozucH6UQk
         SwB9idtf/rAODQki94JTAQL2sowX/df9wuPL8GeV21DBVB65dcXwnPRn4hD87OD0eHzM
         MGjg==
X-Gm-Message-State: AOAM530KVx2SelEfi1O+h02cysUnGS9ilNPPWkpcmIvuJVR9Wys1eC+d
        KxbZlMsDGiipy1AQYNjuNeN3TLK+cQhxrm8/hZaRxQ==
X-Google-Smtp-Source: ABdhPJzq3a5wx76W4hZJ3J/Mqk4N79e3BhGOpuIKHRDsBWV6w0TtjQ7B7qXfQE/JSCz5Zy3uS6iFbskTIXO+XI2G6I4=
X-Received: by 2002:adf:db86:0:b0:205:bccf:8cbf with SMTP id
 u6-20020adfdb86000000b00205bccf8cbfmr15183666wri.346.1649043575307; Sun, 03
 Apr 2022 20:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220403031355.20894-1-rdunlap@infradead.org> <CAAhSdy2CJMeD_JhvwkEKShtYxyLGVRme8rE4cmCcDFfO90_D-Q@mail.gmail.com>
 <61196f88-7306-058d-7b9b-21e32f1fca92@infradead.org>
In-Reply-To: <61196f88-7306-058d-7b9b-21e32f1fca92@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 4 Apr 2022 09:08:25 +0530
Message-ID: <CAAhSdy3w2tXVtD9jBO7xFx8F_CbhKZDs6PfFF44CRhVfXmBbNg@mail.gmail.com>
Subject: Re: [PATCH -next] cpuidle: riscv: support non-SMP config
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 4, 2022 at 9:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 4/3/22 20:05, Anup Patel wrote:
> > (Removed my WDC email because it does not exist anymore)
> >
> > On Sun, Apr 3, 2022 at 8:44 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Add <asm/smp.h> for cpuid_to_hartid_map etc.
> >> This is needed for both SMP and non-SMP builds, but not having it
> >> causes a build error for non-SMP:
> >>
> >> drivers/cpuidle/cpuidle-riscv-sbi.c: In function 'sbi_cpuidle_init_cpu':
> >> drivers/cpuidle/cpuidle-riscv-sbi.c:350:26: error: implicit declaration of function 'cpuid_to_hartid_map' [-Werror=implicit-function-declaration]
> >>
> >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Cc: Anup Patel <anup.patel@wdc.com>
> >> Cc: Anup Patel <anup@brainfault.org>
> >> Cc: Anup Patel <apatel@ventanamicro.com>
> >> Cc: Atish Patra <atishp@rivosinc.com>
> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: linux-pm@vger.kernel.org
> >> Cc: linux-riscv@lists.infradead.org
> >> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> >> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> >> Cc: Albert Ou <aou@eecs.berkeley.edu>
> >> ---
> >>  drivers/cpuidle/cpuidle-riscv-sbi.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> --- linux-next-20220401.orig/drivers/cpuidle/cpuidle-riscv-sbi.c
> >> +++ linux-next-20220401/drivers/cpuidle/cpuidle-riscv-sbi.c
> >> @@ -22,6 +22,7 @@
> >>  #include <linux/pm_runtime.h>
> >>  #include <asm/cpuidle.h>
> >>  #include <asm/sbi.h>
> >> +#include <asm/smp.h>
> >
> > I suggest include linux/smp.h here instead of asm/smp.h
> >
> > Otherwise it looks good to me.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
>
> Yeah, checkpatch also suggested that but it does not work.
> Yes, I tested it.
>
> linux/smp.h only #includes <asm/smp.h> if CONFIG_SMP is enabled,
> and this patch needs <asm/smp.h> for the non-SMP case.

Okay, sounds good to me.

No changes needed in this patch.

Regards,
Anup

>
> >
> >>  #include <asm/suspend.h>
> >>
> >>  #include "dt_idle_states.h"
>
> thanks.
> --
> ~Randy
