Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6898D2DD281
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 14:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLQN7i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 08:59:38 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42421 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQN7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 08:59:37 -0500
Received: by mail-ot1-f48.google.com with SMTP id 11so27311265oty.9;
        Thu, 17 Dec 2020 05:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7gwvGVWjL+AxRFG9mZnNHSbjEVuL8pXqT0fw2E47yM=;
        b=PqZ/dEdOvf5iWmTSl8ds9ysybKzV6rkqPECL7Gry4mgZtxt4m75zShoHnJVWYiD0Tv
         ZsHrGj+6LmVAsetymy6L4YTufw3jXlPqxZpfJHKZcmDeJD98+YfbtwDiNMUUJsa6kC6d
         ev7y8lS5vfPy7NIn0rJqESuGhWbp9MCd9ka21+TkSbjNe+u8S27ZgybCo/JduHD8JC7T
         t0XN9N4WqNc/Y9lH7hHmUJ/VzYOnkAfv2L9YsPDD3QfuUEmLwEzG9KZE1lldqZs0zwvs
         42iOMd7achWZDOLscxwS2U0D6TeRORUpWHuYgssKEut1KcIgIOmTk/mvtnW49TDmteME
         kMbQ==
X-Gm-Message-State: AOAM533r3iLMZ+yZ4EWDphrwXl4idwh8leGMRb09ZgNgw5HMUCEKRNWV
        QqRB1b3nf0oFSfHwp1ZuMssTvcM2+jAPyRdI/Gk=
X-Google-Smtp-Source: ABdhPJz00EcXzZprqy6xcxFXBAt89LlEDQmITmhJ0zOxqelVcu8TfwpjHGMSUcBIp8DDOmmOvacku6yrkynChinRG/I=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr30290443otk.206.1608213536569;
 Thu, 17 Dec 2020 05:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20201217104215.2544837-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Dec 2020 14:58:45 +0100
Message-ID: <CAJZ5v0ghXA=mao_S-VH-x0_0uvGYK_oWj10f-A=u0w82tXDg5Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use the latest guaranteed freq
 during verify
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 17, 2020 at 11:44 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> This change tries to address an issue, when BIOS disabled turbo
> but HWP_CAP guaranteed is changed later and user space wants to take
> advantage of this increased guaranteed performance.
>
> The HWP_CAP.GUARANTEED value is not a static value. It can be changed
> by some out of band agent or during Intel Speed Select performance
> level change. The HWP_CAP.MAX still shows max possible performance when
> BIOS disabled turbo. So guaranteed can still change as long as this is
> same or below HWP_CAP.MAX.
>
> When guaranteed is changed, the sysfs base_frequency attributes shows
> the latest guaranteed frequency. This attribute can be used by user
> space software to update scaling min/max frequency.
>
> Currently the setpolicy callback already uses the latest HWP_CAP
> values when setting HWP_REQ. But the verify callback will still restrict
> the user settings to the to old guaranteed value. So if the guaranteed
> is increased, user space can't take advantage of it.
>
> To solve this similar to setpolicy callback, read the latest HWP_CAP
> values and use it to restrict the maximum setting. This is done by
> calling intel_pstate_get_hwp_max(), which already accounts for user
> and BIOS turbo disable to get the current max performance.
>
> This issue is side effect of fixing the issue of scaling frequency
> limits by the
>  'commit eacc9c5a927e ("cpufreq: intel_pstate:
>  Fix intel_pstate_get_hwp_max() for turbo disabled")'
> The fix resulted in correct setting of reduced scaling frequencies,
> but this resulted in capping HWP.REQ to HWP_CAP.GUARANTEED in this case.
>
> Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2a4db856222f..7081d1edb22b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2199,6 +2199,12 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
>
>  static int intel_pstate_get_max_freq(struct cpudata *cpu)
>  {
> +       if (hwp_active) {
> +               int turbo_max, max_state;
> +
> +               intel_pstate_get_hwp_max(cpu->cpu, &turbo_max, &max_state);

This would cause intel_pstate_get_hwp_max() to be called twice in
intel_pstate_update_perf_limits() which is not perfect.

> +               return max_state * cpu->pstate.scaling;
> +       }
>         return global.turbo_disabled || global.no_turbo ?
>                         cpu->pstate.max_freq : cpu->pstate.turbo_freq;
>  }
> --
