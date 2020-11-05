Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4232A7F6E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 14:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKENGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 08:06:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34016 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKENGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 08:06:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id j14so1341872ots.1;
        Thu, 05 Nov 2020 05:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdZgb+k5dRx1eb1k/ksppuSD/98WX1sN0LMVhJbD6Rg=;
        b=t23ZMnXX6xGpHg8GrvX18snEhLrzgFK0OrkIc4XZBGnT4l+/dqQVCvVoqTGr8utLDX
         +F7O9wXlNlGsesxv5CwIB+auYfc7x7Jm6fw5SA+UtQ/8qEuKtspc2OHvNTCbzjMmFchv
         JOhjMCy3zz39B5HbAvbUt0ImNcgvijJmdA0yVej8L6BGD+Mo0BILmtW/4RDuUEfUf9yf
         rKRAIOLEsKvcuOuwauKzlb2lcwYqDbM5tUJPIhqKm6POjb93fp00Xj8HYHVi+X+6Mq7F
         qyPSXBOphxnGBBA5lzK/8iAZ3m9e1tUscGtOQFbcCM3gAMoJ5r1eIUoSLj5Bqlbw186h
         5KXQ==
X-Gm-Message-State: AOAM531yW9nAsEpKtbmCVhrvlBN7uRNkTP0j794yXj5qrB7zxdr0LTo2
        JI25782e1VDwy3HZVWc3wWxiPA/aSIEs5B/0ZKY=
X-Google-Smtp-Source: ABdhPJzGcgK8kFkkRHcPJ7R6ZpgkZtLzu91vcYrqBSfeZKyD8GzRT5vpOuDGy5iawjTvnTj4D9+iz428w+vKigRUah8=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr1627406ota.321.1604581566378;
 Thu, 05 Nov 2020 05:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20201105125524.4409-1-ionela.voinescu@arm.com> <20201105125524.4409-9-ionela.voinescu@arm.com>
In-Reply-To: <20201105125524.4409-9-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 14:05:55 +0100
Message-ID: <CAJZ5v0hheK3WrpKFXDUF1A4D9wt8ro3KJ73wqNwxn9DJyrt6zw@mail.gmail.com>
Subject: Re: [PATCH 8/8] acpi: fix NONE coordination for domain mapping failure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 5, 2020 at 1:57 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> For errors parsing the _PSD domains, a separate domain is returned for
> each CPU in the failed _PSD domain with no coordination (as per previous
> comment). But contrary to the intention, the code was setting
> CPUFREQ_SHARED_TYPE_ALL as coordination type.
>
> Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
> the domain information. The function still return the error and the caller
> is free to bail out the domain initialisation altogether in that case.
>
> Given that both functions return domains with a single CPU, this change
> does not affect the functionality, but clarifies the intention.

Is this related to any other patches in the series?

> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/acpi/cppc_acpi.c         | 2 +-
>  drivers/acpi/processor_perflib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 75e36b909ae6..e1e46cc66eeb 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -477,7 +477,7 @@ int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
>         /* Assume no coordination on any error parsing domain info */
>         cpumask_clear(domain->shared_cpu_map);
>         cpumask_set_cpu(cpu, domain->shared_cpu_map);
> -       domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +       domain->shared_type = CPUFREQ_SHARED_TYPE_NONE;
>
>         return -EFAULT;
>  }
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 5909e8fa4013..5ce638537791 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -710,7 +710,7 @@ int acpi_processor_preregister_performance(
>                 if (retval) {
>                         cpumask_clear(pr->performance->shared_cpu_map);
>                         cpumask_set_cpu(i, pr->performance->shared_cpu_map);
> -                       pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +                       pr->performance->shared_type = CPUFREQ_SHARED_TYPE_NONE;
>                 }
>                 pr->performance = NULL; /* Will be set for real in register */
>         }
> --
> 2.17.1
>
