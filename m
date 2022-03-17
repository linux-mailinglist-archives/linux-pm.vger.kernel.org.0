Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988F64DC5D9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Mar 2022 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiCQMcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiCQMcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 08:32:08 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9461DDFCB;
        Thu, 17 Mar 2022 05:30:51 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e59939b862so55992357b3.10;
        Thu, 17 Mar 2022 05:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdSRIsJMcMTbELmRjIH9092SWXjm1j5Pn9ugkzrXeHc=;
        b=YGN8oJiUhlq+E0Gk+RS0WfPFZFCqfhI8hW66gYJ0oVTvIHBI2lEiow/4+iEWWVJrMq
         5t8w1wC+KnhmYHSjVIS1wn2NHrPy2N9xoVuvlrJGKHOUMlEyEOexMDqADPzIFqG8mFvf
         XQMA5RI3FE55HzYvSBs2wfOwm7M12i1YQPAEHXq5uvVzWx1sbdaB3WqfARMnzj/PB3ML
         CYFnjx9FQ7ZEL0uhVn0PNpgLyc015oQb76PYgd2KssK1HrDp6oeNL6orPa3ZGR3zF1uG
         rT1ly6o1+aldlYX23Hw7ZiaJNSjmFrSJDK+dNnlMa8WSLE4xcsqmMNcBQNYg1+4dgPoB
         z0Iw==
X-Gm-Message-State: AOAM5306cXjPhm0IP49djheHd5TGuoN4pBZs5wn81Nv1DHlihqf5sKDm
        LaHnotQHy4bMBnfkDY/5XEFAkrrQ/ZQXCJV4F4psaDdQp0Q=
X-Google-Smtp-Source: ABdhPJyd81XrKccs0+WLtYrqHQXA2xz5pt2ggNNPzRgJujU6Bb4vePhJKgAlZ72/znO5eedXXje0MET65oFV/csFt8I=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr5042332ywb.326.1647520250820; Thu, 17
 Mar 2022 05:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYoRsXkyWf0vmEE2HvjF6pzCC4utxTF=7AFx1PJv4Evh=C+Ow@mail.gmail.com>
 <CAAYoRsW4LqNvSZ3Et5fqeFcHQ9j9-0u9Y-LN9DmpCS3wG3+NWg@mail.gmail.com>
 <20220228041228.GH4548@shbuild999.sh.intel.com> <11956019.O9o76ZdvQC@kreacher>
 <20220301055255.GI4548@shbuild999.sh.intel.com> <CAJZ5v0jWUR__zn0=SDDecFct86z-=Y6v5fi37mMyW+zOBi7oWw@mail.gmail.com>
 <CAAYoRsVLOcww0z4mp9TtGCKdrgeEiL_=FgrUO=rwkZAok4sQdg@mail.gmail.com>
 <CAJZ5v0hK4zoOtgNQNFkJHC0XOiGsPGUPphHU5og44e_K4kGU9g@mail.gmail.com>
 <CAAYoRsWN-h+fBAoocGmUFHDkOv2PL+6U59_ASBYH74j0orHaCQ@mail.gmail.com>
 <CAJZ5v0iOOmRY3uC1-ZGQ30VysMuAjGum=Lt4tkqNUjop+ikqZw@mail.gmail.com>
 <CAAYoRsVs_CB-dBGShksmXATRP3oGnD6uU-xQdSPjkRER+j6fTQ@mail.gmail.com>
 <CAAYoRsVnPa-aiKCju7Nz+cznyOo2sbioFks+gU7W7dqWyO8JJw@mail.gmail.com> <CAAYoRsU=SjE2zpQPjxrE6aDzEk6+AZy9DUAJ4Vv2qimbiJ2ySQ@mail.gmail.com>
In-Reply-To: <CAAYoRsU=SjE2zpQPjxrE6aDzEk6+AZy9DUAJ4Vv2qimbiJ2ySQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 13:30:39 +0100
Message-ID: <CAJZ5v0hTOD8Y-ft0jo8KO+RW33ow7_Lm+6gAWA0BpM7o-u4vyQ@mail.gmail.com>
Subject: Re: CPU excessively long times between frequency scaling driver calls
 - bisected
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 16, 2022 at 4:55 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Readers: So that graphs and large attachments could be used, I have
> been on an off-list branch of this thread with Srinivas, and copied a
> couple of others. While now returning to this on-list thread, I'll
> only take up Rafael's proposed patch.
>
> Hi Rafael,
>
> So far all work has been done with: HWP disabled; intel_pstate; powersave.
> The reason was that it is, by far, the best way to obtain good trace data
> using the intel_pstate_tracer.py utility.
>
> I always intended to try/test: HWP disabled; intel_cpufreq; schedutil.
> There is an issue with the proposed patch and schedutil.
>
> If any CPU ever requests a pstate > the max non turbo pstate
> then it will stay at that request forever. Ultimately the idle
> power goes to about 5.7 watts (verses 1.4 watts expected).
> IRQs go very high, as the tick never turns off.
> Actually, one knows how many CPUs are stuck requesting a high
> pstate just by looking at IRQs.

