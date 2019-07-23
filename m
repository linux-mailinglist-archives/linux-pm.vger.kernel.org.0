Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330C17175E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfGWLrq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 07:47:46 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45197 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbfGWLrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 07:47:46 -0400
Received: by mail-vk1-f195.google.com with SMTP id e83so8557720vke.12
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dBxJDUf07AXZT1DslLp2oPEscDOmXAV+KRm01KVmpI=;
        b=ve9dNQIU1/ScDGRilK0yswo1rbhImUF9nVICpYHb485c/Bj4lDj04wxmDmoyFjB8mr
         aid5olNv3hC03Je2M0Yi+c/yaAMWkANnaHJfmN7k5hMFnTMMCxa2/t+yVeX6fEGYSH/g
         +phgBCSHBdCNeK0F73qWUdixYw95HKKvatfcABX0y3Qx98v/FdadS6BxrckWRPnmYhn1
         NvxBrLaFy/pVn30DNFAioHuEw5yqalhKaitfwkw+4fhyceclxiZSqhdL2d13iaSWBB3P
         CkGnMGApXt3qLRSyzv5Vrkb87mumfSWdV1zzJhMR4bw1Vk3Fa9YJyvJlKZe80Nq6hlef
         +UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dBxJDUf07AXZT1DslLp2oPEscDOmXAV+KRm01KVmpI=;
        b=IFfMjMKgiZG2XiRlCj4s5QnAtRcs9h0iurR728W6ax8JMgGSGFayTK0pAfPkgEg/AS
         ljmIX+IWrWGy2jp2kmAzz2oc/23ZKvAK8VLyxe/rLI5va4Q1JyquIMKSrnDoBY04D59a
         3e13eN9c5Lvd6TSx4xqfziDQSizKY9rewTGMN+mzMo3BbHHKrBBOi6hPuwuCYEiNSe/h
         yA0f3zfLYNzArDzPbGoL8PqvvstrxKgNQpTY1i7l9jAtBKSdUNJakLhtpD7t994gke92
         +T6k4pzXYD97jgmM4k75xzQqya/2uy5JgGWLiE4H4yq+X14XwEf5ym6sWttWLXrKDLas
         AEmg==
X-Gm-Message-State: APjAAAXr7jXIgJ06DCGHHb7fN3eOchNP/XIZpWiYyS7fgSIo+D142OOw
        YRwa4uwxVqoaSk+6skPqrU1YMTQThzxu6DYbYSO9ew==
X-Google-Smtp-Source: APXvYqys3QoXnQABINpJN0For4m7L6uG7ajsZKIGLu3Ym5MrKZDHkQYDNotxM7t1yjupurrNwmbVyPXRHdtIHhe1VJ8=
X-Received: by 2002:a1f:9f06:: with SMTP id i6mr28502502vke.52.1563882464630;
 Tue, 23 Jul 2019 04:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com> <20190722153745.32446-7-lorenzo.pieralisi@arm.com>
In-Reply-To: <20190722153745.32446-7-lorenzo.pieralisi@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Jul 2019 13:47:08 +0200
Message-ID: <CAPDyKFrhggN_TDcB-Qdhe6booD1MzMJTe90D4DyRCKTq3cgU=g@mail.gmail.com>
Subject: Re: [PATCH 6/6] PSCI: cpuidle: Refactor CPU suspend power_state
 parameter handling
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 Jul 2019 at 17:38, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Current PSCI code handles idle state entry through the
> psci_cpu_suspend_enter() API, that takes an idle state index as a
> parameter and convert the index into a previously initialized
> power_state parameter before calling the PSCI.CPU_SUSPEND() with it.
>
> This is unwieldly, since it forces the PSCI firmware layer to keep track
> of power_state parameter for every idle state so that the
> index->power_state conversion can be made in the PSCI firmware layer
> instead of the CPUidle driver implementations.
>
> Move the power_state handling out of drivers/firmware/psci
> into the respective ACPI/DT PSCI CPUidle backends and convert
> the psci_cpu_suspend_enter() API to get the power_state
> parameter as input, which makes it closer to its firmware
> interface PSCI.CPU_SUSPEND() API.
>
> A notable side effect is that the PSCI ACPI/DT CPUidle backends
> now can directly handle (and if needed update) power_state
> parameters before handing them over to the PSCI firmware
> interface to trigger PSCI.CPU_SUSPEND() calls.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  arch/arm64/kernel/cpuidle.c    |  47 +++++++++-
>  drivers/cpuidle/cpuidle-psci.c |  87 +++++++++++++++++-
>  drivers/firmware/psci/psci.c   | 158 ++-------------------------------
>  include/linux/cpuidle.h        |  17 +++-
>  include/linux/psci.h           |   4 +-
>  5 files changed, 153 insertions(+), 160 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index 4bcd1bca0dfc..e4d6af2fdec7 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -47,6 +47,44 @@ int arm_cpuidle_suspend(int index)
>
>  #define ARM64_LPI_IS_RETENTION_STATE(arch_flags) (!(arch_flags))
>
> +static int psci_acpi_cpu_init_idle(unsigned int cpu)
> +{
> +       int i, count;
> +       struct acpi_lpi_state *lpi;
> +       struct acpi_processor *pr = per_cpu(processors, cpu);
> +
> +       /*
> +        * If the PSCI cpu_suspend function hook has not been initialized
> +        * idle states must not be enabled, so bail out
> +        */
> +       if (!psci_ops.cpu_suspend)
> +               return -EOPNOTSUPP;
> +
> +       if (unlikely(!pr || !pr->flags.has_lpi))
> +               return -EINVAL;
> +
> +       count = pr->power.count - 1;
> +       if (count <= 0)
> +               return -ENODEV;
> +
> +       for (i = 0; i < count; i++) {
> +               u32 state;
> +
> +               lpi = &pr->power.lpi_states[i + 1];
> +               /*
> +                * Only bits[31:0] represent a PSCI power_state while
> +                * bits[63:32] must be 0x0 as per ARM ACPI FFH Specification
> +                */
> +               state = lpi->address;
> +               if (!psci_power_state_is_valid(state)) {
> +                       pr_warn("Invalid PSCI power state %#x\n", state);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  int acpi_processor_ffh_lpi_probe(unsigned int cpu)
>  {
>         return psci_acpi_cpu_init_idle(cpu);
> @@ -54,10 +92,13 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
>
>  int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
>  {
> +       u32 state = lpi->address;
> +
>         if (ARM64_LPI_IS_RETENTION_STATE(lpi->arch_flags))
> -               return CPU_PM_CPU_IDLE_ENTER_RETENTION(psci_cpu_suspend_enter,
> -                                               lpi->index);
> +               return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(psci_cpu_suspend_enter,
> +                                               lpi->index, state);
>         else
> -               return CPU_PM_CPU_IDLE_ENTER(psci_cpu_suspend_enter, lpi->index);
> +               return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> +                                            lpi->index, state);
>  }

I am not sure where the acpi+psci cpuidle code really belongs. Perhaps
some code should be moved into separate acpi+psci cpuidle driver?

In any case and whatever makes sense, it can be done on top of the
current series.

[...]

Kind regards
Uffe
