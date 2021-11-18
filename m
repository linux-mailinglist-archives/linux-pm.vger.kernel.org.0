Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A77455C72
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 14:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhKRNSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 08:18:05 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38631 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhKRNSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 08:18:05 -0500
Received: by mail-oi1-f173.google.com with SMTP id r26so14178447oiw.5;
        Thu, 18 Nov 2021 05:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52oLeLHIWh1xHoLlS9D+Tl+qwNv+fGRWrOK+8Oypj1U=;
        b=REfpOoFxpGY5M3VBg47a6Tb9xt069wzIzy/fm34BS8yW/HJn8TDVi1coilsUfJ0F6d
         nBNov5EBGiOQLI0QynHtjZAojhb6sylMpmjL6uZPgxw+tE4tYK4MeON+AooGuJJjF6UB
         ZQ0mNluq1Dgxn5NzEN++pfxe9/x3FNqDnDeoHWPR0ak2djiQMuUrc2YP38PfZ2MG37iA
         YVwH+/dXC5UdWBWW1EK5fOl6Toor2mIRfCk8b5gpdz1FkJ1WZTt6KEOs9tDGtNCPwUKL
         gyVE/C8eMunZ0gfWM2RyRVqg9Y988tJK5k5C/B0lJezIeXLxAdavZ/yElKqT26NGvZaD
         WU8w==
X-Gm-Message-State: AOAM532q7Md2an+q3vI8ALJ+iUYu61PwV+NxMX9cazWTbTsuMMa0E6lE
        07SeASaVpkCXqQYDyyz1i8hw/t0PhWuyh2ngxsjbi6DFBDs=
X-Google-Smtp-Source: ABdhPJznVs8RdU58nNdpoEVh7Va5XIjxAah0DS4EqoY0YLpBdNkaHrgSESoA4MuVtUS6Hp8Sn4vadDFuOUkO5r1REHg=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr7709090oiw.51.1637241304764;
 Thu, 18 Nov 2021 05:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20211118124553.599419-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211118124553.599419-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 14:14:54 +0100
Message-ID: <CAJZ5v0gaCgqJy59YEp3KPOGO9W99rLFUDJ1Bw5iGLokA-U5R_Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Avoid using CPPC when ACPI CPC is
 not valid
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 18, 2021 at 1:46 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> If ACPI CPC is not valid, dereference cpc_desc in cppc_get_perf() causes
> a NULL pointer dereference. So avoid using CPPC for that scenario.
>
> Fixes: 46573fd6369f ("cpufreq: intel_pstate: hybrid: Rework HWP calibration")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

The bug is real, but it is not in intel_pstate.

cppc_get_perf() should return an error in that case.

Let me fix this.

> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 815df3daae9df..24c7d705b99b6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3369,7 +3369,7 @@ static int __init intel_pstate_init(void)
>                         if (!default_driver)
>                                 default_driver = &intel_pstate;
>
> -                       if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
> +                       if (boot_cpu_has(X86_FEATURE_HYBRID_CPU) && acpi_cpc_valid())
>                                 intel_pstate_cppc_set_cpu_scaling();
>
>                         goto hwp_cpu_matched;
> --
> 2.32.0
>
