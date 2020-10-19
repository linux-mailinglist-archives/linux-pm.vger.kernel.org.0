Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDD292A65
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgJSP35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 11:29:57 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36351 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgJSP35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 11:29:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id 32so10865897otm.3;
        Mon, 19 Oct 2020 08:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufauCX1mTVCFB7Ocw9R6zTidUIroDFBpcM3yia+iYYA=;
        b=Mq/B0bNtwxPCmz9qksEdAJ30zSV3oAof7tgYIM/grEvvqD/jR209m4e4VG4mNEfFee
         JbkPdkcS69kmbUu6ly/wytjdV/pnY63kDTnr3jfzwZFf4ptOqtyJHDDfbfp9HMXlV4HG
         F931Okm2XiFXU6NmGcos1t0AtUZYsh4Hh7GKK3cYfIJ3SBQBl7gcuDovnv8VqvyZi/yj
         LiSsUhM/tiPkUChvoy7ctW/oMrlTHOAEb0u51l6E2IsBtOnGmpcMp0pxNGR5Ksm9a2ul
         8JIfBvkYUw5PTsOueAKg9zoT+ohT07ifuHzaQkA96qwkI1YOBetAGa3nbiGmddt/OkPX
         4WPw==
X-Gm-Message-State: AOAM533mugTb52LfrB8AsqFAZB5MKmGBj3PWx9VSwrAguibgpwJSRPBC
        B18HR/lnIa6KQPpuPEKLmpiMAwotgapN06JhqGM=
X-Google-Smtp-Source: ABdhPJy0cAg9mRLdvJiGO5d2Z+lYL4CHi4TBBcdKbJMJzOBjWYxOdUw4ImJi/uqHWbPDoavzmuJ/hrqbEyKGPj6AMEI=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr368114otq.321.1603121396651;
 Mon, 19 Oct 2020 08:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201019035741.2279043-1-wei.huang2@amd.com>
In-Reply-To: <20201019035741.2279043-1-wei.huang2@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Oct 2020 17:29:45 +0200
Message-ID: <CAJZ5v0gaQOSezJsJ7La5VC5apYj5zYL+wKAvyEB8T4w1V0TkCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] acpi-cpufreq: Honor _PSD table setting in CPU
 frequency control
To:     Wei Huang <wei.huang2@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 5:57 AM Wei Huang <wei.huang2@amd.com> wrote:
>
> acpi-cpufreq has a old quirk that overrides the _PSD table supplied by
> BIOS on AMD CPUs. However the _PSD table of new AMD CPUs (Family 19h+)
> now accurately reports the P-state dependency of CPU cores. Hence this
> quirk needs to be fixed in order to support new CPUs' frequency control.
>
> Fixes: acd316248205 ("acpi-cpufreq: Add quirk to disable _PSD usage on all AMD CPUs")
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index e4ff681faaaa..1e4fbb002a31 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -691,7 +691,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
>         }
>
> -       if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
> +       if (check_amd_hwpstate_cpu(cpu) && boot_cpu_data.x86 < 0x19 &&
> +           !acpi_pstate_strict) {
>                 cpumask_clear(policy->cpus);
>                 cpumask_set_cpu(cpu, policy->cpus);
>                 cpumask_copy(data->freqdomain_cpus,
> --

Applied as 5.10-rc material under edited subject, thanks!
