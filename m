Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98B84465EB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 16:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKEPnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 11:43:18 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33416 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhKEPnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 11:43:15 -0400
Received: by mail-oi1-f182.google.com with SMTP id bl27so12251035oib.0;
        Fri, 05 Nov 2021 08:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aMNxNbmpqOJ7wYtvnDP1I1JUU/Vwc9pDw9R9dCWQ44=;
        b=vaOaWAiEfBFJqtU4VEou2yq40L7FbHZhG0orjk7Afxa0bfnM0P9e4Vt7zjltUbb5FI
         6bV+0yyK1tiuCq3V5fmsrs5w7AZfv3MuLmoQOThRYq0wPAOQ/G/WZZ5uS3iuXS+kkZRU
         niMk6TBshGu3/8fXiS6h0SzMOFXigO3jGAtw4DzFB4c8r3aszGZia07mUNc+fKkbJSu0
         6gTy9zzDoTuKO35vjnoiswrpnYP2q/NIcZXBnm5kMx+eoPO8kkyK42xHePL7d3/hCeOY
         BCUzKG4ZvH9w6a03sYX/F4Blk9UnppTEzFN59j97vcWbwt2TGDt6E6SL2MnBB6iOuVj6
         XZzA==
X-Gm-Message-State: AOAM532o8as1kz47jkdDWzFZxNdlUHrXBWmdwwJSUp8h5HznZ+WRIn2g
        xRINsGArhRz3WX6JzCjqzeSTPdm2JZSpdaT4NxQ=
X-Google-Smtp-Source: ABdhPJyc7w0NC5gvnKZJhWB4Hi7WOpvPTSAuWUqtQbakK/6zRNwCBktNVWVPjvoGCL0SjsOFomAK54mlVnTp8moDgGo=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr22209764oil.166.1636126835039;
 Fri, 05 Nov 2021 08:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211022075057.10759-1-Pierre.Gondois@arm.com>
In-Reply-To: <20211022075057.10759-1-Pierre.Gondois@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Nov 2021 16:40:24 +0100
Message-ID: <CAJZ5v0g4RrpnRfTsBm_Qi2-JM8SQCAH9_7gTM9cB3Rmc0DG4Hg@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix performance/frequency conversion
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 22, 2021 at 9:51 AM Pierre Gondois <Pierre.Gondois@arm.com> wrote:
>
> CPUfreq governors request CPU frequencies using information
> on current CPU usage. The CPPC driver converts them to
> performance requests. Frequency targets are computed as:
>   target_freq = (util / cpu_capacity) * max_freq
> target_freq is then clamped between [policy->min, policy->max].
>
> The CPPC driver converts performance values to frequencies
> (and vice-versa) using cppc_cpufreq_perf_to_khz() and
> cppc_cpufreq_khz_to_perf(). These functions both use two different
> factors depending on the range of the input value. For
> cppc_cpufreq_khz_to_perf():
> - (NOMINAL_PERF / NOMINAL_FREQ) or
> - (LOWEST_PERF / LOWEST_FREQ)
> and for cppc_cpufreq_perf_to_khz():
> - (NOMINAL_FREQ / NOMINAL_PERF) or
> - ((NOMINAL_PERF - LOWEST_FREQ) / (NOMINAL_PERF - LOWEST_PERF))
>
> This means the functions are not inverse for some values:
> (perf_to_khz(khz_to_perf(x)) != x)
>
> This patch makes use of one single conversion factor, being
> (MAX_PERF / MAX_FREQ).
>
> As LOWEST_FREQ is not used during conversion, the LOWEST_FREQ
> advertised through policy->cpuinfo.min_freq might be different
> from the LOWEST_FREQ value available in the CPPC object,
> but the conversion will be correct.

Well, this assumes that there is a linear perf <-> freq mapping which
is a change in behavior.

While I agree that consistency is a good thing in general, won't this
cause the values visible via sysfs to change?  And if it does, won't
it confuse anyone or break anything in user space?

> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d4c27022b9c9..d2ac74e7701e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -302,13 +302,10 @@ static u64 cppc_get_dmi_max_khz(void)
>  }
>
>  /*
> - * If CPPC lowest_freq and nominal_freq registers are exposed then we can
> - * use them to convert perf to freq and vice versa
> - *
> - * If the perf/freq point lies between Nominal and Lowest, we can treat
> - * (Low perf, Low freq) and (Nom Perf, Nom freq) as 2D co-ordinates of a line
> - * and extrapolate the rest
> - * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
> + * The CPPC driver receives frequency requests and translates them to performance
> + * requests. Thus, frequency values are actually performance values on a frequency
> + * scale. The conversion is done as:
> + * target_freq = target_perf * (nominal_freq / nominal_perf)
>   */
>  static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
>                                              unsigned int perf)
> @@ -317,14 +314,9 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
>         static u64 max_khz;
>         u64 mul, div;
>
> -       if (caps->lowest_freq && caps->nominal_freq) {
> -               if (perf >= caps->nominal_perf) {
> -                       mul = caps->nominal_freq;
> -                       div = caps->nominal_perf;
> -               } else {
> -                       mul = caps->nominal_freq - caps->lowest_freq;
> -                       div = caps->nominal_perf - caps->lowest_perf;
> -               }
> +       if (caps->nominal_freq) {
> +               mul = caps->nominal_freq;
> +               div = caps->nominal_perf;
>         } else {
>                 if (!max_khz)
>                         max_khz = cppc_get_dmi_max_khz();
> @@ -341,14 +333,9 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
>         static u64 max_khz;
>         u64  mul, div;
>
> -       if (caps->lowest_freq && caps->nominal_freq) {
> -               if (freq >= caps->nominal_freq) {
> -                       mul = caps->nominal_perf;
> -                       div = caps->nominal_freq;
> -               } else {
> -                       mul = caps->lowest_perf;
> -                       div = caps->lowest_freq;
> -               }
> +       if (caps->nominal_freq) {
> +               mul = caps->nominal_perf;
> +               div = caps->nominal_freq;
>         } else {
>                 if (!max_khz)
>                         max_khz = cppc_get_dmi_max_khz();
> --
> 2.17.1
>
