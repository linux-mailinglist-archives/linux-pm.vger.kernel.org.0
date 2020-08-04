Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2623B91D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgHDKw4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:52:56 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39782 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgHDKwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 06:52:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id z18so9750816otk.6;
        Tue, 04 Aug 2020 03:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rjBo/61zITBrwF1WjzmAsT440t2d+iDU1/0VMNC1D0=;
        b=qsGA8HiISd5O/5c48U/8JdoFfAqxnNacNtCmsuQ8V5FUhLd1vLBtKTeKykEkV45mc9
         FdyvHz/63q9EaMeN7/wmvifMIXa6GquGA6p72/dxcFEuv1beq0Sl+MXr8MVwS5YFCWF8
         dwajM50dtg7FmwUAbVUy55FcxWfJGr7PZmdXn+Espjz9ahC1KP3SAIY4FYwZY3dfdC9Z
         wLIuX7UjiQAltUTl3lVCQs0R6aIatv00Ac0eWEnuNO8aon94GrCLu9XKtUcZNtR9oyt+
         2WroQYUV4++67SL+OmTeyYCOFUuQPxmOXrqmMuJjKeMJV9KugX7I1XujUm8iF2a3GnGn
         84tw==
X-Gm-Message-State: AOAM533ndUMgcVcuGmsZQDiQsGlhyIYDTpe8p4mebnR+lrCvo9pi6G+p
        bVHTSyA8BVNsbuO+yy4LvOlP4ZjQk114sSAeebnQJg==
X-Google-Smtp-Source: ABdhPJxX+PfRpylozWROtK7IoiOeZMxqnw+Is2216jIdlCZiwKhvwJnNjIeFvS9I4lLIIDQv2hLbOydCC/HJlvrquGg=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr17136289oth.262.1596538372394;
 Tue, 04 Aug 2020 03:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200803183720.13082-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20200803183720.13082-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Aug 2020 12:52:41 +0200
Message-ID: <CAJZ5v0iaWFsD=A=sRdVGDOm6QkT==_4C0qCQ=A4iFYvjVbuyLg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_max_freq when
 MSR_TURBO_RATIO_LIMIT is 0
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 3, 2020 at 8:37 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The MSR_TURBO_RATIO_LIMIT can be 0. This is not an error. User can update
> this MSR via BIOS settings on some systems or can use msr tools to update.
> Also some systems boot with value = 0.
>
> This results in display of cpufreq/cpuinfo_max_freq wrong. This value
> will be equal to cpufreq/base_frequency, even though turbo is enabled.
>
> But platform will still function normally in HWP mode as we get max
> 1-core frequency from the MSR_HWP_CAPABILITIES. This MSR is already used
> to calculate cpu->pstate.turbo_freq, which is used for to set
> policy->cpuinfo.max_freq. But some other places cpu->pstate.turbo_pstate
> is used. For example to set policy->max.
>
> To fix this, also update cpu->pstate.turbo_pstate when updating
> cpu->pstate.turbo_freq.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as a fix for 5.9-rc1, thanks!

> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 7e0f7880b21a..c7540ad28995 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1572,6 +1572,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>
>                 intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
>                 cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
> +               cpu->pstate.turbo_pstate = phy_max;
>         } else {
>                 cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
>         }
> --
> 2.17.1
>
