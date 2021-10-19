Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA2433CE2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhJSRCQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 13:02:16 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37459 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhJSRCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 13:02:15 -0400
Received: by mail-oi1-f176.google.com with SMTP id o83so5947038oif.4;
        Tue, 19 Oct 2021 10:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooo83OSz7vbQdFOJmPWLx460yaZhwNmEZuCrtQkhKbY=;
        b=l8ojSJ7kjg+Mq0NigvdQ9BSq8L+FTk3OTgi1ol4nxv9OxUgxlCR3j7ekI6eDwUSVtW
         uyNi7E9gxxMT3C9ZKy4gm5O/bqmHY+17l/VXQaTiTiWRGMALLLt8tu+bYmYmxYWFZEvN
         Jzl7Q0q2TYK9EcbfngiAPy7G5R0c5nO0cB3X+O2uHXiggkFzvnEC2MQ5fZc2q5VZajWL
         oAf/9CVGiWU04NJEWk6S6hu/zuE31GlA0HkIPwXoa0bb2DxKVqG8nnTZKeAKjR0axlNL
         X946WmEux7Ih6DRYVbpIFhDQLLiLekTw3mgNtZlnGxbom1ZXFOp+E+aUpkEgA/aD2NRF
         TG8A==
X-Gm-Message-State: AOAM533lgnOw/97bLDCzlurFkqgYC5hvgKbStLX64Bx9XxTeY154oWGq
        7WblQcFJYCzwdmQ3WNZpN1frrmO1eFOSp8BSpeI=
X-Google-Smtp-Source: ABdhPJw1BUjeQEztWtQ5VMRmMEPC4CU0qqAstnLfjebebV31MgAGnLdmPinIekBJQ+XTYwJSOFzekwr0ZmZJFd9ijlY=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr5330439oif.51.1634662802579;
 Tue, 19 Oct 2021 10:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210926090605.3556134-1-ray.huang@amd.com> <20210926090605.3556134-5-ray.huang@amd.com>
In-Reply-To: <20210926090605.3556134-5-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 18:59:51 +0200
Message-ID: <CAJZ5v0g58vrHNcOEoWUCKmTxraSTuCzVLffzEAgz7TPa8+TNyw@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] ACPI: CPPC: add cppc enable register function
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 26, 2021 at 11:06 AM Huang Rui <ray.huang@amd.com> wrote:
>
> From: Jinzhou Su <Jinzhou.Su@amd.com>
>
> Add a new function to enable CPPC feature. This function
> will write Continuous Performance Control package
> EnableRegister field on the processor.

And what is going to take place after this write?

Also, it would be good to mention that the user of this function will
be added subsequently.

> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2efe2ba97d96..b285960c35e7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1220,6 +1220,54 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>
> +/**
> + * cppc_set_enable - Set to enable CPPC on the processor by writing the
> + * Continuous Performance Control package EnableRegister feild.
> + * @cpu: CPU for which to enable CPPC register.
> + * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
> + *
> + * Return: 0 for success, -ERRNO or -EIO otherwise.
> + */
> +int cppc_set_enable(int cpu, u32 enable)
> +{
> +       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +       struct cpc_register_resource *enable_reg;
> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +       struct cppc_pcc_data *pcc_ss_data = NULL;
> +       int ret = -1;
> +
> +       /* check the input value*/
> +       if (cpu < 0 || cpu > num_possible_cpus() - 1 || enable > 1)

Why not use cpu_possible()?  And why enable > 1 is a problem?

> +               return -ENODEV;

-EINVAL

> +
> +       if (!cpc_desc) {

if this is checked, the cpu_possible() check above is redundant.

> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +               return -ENODEV;
> +       }
> +
> +       enable_reg = &cpc_desc->cpc_regs[ENABLE];
> +
> +       if (CPC_IN_PCC(enable_reg)) {
> +
> +               if (pcc_ss_id < 0)
> +                       return -EIO;
> +
> +               ret = cpc_write(cpu, enable_reg, enable);
> +               if (ret)
> +                       return ret;
> +
> +               pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +               down_write(&pcc_ss_data->pcc_lock);
> +               /* after writing CPC, transfer the ownership of PCC to platfrom */
> +               ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +               up_write(&pcc_ss_data->pcc_lock);
> +       }

Does it really need to do nothing if the register is not in PCC?  If
so, then why?

> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_enable);
> +
>  /**
>   * cppc_set_perf - Set a CPU's performance controls.
>   * @cpu: CPU for which to set performance controls.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 9f4985b4d64d..3fdae40a75fc 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,6 +137,7 @@ struct cppc_cpudata {
>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
> +extern int cppc_set_enable(int cpu, u32 enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern bool acpi_cpc_valid(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> @@ -157,6 +158,10 @@ static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
>         return -ENOTSUPP;
>  }
> +static inline int cppc_set_enable(int cpu, u32 enable)
> +{
> +       return -ENOTSUPP;
> +}
>  static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>  {
>         return -ENOTSUPP;
> --
> 2.25.1
>
