Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CBC738D93
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFURso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 21 Jun 2023 13:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFURsn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 13:48:43 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C9E41
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 10:48:42 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-98771dde617so152842166b.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 10:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369721; x=1689961721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpoVZuEUV3d0CfrEq/U86QzuBQUKBDj+qK5ZRtH9Ei8=;
        b=JmyMsUie56FAwnJJTIevNxBTY2sm9OZ3Bjmuwe/d4s3gH2upAM9oqHloKu+YbRsVrL
         SA9OZe96/6kgrIdyZGZSraMb7BUhMEruO/c8FMzOX+5ekz6nLs2aZwlib72t0m13n82b
         0966kcoQ1v344UNwS8SpsGvZ1ZdY/VXhND4G6BzrcPqHpYkmkYSqmPQCqBOfM0CEcNym
         05OwjgUqc7dRG0vzGIcxGojU3sTQJIKKEbHgBdt+xVcFHGGrelCphCGsa+tyHO0UJjcq
         59A1eRhf103d21CZpOeUfKO7hKMZ4nuB7+a183RqCgzJSC9MCI2sRLRzZW3lZOwEgnzG
         LErw==
X-Gm-Message-State: AC+VfDxHjwsxXs+45CTGt1XYiBX7I8ReMsKPS+3wdAnYF+7n9RzVwk3Z
        tITyWpROz2gOyz83KYAnTjyJXFGiSbcyaE1JFVk=
X-Google-Smtp-Source: ACHHUZ5gavcnYw8PzzDeG7btFgFDC7COOHeOV5o+4kGf52ZZfE8eoGz1xUdHTJo0fJ4oQ8fRtOZbHljMCjVcAC2Pl1s=
X-Received: by 2002:a17:906:74da:b0:976:50a4:ac40 with SMTP id
 z26-20020a17090674da00b0097650a4ac40mr12685494ejl.0.1687369720575; Wed, 21
 Jun 2023 10:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230620180354.1020392-1-arjan@linux.intel.com>
In-Reply-To: <20230620180354.1020392-1-arjan@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Jun 2023 19:48:29 +0200
Message-ID: <CAJZ5v0jidr_L94zcmk8kh=__FHXikGn40qNPHZ_bJeGurB_8gg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add a "Long HLT" C1 state for the VM guest mode
To:     arjan@linux.intel.com
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 20, 2023 at 8:04 PM <arjan@linux.intel.com> wrote:
>
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> intel_idle will, for the bare metal case, usually have one or more deep
> power states that have the CPUIDLE_FLAG_TLB_FLUSHED flag set. When
> a state with this flag is selected by the cpuidle framework, it will also
> flush the TLBs as part of entering this state. The benefit of doing this is
> that the kernel does not need to wake the cpu out of this deep power state
> just to flush the TLBs... for which the latency can be very high due to
> the exit latency of deep power states.
>
> In a VM guest currently, this benefit of avoiding the wakeup does not exist,
> while the problem (long exit latency) is even more severe. Linux will need
> to wake up a vCPU (causing the host to either come out of a deep C state,
> or the VMM to have to deschedule something else to schedule the vCPU) which
> can take a very long time.. adding a lot of latency to tlb flush operations
> (including munmap and others).
>
> To solve this, add a "Long HLT" C state to the state table for the VM guest
> case that has the CPUIDLE_FLAG_TLB_FLUSHED flag set.  The result of that is
> that for long idle periods (where the VMM is likely to do things that cause
> large latency) the cpuidle framework will flush the TLBs (and avoid the
> wakeups), while for short/quick idle durations, the existing behavior is
> retained.
>
> Now, there is still only "hlt" available in the guest, but for long idle,
> the host can go to a deeper state (say C6).  There is a reasonable debate
> one can have to what to set for the exit_latency and break even point for
> this "Long HLT" state.  The good news is that intel_idle has these values
> available for the underlying CPU (even when mwait is not exposed).  The
> solution thus is to just use the latency and break even of the deepest state
> from the bare metal CPU.  This is under the assumption that this is a pretty
> reasonable estimate of what the VMM would do to cause latency.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 55 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index a80e1f520293..34201d7ef33e 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1287,6 +1287,13 @@ static struct cpuidle_state vmguest_cstates[] __initdata = {
>                 .exit_latency = 5,
>                 .target_residency = 10,
>                 .enter = &intel_idle_hlt, },
> +       {
> +               .name = "C1L",
> +               .desc = "Long HLT",
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_TLB_FLUSHED,
> +               .exit_latency = 5,
> +               .target_residency = 200,
> +               .enter = &intel_idle_hlt, },
>         {
>                 .enter = NULL }
>  };
> @@ -2130,6 +2137,45 @@ static void __init intel_idle_cpuidle_devices_uninit(void)
>                 cpuidle_unregister_device(per_cpu_ptr(intel_idle_cpuidle_devices, i));
>  }
>
> +/*
> + * Match up the latency and break even point of the bare metal (cpu based)
> + * states with the deepest VM available state.
> + *
> + * We only want to do this for the deepest state, the ones that has
> + * the TLB_FLUSHED flag set on the .
> + *
> + * All our short idle states are dominated by vmexit/vmenter latencies,
> + * not the underlying hardware latencies so we keep our values for these.
> + */
> +static void matchup_vm_state_with_baremetal(void)
> +{
> +       int cstate;
> +
> +       for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> +               int matching_cstate;
> +
> +               if (intel_idle_max_cstate_reached(cstate))
> +                       break;
> +
> +               if (!cpuidle_state_table[cstate].enter)
> +                       break;
> +
> +               if (!(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_TLB_FLUSHED))
> +                       continue;
> +
> +               for (matching_cstate = 0; matching_cstate < CPUIDLE_STATE_MAX; ++matching_cstate) {
> +                       if (!icpu->state_table[matching_cstate].enter)
> +                               break;
> +                       if (icpu->state_table[matching_cstate].exit_latency > cpuidle_state_table[cstate].exit_latency) {
> +                               cpuidle_state_table[cstate].exit_latency = icpu->state_table[matching_cstate].exit_latency;
> +                               cpuidle_state_table[cstate].target_residency = icpu->state_table[matching_cstate].target_residency;
> +                       }
> +               }
> +
> +       }
> +}
> +
> +
>  static int __init intel_idle_vminit(const struct x86_cpu_id *id)
>  {
>         int retval;
> @@ -2145,6 +2191,15 @@ static int __init intel_idle_vminit(const struct x86_cpu_id *id)
>         if (!intel_idle_cpuidle_devices)
>                 return -ENOMEM;
>
> +       /*
> +        * We don't know exactly what the host will do when we go idle, but as a worst estimate
> +        * we can assume that the exit latency of the deepest host state will be hit for our
> +        * deep (long duration) guest idle state.
> +        * The same logic applies to the break even point for the long duration guest idle state.
> +        * So lets copy these two properties from the table we found for the host CPU type.
> +        */
> +       matchup_vm_state_with_baremetal();
> +
>         intel_idle_cpuidle_driver_init(&intel_idle_driver);
>
>         retval = cpuidle_register_driver(&intel_idle_driver);
> --

Applied as 6.5 material, thanks!