That may be because INTEL_CPUFREQ_TRANSITION_DELAY is too small.

Please try to increase
/sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us to 10000 and
see what difference this makes.

> Trace is useless because it virtually never gets called.
> So I have been reading the IA32_PERF_CTL MSR
> directly.
>
> Example:
>
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> 6 cores, 12 CPUs
> min pstate 8
> max non-turbo pstate 41
> max turbo pstate 48
> The system is idle.
>
> doug@s19:~$ sudo
> /home/doug/kernel/linux/tools/power/x86/turbostat/turbostat --Summary
> --quiet --show Busy%,Bzy_MHz,IRQ,PkgWatt --interval 10
> Busy%   Bzy_MHz IRQ     PkgWatt
> 0.11    800     844     1.33
> 0.01    800     231     1.33
> 0.11    800     723     1.33 <<< Powersave governor
> 0.03    889     440     1.33
> 0.17    4418    21511   4.31 <<< Schedutil governor
> 0.12    4101    30153   4.48 <<< 3 CPUs are > pstate 41
> 0.22    4347    34226   4.75
> 0.17    4101    43554   4.78
> 0.29    4300    50565   4.94
> 0.21    4098    50297   4.76 <<< 5 CPUs are > pstate 41
> 0.29    4298    50532   4.84
> 0.20    4101    50126   4.63
> 0.20    4101    50149   4.62
> 0.29    4297    50623   4.76
> 0.20    4101    50203   4.72
> 0.29    4295    50642   4.78
> 0.20    4101    50223   4.68
> 0.29    4292    50597   4.88
> 0.20    4101    50208   4.73
> 0.29    4296    50519   4.84
> 0.20    4101    50167   4.80
> 0.20    4101    50242   4.76
> 0.29    4302    50625   4.94
> 0.20    4101    50233   4.73
> 0.29    4296    50613   4.78
> 0.20    4101    50231   4.70
> 0.29    4292    50802   4.93
> 1.46    4669    65610   8.36
> 0.41    4225    80701   5.48
> 0.33    4101    80219   5.36 <<< 8 CPUs are > ptstate 41
> 0.34    4098    80313   5.38
> 0.41    4228    80689   5.56
> 0.33    4101    80252   5.46
>
> And the related MSR reads:
>
> 3 CPUs are > pstate 41:
> root@s19:/home/doug# c/msr-decoder | grep IA32_PERF_CTL
> 9.) 0x199: IA32_PERF_CTL        : CPU 0-11 :  30 :   8 :   8 :  48 :
> 48 :  48 :   8 :  30 :  31 :   8 :   8 :   8 :
>
> 5 CPUs are > psate 41:
> root@s19:/home/doug# c/msr-decoder | grep IA32_PERF_CTL
> 9.) 0x199: IA32_PERF_CTL        : CPU 0-11 :  44 :  30 :  31 :  48 :
> 48 :  48 :   8 :   8 :   8 :   8 :  48 :   8 :
>
> 8 CPUs are > pstate 41:
> root@s19:/home/doug# c/msr-decoder | grep IA32_PERF_CTL
> 9.) 0x199: IA32_PERF_CTL        : CPU 0-11 :  45 :  48 :  48 :  48 :
> 48 :  48 :   8 :  30 :   8 :   8 :  48 :  42 :
>
> This issue is independent of the original patch or the suggested modification:
>
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index f878a4545eee..94018ac0b59b 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1980,7 +1980,7 @@ static void intel_pstate_update_perf_ctl(struct
> > cpudata *cpu)
> >          * P-states to prevent them from getting back to the high frequency
> >          * right away after getting out of deep idle.
> >          */
> > -       cpuidle_update_retain_tick(pstate > cpu->pstate.max_pstate);
> > +       cpuidle_update_retain_tick(pstate > ((cpu->pstate.max_pstate +
> > cpu->pstate.min_pstate)/2));
> >         wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
> >  }
>
> ... Doug
