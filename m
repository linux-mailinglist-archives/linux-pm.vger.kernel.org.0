Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83B20FBE0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgF3Shr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:37:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42831 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgF3Shr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 14:37:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id 76so4807930otu.9;
        Tue, 30 Jun 2020 11:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qDEyqS8NE3oxK3prUz3RFXZ5fxmePBlSyhV2vUSR+Q=;
        b=VWAR2HIrilq+maXmrHUWNQ8MjJU6dFDHH1vhD/KMFptE2pmPYv0S5yagkGhic25nfu
         iOKxNUVXYyEsPgNVy2kYhATEqdqUSIOwFpLyJclHH02lkTD7NVny2j/HVTCzBmJrNAog
         D+c+iKzpW4t9P5zPLfFChN0fKdORkXGuXbtM+xsazSRvywm5JbwiBarj2qbZRoAuWRgb
         rR4qzOIYsVvRDuxGMRHi75S7JGlpcCRvzx8U4pW2UDz3FogmRZm8t4IJ+rBXXDO0VtO+
         gSbQoe17cZYGxFaAiYv2ClVXGWIpTMhfyLjMgTvPTYod2aKwBIav5s5D2ycmtAUTU1RK
         ONRQ==
X-Gm-Message-State: AOAM533aytCsau5gAledXbnvOp37EFRZUFfsq4pWtlS+PKMIQVkSkvLY
        PAEwKfhB/y3EqPD2UskTagSW1zGHP4eJ1R8JoF4=
X-Google-Smtp-Source: ABdhPJzarDlb+hklbsYImIVV9e+FkSn+Fib8wLTdLmfPuUKv5CsNUzd3PRFgygvj0YhPd75oNE26pMl/5znGaWv3gWw=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr18548733otn.118.1593542265559;
 Tue, 30 Jun 2020 11:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <b217dc843935e3f86584a73893d330fd99a4e472.1592889188.git.viresh.kumar@linaro.org>
In-Reply-To: <b217dc843935e3f86584a73893d330fd99a4e472.1592889188.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 20:37:34 +0200
Message-ID: <CAJZ5v0iZXQgiA1hB2f90XoPgz_piVD0Vg-3UWW_ZT-mhJ4_KCg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cppc: Reorder code and remove
 apply_hisi_workaround variable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 23, 2020 at 7:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> With the current approach we have an extra check in the
> cppc_cpufreq_get_rate() callback, which checks if hisilicon's get rate
> implementation should be used instead. While it works fine, the approach
> isn't very straight forward, over that we have an extra check in the
> routine.
>
> Rearrange code and update the cpufreq driver's get() callback pointer
> directly for the hisilicon case. This gets the extra variable is removed
> and the extra check isn't required anymore as well.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Xiongfeng Wang, will it be possible for you to give this a try as I
> can't really test it locally.
>
>  drivers/cpufreq/cppc_cpufreq.c | 91 ++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 257d726a4456..03a21daddbec 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -45,8 +45,6 @@ struct cppc_workaround_oem_info {
>         u32 oem_revision;
>  };
>
> -static bool apply_hisi_workaround;
> -
>  static struct cppc_workaround_oem_info wa_info[] = {
>         {
>                 .oem_id         = "HISI  ",
> @@ -59,50 +57,6 @@ static struct cppc_workaround_oem_info wa_info[] = {
>         }
>  };
>
> -static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
> -                                       unsigned int perf);
> -
> -/*
> - * HISI platform does not support delivered performance counter and
> - * reference performance counter. It can calculate the performance using the
> - * platform specific mechanism. We reuse the desired performance register to
> - * store the real performance calculated by the platform.
> - */
> -static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> -{
> -       struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
> -       u64 desired_perf;
> -       int ret;
> -
> -       ret = cppc_get_desired_perf(cpunum, &desired_perf);
> -       if (ret < 0)
> -               return -EIO;
> -
> -       return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
> -}
> -
> -static void cppc_check_hisi_workaround(void)
> -{
> -       struct acpi_table_header *tbl;
> -       acpi_status status = AE_OK;
> -       int i;
> -
> -       status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> -       if (ACPI_FAILURE(status) || !tbl)
> -               return;
> -
> -       for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> -               if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> -                   !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> -                   wa_info[i].oem_revision == tbl->oem_revision) {
> -                       apply_hisi_workaround = true;
> -                       break;
> -               }
> -       }
> -
> -       acpi_put_table(tbl);
> -}
> -
>  /* Callback function used to retrieve the max frequency from DMI */
>  static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
>  {
> @@ -402,9 +356,6 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>         int ret;
>
> -       if (apply_hisi_workaround)
> -               return hisi_cppc_cpufreq_get_rate(cpunum);
> -
>         ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>         if (ret)
>                 return ret;
> @@ -455,6 +406,48 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>         .name = "cppc_cpufreq",
>  };
>
> +/*
> + * HISI platform does not support delivered performance counter and
> + * reference performance counter. It can calculate the performance using the
> + * platform specific mechanism. We reuse the desired performance register to
> + * store the real performance calculated by the platform.
> + */
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +       struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
> +       u64 desired_perf;
> +       int ret;
> +
> +       ret = cppc_get_desired_perf(cpunum, &desired_perf);
> +       if (ret < 0)
> +               return -EIO;
> +
> +       return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
> +}
> +
> +static void cppc_check_hisi_workaround(void)
> +{
> +       struct acpi_table_header *tbl;
> +       acpi_status status = AE_OK;
> +       int i;
> +
> +       status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> +       if (ACPI_FAILURE(status) || !tbl)
> +               return;
> +
> +       for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> +               if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> +                   !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +                   wa_info[i].oem_revision == tbl->oem_revision) {
> +                       /* Overwrite the get() callback */
> +                       cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
> +                       break;
> +               }
> +       }
> +
> +       acpi_put_table(tbl);
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
>         int i, ret = 0;
> --

Applied as 5.9 material, thanks!
