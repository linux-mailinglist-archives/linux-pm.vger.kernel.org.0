Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962EB290745
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 16:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408930AbgJPOfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 10:35:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39276 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408929AbgJPOfG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 10:35:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id c13so2660367oiy.6;
        Fri, 16 Oct 2020 07:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMrhIZD6r0of3W5tstYF8ZNKDB8ambJy+gjTSmYvPiw=;
        b=tDsZee+FToTzIQZopfaC5WJ7U+RVCu0+fSgWYrebLaMi4zX4VTerGAAOMxsG6t3yit
         HTlH4za27Wg7acWlb70vcmNNXaPIeZ/zzLkMinKRY1mpjct12KsrlzunN7Ac3nD1wiAg
         0mpvZI56VEiR+GRPM9PwSvMsoS/xrpnNmnXT+AksKqOsA+ojEb25k+sF1EUnslGShXQG
         yqwZihx7iVwq10K5L2ukCZ0bZ1SLc8HPysoE+54w5mqJMzy1WWQZGcqnb9BX6U/KRzDF
         ATKDUIAne+EX3w/WpTOUbXpMYK9/XOcR3xI8VI0wf299ZEp9yAazSYdFLZH/Yn/emtmV
         7g2g==
X-Gm-Message-State: AOAM532Dla5nAbPlVXc6sgB7gGPj+PTYNZPaaDMt/R/GCBIkbQIOSjZ1
        FbVEgvGy88NjZKMQJQYNUQpS2Md7fRM9OBGvxWw=
X-Google-Smtp-Source: ABdhPJzwektfZX7s7ICU25OD4YqiBH+zmoJaUe0za277AGueUQMCvay8xkoH5mOrl2rYdv/ZEubJfU9OxKvlIpnvPeE=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2681753oic.157.1602858905300;
 Fri, 16 Oct 2020 07:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201009033038.23157-1-yu.c.chen@intel.com>
In-Reply-To: <20201009033038.23157-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 16:34:54 +0200
Message-ID: <CAJZ5v0jcGWKz_LuWOaeZaNqJ0RX69Bw9wisZ=Ver7TKdJf8XNQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] cpufreq: intel_pstate: Delete intel_pstate sysfs if
 failed to register the driver
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 9, 2020 at 5:29 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> There is a corner case that if the intel_pstate driver failed to be
> registered(might be due to invalid MSR access) and with the acpi_cpufreq
> loaded, the intel_pstate sysfs might still be created, which makes the
> user confusing(turbostat for example):
>
> grep . /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
> acpi-cpufreq
>
> grep . /sys/devices/system/cpu/intel_pstate/*
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:0
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:0
> grep: /sys/devices/system/cpu/intel_pstate/no_turbo: Resource temporarily unavailable
> grep: /sys/devices/system/cpu/intel_pstate/num_pstates: Resource temporarily unavailable
> /sys/devices/system/cpu/intel_pstate/status:off
> grep: /sys/devices/system/cpu/intel_pstate/turbo_pct: Resource temporarily unavailable
>
> The existing of intel_pstate sysfs does not mean that the intel_pstate driver
> has been successfully loaded(for example, echo off to status), but the
> intel_pstate sysfs should not co-exist when acpi-cpufreq is also present.
> Fix this issue by deleting the intel_pstate sysfs if the driver failed
> to be loaded during bootup.
>
> Reported-by: Wendy Wang <wendy.wang@intel.com>
> Suggested-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 9a515c460a00..8c5f9680de83 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1420,6 +1420,26 @@ static void __init intel_pstate_sysfs_expose_params(void)
>         }
>  }
>
> +static void __init intel_pstate_sysfs_clean(void)
> +{
> +       if (!intel_pstate_kobject)
> +               return;
> +
> +       sysfs_remove_group(intel_pstate_kobject, &intel_pstate_attr_group);
> +
> +       if (per_cpu_limits)
> +               goto release_kobj;
> +
> +       sysfs_remove_file(intel_pstate_kobject, &max_perf_pct.attr);
> +       sysfs_remove_file(intel_pstate_kobject, &min_perf_pct.attr);
> +
> +       if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids))
> +               sysfs_remove_file(intel_pstate_kobject, &energy_efficiency.attr);
> +
> +release_kobj:
> +       kobject_put(intel_pstate_kobject);
> +}
> +
>  static void intel_pstate_sysfs_expose_hwp_dynamic_boost(void)
>  {
>         int rc;
> @@ -3063,8 +3083,10 @@ static int __init intel_pstate_init(void)
>         mutex_lock(&intel_pstate_driver_lock);
>         rc = intel_pstate_register_driver(default_driver);
>         mutex_unlock(&intel_pstate_driver_lock);
> -       if (rc)
> +       if (rc) {
> +               intel_pstate_sysfs_clean();
>                 return rc;
> +       }
>
>         if (hwp_active) {
>                 const struct x86_cpu_id *id;
> --

Applied as 5.10-rc material with some minor changes and the Srinivas'
ACK, thanks!
