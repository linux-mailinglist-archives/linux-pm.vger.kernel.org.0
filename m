Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D555E3A1A37
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhFIPzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 11:55:25 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:36661 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbhFIPzZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 11:55:25 -0400
Received: by mail-oi1-f177.google.com with SMTP id a21so25564326oiw.3;
        Wed, 09 Jun 2021 08:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GePodMOee0azACNFHtOPRzOQtkdj5aSzI6hkdk+H1q0=;
        b=YNnGETb17eWKvd+m4ZFdeEfNWhCsxvRnQb0RsbuoMPu8xJuM+UE7pos8Q5+EuGa+PQ
         EFjUIHzUNU2sq/J+icsn7oQwd6keFR8vNflAviGj085zDEdI4M9yswkK18aBa1LHBEFd
         iZoQz/LTfpkrC2QELocUZjIulfm/c9uGQP4b8ACYXTVmNsDbakZ7HF+oG3BfCrJL9bW6
         YMuQFBfQICIHXYrOCBekMiUEvne74SWoGW6hjJwg3YN7jGmJjfuEhiCHYvJz5S8POD6h
         AbGLtb10B9Rtvek6g6MAy61g7wg488Rt6EvKkrs6Ej6fatCNd34iH2L3rwea82ZgeR/+
         tHnA==
X-Gm-Message-State: AOAM531DDPkax3DOu3EvmfrPJ0BRN1Ono/6t6hCXolQVATppqbVWo2Tb
        H7KJLU6ZXrfGpNkcUWPgiB7bpJkGo5pc5PVQtPw=
X-Google-Smtp-Source: ABdhPJxnbRlOyuffFoSua4bAcB9GXMNu8SUX35LPlLqZk5YDmXmpHkEXKt/Ad8rhNhXSst29mFVrTBH5VulyDGBWxM0=
X-Received: by 2002:aca:650d:: with SMTP id m13mr7053680oim.157.1623254010275;
 Wed, 09 Jun 2021 08:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210528032054.7572-1-yu.c.chen@intel.com>
In-Reply-To: <20210528032054.7572-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 17:53:19 +0200
Message-ID: <CAJZ5v0gaSd_6XqYhrKm49mk01U1JC+2Vfgy=tG8dBWrKwdLHjg@mail.gmail.com>
Subject: Re: [PATCH][v2] intel_idle: Adjust the SKX C6 latency and residency
 if PC6 is disabled
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 28, 2021 at 5:16 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Currently cpuidle assumes worst-case C-state parameters, and so C6
> is described with PC6 parameters, which is worst case for requesting
> CC6. When PC6 is enabled, this is appropriate. But if PC6 is disabled
> in BIOS, the exit latency and target_residency should be adjusted
> accordingly.
>
> Exit latency:
> Previously the C6 exit latency was measured when woken up from CC6/PC6.
> With PC6 disabled, the C6 exit latency should be CC6/PC0.
>
> Target residency:
> With PC6 disabled, idle duration within [CC6, PC6) would make the
> idle governor choose C1E over C6. This would cause low energy-efficiency.
> We should lower the bar to request C6 when PC6 is disabled.
>
> To fill this gap, check if PC6 is disabled in the BIOS in the
> MSR_PKG_CST_CONFIG_CONTROL(0xe2). If so, use CC6/PC0 parameters as the
> new exit latency. Meanwhile, update target_residency to 3 times of the new
> exit latency. This is consistent with how intel_idle driver uses _CST to
> calculate the target_residency. The consequence is that, the OS would
> be more offen to choose C6 over C1E when PC6 is disabled. This is reasonable
> because if the user is using C6, it implies that the user cares about energy,
> so choosing C6 more frequently is in accordance with user requirement.
>
> The new exit latency of CC6/PC0 92us was from wult[1] result on SKX, which was
> measured via NIC wakeup from 99.99th latency. Besides SKX, the CLX and CPX
> both have the same CPU model number. And since they have similar CC6 exit latency
> to SKX, 96us and 89us respectively, reuse the value of SKX.
>
> There is concern that if we should introduce a more generic solution
> rather than optimizing on each platforms. However consider the
> code complexity and different PC6 bit interpretation on different
> platforms, tune the code per platform seems to be an acceptable trade-off.
>
> [1] https://intel.github.io/wult/
>
> Suggested-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Simplify the commit log to not mention C3/PC3. (Artem)
>     Confirm the exit latency on CLX and CPX.(Artem)
> ---
>  drivers/idle/intel_idle.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ec1b9d306ba6..e6c543b5ee1d 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1484,6 +1484,36 @@ static void __init sklh_idle_state_table_update(void)
>         skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;  /* C9-SKL */
>  }
>
> +/**
> + * skx_idle_state_table_update - Adjust the Sky Lake/Cascade Lake
> + * idle states table.
> + */
> +static void __init skx_idle_state_table_update(void)
> +{
> +       unsigned long long msr;
> +
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
> +
> +       /*
> +        * 000b: C0/C1 (no package C-state support)
> +        * 001b: C2
> +        * 010b: C6 (non-retention)
> +        * 011b: C6 (retention)
> +        * 111b: No Package C state limits.
> +        */
> +       if ((msr & 0x7) < 2) {
> +               /*
> +                * Uses the CC6 + PC0 latency and 3 times of
> +                * latency for target_residency if the PC6
> +                * is disabled in BIOS. This is consistent
> +                * with how intel_idle driver uses _CST
> +                * to set the target_residency.
> +                */
> +               skx_cstates[2].exit_latency = 92;
> +               skx_cstates[2].target_residency = 276;
> +       }
> +}
> +
>  static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>  {
>         unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
> @@ -1515,6 +1545,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
>         case INTEL_FAM6_SKYLAKE:
>                 sklh_idle_state_table_update();
>                 break;
> +       case INTEL_FAM6_SKYLAKE_X:
> +               skx_idle_state_table_update();
> +               break;
>         }
>
>         for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> --

Applied as 5.14 material with some edits in the subject and changelog.

Thanks!
