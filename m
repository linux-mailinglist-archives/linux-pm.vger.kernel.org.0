Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883DF1BDAA2
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2Laa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 07:30:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45398 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgD2Laa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 07:30:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id e20so1333337otk.12;
        Wed, 29 Apr 2020 04:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJLQaIat2tDbEwACly2x5coQW2dyQ71GmCW1Pk/+Pe0=;
        b=lu6Wh/M+LRHLWNg4cR8b9fCM0GIKOZfVDKacY39nnCoWwOXTDcSFwjzMg82RfQGPuo
         1aZHs/P9FeaBec98E/HlbzSpXaiJw94wb84edCPlyNzPKvjADGPopsxP/Jdu9OIu3WJP
         Ak5eZTj1iLyYJYSMpbX3tPuqinUsaiS/j+L34DqBNd8PJFVGtY5f/o5T0A/gBYiyYIb4
         OKL8jT3mViTzzC23hhqnVog6UtgAYmF1POo68rYyS1XYrCZx8cBvHbzQXB/x2VIg8i5x
         NGXorNi14ZheGKkrjQW2qZQTq0Aie9WIWZ66kfQ3IL4LhLgd+THo5Vs5uEAwg4CxW+8N
         Dgfw==
X-Gm-Message-State: AGi0PuanipB5Cmh8tlI0wrQTE44UC9QC6vGOC6JKEnII5ycA6wOboLT0
        QtDfpOPNVdvesaENYeHcMN980M0FrC4Z86TTUj8=
X-Google-Smtp-Source: APiQypIxdnHfH8fsytx0SXUL7Yzk0wRF6oZwhYIlSygbrTH5FgtTjQI6UbJwZ6dhKKE3HNiTqMY6ekE7V/Zic4Xznmc=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr25072932otm.167.1588159829033;
 Wed, 29 Apr 2020 04:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200428132450.24901-1-ggherdovich@suse.cz> <20200428132450.24901-2-ggherdovich@suse.cz>
In-Reply-To: <20200428132450.24901-2-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 13:30:17 +0200
Message-ID: <CAJZ5v0jitYE=a25rFd0Tb6QYeWeSJBE4p_yg29bq_e0Q5Pecbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 28, 2020 at 3:25 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> The product mcnt * arch_max_freq_ratio could be zero if it overflows u64.
>
> For context, a large value for arch_max_freq_ratio would be 5000,
> corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
> 1500-2000). A large increment frequency for the MPERF counter would be 5GHz
> (the base clock of all CPUs on the market today is less than that). With
> these figures, a CPU would need to go without a scheduler tick for around 8
> days for the u64 overflow to happen. It is unlikely, but the check is
> warranted.
>
> In that case it's also appropriate to disable frequency invariant
> accounting: the feature relies on measures of the clock frequency done at
> every scheduler tick, which need to be "fresh" to be at all meaningful.
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/smpboot.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 8c89e4d9ad28..4718f29a3065 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -2039,6 +2039,14 @@ static void init_freq_invariance(bool secondary)
>         }
>  }
>
> +static void disable_freq_invariance_workfn(struct work_struct *work)
> +{
> +       static_branch_disable(&arch_scale_freq_key);
> +}
> +
> +static DECLARE_WORK(disable_freq_invariance_work,
> +                   disable_freq_invariance_workfn);
> +
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>
>  void arch_scale_freq_tick(void)
> @@ -2055,14 +2063,18 @@ void arch_scale_freq_tick(void)
>
>         acnt = aperf - this_cpu_read(arch_prev_aperf);
>         mcnt = mperf - this_cpu_read(arch_prev_mperf);
> -       if (!mcnt)
> -               return;
>
>         this_cpu_write(arch_prev_aperf, aperf);
>         this_cpu_write(arch_prev_mperf, mperf);
>
>         acnt <<= 2*SCHED_CAPACITY_SHIFT;
>         mcnt *= arch_max_freq_ratio;
> +       if (!mcnt) {
> +               pr_warn("Scheduler tick missing for long time, disabling scale-invariant accounting.\n");
> +               /* static_branch_disable() acquires a lock and may sleep */
> +               schedule_work(&disable_freq_invariance_work);
> +               return;
> +       }
>
>         freq_scale = div64_u64(acnt, mcnt);
>
> --
> 2.16.4
>
